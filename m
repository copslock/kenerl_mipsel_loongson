Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Feb 2003 07:48:59 +0000 (GMT)
Received: from [IPv6:::ffff:212.12.33.223] ([IPv6:::ffff:212.12.33.223]:5765
	"EHLO jusst.de") by linux-mips.org with ESMTP id <S8224851AbTBQHs7> convert rfc822-to-8bit;
	Mon, 17 Feb 2003 07:48:59 +0000
Received: from p5081f16c.dip.t-dialin.net ([80.129.241.108] helo=juli.scheel-home.de)
	by jusst.de with asmtp (Exim 4.05)
	id 18kfxL-0001L0-00; Mon, 17 Feb 2003 08:44:51 +0100
From: Julian Scheel <jscheel@activevb.de>
To: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
Subject: Re: [patch] VR4181A and SMVR4181A
Date: Mon, 17 Feb 2003 08:50:18 +0100
User-Agent: KMail/1.5
Cc: linux-mips@linux-mips.org
References: <20030213155833.56019323.yoichi_yuasa@montavista.co.jp> <20030217105115.093847a8.yoichi_yuasa@montavista.co.jp> <20030217163205.00ca177a.yoichi_yuasa@montavista.co.jp>
In-Reply-To: <20030217163205.00ca177a.yoichi_yuasa@montavista.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200302170850.18887.jscheel@activevb.de>
Return-Path: <jscheel@activevb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jscheel@activevb.de
Precedence: bulk
X-list: linux-mips

Hi Yoichi,

> Yoichi Yuasa <yoichi_yuasa@montavista.co.jp> wrote:
> [...]
>
> This is a problem depending on binutils.
> Please use binutils corresponding to VR4100 series.

I built my binutils on my own, following the tutorial found at 
http://www.ltc.com/~brad/mips/mips-cross-toolchain/. So I used 
../binutils/configure --target=mipsel-linux \
  --libdir='${exec_prefix}'/mipsel-linux/i386-linux/lib
as configure-settings. How can I set something more special than the 
mipsel-architecture (the vr4100-processors)

> > -m4100 option can be tried supposing you are using gcc
> > which has a problem as the present option.
> >
> > Please change following line.
> >
> > ifdef CONFIG_CPU_VR41XX
> > GCCFLAGS        += -mcpu=r4600 -mips2 -Wa,-m4100,--trap
> > endif
> >
> > Please let me know what the result became.

Shouldn't I additionally add -msoft-float, because the VR4181A has no 
FP-Coprocessor?

-- 
Grüße,
Julian
