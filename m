Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Feb 2003 14:38:56 +0000 (GMT)
Received: from r-bu.iij4u.or.jp ([IPv6:::ffff:210.130.0.89]:23802 "EHLO
	r-bu.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225209AbTBQOiz>;
	Mon, 17 Feb 2003 14:38:55 +0000
Received: from pudding.montavista.co.jp (gatekeeper.montavista.co.jp [202.232.97.130])
	by r-bu.iij4u.or.jp (8.11.6+IIJ/8.11.6) with SMTP id h1HEckN29273;
	Mon, 17 Feb 2003 23:38:46 +0900 (JST)
Date: Mon, 17 Feb 2003 23:33:03 +0900
From: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
To: Julian Scheel <jscheel@activevb.de>
Cc: yoichi_yuasa@montavista.co.jp, linux-mips@linux-mips.org
Subject: Re: [patch] VR4181A and SMVR4181A
Message-Id: <20030217233303.4fcf43dd.yoichi_yuasa@montavista.co.jp>
In-Reply-To: <200302171510.00299.jscheel@activevb.de>
References: <20030213155833.56019323.yoichi_yuasa@montavista.co.jp>
	<200302170850.18887.jscheel@activevb.de>
	<20030217173419.732b2456.yoichi_yuasa@montavista.co.jp>
	<200302171510.00299.jscheel@activevb.de>
Organization: MontaVista Software Japan, Inc.
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@montavista.co.jp
Precedence: bulk
X-list: linux-mips

Hi Julian,

On Mon, 17 Feb 2003 15:10:00 +0100
Julian Scheel <jscheel@activevb.de> wrote:

> Hi Yoichi,
> 
> Am Montag, 17. Februar 2003 09:34 schrieb Yoichi Yuasa:
> > I am using binutils-2.12.1 .
> >
> > I also try binutils-2.13.90.0.16 .
> > The binutils option was changed, it was able to compile as the following
> > options.
> >
> > GCCFLAGS        += -march=vr4100 -Wa,--trap
> >
> > I don't know yet about the details of new options.
> > We need to investigate about the details of options.
> 
> This seems to work!
> 
> > You have to add -msoft-float, if you don't use FPU Emulator.
> > FPU Emulator is used by the default.
> 
> Ok.
> 
> I have some more problems with the chip at present. I managed to build a 
> kernel, but booting won't work.
> I use the NEC Bootloader, and load the Image over a serial-connection to the 
> Ram (address 0x8010000). The bootloader set the INTERNAL_REGISTERS_BASE to 
> 0xab000000. If I understand the starting-process, the kernel normally 
> searches it at 0xbfa00000 which is the address, before the Bootloader changes 
> it. This is set in include/asm-mips/nile4.h . It gets changed to 0x0a000000 
> (set it smvr4181a.h).
> Now I change the address in nile4.h to 0xab000000, so that the kernel should 
> use the correct address and then changes it to his 0x0a000000.

Which bootloader are you using?
I use PMON (provided from NEC).

PMON load from serial or ethernet to 0x80100000.
This is specified by arch/mips/Makefile.

When you type "g", PMON is jumped to kernel_entry.
When PMON does not recognize kernel_entry,
you can investigate System.map and can specify an address.

Yoichi
