Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Dec 2003 12:58:55 +0000 (GMT)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:47095 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225869AbTLWM6y>; Tue, 23 Dec 2003 12:58:54 +0000
Received: from localhost (p3070-ipad28funabasi.chiba.ocn.ne.jp [220.107.202.70])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3F29749EC; Tue, 23 Dec 2003 21:58:46 +0900 (JST)
Date: Tue, 23 Dec 2003 22:02:13 +0900 (JST)
Message-Id: <20031223.220213.74756743.anemo@mba.ocn.ne.jp>
To: macro@ds2.pg.gda.pl
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [patch] 2.4: Support for newer gcc/gas options
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.55.0312161822240.8262@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0312161822240.8262@jurand.ds.pg.gda.pl>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 16 Dec 2003 22:33:41 +0100 (CET), "Maciej W. Rozycki" <macro@ds2.pg.gda.pl> said:
macro>  The patch implements a make macro called set_gccflags which
macro> accepts two sets of options consisting of a CPU name and an ISA
macro> name each.  Within both sets "-march=" and failing that
macro> "-mcpu=" is checked with the CPU name and the ISA name is
macro> checked simultaneously.  For gcc if the first set of options
macro> fails, the second one is selected even if it would lead to a
macro> failure.  For gas both sets are checked and if none succeeds,
macro> an empty set is selected.

With this patch, most r4k use MIPS3 ISA, right?

If so, please fix include/asm-mips/asm.h or arch/mips/kernel/entry.S
on 2.4 branch also.

As I wrote in August, handle_adel_int will be broken with MIPS3 ISA.
<http://www.linux-mips.org/archives/linux-mips/2003-08/msg00072.html>


Excerpt from include/asm-mips/asm.h:

#if (_MIPS_ISA == _MIPS_ISA_MIPS1) || (_MIPS_ISA == _MIPS_ISA_MIPS2) || \
    (_MIPS_ISA == _MIPS_ISA_MIPS32)
#define REG_S           sw 
#define REG_L           lw 
#define REG_SUBU        subu
#define REG_ADDU        addu
#endif
#if (_MIPS_ISA == _MIPS_ISA_MIPS3) || (_MIPS_ISA == _MIPS_ISA_MIPS4) || \
    (_MIPS_ISA == _MIPS_ISA_MIPS5) || (_MIPS_ISA == _MIPS_ISA_MIPS64)
#define REG_S           sd
#define REG_L           ld
#define REG_SUBU        dsubu
#define REG_ADDU        daddu
#endif

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

Excerpt from arch/mips/kernel/entry.S:

#define __BUILD_clear_ade(exception)                                    \
		.set	reorder;					\
		MFC0	t0,CP0_BADVADDR;                                \
		.set	noreorder;					\
		REG_S	t0,PT_BVADDR(sp);                               \
		KMODE

With MIPS3 ISA, handle_adel_int will be:

8002630c <handle_adel_int> 40284000 	dmfc0	t0,$8
80026310 <handle_adel_int+0x4> 00000000 	nop
80026314 <handle_adel_int+0x8> ffa800a4 	sd	t0,164(sp)

which is wrong for 32bit kernel.

---
Atsushi Nemoto
