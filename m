Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2003 07:51:26 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:16477
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225072AbTHLGvT>; Tue, 12 Aug 2003 07:51:19 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.35 #1)
	id 19mT02-0007bs-00
	for linux-mips@linux-mips.org; Tue, 12 Aug 2003 08:51:18 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 19mT02-0006Cb-00
	for <linux-mips@linux-mips.org>; Tue, 12 Aug 2003 08:51:18 +0200
Date: Tue, 12 Aug 2003 08:51:18 +0200
To: linux-mips@linux-mips.org
Subject: Re: GCCFLAGS for gcc 3.3.x (-march and _MIPS_ISA)
Message-ID: <20030812065118.GD23104@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030812.152654.74756131.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030812.152654.74756131.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3025
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> I'm trying to compile kernel with gcc 3.3.1 and binutils 2.14.  I
> found this report on this ML:
> 
> >>>>> On Tue, 13 May 2003 13:33:16 +0200, Guido Guenther <agx@sigxcpu.org> said:
> Guido> Just for completeness: I had to use:
> Guido>  GCCFLAGS += -mabi=32 -march=r4600 -mtune=r4600 -Wa,--trap
> Guido> to make gcc-3.3 happy (note the 32 instead of o32). gcc-3.2
> Guido> doesn't seem to handle these options correctly at all.
> 
> It can compile the kernel, but handle_adel_int (and handle_ades_int)
> contain wrong codes.
> 
> 8002630c <handle_adel_int> 40284000 	dmfc0	t0,$8
> 80026310 <handle_adel_int+0x4> 00000000 	nop
> 80026314 <handle_adel_int+0x8> ffa800a4 	sd	t0,164(sp)
> 
> The source code for this instructions are:
> 
> #define __BUILD_clear_ade(exception)                                    \
> 		.set	reorder;					\
> 		MFC0	t0,CP0_BADVADDR;                                \
> 		.set	noreorder;					\
> 		REG_S	t0,PT_BVADDR(sp);                               \
> 		KMODE
> 
> The macro MFC0 and REG_S are defined asm.h and depend on _MIPS_ISA.
> 
> #if (_MIPS_ISA == _MIPS_ISA_MIPS1) || (_MIPS_ISA == _MIPS_ISA_MIPS2) || \
>     (_MIPS_ISA == _MIPS_ISA_MIPS32)
> #define MFC0		mfc0
> #define MTC0		mtc0
> #endif
> #if (_MIPS_ISA == _MIPS_ISA_MIPS3) || (_MIPS_ISA == _MIPS_ISA_MIPS4) || \
>     (_MIPS_ISA == _MIPS_ISA_MIPS5) || (_MIPS_ISA == _MIPS_ISA_MIPS64)
> #define MFC0		dmfc0
> #define MTC0		dmtc0
> #endif
> 
> The option -march=r4600 seems to make gcc 3.3.x choose MIPS_ISA_MIPS3.

Which is ok, because the available ISA has little to do with the actually
used register width.

If the intention is to use mfc0 for 32bit kernels and dmfc0 for 64bit,
the check should probably be

#ifdef __mips64
# define MFC0		dmfc0
# define MTC0		dmtc0
#else
# define MFC0		mfc0
# define MTC0		mtc0
#endif

> So, the right options is:
> 
> 	GCCFLAGS += -mabi=32 -march=mips2 -mtune=r4600 -Wa,--trap
> (or	GCCFLAGS += $(call check_gcc, -mcpu=r4600 -mips2, -mabi=32 -march=mips2 -mtune=r4600) -Wa,--trap)
> 
> Isn't it?

-march=mips2 is an alias for -march=r6000, I don't think that's a
good choice.


Thiemo
