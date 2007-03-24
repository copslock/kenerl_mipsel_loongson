Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Mar 2007 23:24:19 +0000 (GMT)
Received: from phoenix.bawue.net ([193.7.176.60]:11729 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20022916AbXCXXYB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 24 Mar 2007 23:24:01 +0000
Received: from lagash (88-106-169-123.dynamic.dsl.as9105.com [88.106.169.123])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 428D4B805B;
	Sun, 25 Mar 2007 00:15:40 +0100 (CET)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1HVFSs-0003jg-TM; Sat, 24 Mar 2007 23:16:02 +0000
Date:	Sat, 24 Mar 2007 23:16:02 +0000
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	kumba@gentoo.org, linux-mips@linux-mips.org, vagabon.xyz@gmail.com
Subject: Re: Building 64 bit kernel on Cobalt
Message-ID: <20070324231602.GP2311@networkno.de>
References: <4603DA74.70707@gentoo.org> <20070324.002440.93023010.anemo@mba.ocn.ne.jp> <46049BAD.1010705@gentoo.org> <20070324.234727.25910303.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070324.234727.25910303.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Fri, 23 Mar 2007 23:31:57 -0400, Kumba <kumba@gentoo.org> wrote:
> > Well, o64 went away as we all know.  It was never a favourable
> > option for very good reasons (although I used it right up until it
> > died and I was forced off of it).  The replacement for it, that was
> > more preferred and resulted in similar code was building a kernel
> > for any of these three systems using CONFIG_BUILD_ELF64 + -msym32
> > (auto selected in the Makefile) + the make vmlinux.32 target.  I
> > believe this method is what Debian uses for building their mips
> > kernels for SGI systems, but don't quote me on that.  If someone
> > from Debian wants to comment, please do.
> 
> The replacement is CONFIG_BUILD_ELF64=n (it adds -msym32 option) +
> CONFIG_BOOT_ELF32=y (it adds vmlinux.32 to "all" target).  Not
> CONFIG_BUILD_ELF64=y.
> 
> CONFIG_BUILD_ELF64=n enables -msym32 option, which means the kernel
> load address should be CKSEG0.

This sounds wrong to me, since CONFIG_BUILD_ELF64=n will build a
ELF64 kernel (from compiler/linker POV). This tricks people into
believing they need no ELF64 capable toolchain for a 64bit kernel.

IMO -msym32 should depend on:
    ((Compiler can do -msym32)
     && (load address is in ckseg0)
     && CONFIG_64BIT)

which obsoletes the whole CONFIG_BUILD_ELF* stuff.


Thiemo
