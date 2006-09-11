Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Sep 2006 22:32:06 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:57788 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S20038533AbWIKVcE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 11 Sep 2006 22:32:04 +0100
Received: from lagash (88-106-139-84.dynamic.dsl.as9105.com [88.106.139.84])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id BD75748A5C; Mon, 11 Sep 2006 23:32:03 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GMtM0-0008KG-8W; Mon, 11 Sep 2006 22:30:08 +0100
Date:	Mon, 11 Sep 2006 22:30:08 +0100
To:	Dirk Behme <dirk.behme@googlemail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: QEMU MIPS user space emulation issue
Message-ID: <20060911213008.GD13414@networkno.de>
References: <450589A6.5040808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450589A6.5040808@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Dirk Behme wrote:
> Hi,
> 
> we have an issue using QEMUs MIPS user space emulation 
> running programs compiled with mipsel glibc based 
> crosscompiler [1]. Because I'm not sure if it's a QEMU or 
> toolchain (or anything else?) issue, I'd like to ask the 
> experts here.
> 
> Up to now, the conclusion from [1] is that QEMUs mipsel user 
> space emulation fails executing a simple hello world program 
> if compiled with glibc based mipsel toolchain build with 
> crosstool and linked dynamically. Compiled with toolchain 
> using uClib or same program linked statically (-static) is okay.

So this is unlikely to be a kernel problem.

> For example, hello world compiled with mipsel toolchain 
> build with crosstool-0.42 configuration
> 
> cat mipsel.dat gcc-3.4.1-glibc-2.3.2.dat
> 
> fails if dynamically linked. As mentioned above, using 
> -static is okay.

Start from a known working mipsel userland, e.g. the one from Debian
unstable, and use it to isolate the bug.

> If failing, debug output shows that code
> 
> ...
> 0x401fa00c:  lw t9,-32600(gp)
> 0x401fa010:  addiu      a0,a0,30820
> 0x401fa014:  addiu      a1,a1,29452
> 0x401fa018:  addiu      a3,a3,25856
> 0x401fa01c:  jalr       t9
> 0x401fa020:  li a2,161
> ...

Sa a guess, it might be a dynamic symbol mis-resolved by the ld.so.


Thiemo
