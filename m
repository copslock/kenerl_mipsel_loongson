Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Apr 2003 00:34:58 +0100 (BST)
Received: from p508B65B8.dip.t-dialin.net ([IPv6:::ffff:80.139.101.184]:49348
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225255AbTD0Xez> convert rfc822-to-8bit; Mon, 28 Apr 2003 00:34:55 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3RNYph14201;
	Mon, 28 Apr 2003 01:34:51 +0200
Date: Mon, 28 Apr 2003 01:34:51 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Karsten Merker <karsten@excalibur.cologne.de>
Cc: linux-mips@linux-mips.org
Subject: Re: Die ll/sc-Emulation ist immer noch kaputt...
Message-ID: <20030428013451.A13685@linux-mips.org>
References: <20030425180419.GB6120@excalibur.cologne.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030425180419.GB6120@excalibur.cologne.de>; from karsten@excalibur.cologne.de on Fri, Apr 25, 2003 at 08:04:19PM +0200
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 25, 2003 at 08:04:19PM +0200, Karsten Merker wrote:

> mipsel-linux-gcc -D__KERNEL__ -I/tmp/linux-2.4/linux/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -fomit-frame-pointer
> -I /tmp/linux-2.4/linux/include/asm/gcc -G 0 -mno-abicalls -fno-pic -pipe
> -mcpu=r3000 -mips1   -nostdinc -iwithprefix include -DKBUILD_BASENAME=proc
> -c -o proc.o proc.c
> proc.c: In function how_cpuinfo':
> proc.c:118: l_ops' undeclared (first use in this function)
> proc.c:118: (Each undeclared identifier is reported only once
> proc.c:118: for each function it appears in.)
> proc.c:119: c_ops' undeclared (first use in this function)
> make[1]: *** [proc.o] Fehler 1
> make[1]: Leaving directory /tmp/linux-2.4/linux/arch/mips/kernel'
> 
> Bau Deine Kernels bitte mal mit defconfig-decstation, bevor Du sie
> eincheckst }:->

You got odd control characters in your mail ...

Somhow those ll/sc counters in their current form are rather useless as
they're only per system, not per thread so for now I'm removing them.
Yell if somebody minds - I just don't think they're really useful in
their current form ...

  Ralf
