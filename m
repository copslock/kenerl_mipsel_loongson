Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Feb 2003 01:57:12 +0000 (GMT)
Received: from sonicwall.montavista.co.jp ([IPv6:::ffff:202.232.97.131]:20036
	"EHLO yuubin.montavista.co.jp") by linux-mips.org with ESMTP
	id <S8225192AbTBQB5M>; Mon, 17 Feb 2003 01:57:12 +0000
Received: from pudding.montavista.co.jp ([10.200.0.40])
	by yuubin.montavista.co.jp (8.12.5/8.12.5) with SMTP id h1H20V44018395;
	Mon, 17 Feb 2003 11:00:33 +0900
Date: Mon, 17 Feb 2003 10:51:15 +0900
From: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
To: Julian Scheel <jscheel@activevb.de>
Cc: yoichi_yuasa@montavista.co.jp, linux-mips@linux-mips.org
Subject: Re: [patch] VR4181A and SMVR4181A
Message-Id: <20030217105115.093847a8.yoichi_yuasa@montavista.co.jp>
In-Reply-To: <200302151117.16972.jscheel@activevb.de>
References: <20030213155833.56019323.yoichi_yuasa@montavista.co.jp>
	<200302151117.16972.jscheel@activevb.de>
Organization: MontaVista Software Japan, Inc.
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@montavista.co.jp
Precedence: bulk
X-list: linux-mips

Hi Julian,

On Sat, 15 Feb 2003 11:17:16 +0100
Julian Scheel <jscheel@activevb.de> wrote:

> Hi,
> 
> I'm using the config, which is provided as arch/mips/defconfig-smvr4181a. The 
> kernel is the 2.4-release (cvs -rlinux_2_4) form linux-mips.org.
> Compiling works fine for some time, but then I get this error:
> 
> jscheel/Programmieren/cmms/linux/include/asm/gcc -G 0 -mno-abicalls -fno-pic 
> -pipe -mcpu=r4600 -mips2 -Wa,--trap   -nostdinc -iwithprefix include 
> -DKBUILD_BASENAME=pmu  -c -o pmu.o pmu.c
> {standard input}: Assembler messages:
> {standard input}:125: Warning: Tried to set unrecognized symbol: vr4100
> 
> {standard input}:126: Error: opcode not supported on this processor `standby'
> make[1]: *** [pmu.o] Error 1
> make[1]: Leaving directory 
> `/home/jscheel/Programmieren/cmms/linux/arch/mips/vr4181a/common'
> make: *** [_dir_arch/mips/vr4181a/common] Error 2
> 
> Is this a problem with your patch or perhaps with my cross-compiler? (Depends 
> it on GCC 3.x?)

-m4100 option can be tried supposing you are using gcc
which has a problem as the present option.

Please change following line.

ifdef CONFIG_CPU_VR41XX
GCCFLAGS        += -mcpu=r4600 -mips2 -Wa,-m4100,--trap
endif

Please let me know what the result became.

Yoichi
