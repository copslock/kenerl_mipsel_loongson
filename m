Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Feb 2003 15:22:54 +0000 (GMT)
Received: from dsmtp8.dion.ne.jp ([IPv6:::ffff:210.196.3.101]:1176 "EHLO
	dsmtp8.dion.ne.jp") by linux-mips.org with ESMTP
	id <S8224847AbTBOPWx>; Sat, 15 Feb 2003 15:22:53 +0000
Received: from jr0bak.homelinux.net (M028044.ppp.dion.ne.jp [61.117.28.44])
	by dsmtp8.dion.ne.jp (3.7W-03013013) id AAA10424
	for <linux-mips@linux-mips.org>; Sun, 16 Feb 2003 00:22:48 +0900 (JST)
Date: Sun, 16 Feb 2003 00:22:56 +0900
From: Kunihiko IMAI <bak@d2.dion.ne.jp>
To: linux-mips@linux-mips.org
Subject: Re: [patch] VR4181A and SMVR4181A
Message-Id: <20030216002256.3ba5d984.bak@d2.dion.ne.jp>
In-Reply-To: <200302151117.16972.jscheel@activevb.de>
References: <20030213155833.56019323.yoichi_yuasa@montavista.co.jp>
	<200302151117.16972.jscheel@activevb.de>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i386-vine-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <bak@d2.dion.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bak@d2.dion.ne.jp
Precedence: bulk
X-list: linux-mips

Hi,

On Sat, 15 Feb 2003 11:17:16 +0100
Julian Scheel <jscheel@activevb.de> wrote:

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

I met this error, too.  This means that your assembler didn't
recognize the instruction 'standby'.

To escape this error, quick and dirty method, replace 'standby' with 'cop0
0x21'.  These means same instruction.

Thanks.
_._. __._  _ . ... _  .___ ._. _____ _... ._ _._ _.._. .____  _ . ... _

                                                          Kunihiko IMAI
