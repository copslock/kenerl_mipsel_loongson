Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Feb 2005 12:35:03 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:47201
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224987AbVBUMes>; Mon, 21 Feb 2005 12:34:48 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1D3Clx-0006M5-00; Mon, 21 Feb 2005 13:34:45 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1D3Clx-0007xD-00; Mon, 21 Feb 2005 13:34:45 +0100
Date:	Mon, 21 Feb 2005 13:34:45 +0100
To:	?????? <li_jiankun@hotmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: error:Unhandled relocation of type 7 for
Message-ID: <20050221123445.GT1757@rembrandt.csv.ica.uni-stuttgart.de>
References: <BAY16-DAV135F2C5B899BA0A6CC8E23E96D0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY16-DAV135F2C5B899BA0A6CC8E23E96D0@phx.gbl>
User-Agent: Mutt/1.5.6+20040907i
From:	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7294
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

?????? wrote:
> Hi everyone,
> 
>   I has been developing drivers for AMD MIPS CPU Au1x00, but I encounted some problems, maybe you could help me!
> 
>   I cross-complile my kernel with options:
>   make CFLAGS="-D__KERNEL__ -I/work/opt/target/root/ljk/pda_linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -fno-pic -mno-abicalls -mlong-calls -fomit-frame-pointer -I /work/opt/target/root/ljk/pda_linux/include/asm/gcc -G 0 -mno-abicalls -fno-pic -pipe -mcpu=r4600 -mips2 -Wa,--trap " -C  arch/mips/lib
> 
>   and then I compile my driver modules with following options:
>   mips_fp_le-gcc  -D__KERNEL__ -DMODULE=1 -I/opt/target/root/ljk/pda_linux/include -O2  -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -nostdinc -iwithprefix include -fno-pic -mno-abicalls -mlong-calls

"-G 0 -mcpu=r4600 -mips2 -Wa,--trap" went missing.

>   but when I want to insmod this modules, the errors come:
>   insmod snd-page-alloc.o
>   snd-page-alloc.o: Unhandled relocation of type 7 for
>   snd-page-alloc.o: Unhandled relocation of type 7 for
>   snd-page-alloc.o: Unhandled relocation of type 7 for
>   snd-page-alloc.o: Unhandled relocation of type 7 for
>   snd-page-alloc.o: Unhandled relocation of type 7 for
>   snd-page-alloc.o: Unhandled relocation of type 7 for
>   snd-page-alloc.o: Unhandled relocation of type 7 for
>   snd-page-alloc.o: Unhandled relocation of type 7 for
>   snd-page-alloc.o: Unhandled relocation of type 7 for
>   snd-page-alloc.o: Unhandled relocation of type 7 for

And that's the result of it (missing -G 0, specifically).


Thiemo
