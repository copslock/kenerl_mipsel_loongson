Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2003 07:25:42 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:50962
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225193AbTHLGZe>; Tue, 12 Aug 2003 07:25:34 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 12 Aug 2003 06:25:33 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h7C6PKDV005922
	for <linux-mips@linux-mips.org>; Tue, 12 Aug 2003 15:25:22 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Tue, 12 Aug 2003 15:26:54 +0900 (JST)
Message-Id: <20030812.152654.74756131.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org
Subject: GCCFLAGS for gcc 3.3.x (-march and _MIPS_ISA)
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

I'm trying to compile kernel with gcc 3.3.1 and binutils 2.14.  I
found this report on this ML:

>>>>> On Tue, 13 May 2003 13:33:16 +0200, Guido Guenther <agx@sigxcpu.org> said:
Guido> Just for completeness: I had to use:
Guido>  GCCFLAGS += -mabi=32 -march=r4600 -mtune=r4600 -Wa,--trap
Guido> to make gcc-3.3 happy (note the 32 instead of o32). gcc-3.2
Guido> doesn't seem to handle these options correctly at all.

It can compile the kernel, but handle_adel_int (and handle_ades_int)
contain wrong codes.

8002630c <handle_adel_int> 40284000 	dmfc0	t0,$8
80026310 <handle_adel_int+0x4> 00000000 	nop
80026314 <handle_adel_int+0x8> ffa800a4 	sd	t0,164(sp)

The source code for this instructions are:

#define __BUILD_clear_ade(exception)                                    \
		.set	reorder;					\
		MFC0	t0,CP0_BADVADDR;                                \
		.set	noreorder;					\
		REG_S	t0,PT_BVADDR(sp);                               \
		KMODE

The macro MFC0 and REG_S are defined asm.h and depend on _MIPS_ISA.

#if (_MIPS_ISA == _MIPS_ISA_MIPS1) || (_MIPS_ISA == _MIPS_ISA_MIPS2) || \
    (_MIPS_ISA == _MIPS_ISA_MIPS32)
#define MFC0		mfc0
#define MTC0		mtc0
#endif
#if (_MIPS_ISA == _MIPS_ISA_MIPS3) || (_MIPS_ISA == _MIPS_ISA_MIPS4) || \
    (_MIPS_ISA == _MIPS_ISA_MIPS5) || (_MIPS_ISA == _MIPS_ISA_MIPS64)
#define MFC0		dmfc0
#define MTC0		dmtc0
#endif

The option -march=r4600 seems to make gcc 3.3.x choose MIPS_ISA_MIPS3.

So, the right options is:

	GCCFLAGS += -mabi=32 -march=mips2 -mtune=r4600 -Wa,--trap
(or	GCCFLAGS += $(call check_gcc, -mcpu=r4600 -mips2, -mabi=32 -march=mips2 -mtune=r4600) -Wa,--trap)

Isn't it?

---
Atsushi Nemoto
