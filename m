Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Feb 2003 08:40:09 +0000 (GMT)
Received: from r-bu.iij4u.or.jp ([IPv6:::ffff:210.130.0.89]:2768 "EHLO
	r-bu.iij4u.or.jp") by linux-mips.org with ESMTP id <S8224851AbTBQIkI>;
	Mon, 17 Feb 2003 08:40:08 +0000
Received: from pudding.montavista.co.jp (gatekeeper.montavista.co.jp [202.232.97.130])
	by r-bu.iij4u.or.jp (8.11.6+IIJ/8.11.6) with SMTP id h1H8e2N23953;
	Mon, 17 Feb 2003 17:40:02 +0900 (JST)
Date: Mon, 17 Feb 2003 17:34:19 +0900
From: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
To: Julian Scheel <jscheel@activevb.de>
Cc: yoichi_yuasa@montavista.co.jp, linux-mips@linux-mips.org
Subject: Re: [patch] VR4181A and SMVR4181A
Message-Id: <20030217173419.732b2456.yoichi_yuasa@montavista.co.jp>
In-Reply-To: <200302170850.18887.jscheel@activevb.de>
References: <20030213155833.56019323.yoichi_yuasa@montavista.co.jp>
	<20030217105115.093847a8.yoichi_yuasa@montavista.co.jp>
	<20030217163205.00ca177a.yoichi_yuasa@montavista.co.jp>
	<200302170850.18887.jscheel@activevb.de>
Organization: MontaVista Software Japan, Inc.
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@montavista.co.jp
Precedence: bulk
X-list: linux-mips

Hi Julian,

On Mon, 17 Feb 2003 08:50:18 +0100
Julian Scheel <jscheel@activevb.de> wrote:

> Hi Yoichi,
> 
> > Yoichi Yuasa <yoichi_yuasa@montavista.co.jp> wrote:
> > [...]
> >
> > This is a problem depending on binutils.
> > Please use binutils corresponding to VR4100 series.
> 
> I built my binutils on my own, following the tutorial found at 
> http://www.ltc.com/~brad/mips/mips-cross-toolchain/. So I used 
> ../binutils/configure --target=mipsel-linux \
>   --libdir='${exec_prefix}'/mipsel-linux/i386-linux/lib
> as configure-settings. How can I set something more special than the 
> mipsel-architecture (the vr4100-processors)

I am using binutils-2.12.1 .

I also try binutils-2.13.90.0.16 .
The binutils option was changed, it was able to compile as the following options.

GCCFLAGS        += -march=vr4100 -Wa,--trap

I don't know yet about the details of new options.
We need to investigate about the details of options.

> > > -m4100 option can be tried supposing you are using gcc
> > > which has a problem as the present option.
> > >
> > > Please change following line.
> > >
> > > ifdef CONFIG_CPU_VR41XX
> > > GCCFLAGS        += -mcpu=r4600 -mips2 -Wa,-m4100,--trap
> > > endif
> > >
> > > Please let me know what the result became.
> 
> Shouldn't I additionally add -msoft-float, because the VR4181A has no 
> FP-Coprocessor?

You have to add -msoft-float, if you don't use FPU Emulator.
FPU Emulator is used by the default.

Yoichi
