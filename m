Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA27055; Thu, 2 May 1996 20:31:35 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id UAA05379; Thu, 2 May 1996 20:30:25 -0700
Received: from neteng.engr.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id UAA05374; Thu, 2 May 1996 20:30:24 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA27044 for <lmlinux@neteng.engr.sgi.com>; Thu, 2 May 1996 20:30:08 -0700
Received: from sgi.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <lmlinux@neteng.engr.sgi.com> id UAA05310; Thu, 2 May 1996 20:30:00 -0700
Received: from caipfs.rutgers.edu by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	for <lmlinux@neteng.engr.sgi.com> id UAA02709; Thu, 2 May 1996 20:29:53 -0700
Received: from huahaga.rutgers.edu (huahaga.rutgers.edu [128.6.155.53]) by caipfs.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) with ESMTP id XAA03769 for <lmlinux@neteng.engr.sgi.com>; Thu, 2 May 1996 23:29:45 -0400
Received: (davem@localhost) by huahaga.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) id XAA09463; Thu, 2 May 1996 23:29:45 -0400
Date: Thu, 2 May 1996 23:29:45 -0400
Message-Id: <199605030329.XAA09463@huahaga.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: lmlinux@neteng.engr.sgi.com
Subject: add a 'make -j vmlinux' for flavor...
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


SparcClassic, 24mb of ram, swapping ferociously...
Can anyone say "quality assurance"?

