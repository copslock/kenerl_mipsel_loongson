Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id UAA48702 for <linux-archive@neteng.engr.sgi.com>; Mon, 3 May 1999 20:37:45 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA66685
	for linux-list;
	Mon, 3 May 1999 20:34:04 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA53958
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 3 May 1999 20:34:02 -0700 (PDT)
	mail_from (clepple@foo.tho.org)
Received: from foo.tho.org (pr250.pheasantrun.net [208.140.225.250]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id XAA00256
	for <linux@cthulhu.engr.sgi.com>; Mon, 3 May 1999 23:33:57 -0400 (EDT)
	mail_from (clepple@foo.tho.org)
Received: from foo.tho.org (clepple@sprocket.foo.tho.org [206.223.45.3])
	by foo.tho.org (8.8.7/8.8.7) with ESMTP id XAA29966
	for <linux@cthulhu.engr.sgi.com>; Mon, 3 May 1999 23:33:56 -0400
Message-ID: <372E6AA0.505A6071@foo.tho.org>
Date: Tue, 04 May 1999 03:33:52 +0000
From: Charles Lepple <clepple@foo.tho.org>
X-Mailer: Mozilla 4.5 [en] (X11; U; Linux 2.0.36 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux/SGI <linux@cthulhu.engr.sgi.com>
Subject: building an elf64 R10k kernel
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hey all,
Does anyone out there know any details on building elf64 objects? I was
all happy about seeing Andrew's Indigo2 patches, and decided that I
_had_ to try and make it work on an Indigo2 Impact 10000... Suffice it
to say that it isn't straightforward.

I first tried to get the machine to boot an elf32 kernel. That failed
miserably, since it doesn't recognize 32-bit ELF objects. Comparison of
sashARCS and sash64 indicated that I needed to use elf64. My first
inclination was to just try the same load address as the Indys and r4400
Indigo2s use. I can't remember the exact error message, but the PROM
basically panicked while loading the first word at 0x88002000 (or
wherever). So I tried using the 64 bit start address from sash64 (high
hex nibble is 0xa). Needless to say, the elf32 linker options conflicted
with that one, and the linker (from binutils-2.8.1 or so) seg faulted.

When I finally recompiled with -mips3 and with a revised linker script,
I noticed something curious. Instead of just truncating the 64-bit
addresses, it rounded them off to 0xffffffff. Any thoughts on this? Am I
approaching this wrong?

And does anyone have a semi-offical memory map for the R10k Indigo2s?

-- 
Charles Lepple
System Administrator, Virginia Tech EE Workstation Labs
clepple@ee.vt.edu || http://www.foo.tho.org/charles/
