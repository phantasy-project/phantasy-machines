#!/usr/bin/softIoc

dbLoadRecords("./template.db", "S=C7SR_CMTF,SS=PSC1,D=N0001,F=I")
dbLoadRecords("./template.db", "S=C7SR_CMTF,SS=PSC2,D=N0001,F=I")

iocInit()
