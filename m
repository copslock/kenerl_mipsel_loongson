Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Feb 2003 14:08:43 +0000 (GMT)
Received: from [IPv6:::ffff:212.12.33.223] ([IPv6:::ffff:212.12.33.223]:8325
	"EHLO jusst.de") by linux-mips.org with ESMTP id <S8225192AbTBQOIm> convert rfc822-to-8bit;
	Mon, 17 Feb 2003 14:08:42 +0000
Received: from pd9e315e9.dip.t-dialin.net ([217.227.21.233] helo=juli.scheel-home.de)
	by jusst.de with asmtp (Exim 4.05)
	id 18klsi-0001Lz-00; Mon, 17 Feb 2003 15:04:28 +0100
From: Julian Scheel <jscheel@activevb.de>
To: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
Subject: Re: [patch] VR4181A and SMVR4181A
Date: Mon, 17 Feb 2003 15:10:00 +0100
User-Agent: KMail/1.5
Cc: yoichi_yuasa@montavista.co.jp, linux-mips@linux-mips.org
References: <20030213155833.56019323.yoichi_yuasa@montavista.co.jp> <200302170850.18887.jscheel@activevb.de> <20030217173419.732b2456.yoichi_yuasa@montavista.co.jp>
In-Reply-To: <20030217173419.732b2456.yoichi_yuasa@montavista.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200302171510.00299.jscheel@activevb.de>
Return-Path: <jscheel@activevb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jscheel@activevb.de
Precedence: bulk
X-list: linux-mips

Hi Yoichi,

Am Montag, 17. Februar 2003 09:34 schrieb Yoichi Yuasa:
> I am using binutils-2.12.1 .
>
> I also try binutils-2.13.90.0.16 .
> The binutils option was changed, it was able to compile as the following
> options.
>
> GCCFLAGS        += -march=vr4100 -Wa,--trap
>
> I don't know yet about the details of new options.
> We need to investigate about the details of options.

This seems to work!

> You have to add -msoft-float, if you don't use FPU Emulator.
> FPU Emulator is used by the default.

Ok.

I have some more problems with the chip at present. I managed to build a 
kernel, but booting won't work.
I use the NEC Bootloader, and load the Image over a serial-connection to the 
Ram (address 0x8010000). The bootloader set the INTERNAL_REGISTERS_BASE to 
0xab000000. If I understand the starting-process, the kernel normally 
searches it at 0xbfa00000 which is the address, before the Bootloader changes 
it. This is set in include/asm-mips/nile4.h . It gets changed to 0x0a000000 
(set it smvr4181a.h).
Now I change the address in nile4.h to 0xab000000, so that the kernel should 
use the correct address and then changes it to his 0x0a000000.

I think this is the problem, because I get absolutely no output after the 
binary-download finished and should start.
Hopefully you can follow my explanation of the problem (c:

-- 
Grüße,
Julian
