Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Nov 2002 17:22:16 +0100 (CET)
Received: from crack.them.org ([65.125.64.184]:41743 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S1123923AbSKLQWP>;
	Tue, 12 Nov 2002 17:22:15 +0100
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 18Bfg3-0001iA-00; Tue, 12 Nov 2002 12:22:19 -0600
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 18Bdok-0000mP-00; Tue, 12 Nov 2002 11:23:10 -0500
Date: Tue, 12 Nov 2002 11:23:10 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: atul srivastava <atulsrivastava9@rediffmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: problem with big endian binutils..?
Message-ID: <20021112162310.GA2934@nevyn.them.org>
References: <20021112132512.31137.qmail@mailweb34.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021112132512.31137.qmail@mailweb34.rediffmail.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 12, 2002 at 01:25:12PM -0000, atul srivastava wrote:
> Have anybody confirmed stability of binutils for big endian 
> mips?
> while little endian gives me no problem
> but i am simply unable to make a working big endian ramdisk.
> 
> specific problem is in identifying the e_type and e_machine fields 
> in elf header of executables.
> expected value of e_type is 0x2(ET_EXEC) amd e_machine is 
> 0x8(EM_MIPS)
> but those are read as 0x200 and 0x800 respectivly ..this is 
> obviously the endianness problem.

Binutils is just fine.  This is a problem with whatever's reading them.

> I have tried big endian ramdisk from 
> ftp://ftp.ltc.com/pub/linux/mips/ramdisk/ramdisk
> and also tried compiling one using uclibc package , both
> failed because of same reason.
> 
> when i run file command on those executables after mounting the 
> ramdisk on my host i get o/p like
> 
> ELF 32-bit LSB executable, MIPS R3000_BE - invalid byte order, 
> version 1, statically linked, stripped
> 
> though i see lot of mails regarding "invalid byteorder" but I 
> didn't find specific suggestions.

It's normal.  The 'file' output is outdated.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
