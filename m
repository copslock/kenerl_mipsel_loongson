Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Feb 2003 10:16:26 +0000 (GMT)
Received: from [IPv6:::ffff:212.12.33.223] ([IPv6:::ffff:212.12.33.223]:59268
	"EHLO jusst.de") by linux-mips.org with ESMTP id <S8224847AbTBOKQZ> convert rfc822-to-8bit;
	Sat, 15 Feb 2003 10:16:25 +0000
Received: from p5081eff0.dip.t-dialin.net ([80.129.239.240] helo=juli.scheel-home.de)
	by jusst.de with asmtp (Exim 4.05)
	id 18jzJ2-0001EV-00; Sat, 15 Feb 2003 11:12:24 +0100
From: Julian Scheel <jscheel@activevb.de>
To: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
Subject: Re: [patch] VR4181A and SMVR4181A
Date: Sat, 15 Feb 2003 11:17:16 +0100
User-Agent: KMail/1.5
References: <20030213155833.56019323.yoichi_yuasa@montavista.co.jp>
In-Reply-To: <20030213155833.56019323.yoichi_yuasa@montavista.co.jp>
Cc: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200302151117.16972.jscheel@activevb.de>
Return-Path: <jscheel@activevb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jscheel@activevb.de
Precedence: bulk
X-list: linux-mips

Hi,

I'm using the config, which is provided as arch/mips/defconfig-smvr4181a. The 
kernel is the 2.4-release (cvs -rlinux_2_4) form linux-mips.org.
Compiling works fine for some time, but then I get this error:

jscheel/Programmieren/cmms/linux/include/asm/gcc -G 0 -mno-abicalls -fno-pic 
-pipe -mcpu=r4600 -mips2 -Wa,--trap   -nostdinc -iwithprefix include 
-DKBUILD_BASENAME=pmu  -c -o pmu.o pmu.c
{standard input}: Assembler messages:
{standard input}:125: Warning: Tried to set unrecognized symbol: vr4100

{standard input}:126: Error: opcode not supported on this processor `standby'
make[1]: *** [pmu.o] Error 1
make[1]: Leaving directory 
`/home/jscheel/Programmieren/cmms/linux/arch/mips/vr4181a/common'
make: *** [_dir_arch/mips/vr4181a/common] Error 2

Is this a problem with your patch or perhaps with my cross-compiler? (Depends 
it on GCC 3.x?)

Thanks in advice!

Am Donnerstag, 13. Februar 2003 07:58 schrieb Yoichi Yuasa:
> Hello Ralf,
>
> I added support of NEC VR4181A and NEC SMVR4181A board.
>
> As for VR4181A, The peripheral differs from VR4181 or VR4100 series
> greatly. If a VR4100 core is removed from VR4181, VR4181A and VR4100
> series, they are completely different chip.
>
> Therefore, the directory vr4181a was newly created below to arch/mips.
>
> This patch is based on linux_2_4 tag cvs tree on ftp.linux-mips.org
> Would you apply this patch to CVS on ftp.linux-mips.org?
>
> P.S.
> The patch for 2.5 is also created now. Please wait for a moment.
>
> Best Regards,
>
> Yoichi

-- 
Grüße,
Julian
