Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Feb 2004 16:13:00 +0000 (GMT)
Received: from brilsmurf.chem.tue.nl ([IPv6:::ffff:131.155.84.68]:10722 "EHLO
	brilsmurf.chem.tue.nl") by linux-mips.org with ESMTP
	id <S8224991AbUBLQM7>; Thu, 12 Feb 2004 16:12:59 +0000
Received: from brilsmurf.chem.tue.nl (localhost [127.0.0.1])
	by brilsmurf.chem.tue.nl (8.12.3/8.12.3/Debian-6.6) with ESMTP id i1CGCwvI022610
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-mips@linux-mips.org>; Thu, 12 Feb 2004 17:12:59 +0100
Received: from localhost (joost@localhost)
	by brilsmurf.chem.tue.nl (8.12.3/8.12.3/Debian-6.6) with ESMTP id i1CGCwSx006021
	for <linux-mips@linux-mips.org>; Thu, 12 Feb 2004 17:12:58 +0100
X-Authentication-Warning: brilsmurf.chem.tue.nl: joost owned process doing -bs
Date: Thu, 12 Feb 2004 17:12:58 +0100 (CET)
From: Joost <Joost@stack.nl>
X-X-Sender: joost@brilsmurf.chem.tue.nl
To: linux-mips@linux-mips.org
Subject: indy r4000FPC kernel?
Message-ID: <Pine.LNX.4.58.0402121652410.24037@brilsmurf.chem.tue.nl>
ReplyTo: Joost@stack.nl
User-Agent: 007
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Joost@stack.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Joost@stack.nl
Precedence: bulk
X-list: linux-mips

Hello,

Is this the correct list to be asking about kernel trouble?
If not, i apologize for this lengthy piece of offtopic ranting :-)

  I'm trying to get a working kernel on my indy, but 2.4.16
seems to be as far as it will go. The 2.4.22 that comes with
debian testing gives an error while booting so i decided
to try and be adventurous and downloaded the 2.6 sources
via cvs. The PROM in this beast is old i gues, it won't
boot elf kernels, so i used the 'ecoff' tip on linux-mips.com.
  Going from elf to ecoff gives out a warning:
arch/mips/boot/elf2ecoff vmlinux vmlinux.ecoff
wrote 20 byte file header.
wrote 56 byte a.out header.
wrote 120 bytes of section headers.
wrote 12 byte pad.
writing 3685492 bytes...
Warning: 908 byte intersegment gap.
writing 499845 bytes...
  Is this warning about the 'intersegment gap' something I
can safely ignore?
  After booting this kernel it panics, complaining about
'unaligned instruction access in arch/mips/kernel/unaligned.c::do_ade,
line 544[#1]: cpu 0' followd by lots of yukkie numbers and a call trace:
[<883e558c>] mem_init+0x6c/0x1e4
[<883ef580>] start_kernel+0x114/0x238
[<883ef588>] start_kernel+0x17c/0x238
[<883ef30c>] unknown_bootoption+0x0/0x130
[<883ef08c>] no_smp+0x0/0x10
Kernel Panic! Attempted to kill the idle task!

  Am I doing something obvious wrong? The compiler in use is
gcc-2.95.4, the machine is an indy with r4000FPC. I'm doing
a native compile (yes, my time is cheap :-).

Thank you for your time!

Joost.
--
I have spent most of my money on women and beer. The rest I just wasted...
