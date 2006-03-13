Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Mar 2006 21:16:20 +0000 (GMT)
Received: from bender.bawue.de ([193.7.176.20]:26258 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S8133524AbWCMVQK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Mar 2006 21:16:10 +0000
Received: from lagash (unknown [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 1B2AA456D5; Mon, 13 Mar 2006 22:25:13 +0100 (MET)
Received: from ths by lagash with local (Exim 4.60)
	(envelope-from <ths@networkno.de>)
	id 1FIuXo-0005YP-J0; Mon, 13 Mar 2006 21:25:36 +0000
Date:	Mon, 13 Mar 2006 21:25:36 +0000
To:	Kurt Schwemmer <kurts@vitesse.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Cross compile kernel w/ buildroot toolchain
Message-ID: <20060313212535.GF15212@networkno.de>
References: <389E6A416914954182ECDFCD844D8269434FC1@MX-COS.vsc.vitesse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <389E6A416914954182ECDFCD844D8269434FC1@MX-COS.vsc.vitesse.com>
User-Agent: Mutt/1.5.11+cvs20060126
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10799
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

On Mon, Mar 13, 2006 at 02:07:34PM -0700, Kurt Schwemmer wrote:
> I didn't touch any of the source yet. 

Hm, are you sure? Because...

> make -f scripts/Makefile.build obj=arch/mips/kernel
>   /klocal/buildroot/build_mipsel/staging_dir/bin/mipsel-linux-gcc
> -Wp,-MD,arch/mips/kernel/.entry.o.d  -nostdinc -isystem
> /klocal/buildroot/build_mipsel/staging_dir/bin-ccache/../lib/gcc/mipsel-
> linux-uclibc/3.4.5/include -D__KERNEL__ -Iinclude  -D__ASSEMBLY__  -I
> /usr/local/src/linux-2.6/include/asm/gcc -G 0 -mno-abicalls -fno-pic
> -pipe  -finline-limit=100000 -mabi=32 -march=mips32r2 -Wa,-32
> -Wa,-march=mips32r2 -Wa,-mips32r2 -Wa,--trap
> -Iinclude/asm-mips/mach-mips -Iinclude/asm-mips/mach-generic -Wall
> -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common
> -ffreestanding -O2     -fomit-frame-pointer  -I
> /usr/local/src/linux-2.6/include/asm/gcc -G 0 -mno-abicalls -fno-pic
> -pipe  -finline-limit=100000 -mabi=32 -march=mips32r2 -Wa,-32
> -Wa,-march=mips32r2 -Wa,-mips32r2 -Wa,--trap
> -Iinclude/asm-mips/mach-mips -Iinclude/asm-mips/mach-generic    -c -o
> arch/mips/kernel/entry.o arch/mips/kernel/entry.S
> arch/mips/kernel/entry.S: Assembler messages:
> arch/mips/kernel/entry.S:157: Error: opcode not supported on this
> processor: mips32 (mips32) `jr.hb $31'

... arch/mips/kernel/entry.S has only 147 lines in the copy I see.

> make[1]: *** [arch/mips/kernel/entry.o] Error 1
> make: *** [arch/mips/kernel] Error 2
> 
> Also, assembler -v output:
> GNU assembler version 2.16.1 (mipsel-linux-uclibc) using BFD version
> 2.16.1

What's also weird is that gas gets the mips32r2 option fed four times
(just to make sure?) and still claims it got mips32 (r1) in the error
message.


Thiemo
