Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2003 21:15:15 +0100 (BST)
Received: from SteeleMR-loadb-NAT-49.caltech.edu ([IPv6:::ffff:131.215.49.69]:39549
	"EHLO water-ox.its.caltech.edu") by linux-mips.org with ESMTP
	id <S8225511AbTJGTqy>; Tue, 7 Oct 2003 20:46:54 +0100
Received: from fire-dog (fire-dog [192.168.1.4])
	by water-ox-postvirus (Postfix) with ESMTP id 862B026AC1A
	for <linux-mips@linux-mips.org>; Tue,  7 Oct 2003 12:46:46 -0700 (PDT)
Received: from earth-ox ([192.168.1.9])
	by fire-dog (MailMonitor for SMTP v1.2.2 ) ;
	Tue, 7 Oct 2003 12:46:45 -0700 (PDT)
Received: from blinky.its.caltech.edu (blinky.its.caltech.edu [131.215.48.132])
	by earth-ox.its.caltech.edu (Postfix) with ESMTP id 98C59109A1B
	for <linux-mips@linux-mips.org>; Tue,  7 Oct 2003 12:46:45 -0700 (PDT)
Received: from localhost (noah@localhost)
	by blinky.its.caltech.edu (8.12.9/8.12.8) with ESMTP id h97Jkip7025946
	for <linux-mips@linux-mips.org>; Tue, 7 Oct 2003 12:46:45 -0700 (PDT)
X-Authentication-Warning: blinky.its.caltech.edu: noah owned process doing -bs
Date: Tue, 7 Oct 2003 12:46:44 -0700 (PDT)
From: "Noah J. Misch" <noah@caltech.edu>
X-X-Sender: noah@blinky
To: linux-mips@linux-mips.org
Subject: Possible Missing include in arch/mips/kernel/vmlinux.lds.S
Message-ID: <Pine.GSO.4.58.0310071220150.23851@blinky>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <noah@caltech.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3372
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noah@caltech.edu
Precedence: bulk
X-list: linux-mips

Please CC:/To: relevant messages to me; I do not subscribe to linux-mips.

Executive summary: File in subject line may need #include <linux/config.h>

I just wrote a new version of scripts/configcheck.pl, the script that runs
when you call 'make configcheck' in a linux source tree.  This script is
supposed to find files that need to include linux/config.h but do not
include it, and vice-versa.  I found only one file in the 2.6.0-test6 tree
that needs config.h and does not include it[1]:

arch/mips/kernel/vmlinux.lds.S

This file uses CONFIG_BOOT_ELF64, CONFIG_MIPS32, and CONFIG_MIPS64, but
neither it nor the one file it includes, asm-generic/vmlinux.lds.h,
include linux/config.h.  This is true both in the linux-2.6.0-test6
version, and also in the linux-mips CVS tree as of 3:00 PM 10/7/2003.

I don't use linux-mips myself, so I haven't verified this issue with a
real toolchain.  It seems pretty clear-cut, but if I'm mistaken, would one
of you send me arch/mips/kernel/.vmlinux.lds.s.cmd from the tree of a
built kernel so I can fix my methodology? :)

[1] That is, in a way that would cause bugs right now.  Many, many files
need config.h but include it only indirectly, and many files need config.h
but never compile standalone.  I found only one file that does not fall
into either category.
