Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Feb 2005 14:05:57 +0000 (GMT)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:54811 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225003AbVBUOFn>; Mon, 21 Feb 2005 14:05:43 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j1LDxRtA014812;
	Mon, 21 Feb 2005 13:59:27 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j1LDxQ31014811;
	Mon, 21 Feb 2005 13:59:26 GMT
Date:	Mon, 21 Feb 2005 13:59:26 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc:	?????? <li_jiankun@hotmail.com>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: error:Unhandled relocation of type 7 for
Message-ID: <20050221135926.GB12444@linux-mips.org>
References: <BAY16-DAV135F2C5B899BA0A6CC8E23E96D0@phx.gbl> <20050221123445.GT1757@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050221123445.GT1757@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 21, 2005 at 01:34:45PM +0100, Thiemo Seufer wrote:
> Date:	Mon, 21 Feb 2005 13:34:45 +0100
> To:	?????? <li_jiankun@hotmail.com>
> Cc:	linux-mips <linux-mips@linux-mips.org>
> Subject: Re: error:Unhandled relocation of type 7 for
> Content-Type: text/plain; charset=us-ascii
> From:	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
> 
> ?????? wrote:
> > Hi everyone,
> > 
> >   I has been developing drivers for AMD MIPS CPU Au1x00, but I encounted some problems, maybe you could help me!
> > 
> >   I cross-complile my kernel with options:
> >   make CFLAGS="-D__KERNEL__ -I/work/opt/target/root/ljk/pda_linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -fno-pic -mno-abicalls -mlong-calls -fomit-frame-pointer -I /work/opt/target/root/ljk/pda_linux/include/asm/gcc -G 0 -mno-abicalls -fno-pic -pipe -mcpu=r4600 -mips2 -Wa,--trap " -C  arch/mips/lib
> > 
> >   and then I compile my driver modules with following options:
> >   mips_fp_le-gcc  -D__KERNEL__ -DMODULE=1 -I/opt/target/root/ljk/pda_linux/include -O2  -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -nostdinc -iwithprefix include -fno-pic -mno-abicalls -mlong-calls
> 
> "-G 0 -mcpu=r4600 -mips2 -Wa,--trap" went missing.
> 
> >   but when I want to insmod this modules, the errors come:
> >   insmod snd-page-alloc.o
> >   snd-page-alloc.o: Unhandled relocation of type 7 for
> >   snd-page-alloc.o: Unhandled relocation of type 7 for
> >   snd-page-alloc.o: Unhandled relocation of type 7 for
> >   snd-page-alloc.o: Unhandled relocation of type 7 for
> >   snd-page-alloc.o: Unhandled relocation of type 7 for
> >   snd-page-alloc.o: Unhandled relocation of type 7 for
> >   snd-page-alloc.o: Unhandled relocation of type 7 for
> >   snd-page-alloc.o: Unhandled relocation of type 7 for
> >   snd-page-alloc.o: Unhandled relocation of type 7 for
> >   snd-page-alloc.o: Unhandled relocation of type 7 for
> 
> And that's the result of it (missing -G 0, specifically).

GP Optimization has _never_ done anything useful on Linux as such I blame
the person who put that -G 8 crap into gcc.

  Ralf
