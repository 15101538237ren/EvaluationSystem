#!/bin/sh
MPATH=~/Projects/EvaluationSystem/EvaluationSystem/
nohup python ${MPATH}manage.py runserver 0.0.0.0:80 &
