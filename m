Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id TAA07070 for <linux-archive@neteng.engr.sgi.com>; Sun, 1 Nov 1998 19:53:15 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA63852
	for linux-list;
	Sun, 1 Nov 1998 19:52:14 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.42.13])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA01929
	for <linux@engr.sgi.com>;
	Sun, 1 Nov 1998 19:52:11 -0800 (PST)
	mail_from (ariel@oz.engr.sgi.com)
Received: (from ariel@localhost) by oz.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) id TAA35937 for linux@engr.sgi.com; Sun, 1 Nov 1998 19:52:11 -0800 (PST)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199811020352.TAA35937@oz.engr.sgi.com>
Subject: booting problems (forward)
To: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
Date: Sun, 1 Nov 1998 19:52:11 -0800 (PST)
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

[Forwarding a bounced message ]

:From: Luke Deller <luked@cse.unsw.edu.au>
:To: adevries@engsoc.carleton.ca
:Date: Sun, 1 Nov 1998 16:33:18 +1100 (EST)
:X-Sender: luked@ganter.disy.cse.unsw.EDU.AU
:cc: linux@engr.sgi.com
:Subject: mips linux
:Message-ID: <Pine.OSF.3.95.981101161535.18240B-100000@ganter.disy.cse.unsw.EDU.AU>
:MIME-Version: 1.0
:Content-Type: TEXT/PLAIN; charset=US-ASCII
:
:Hi,
:
:We have installed linux on an SGI Indy with no level 2 cache.
:As requested in a README file, i'm letting you guys know how we went.
:
:There was an untested kernel in:
:ftp.linux.sgi.com:/pub/test/vmlinux-indy-noL2-2.1.72.tar.gz
:We tried this kernel and it didn't work.  The screen went black, so it looks
:like it got into console mode ok, but there was no text output at all.
:
:We have successfully booted linux using the kernel in:
:ftp.linux.sgi.com:/pub/test/vmlinux-indy-noL2-971208.tar.gz
:
:There was one problem that we encountered with the simple filesystem in:
:ftp.linux.sgi.com:/pub/mips-linux/GettingStarted/root-be-0.04.cpio.gz
:It is missing libz.so, so "rpm" couldn't run.  We had to use an x86 linux
:box to extract the zlib rpm so that we could extract other rpms on the mips 
:box.
:
:If you would like us to test any more mips-linux kernels for an indy with no
:level 2 cache, please don't hesitate to email me.
:
:Luke.
:
:--------------------------------------------------------------------------
:           Luke Deller                               luked@cse.unsw.edu.au
: _--_|\    Computer Engineering student           
:/      \   School of Computer Science and Engineering     ? ? ? ?        
:\_.--._*   The University of New South Wales               ~~^^~  
:      v    Sydney, NSW     2052    AUSTRALIA                o o
:-------------------------------------------------------ooO--(_)--Ooo------
:


-- 
Peace, Ariel
