#!/bin/bash

LOG={{build_anchors}}/openmpibuild.log

echo "Install openmpi {{openmpiinfo['version']}}"          >  $LOG
date                                                       >> $LOG

cd {{source_download_dir}}                                 >> $LOG
tar xf {{openmpiinfo['filename']}}                         >> $LOG
cd openmpi-{{openmpiinfo['version']}}                      >> $LOG

echo "++++++++++++++++++ configure +++++++++++++++++++"    >> $LOG
./configure --prefix={{openmpiinfo['prefix']}} {{openmpiinfo['flags']}}        2>1 >> $LOG
echo "+++++++++++++++++++++ make +++++++++++++++++++++"    >> $LOG
make -j {{ansible_processor_vcpus}}                    2>1 >> $LOG
echo "++++++++++++++++++++ check +++++++++++++++++++++"    >> $LOG
make check                                             2>1 >> $LOG
echo "+++++++++++++++++++++ inst +++++++++++++++++++++"    >> $LOG
make install                                           2>1 >> $LOG

cd /root
rm -rf {{source_download_dir}}/openmpi-{{openmpiinfo['version']}}
