Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA55554 for <linux-archive@neteng.engr.sgi.com>; Sun, 19 Jul 1998 08:36:36 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA65641
	for linux-list;
	Sun, 19 Jul 1998 08:36:05 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA05931
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 19 Jul 1998 08:36:02 -0700 (PDT)
	mail_from (mjhsieh@helix.life.nthu.edu.tw)
Received: from helix.life.nthu.edu.tw (helix.life.nthu.edu.tw [140.114.98.34]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA16215
	for <linux@cthulhu.engr.sgi.com>; Sun, 19 Jul 1998 08:36:01 -0700 (PDT)
	mail_from (mjhsieh@helix.life.nthu.edu.tw)
Received: (from mjhsieh@localhost)
	by helix.life.nthu.edu.tw (8.8.7/8.8.7) id XAA07942;
	Sun, 19 Jul 1998 23:35:27 +0800
Message-ID: <19980719233527.A7930@helix.life.nthu.edu.tw>
Date: Sun, 19 Jul 1998 23:35:27 +0800
From: "Francis M. J. Hsieh" <mjhsieh@helix.life.nthu.edu.tw>
To: Linux <linux@cthulhu.engr.sgi.com>
Subject: benchmark........
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Well, here is a benchmark using MDBNCH, a benchmark program doing floating
point calculation on molecular dynamics (one of the research fields of out lab)

SGI Indy, R4600PC 133MHz, f77 4.0.2, -mips2 -O3 -sopt ......... 73.0 s  12Feb96
SGI Indy, R4600PC 133MHz, f77 4.0.2, -mips2 -O2 ............... 77.4 s  12Feb96
SGI Indy, R4600PC 133MHz, f77 4.0.2, -mips2 -O3 ............... 80.5 s  12Feb96
SGI Indy, R4600PC 100MHz, f77 4.0.1, -mips2 -O2 -sopt ......... 89.0 s  02Nov94
SGI Indy, R4600PC 100MHz, f77 4.0.1, -mips2 -O2 ............... 95.2 s  02Nov94
SGI Indy, R4600PC 100MHz, f77 4.0.1, -mips2 -O2 -non_shared .. 100.4 s  02Nov94
SGI Indy, R4600PC 100MHz, f77 4.0.1, -mips2 -O3 -non_shared .. 101.7 s  02Nov94
SGI Indy, R4000PC 100MHz, f77 4.0.1, -mips2 -O2 -sopt ........ 102.8 s  01Nov94
SGI Indy, R4000PC 100MHz, egcs-g77, -O2 -ff77 ................ 104.3 s  19Jul98
  (hardhat kernel 2.1.100)
SGI Indy, R4000PC 100MHz, f77 4.0.1, -mips2 -O2 -sopt -static  109.6 s  01Nov94
SGI Indy, R4000PC 100MHz, f77 4.0.1, -mips2 -O2 -ddopt ....... 110.2 s  01Nov94
SGI Indy, R4000PC 100MHz, f77 4.0.1, -mips2 -O2 .............. 110.6 s  01Nov94
SGI Indy, R4000PC 100MHz, f77 4.0.1, -mips2 -O2 -non_shared .. 114.4 s  01Nov94
SGI Indy, R4000PC 100MHz, f77 4.0.1, -mips2 -O3 -non_shared .. 128.9 s  01Nov94
SGI Indy, R4000PC 100MHz, f77 4.0.1, -mips2 -O2 -static ...... 145.5 s  01Nov94
SGI Indy, R4000PC 100MHz, f77 4.0.1, -mips2 -O1 .............. 154.3 s  01Nov94

for more information about MDBNCH see http://www.sissa.it/furio/mdbnch.html

--
Francis M. J. Hsieh      | Email:   mjhsieh@life.nthu.edu.tw
Life Science Department, | Webpage: http://www.life.nthu.edu.tw/~mjhsieh/
National Tsing Hua Univ, | Voice:   +886 3 5715131 ext 3482
HsinChu, Taiwan Republic | 	    +886 3 5715649