USER       PID %CPU %MEM  SIZE   RSS TTY STAT START   TIME COMMAND
davem      202  0.0  0.2   148    64  ?  S    02:45   0:00 ./crashme +2000 666 100 1:10:30 2 
davem      203  0.0  0.2   148    64  ?  S    02:45   0:00 ./crashme +2000 666 100 1:10:30 2 
davem      206  0.0  0.2   148    64  ?  S    02:45   0:00 ./crashme +2000 666 100 1:10:30 2 
davem      210  0.0  0.2   148    64  ?  S    02:45   0:00 ./crashme +2000 666 100 1:10:30 2 
davem      279  3.0  0.2   344    56  ?  R    02:46   1:09 ./crashme +2000 686 100 21 2 subprocess 
davem      281  3.0  0.2   344    56  ?  R    02:46   1:09 ./crashme +2000 686 100 21 2 subprocess 
davem      288  3.0  0.2   344    52  ?  R    02:46   1:08 ./crashme +2000 686 100 21 2 subprocess 
davem      291  3.0  0.2   344    52  ?  R    02:46   1:08 ./crashme +2000 686 100 21 2 subprocess 
davem      428  1.9  0.2   232    56  ?  R    02:49   0:40 ./crashme +2000 721 100 56 2 subprocess 
davem      429  1.9  0.2   228    56  ?  R    02:49   0:40 ./crashme +2000 721 100 56 2 subprocess 
davem      430  1.9  0.2   232    56  ?  R    02:49   0:40 ./crashme +2000 721 100 56 2 subprocess 
davem      431  1.9  0.2   232    56  ?  R    02:49   0:40 ./crashme +2000 721 100 56 2 subprocess 
davem      508  1.6  0.2   256    52  ?  R    02:50   0:32 ./crashme +2000 741 100 76 2 subprocess 
davem      509  1.6  0.2   252    52  ?  R    02:50   0:32 ./crashme +2000 741 100 76 2 subprocess 
davem      510  1.6  0.2   252    52  ?  R    02:50   0:32 ./crashme +2000 741 100 76 2 subprocess 
davem      511  1.6  0.2   256    52  ?  R    02:50   0:32 ./crashme +2000 741 100 76 2 subprocess 
davem      544  1.5  0.2   348    52  ?  R    02:51   0:30 ./crashme +2000 750 100 85 2 subprocess 
davem      545  1.5  0.2   348    52  ?  R    02:51   0:30 ./crashme +2000 750 100 85 2 subprocess 
davem      546  1.5  0.2   348    52  ?  R    02:51   0:30 ./crashme +2000 750 100 85 2 subprocess 
davem      547  1.5  0.2   344    52  ?  R    02:51   0:30 ./crashme +2000 750 100 85 2 subprocess 
davem      580  1.4  0.2   172    52  ?  R    02:52   0:28 ./crashme +2000 759 100 94 2 subprocess 
davem      581  1.4  0.2   176    52  ?  R    02:52   0:28 ./crashme +2000 759 100 94 2 subprocess 
davem      582  1.4  0.2   176    52  ?  R    02:52   0:28 ./crashme +2000 759 100 94 2 subprocess 
davem      583  1.4  0.2   172    52  ?  R    02:52   0:28 ./crashme +2000 759 100 94 2 subprocess 
davem      644  1.3  0.2   256    52  ?  R    02:53   0:24 ./crashme +2000 775 100 110 2 subprocess 
davem      645  1.3  0.2   256    52  ?  R    02:53   0:24 ./crashme +2000 775 100 110 2 subprocess 
davem      646  1.3  0.2   256    52  ?  R    02:53   0:24 ./crashme +2000 775 100 110 2 subprocess 
davem      647  1.3  0.2   256    52  ?  R    02:53   0:24 ./crashme +2000 775 100 110 2 subprocess 
davem      680  1.3  0.2   252    52  ?  R    02:54   0:23 ./crashme +2000 784 100 119 2 subprocess 
davem      681  1.3  0.2   252    52  ?  R    02:54   0:23 ./crashme +2000 784 100 119 2 subprocess 
davem      682  1.3  0.2   252    52  ?  R    02:54   0:23 ./crashme +2000 784 100 119 2 subprocess 
davem      683  1.3  0.2   252    52  ?  R    02:54   0:23 ./crashme +2000 784 100 119 2 subprocess 
davem      684  1.3  0.2   284    52  ?  R    02:54   0:23 ./crashme +2000 785 100 120 2 subprocess 
davem      685  1.3  0.2   284    52  ?  R    02:54   0:23 ./crashme +2000 785 100 120 2 subprocess 
davem      686  1.3  0.2   284    52  ?  R    02:54   0:23 ./crashme +2000 785 100 120 2 subprocess 
davem      687  1.3  0.2   284    52  ?  R    02:54   0:23 ./crashme +2000 785 100 120 2 subprocess 
davem      712  1.3  0.2   192    52  ?  R    02:55   0:22 ./crashme +2000 792 100 127 2 subprocess 
davem      713  1.3  0.2   196    52  ?  R    02:55   0:22 ./crashme +2000 792 100 127 2 subprocess 
davem      714  1.3  0.2   192    52  ?  R    02:55   0:22 ./crashme +2000 792 100 127 2 subprocess 
davem      716  1.3  0.2   192    52  ?  R    02:55   0:22 ./crashme +2000 792 100 127 2 subprocess 
davem      821  1.2  0.2   348    52  ?  R    02:57   0:19 ./crashme +2000 819 100 154 2 subprocess 
davem      822  1.2  0.2   348    52  ?  R    02:57   0:19 ./crashme +2000 819 100 154 2 subprocess 
davem      876  1.2  0.2   220    56  ?  R    02:59   0:18 ./crashme +2000 833 100 168 2 subprocess 
davem      877  1.2  0.2   220    56  ?  R    02:59   0:18 ./crashme +2000 833 100 168 2 subprocess 
davem      878  1.2  0.2   220    56  ?  R    02:59   0:18 ./crashme +2000 833 100 168 2 subprocess 
davem      880  1.2  0.2   216    56  ?  R    02:59   0:18 ./crashme +2000 833 100 168 2 subprocess 
davem     1029  1.1  0.2   308    52  ?  R    03:02   0:15 ./crashme +2000 871 100 206 2 subprocess 
davem     1030  1.1  0.2   316    52  ?  R    03:02   0:15 ./crashme +2000 871 100 206 2 subprocess 
davem     1092  1.1  0.2   256    52  ?  R    03:03   0:13 ./crashme +2000 887 100 222 2 subprocess 
davem     1094  1.1  0.2   256    52  ?  R    03:03   0:13 ./crashme +2000 887 100 222 2 subprocess 
davem     1095  1.1  0.2   256    52  ?  R    03:03   0:13 ./crashme +2000 887 100 222 2 subprocess 
davem     1096  1.1  0.2   256    52  ?  R    03:03   0:13 ./crashme +2000 887 100 222 2 subprocess 
davem     1104  1.1  0.2   348    52  ?  R    03:04   0:13 ./crashme +2000 889 100 224 2 subprocess 
davem     1131  1.1  0.1   344    36  ?  R    03:04   0:13 ./crashme +2000 896 100 231 2 subprocess 
davem     1239  1.1  0.1   228    40  ?  R    03:07   0:11 ./crashme +2000 923 100 258 2 subprocess 
davem     1240  1.1  0.2   224    52  ?  R    03:07   0:11 ./crashme +2000 923 100 258 2 subprocess 
davem     1300  1.1  0.1   208    36  ?  R    03:09   0:10 ./crashme +2000 939 100 274 2 subprocess 
davem     1302  1.1  0.1   204    36  ?  R    03:09   0:10 ./crashme +2000 939 100 274 2 subprocess 
davem     1303  1.1  0.2   208    52  ?  R    03:09   0:10 ./crashme +2000 939 100 274 2 subprocess 
davem     1306  1.1  0.2   204    52  ?  R    03:09   0:10 ./crashme +2000 939 100 274 2 subprocess 
davem     1312  1.1  0.1   348    44  ?  R    03:09   0:10 ./crashme +2000 942 100 277 2 subprocess 
davem     1316  1.1  0.2   348    52  ?  R    03:09   0:10 ./crashme +2000 942 100 277 2 subprocess 
davem     1406  1.1  0.2   240    52  ?  R    03:11   0:08 ./crashme +2000 965 100 300 2 subprocess 
davem     1450  1.1  0.1   344    40  ?  R    03:12   0:07 ./crashme +2000 975 100 310 2 subprocess 
davem     1487  1.1  0.1   348    40  ?  R    03:13   0:07 ./crashme +2000 985 100 320 2 subprocess 
davem     1513  1.1  0.1   228    40  ?  R    03:13   0:06 ./crashme +2000 992 100 327 2 subprocess 
davem     1514  1.1  0.1   232    40  ?  R    03:13   0:06 ./crashme +2000 992 100 327 2 subprocess 
davem     1568  1.1  0.2   348    52  ?  R    03:15   0:06 ./crashme +2000 1006 100 341 2 subprocess 
davem     1571  1.1  0.2   348    52  ?  R    03:15   0:06 ./crashme +2000 1006 100 341 2 subprocess 
davem     1597  1.1  0.2   328    52  ?  R    03:15   0:05 ./crashme +2000 1012 100 347 2 subprocess 
davem     1608  1.1  0.2   332    52  ?  R    03:15   0:05 ./crashme +2000 1015 100 350 2 subprocess 
davem     1649  1.0  0.2  3960    52  ?  R    03:16   0:04 ./crashme +2000 1026 100 361 2 subprocess 
davem     1683  1.1  0.2   204    56  ?  R    03:17   0:04 ./crashme +2000 1035 100 370 2 subprocess 
davem     1685  1.2  0.2   200    52  ?  R    03:17   0:04 ./crashme +2000 1035 100 370 2 subprocess 
davem     1687  1.1  0.2   200    52  ?  R    03:17   0:04 ./crashme +2000 1035 100 370 2 subprocess 
davem     1690  1.1  0.2   204    64  ?  R    03:17   0:04 ./crashme +2000 1035 100 370 2 subprocess 
davem     1816  0.2  1.5   584   344  p0 S    03:20   0:00 -bash 
davem     1834  1.2  0.1   192    44  ?  R    03:20   0:02 ./crashme +2000 1072 100 407 2 subprocess 
davem     1835  1.1  0.2   192    52  ?  R    03:20   0:02 ./crashme +2000 1072 100 407 2 subprocess 
davem     1838  1.3  0.2   192    52  ?  R    03:20   0:02 ./crashme +2000 1072 100 407 2 subprocess 
davem     1840  1.1  0.3   192    68  ?  R    03:20   0:02 ./crashme +2000 1072 100 407 2 subprocess 
davem     1844  1.3  0.3   344    72  ?  R    03:20   0:02 ./crashme +2000 1073 100 408 2 subprocess 
davem     1858  1.2  0.2   256    60  ?  R    03:21   0:02 ./crashme +2000 1077 100 412 2 subprocess 
davem     1917  1.7  0.7   348   176  ?  R    03:22   0:01 ./crashme +2000 1089 100 424 2 subprocess 
davem     1958  1.9  1.0   312   240  p0 R    03:22   0:01 ps -auxwww 
davem     1977 24.1  1.0   344   240  ?  R    03:23   0:01 ./crashme +2000 1103 100 438 2 subprocess 
davem     2023 99.9  1.0   312   228  ?  R    03:24   0:00 ./crashme +2000 1115 100 450 2 subprocess 
davem     2028 99.9  1.0  2248   224  ?  R    03:24   0:00 ./crashme +2000 1117 100 452 2 subprocess 
davem     2039 99.9  0.6   220   140  ?  R    03:25   0:00 ./crashme +2000 1119 100 454 2 subprocess 
davem     2040 99.9  1.0   308   228  ?  R    03:25   0:00 ./crashme +2000 1120 100 455 2 subprocess 
davem     2041 99.9  1.0   320   240  ?  R    03:25   0:00 ./crashme +2000 1120 100 455 2 subprocess 
davem     2042 99.9  1.1   332   248  ?  R    03:25   0:00 ./crashme +2000 1119 100 454 2 subprocess 
davem     2043 99.9  0.7   240   156  ?  R    03:25   0:00 ./crashme +2000 1120 100 455 2 subprocess 
davem     2046 99.9  0.9   296   216  ?  R    03:25   0:00 ./crashme +2000 1120 100 455 2 subprocess 
davem     2049 99.9  1.0   308   224  ?  R    03:25   0:00 ./crashme +2000 1122 100 457 2 subprocess 
davem     2051 99.9  0.9   300   220  ?  R    03:25   0:00 ./crashme +2000 1122 100 457 2 subprocess 
davem     2053 99.9  1.0   308   224  ?  R    03:25   0:00 ./crashme +2000 1123 100 458 2 subprocess 
davem     2055 99.9  1.0   308   232  ?  R    03:25   0:00 ./crashme +2000 1123 100 458 2 subprocess 
davem     2058 99.9  0.9   304   220  ?  R    03:25   0:00 ./crashme +2000 1123 100 458 2 subprocess 
davem     2061 99.9  1.0   304   224  ?  R    03:25   0:00 ./crashme +2000 1125 100 460 2 subprocess 
davem     2063  0.0  0.2   148    60  ?  R    03:25   0:00 ./crashme +2000 666 100 1:10:30 2 
davem     2064  0.0  0.2   148    56  ?  R    03:25   0:00 ./crashme +2000 666 100 1:10:30 2 
davem     2065  0.0  0.2   148    56  ?  R    03:25   0:00 ./crashme +2000 1125 100 460 2 subprocess 
davem     2066 99.9  0.6   220   144  ?  R    03:25   0:00 ./crashme +2000 1126 100 461 2 subprocess 
davem     2067 99.9  0.6   224   144  ?  R    03:25   0:00 ./crashme +2000 1126 100 461 2 subprocess 
davem     2068 99.9  0.6   224   144  ?  R    03:25   0:00 ./crashme +2000 1127 100 462 2 subprocess 
davem     2069 99.9  0.6   224   144  ?  R    03:25   0:00 ./crashme +2000 1127 100 462 2 subprocess 
davem     2070 99.9  0.6   220   140  ?  R    03:25   0:00 ./crashme +2000 1126 100 461 2 subprocess 
davem     2071 99.9  0.6   220   144  ?  R    03:25   0:00 ./crashme +2000 1127 100 462 2 subprocess 
davem     2074 99.9  0.6   216   140  ?  R    03:25   0:00 ./crashme +2000 1127 100 462 2 subprocess 
davem     2086  0.0  0.2   148    64  ?  R    03:26   0:00 ./crashme +2000 666 100 1:10:30 2 
davem     2087  0.0  0.2   148    64  ?  R    03:26   0:00 ./crashme +2000 666 100 1:10:30 2 
davem     2088  0.0  0.2   148    64  ?  R    03:26   0:00 ./crashme +2000 666 100 1:10:30 2 
davem     2089  0.0  0.2   148    64  ?  R    03:26   0:00 ./crashme +2000 666 100 1:10:30 2 
davem     2090  0.0  0.2   148    64  ?  R    03:26   0:00 ./crashme +2000 666 100 1:10:30 2 
root         1  0.0  0.0   188     0  ?  SW   02:43   0:00 (init)
root         2  0.0  0.0     0     0  ?  SW   02:43   0:00 (kflushd)
root         3  0.0  0.0     0     0  ?  SW<  02:43   0:01 (kswapd)
root         4  0.0  0.0     0     0  ?  SW   02:43   0:00 (nfsiod)
root         5  0.0  0.0     0     0  ?  SW   02:43   0:00 (nfsiod)
root         6  0.0  0.0     0     0  ?  SW   02:43   0:00 (nfsiod)
root         7  0.0  0.0     0     0  ?  SW   02:43   0:00 (nfsiod)
root        11  0.0  0.1   116    28  ?  S    02:43   0:00 update (bdfluHOME=/ 
root        27  0.0  0.0   628     4  ?  S    02:44   0:00 (inetd)
root        29  0.0  0.0   636     0  ?  SW   02:44   0:00 (portmap)
root        32  0.0  0.3   272    72  ?  S    02:44   0:00 /usr/sbin/syslogd 
root        34  0.0  0.0   308     0  ?  SW   02:44   0:00 (klogd)
root        47  0.0  0.0   152     0   1 SW   02:44   0:00 (getty)
root        48  0.0  0.0   152     0   2 SW   02:44   0:00 (getty)
root        49  0.0  0.0   152     0   3 SW   02:44   0:00 (getty)
root        50  0.0  0.0   152     0   4 SW   02:44   0:00 (getty)
root        51  0.0  0.0   152     0   5 SW   02:44   0:00 (getty)
root        52  0.0  0.0   152     0   6 SW   02:44   0:00 (getty)
root        84  0.0  0.0   540     0  ?  SWN  02:44   0:00 (punish.sh)
root        99  0.0  0.0   892     0  ?  SWN  02:44   0:01 (make)
root       105  0.0  0.0   660     0  ?  SWN  02:44   0:00 (gcc)
root       107  0.0  0.0   552     0  ?  SWN  02:44   0:00 (bash)
root       109  0.0  0.0   864     0  ?  SWN  02:44   0:00 (make)
root       119  0.0  0.0  1416     0  ?  SWN  02:44   0:01 (cpp)
root       120  0.0  2.8  2776   620  ?  R N  02:44   0:01 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase main.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o - 
root       121  0.0  0.0  1128     0  ?  SWN  02:44   0:00 (as)
root       124  0.0  0.0   952     0  ?  SWN  02:44   0:01 (make)
root       137  0.0  0.0   660     0  ?  SWN  02:44   0:00 (gcc)
root       138  0.0  0.0   660     0  ?  SWN  02:44   0:00 (gcc)
root       139  0.0  0.0   660     0  ?  SWN  02:44   0:00 (gcc)
root       140  0.0  0.0  1288     0  ?  SWN  02:44   0:01 (cpp)
root       141  0.0  1.8  3088   408  ?  R N  02:44   0:02 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase sched.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -fno-omit-frame-pointer -o - 
root       142  0.0  0.0  1128     0  ?  SWN  02:44   0:00 (as)
root       144  0.0  1.9  2612   440  ?  R N  02:44   0:00 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase dma.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o - 
root       145  0.0  0.0   660     0  ?  SWN  02:44   0:00 (gcc)
root       146  0.0  0.0  1128     0  ?  SWN  02:44   0:00 (as)
root       147  0.0  0.0   660     0  ?  SWN  02:44   0:00 (gcc)
root       149  0.0  0.0  1216     0  ?  SWN  02:44   0:01 (cpp)
root       150  0.0  0.0   660     0  ?  SWN  02:44   0:00 (gcc)
root       151  0.0  0.4  3188    92  ?  R N  02:44   0:02 (cc1)
root       152  0.0  0.0  1128     0  ?  SWN  02:44   0:00 (as)
root       153  0.0  0.0  1232     0  ?  SWN  02:44   0:00 (cpp)
root       154  0.0  0.9  3216   208  ?  R N  02:44   0:02 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase exec_domain.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o - 
root       155  0.0  0.0  1236     0  ?  SWN  02:44   0:00 (cpp)
root       156  0.0  0.1  3212    40  ?  R N  02:44   0:02 (cc1)
root       157  0.0  0.0  1128     0  ?  SWN  02:44   0:00 (as)
root       158  0.0  0.0   660     0  ?  SWN  02:44   0:00 (gcc)
root       159  0.0  0.0  1128     0  ?  SWN  02:44   0:00 (as)
root       160  0.0  0.0  1144     0  ?  SWN  02:44   0:00 (cpp)
root       161  0.0  0.0   660     0  ?  SWN  02:44   0:00 (gcc)
root       162  0.1  0.4  3264   108  ?  R N  02:44   0:02 (cc1)
root       163  0.0  0.0  1128     0  ?  SWN  02:44   0:00 (as)
root       164  0.0  0.0   660     0  ?  SWN  02:44   0:00 (gcc)
root       165  0.0  0.0   660     0  ?  SWN  02:44   0:00 (gcc)
root       166  0.0  0.0  1420     0  ?  SWN  02:44   0:01 (cpp)
root       167  0.0  3.6  3100   796  ?  R N  02:44   0:01 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase sys.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o - 
root       168  0.0  0.0  1128     0  ?  SWN  02:44   0:00 (as)
root       169  0.0  0.0   660     0  ?  SWN  02:44   0:00 (gcc)
root       170  0.0  0.0   660     0  ?  SWN  02:44   0:00 (gcc)
root       171  0.0  0.0  1368     0  ?  SWN  02:44   0:01 (cpp)
root       172  0.0  0.4  3088   100  ?  R N  02:44   0:01 (cc1)
root       173  0.0  0.0  1128     0  ?  SWN  02:44   0:00 (as)
root       174  0.0  0.0  1260     0  ?  SWN  02:44   0:00 (cpp)
root       175  0.0  0.0  1196     0  ?  SWN  02:44   0:01 (cpp)
root       176  0.0  0.0   660     0  ?  SWN  02:44   0:00 (gcc)
root       177  0.1  1.7  3260   396  ?  R N  02:44   0:02 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase exit.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o - 
root       178  0.0  0.0  1128     0  ?  SWN  02:44   0:00 (as)
root       179  0.0  0.0  1252     0  ?  SWN  02:44   0:00 (cpp)
root       180  0.1  1.3  3264   292  ?  R N  02:44   0:02 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase signal.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o - 
root       181  0.0  0.0  1128     0  ?  SWN  02:44   0:00 (as)
root       182  0.1  0.7  3272   172  ?  R N  02:44   0:02 (cc1)
root       183  0.0  0.0  1128     0  ?  SWN  02:44   0:00 (as)
root       184  0.0  0.0   660     0  ?  SWN  02:44   0:00 (gcc)
root       185  0.0  0.0  1236     0  ?  SWN  02:44   0:01 (cpp)
root       186  0.0  0.8  3212   180  ?  R N  02:44   0:02 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase info.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o - 
root       187  0.0  0.0  1128     0  ?  SWN  02:44   0:00 (as)
root       188  0.0  0.0   660     0  ?  SWN  02:44   0:00 (gcc)
root       189  0.0  0.0  1316     0  ?  SWN  02:44   0:01 (cpp)
root       190  0.0  0.9  3144   204  ?  R N  02:44   0:02 (cc1)
root       191  0.0  0.0  1128     0  ?  SWN  02:44   0:00 (as)
root       192  0.0  0.0   660     0  ?  SWN  02:44   0:00 (gcc)
root       193  0.0  0.0  1188     0  ?  SWN  02:44   0:00 (cpp)
root       194  0.0  0.0  1104     0  ?  SWN  02:44   0:00 (cpp)
root       195  0.0  3.7  3072   824  ?  R N  02:44   0:01 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase resource.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o - 
root       196  0.0  0.0  1128     0  ?  SWN  02:44   0:00 (as)
root       197  0.0  3.3  3104   740  ?  R N  02:44   0:02 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase softirq.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o - 
root       198  0.0  0.0  1128     0  ?  SWN  02:44   0:00 (as)
root       199  0.0  0.0  1356     0  ?  SWN  02:44   0:01 (cpp)
root       200  0.0  2.5  2512   568  ?  R N  02:44   0:00 /usr/local/gnu/lib/gcc-lib/sparc-sun-sunos4.1.4/2.6.3/cc1 -quiet -dumpbase sysctl.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -o - 
root       201  0.0  0.0  1128     0  ?  SWN  02:44   0:00 (as)
root      1811  0.1  1.0   668   236  ?  S    03:20   0:00 /usr/etc/in.telnetd 
