Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Dec 2003 20:44:12 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:50991
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224916AbTLWUoL>; Tue, 23 Dec 2003 20:44:11 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1AYtNt-000259-00; Tue, 23 Dec 2003 21:44:05 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1AYtNt-0002ta-00; Tue, 23 Dec 2003 21:44:05 +0100
Date: Tue, 23 Dec 2003 21:44:05 +0100
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: macro@ds2.pg.gda.pl, ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [patch] 2.4: Support for newer gcc/gas options
Message-ID: <20031223204405.GL12050@rembrandt.csv.ica.uni-stuttgart.de>
References: <Pine.LNX.4.55.0312161822240.8262@jurand.ds.pg.gda.pl> <20031223.220213.74756743.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223.220213.74756743.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
[snip]
> >>>>> On Tue, 16 Dec 2003 22:33:41 +0100 (CET), "Maciej W. Rozycki" <macro@ds2.pg.gda.pl> said:
> macro>  The patch implements a make macro called set_gccflags which
> macro> accepts two sets of options consisting of a CPU name and an ISA
> macro> name each.  Within both sets "-march=" and failing that
> macro> "-mcpu=" is checked with the CPU name and the ISA name is
> macro> checked simultaneously.  For gcc if the first set of options
> macro> fails, the second one is selected even if it would lead to a
> macro> failure.  For gas both sets are checked and if none succeeds,
> macro> an empty set is selected.
> 
> With this patch, most r4k use MIPS3 ISA, right?

Since -mips2 is retained they actually use -march=r6000 and still
MIPS2 ISA.

> If so, please fix include/asm-mips/asm.h or arch/mips/kernel/entry.S
> on 2.4 branch also.
> 
> As I wrote in August, handle_adel_int will be broken with MIPS3 ISA.
> <http://www.linux-mips.org/archives/linux-mips/2003-08/msg00072.html>
> 
> 
> Excerpt from include/asm-mips/asm.h:
> 
> #if (_MIPS_ISA == _MIPS_ISA_MIPS1) || (_MIPS_ISA == _MIPS_ISA_MIPS2) || \
>     (_MIPS_ISA == _MIPS_ISA_MIPS32)
> #define REG_S           sw 
> #define REG_L           lw 
> #define REG_SUBU        subu
> #define REG_ADDU        addu
> #endif
> #if (_MIPS_ISA == _MIPS_ISA_MIPS3) || (_MIPS_ISA == _MIPS_ISA_MIPS4) || \
>     (_MIPS_ISA == _MIPS_ISA_MIPS5) || (_MIPS_ISA == _MIPS_ISA_MIPS64)
> #define REG_S           sd
> #define REG_L           ld
> #define REG_SUBU        dsubu
> #define REG_ADDU        daddu
> #endif
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

This should use either CONFIG_MIPS{32,64} or the compiler intrinsic
_MIPS_SIM (which did unfortunately change for O32 in gcc 3.4).


Thiemo
