Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Sep 2006 15:23:43 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:63958 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038533AbWIYOXl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 25 Sep 2006 15:23:41 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k8PEOTs5023387;
	Mon, 25 Sep 2006 15:24:29 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k8PEORRl023386;
	Mon, 25 Sep 2006 15:24:27 +0100
Date:	Mon, 25 Sep 2006 15:24:27 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/3] fixed mtc0_tlbw_hazard
Message-ID: <20060925142427.GD20048@linux-mips.org>
References: <20060922010713.657f2861.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922010713.657f2861.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 22, 2006 at 01:07:13AM +0900, Yoichi Yuasa wrote:

> diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/hazards.h mips/include/asm-mips/hazards.h
> --- mips-orig/include/asm-mips/hazards.h	2006-09-21 18:21:11.793973750 +0900
> +++ mips/include/asm-mips/hazards.h	2006-09-21 18:55:07.569201750 +0900
> @@ -138,7 +138,7 @@ ASMMACRO(back_to_back_c0_hazard,
>   * Mostly like R4000 for historic reasons
>   */
>  ASMMACRO(mtc0_tlbw_hazard,
> -	 b	. + 8
> +	 nop; nop; nop; nop; nop; nop
>  	)

This is a patch for the SB1 section of hazards.h; the SB1 does not have
have this hazard so if anything this hazard should be deleted entirely as
in this patch.

diff --git a/include/asm-mips/hazards.h b/include/asm-mips/hazards.h
index dabfc0e..9bb7b4c 100644
--- a/include/asm-mips/hazards.h
+++ b/include/asm-mips/hazards.h
@@ -138,13 +138,10 @@ #elif defined(CONFIG_CPU_SB1)
  * Mostly like R4000 for historic reasons
  */
 ASMMACRO(mtc0_tlbw_hazard,
-	 b	. + 8
 	)
 ASMMACRO(tlbw_use_hazard,
-	 nop; nop; nop; nop; nop; nop
 	)
 ASMMACRO(tlb_probe_hazard,
-	 nop; nop; nop; nop; nop; nop
 	)
 ASMMACRO(tlbw_eret_hazard,
 	)

> @@ -169,7 +169,7 @@ ASMMACRO(back_to_back_c0_hazard,
>   * processors.
>   */
>  ASMMACRO(mtc0_tlbw_hazard,
> -	 b	. + 8
> +	 nop; nop; nop; nop; nop; nop

6 nops is quite some overkill - or does Vr41xx need those?  On R4000/R4600
the mtc0..tlbw hazard is one cycle.  So this one should be a single nop
at most for these cpus.

The macroized hazard barriers aren't used anymore the way they used to;
this is the way the branch trick was meant to be used:

        mtc0    k1, CP0_ENTRYLO1
        b       1f
         tlbwr
1:	nop
        eret

This works because the R4000 kills the two instructions following the
branch delay slot so needs three cycles between the tlbwr and eret.  At
the same time it has a three cycle hazard to cover.  On the R4600 otoh
the branch latency and the hazard is shorter by two cycles so the branch
trick gives optimal performance for both processors.  But that kind of
optimization only really matters to TLB refill handlers and we now got a
different strategy for those anyway.

Talking about nops, R4000 TLBP writes c0_index on stage 7, mfc0 reads
c0_index on stage 4 so tlb_probe_hazard needs 3 nop so the resulting
patch for the catch all case would be:

diff --git a/include/asm-mips/hazards.h b/include/asm-mips/hazards.h
index 7015764..0c39583 100644
--- a/include/asm-mips/hazards.h
+++ b/include/asm-mips/hazards.h
@@ -157,18 +157,18 @@ #else
  * processors.
  */
 ASMMACRO(mtc0_tlbw_hazard,
-	 b	. + 8
+	nop
 	)
 ASMMACRO(tlbw_use_hazard,
-	 nop; nop; nop; nop; nop; nop
+	nop; nop; nop
 	)
 ASMMACRO(tlb_probe_hazard,
-	 nop; nop; nop; nop; nop; nop
+	 nop; nop; nop
 	)
 ASMMACRO(irq_enable_hazard,
 	)
 ASMMACRO(irq_disable_hazard,
-	 _ssnop; _ssnop; _ssnop
+	nop; nop; nop
 	)
 ASMMACRO(back_to_back_c0_hazard,
 	 _ssnop; _ssnop; _ssnop;

  Ralf
