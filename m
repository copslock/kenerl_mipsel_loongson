Received:  by oss.sgi.com id <S42339AbQFTUPK>;
	Tue, 20 Jun 2000 13:15:10 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:30740 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42306AbQFTUOx>; Tue, 20 Jun 2000 13:14:53 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id NAA01454
	for <linux-mips@oss.sgi.com>; Tue, 20 Jun 2000 13:20:02 -0700 (PDT)
	mail_from (rmk@arm.linux.org.uk)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id NAA85692 for <linux-mips@oss.sgi.com>; Tue, 20 Jun 2000 13:14:21 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA49633
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 20 Jun 2000 13:12:25 -0700 (PDT)
	mail_from (rmk@arm.linux.org.uk)
Received: from caramon.arm.linux.org.uk (p10-robin-gui.tch.enablis.net [194.168.180.70]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA04651
	for <linux@cthulhu.engr.sgi.com>; Tue, 20 Jun 2000 13:12:12 -0700 (PDT)
	mail_from (rmk@arm.linux.org.uk)
Received: from flint.arm.linux.org.uk (root@flint [192.168.0.4])
	by caramon.arm.linux.org.uk (8.9.3/8.9.3) with ESMTP id VAA23228;
	Tue, 20 Jun 2000 21:11:39 +0100
Received: (from rmk@localhost)
	by flint.arm.linux.org.uk (8.9.3/8.9.3) id VAA22426;
	Tue, 20 Jun 2000 21:10:06 +0100
From:   Russell King <rmk@arm.linux.org.uk>
Message-Id: <200006202010.VAA22426@flint.arm.linux.org.uk>
Subject: Re: Proposal: non-PC ISA bus support
To:     Geert.Uytterhoeven@sonycom.com (Geert Uytterhoeven)
Date:   Tue, 20 Jun 2000 21:10:06 +0100 (BST)
Cc:     linux-kernel@vger.rutgers.edu (Linux kernel),
        linuxppc-dev@lists.linuxppc.org (Linux/PPC Development),
        linux@cthulhu.engr.sgi.com (Linux/MIPS Development)
In-Reply-To: <Pine.GSO.4.10.10006201254290.8592-100000@dandelion.sonytel.be> from "Geert Uytterhoeven" at Jun 20, 2000 01:21:10 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Geert Uytterhoeven writes:
>  1. ISA I/O space is memory mapped on many platforms (e.g. PPC and MIPS). To
>     access it from user space, you cannot plainly use inb() and friends like on
>     PC, but you have to mmap() the correct region of /dev/mem first. This
>     region depends on the machine type and currently there's no simple way to
>     find out from user space.

We've already solved this on ARM.  Check out arch/arm/kernel/isa.c
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | |   http://www.arm.linux.org.uk/~rmk/aboutme.html    /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
