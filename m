Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Feb 2003 07:37:57 +0000 (GMT)
Received: from r-bu.iij4u.or.jp ([IPv6:::ffff:210.130.0.89]:56317 "EHLO
	r-bu.iij4u.or.jp") by linux-mips.org with ESMTP id <S8224851AbTBQHh4>;
	Mon, 17 Feb 2003 07:37:56 +0000
Received: from pudding.montavista.co.jp (gatekeeper.montavista.co.jp [202.232.97.130])
	by r-bu.iij4u.or.jp (8.11.6+IIJ/8.11.6) with SMTP id h1H7bmN18089;
	Mon, 17 Feb 2003 16:37:48 +0900 (JST)
Date: Mon, 17 Feb 2003 16:32:05 +0900
From: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
To: Julian Scheel <jscheel@activevb.de>
Cc: yoichi_yuasa@montavista.co.jp, linux-mips@linux-mips.org
Subject: Re: [patch] VR4181A and SMVR4181A
Message-Id: <20030217163205.00ca177a.yoichi_yuasa@montavista.co.jp>
In-Reply-To: <20030217105115.093847a8.yoichi_yuasa@montavista.co.jp>
References: <20030213155833.56019323.yoichi_yuasa@montavista.co.jp>
	<200302151117.16972.jscheel@activevb.de>
	<20030217105115.093847a8.yoichi_yuasa@montavista.co.jp>
Organization: MontaVista Software Japan, Inc.
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@montavista.co.jp
Precedence: bulk
X-list: linux-mips

Hi again,

On Mon, 17 Feb 2003 10:51:15 +0900
Yoichi Yuasa <yoichi_yuasa@montavista.co.jp> wrote:

> Hi Julian,
> 
> On Sat, 15 Feb 2003 11:17:16 +0100
> Julian Scheel <jscheel@activevb.de> wrote:
> 
> > Hi,
> > 
> > I'm using the config, which is provided as arch/mips/defconfig-smvr4181a. The 
> > kernel is the 2.4-release (cvs -rlinux_2_4) form linux-mips.org.
> > Compiling works fine for some time, but then I get this error:
> > 
> > jscheel/Programmieren/cmms/linux/include/asm/gcc -G 0 -mno-abicalls -fno-pic 
> > -pipe -mcpu=r4600 -mips2 -Wa,--trap   -nostdinc -iwithprefix include 
> > -DKBUILD_BASENAME=pmu  -c -o pmu.o pmu.c
> > {standard input}: Assembler messages:
> > {standard input}:125: Warning: Tried to set unrecognized symbol: vr4100
> > 
> > {standard input}:126: Error: opcode not supported on this processor `standby'
> > make[1]: *** [pmu.o] Error 1
> > make[1]: Leaving directory 
> > `/home/jscheel/Programmieren/cmms/linux/arch/mips/vr4181a/common'
> > make: *** [_dir_arch/mips/vr4181a/common] Error 2
> > 
> > Is this a problem with your patch or perhaps with my cross-compiler? (Depends 
> > it on GCC 3.x?)

This is a problem depending on binutils.
Please use binutils corresponding to VR4100 series.

> -m4100 option can be tried supposing you are using gcc
> which has a problem as the present option.
> 
> Please change following line.
> 
> ifdef CONFIG_CPU_VR41XX
> GCCFLAGS        += -mcpu=r4600 -mips2 -Wa,-m4100,--trap
> endif
> 
> Please let me know what the result became.

Yoichi
