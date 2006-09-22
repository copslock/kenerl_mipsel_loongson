Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Sep 2006 06:16:44 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:49601 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20037643AbWIVFQm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 22 Sep 2006 06:16:42 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 22 Sep 2006 14:16:40 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 9740B23789;
	Fri, 22 Sep 2006 14:16:34 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 88B942379D;
	Fri, 22 Sep 2006 14:16:34 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k8M5GYW0047164;
	Fri, 22 Sep 2006 14:16:34 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 22 Sep 2006 14:16:34 +0900 (JST)
Message-Id: <20060922.141634.07643963.nemoto@toshiba-tops.co.jp>
To:	yoichi_yuasa@tripeaks.co.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] fixed mtc0_tlbw_hazard
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060922010713.657f2861.yoichi_yuasa@tripeaks.co.jp>
References: <20060922010713.657f2861.yoichi_yuasa@tripeaks.co.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 22 Sep 2006 01:07:13 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> Some mtc0_tlbw_hazard() were broken by "[MIPS] Cleanup hazard handling" patch.
...
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> 
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
>  ASMMACRO(tlbw_use_hazard,
>  	 nop; nop; nop; nop; nop; nop
> @@ -169,7 +169,7 @@ ASMMACRO(back_to_back_c0_hazard,
>   * processors.
>   */
>  ASMMACRO(mtc0_tlbw_hazard,
> -	 b	. + 8
> +	 nop; nop; nop; nop; nop; nop
>  	)
>  ASMMACRO(tlbw_use_hazard,
>  	 nop; nop; nop; nop; nop; nop
> 

The root problem would be new ASMMACRO lacks .set noreorder.

Here is my proposal.


[PATCH] force noreorder in ASMMACRO().

And mtc0_tlbw_hazard and mtc0_tlbw_hazard are adjusted.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/asm-mips/hazards.h b/include/asm-mips/hazards.h
index dabfc0e..52eb0fc 100644
--- a/include/asm-mips/hazards.h
+++ b/include/asm-mips/hazards.h
@@ -12,11 +12,11 @@ #define _ASM_HAZARDS_H
 
 
 #ifdef __ASSEMBLER__
-#define ASMMACRO(name, code...) .macro name; code; .endm
+#define ASMMACRO(name, code...) .macro name; .set push; .set noreorder; code; .set pop; .endm
 #else
 
 #define ASMMACRO(name, code...)						\
-__asm__(".macro " #name "; " #code "; .endm");				\
+__asm__(".macro " #name "; .set push; .set noreorder; " #code "; .set pop; .endm");				\
 									\
 static inline void name(void)						\
 {									\
@@ -138,7 +138,7 @@ #elif defined(CONFIG_CPU_SB1)
  * Mostly like R4000 for historic reasons
  */
 ASMMACRO(mtc0_tlbw_hazard,
-	 b	. + 8
+	 b	. + 8; nop
 	)
 ASMMACRO(tlbw_use_hazard,
 	 nop; nop; nop; nop; nop; nop
@@ -169,7 +169,7 @@ #else
  * processors.
  */
 ASMMACRO(mtc0_tlbw_hazard,
-	 b	. + 8
+	 b	. + 8; nop
 	)
 ASMMACRO(tlbw_use_hazard,
 	 nop; nop; nop; nop; nop; nop
