Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Nov 2002 18:49:50 +0100 (CET)
Received: from p508B764F.dip.t-dialin.net ([80.139.118.79]:18566 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1123923AbSKLRtt>; Tue, 12 Nov 2002 18:49:49 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gACHmCR26127;
	Tue, 12 Nov 2002 18:48:12 +0100
Date: Tue, 12 Nov 2002 18:48:12 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: atul srivastava <atulsrivastava9@rediffmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: problem with big endian binutils..?
Message-ID: <20021112184811.A1972@linux-mips.org>
References: <20021112132257.22770.qmail@webmail24.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021112132257.22770.qmail@webmail24.rediffmail.com>; from atulsrivastava9@rediffmail.com on Tue, Nov 12, 2002 at 01:22:57PM -0000
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 12, 2002 at 01:22:57PM -0000, atul srivastava wrote:

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

Possibly a problem in your reader.  Are you using od to look at the
header?  Od is dumping in the byteorder of the machine it's running on.

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

The error message you're seeing simply means byte 5 of the ELF file is
zero that is unset that is not specifying any endianess.

> though i see lot of mails regarding "invalid byteorder" but I 
> didn't find specific suggestions.

It's a tool bug but a fairly harmless one.

  Ralf
