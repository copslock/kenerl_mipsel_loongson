Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id OAA15200
	for <pstadt@stud.fh-heilbronn.de>; Tue, 20 Jul 1999 14:10:50 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id FAA00953; Tue, 20 Jul 1999 05:08:29 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA69182
	for linux-list;
	Tue, 20 Jul 1999 05:05:32 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA77102
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 20 Jul 1999 05:05:30 -0700 (PDT)
	mail_from (mkomiya@crossnet.co.jp)
Received: from crossnet.co.jp ([210.232.77.94]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA03530
	for <linux@cthulhu.engr.sgi.com>; Tue, 20 Jul 1999 05:05:28 -0700 (PDT)
	mail_from (mkomiya@crossnet.co.jp)
Received: from crossnet.co.jp (nimbus [192.168.77.96])
	by crossnet.co.jp (8.8.7/3.6Wbeta6) with ESMTP id MAA06015
	for <linux@cthulhu.engr.sgi.com>; Tue, 20 Jul 1999 12:07:05 +0900
Message-ID: <37946628.F2D5BA61@crossnet.co.jp>
Date: Tue, 20 Jul 1999 21:06:00 +0900
From: Masami Komiya <mkomiya@crossnet.co.jp>
X-Mailer: Mozilla 4.5 [ja] (Win98; I)
X-Accept-Language: ja
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: glibc cross-compile error
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

I could not cross-compile glibc using Linux/MIPS-2.2.10 sources
because of asm-mips/timex.h.
My workarround is 

*** timex.h.org	Fri Jun 11 11:18:29 1999
--- timex.h	Tue Jul 20 20:34:59 1999
***************
*** 31,36 ****
--- 31,40 ----
  typedef unsigned int cycles_t;
  extern cycles_t cacheflush_time;
  
+ #ifndef __ASM_MIPS_MIPSREGS_H
+ #include <asm/mipsregs.h>
+ #endif
+ 
  static inline cycles_t get_cycles (void)
  {
  	return read_32bit_cp0_register(CP0_COUNT);

I afraid this workarround will be the cause of the another.
Does anyone has the better solution ?

Masami Komiya
