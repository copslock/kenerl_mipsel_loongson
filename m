Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Aug 2003 04:07:25 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:26955
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224802AbTHHDHQ>; Fri, 8 Aug 2003 04:07:16 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.35 #1)
	id 19kxar-0008F5-00; Fri, 08 Aug 2003 05:07:05 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 19kxar-0003dA-00; Fri, 08 Aug 2003 05:07:05 +0200
Date: Fri, 8 Aug 2003 05:07:05 +0200
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: load/store address overflow on binutils 2.14
Message-ID: <20030808030705.GJ3759@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030807.190330.26271096.nemoto@toshiba-tops.co.jp> <20030807231518.GH3759@rembrandt.csv.ica.uni-stuttgart.de> <20030808.101102.71082885.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030808.101102.71082885.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> >>>>> On Fri, 8 Aug 2003 01:15:18 +0200, Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de> said:
> Thiemo> It shouldn't trigger for 32bit, because 0x80000000 is a
> Thiemo> sign-extended 32bit number. How is mips-linux-as actually
> Thiemo> invoked?
> 
> Like this (using mipsel):
> 
> $ mipsel-linux-gcc -o b.o -c -v b.S
> Reading specs from /usr/lib/gcc-lib/mipsel-linux/3.3/specs
> Configured with: ../gcc-3.3/configure --target=mipsel-linux --prefix=/usr --disable-nls --enable-languages=c --disable-shared --disable-threads
> Thread model: single
> gcc version 3.3
>  /usr/lib/gcc-lib/mipsel-linux/3.3/cc1 -E -lang-asm -quiet -v -D__GNUC__=3 -D__GNUC_MINOR__=3 -D__GNUC_PATCHLEVEL__=0 b.S -o /tmp/cceVg6Jo.s
> ignoring nonexistent directory "/usr/mipsel-linux/sys-include"
> ignoring nonexistent directory "/usr/mipsel-linux/include"
> #include "..." search starts here:
> #include <...> search starts here:
>  /usr/lib/gcc-lib/mipsel-linux/3.3/include
> End of search list.
>  /usr/lib/gcc-lib/mipsel-linux/3.3/../../../../mipsel-linux/bin/as -EL -g0 -32 -v -KPIC -o b.o /tmp/cceVg6Jo.s
> GNU assembler version 2.14 (mipsel-linux) using BFD version 2.14 20030612
> b.S: Assembler messages:
> b.S:1: Error: load/store address overflow (max 32 bits)
> 
> The b.S is just one line "lw $2, 0x80000000".

Using  0xffffffff80000000 is a really ugly workaround for it.
Seems like the constant isn't properly sign-extended inernally
by the assembler.


Thiemo
