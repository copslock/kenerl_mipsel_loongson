Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id LAA918152; Fri, 25 Jul 1997 11:35:09 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA18422 for linux-list; Fri, 25 Jul 1997 11:33:44 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA18404 for <linux@engr.sgi.com>; Fri, 25 Jul 1997 11:33:38 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA28683
	for <linux@engr.sgi.com>; Fri, 25 Jul 1997 11:33:33 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id UAA25237; Fri, 25 Jul 1997 20:32:00 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199707251832.UAA25237@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id UAA06233; Fri, 25 Jul 1997 20:31:58 +0200
Subject: Modutils 2.1.42 for MIPS
Date: Fri, 25 Jul 1997 20:31:57 +0200 (MET DST)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Apparently-To: <linux@cthulhu.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

I've copied my home CVS repository of modutils to Linus.  There are still two
one line fixes to the kernel required to make modules work.  I'll check them
in asap.  Many modules are working reliable while other don't work at all.
I suppose there is still some bug in the relocation code.  Try 'en and check
if they work for you.  When modutils are finally debugged I'll release normal
tar.gz source packages and binaries on the usual FTP sites.

Another note about modules affects the performance.  Modules are allocated in
kernel virtual memory which starts from 0xc0000000 upward.  This exceeds the
range of the R_MIPS_16 relocation for j and jal instructions.  Therefore
modules have to be compiled using the option -mlong-jumps which replaces j
and jal instructions by la jr/jalr sequences.  These take twelve instead
for four bytes and are a bit slower.  There are more efficient way to solve
this problem but these are also more complex.

Simple rules to optimize module code when using -mlong-jump:

  - Try to call as view external functions as possible.  Only calls
    to external functins are affected by -mlong-jumps.
  - Taking the address of a function and calling it via a function
    pointer is advantageous for repeated calls.

This is a problematic specific to MIPS.  The other considerations that
apply to modules on Intel machines apply unchanged to MIPS.

Probably not worth to write that much about ...

  Ralf
