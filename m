Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2003 07:49:27 +0100 (BST)
Received: from rwcrmhc12.comcast.net ([IPv6:::ffff:216.148.227.85]:21728 "EHLO
	rwcrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8225193AbTHLGtZ>; Tue, 12 Aug 2003 07:49:25 +0100
Received: from gentoo.org (pcp02545003pcs.waldrf01.md.comcast.net[68.48.92.102](untrusted sender))
          by comcast.net (rwcrmhc12) with SMTP
          id <2003081206491801400kaikhe>
          (Authid: kumba12345);
          Tue, 12 Aug 2003 06:49:18 +0000
Message-ID: <3F388E0C.50802@gentoo.org>
Date: Tue, 12 Aug 2003 02:49:48 -0400
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: GCCFLAGS for gcc 3.3.x (-march and _MIPS_ISA)
References: <20030812.152654.74756131.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20030812.152654.74756131.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:

> I'm trying to compile kernel with gcc 3.3.1 and binutils 2.14.  I
> found this report on this ML:
> 
> 
>>>>>>On Tue, 13 May 2003 13:33:16 +0200, Guido Guenther <agx@sigxcpu.org> said:
> 
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
> 
> So, the right options is:
> 
> 	GCCFLAGS += -mabi=32 -march=mips2 -mtune=r4600 -Wa,--trap
> (or	GCCFLAGS += $(call check_gcc, -mcpu=r4600 -mips2, -mabi=32 -march=mips2 -mtune=r4600) -Wa,--trap)
> 
> Isn't it?
> 
> ---
> Atsushi Nemoto


I don't claim to be an expert on all things mips yet, but If I recall 
correctly, the R4K processor line is a MIPS III capable processor.  So 
-mips3 -mabi=32 should be safe for it.  I've been building kernels off 
linux-mips.org CVS using "-mips3 -mabi=32 -Wa,--trap" in the 
arch/mips/Makefile, and it works great.

Several people I know using Indy's with R5000 processors use "-mips4 
-mabi=32 -Wa,--trap" (cause R5K is MIPS IV).  I know with gcc-3.3.x, 
-mipsX is just a synonym for the appropriate -march specifier, so it 
doesn't seem to make a different whether one uses -march or -mipsX.

I'm slowly working on building a Gentoo install using "-mips3 -mabi=32" 
code on my Indigo2 (Right now, it's a mix of -mips2 and -mips3 with a 
random -mips1 binary scattered around).  Quite a fun, albeit slow, 
experiment.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
