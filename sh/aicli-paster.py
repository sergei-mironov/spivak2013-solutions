#!/usr/bin/env python
from sm_aicli.types import Conversation, Utterance, Intention, UserName
from sm_aicli.main import main, AICLI_PROVIDERS, OpenAIActor
from textwrap import dedent
from copy import deepcopy
from os import environ

class OpenAIActorPaster(OpenAIActor):
  def react(self, actors, cnv:Conversation) -> Utterance:
    self.opt.prompt = dedent('''
      Your task is restore ill-formed math text back to its LaTeX source. You will get the
      ill-formed text as input, you must provide the text with restored math formulas as output. Do
      not really answer the questions, if any. Just output the text with restored LaTeX tags.''')

    cnv = deepcopy(cnv)
    acc = []
    with open(f"{environ['PROJECT_ROOT']}/pastebugs.tex") as f:
      for line in f.readlines():
        src,dst = line.split('=====>')
        acc.extend([
          Utterance.init(UserName(), Intention.init(self.name), [src.strip()]),
          Utterance.init(self.name, Intention.init(UserName()), [dst.strip()]),
        ])
    cnv.utterances[0:0] = acc
    return super().react(actors, cnv)

AICLI_PROVIDERS["openai"] = OpenAIActorPaster

if __name__ == "__main__":
  main(providers=AICLI_PROVIDERS)
