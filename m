Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2014 19:06:53 +0100 (CET)
Received: from mail-lb0-f181.google.com ([209.85.217.181]:42953 "EHLO
        mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008830AbaLOSGWQ8LgB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Dec 2014 19:06:22 +0100
Received: by mail-lb0-f181.google.com with SMTP id l4so9478862lbv.26
        for <multiple recipients>; Mon, 15 Dec 2014 10:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E5uwwcmFil4xvS5JdLbjuqqSd+Qq/4L1RrNPkTfjHf0=;
        b=vaLNSR2gfhn8j+iiU+YjSmXd+GwxrV1Wz/V9EvDqFI/L+FvqlyyfjQXjAVOXEYOI/X
         o/FB1WCdV5W/iIhVko4XMjJoUFXZugfBQFLzXttneFKXN3EAaA64c1gO80Cw6A8wStLn
         54z1CmMx9lMxUSx2rhI6962zFMdmF/NEVEgIugCfD91oadllq8ceQ/7OCzP0xB0ZvKUS
         DAS+UoYe4OVZQkuEkxzmBrPuP5HcE/OLCI+x6aLwAYjTjKfthl80koadyb5uQDjRceiA
         5om+oPTvscvn64dbvV0Hwrv+MC3zv3BylREStV4GSU+3n5gUDMjTlNaV8Qw6zivVVZEZ
         PMxQ==
X-Received: by 10.112.42.47 with SMTP id k15mr156855lbl.75.1418666776891;
        Mon, 15 Dec 2014 10:06:16 -0800 (PST)
Received: from turnip.localdomain (nivc-213.auriga.ru. [80.240.102.213])
        by mx.google.com with ESMTPSA id l9sm1238952lae.0.2014.12.15.10.06.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Dec 2014 10:06:16 -0800 (PST)
From:   Aleksey Makarov <feumilieu@gmail.com>
X-Google-Original-From: Aleksey Makarov <aleksey.makarov@auriga.com>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 03/14] MIPS: OCTEON: Save and restore CP2 SHA3 state
Date:   Mon, 15 Dec 2014 21:03:09 +0300
Message-Id: <1418666603-15159-4-git-send-email-aleksey.makarov@auriga.com>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418666603-15159-1-git-send-email-aleksey.makarov@auriga.com>
References: <1418666603-15159-1-git-send-email-aleksey.makarov@auriga.com>
Return-Path: <feumilieu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44685
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: feumilieu@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: David Daney <david.daney@cavium.com>

Allocate new save space, and then save/restore the registers if
OCTEON III.

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
---
 arch/mips/include/asm/processor.h |  2 ++
 arch/mips/kernel/asm-offsets.c    |  1 +
 arch/mips/kernel/octeon_switch.S  | 43 +++++++++++++++++++++++++++++----------
 3 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index f1df4cb..a5b8a7f 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -211,6 +211,8 @@ struct octeon_cop2_state {
 	unsigned long	cop2_gfm_poly;
 	/* DMFC2 rt, 0x025A; DMFC2 rt, 0x025B - Pass2 */
 	unsigned long	cop2_gfm_result[2];
+	/* DMFC2 rt, 0x24F, DMFC2 rt, 0x50, OCTEON III */
+	unsigned long	cop2_sha3[2];
 };
 #define COP2_INIT						\
 	.cp2			= {0,},
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index b1d84bd..537e6f4 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -382,6 +382,7 @@ void output_octeon_cop2_state_defines(void)
 	OFFSET(OCTEON_CP2_GFM_RESULT,	octeon_cop2_state, cop2_gfm_result);
 	OFFSET(OCTEON_CP2_HSH_DATW,	octeon_cop2_state, cop2_hsh_datw);
 	OFFSET(OCTEON_CP2_HSH_IVW,	octeon_cop2_state, cop2_hsh_ivw);
+	OFFSET(OCTEON_CP2_SHA3,		octeon_cop2_state, cop2_sha3);
 	OFFSET(THREAD_CP2,	task_struct, thread.cp2);
 	OFFSET(THREAD_CVMSEG,	task_struct, thread.cvmseg.cvmseg);
 	BLANK();
diff --git a/arch/mips/kernel/octeon_switch.S b/arch/mips/kernel/octeon_switch.S
index 2787c01..590ca2d 100644
--- a/arch/mips/kernel/octeon_switch.S
+++ b/arch/mips/kernel/octeon_switch.S
@@ -142,6 +142,8 @@
  * void octeon_cop2_save(struct octeon_cop2_state *a0)
  */
 	.align	7
+	.set push
+	.set noreorder
 	LEAF(octeon_cop2_save)
 
 	dmfc0	t9, $9,7	/* CvmCtl register. */
@@ -152,17 +154,17 @@
 	dmfc2	t2, 0x0200
 	sd	t0, OCTEON_CP2_CRC_IV(a0)
 	sd	t1, OCTEON_CP2_CRC_LENGTH(a0)
-	sd	t2, OCTEON_CP2_CRC_POLY(a0)
 	/* Skip next instructions if CvmCtl[NODFA_CP2] set */
 	bbit1	t9, 28, 1f
+	 sd	t2, OCTEON_CP2_CRC_POLY(a0)
 
 	/* Save the LLM state */
 	dmfc2	t0, 0x0402
 	dmfc2	t1, 0x040A
 	sd	t0, OCTEON_CP2_LLM_DAT(a0)
-	sd	t1, OCTEON_CP2_LLM_DAT+8(a0)
 
 1:	bbit1	t9, 26, 3f	/* done if CvmCtl[NOCRYPTO] set */
+	 sd	t1, OCTEON_CP2_LLM_DAT+8(a0)
 
 	/* Save the COP2 crypto state */
 	/* this part is mostly common to both pass 1 and later revisions */
@@ -193,18 +195,20 @@
 	sd	t2, OCTEON_CP2_AES_KEY+16(a0)
 	dmfc2	t2, 0x0101
 	sd	t3, OCTEON_CP2_AES_KEY+24(a0)
-	mfc0	t3, $15,0	/* Get the processor ID register */
+	mfc0	v0, $15,0	/* Get the processor ID register */
 	sd	t0, OCTEON_CP2_AES_KEYLEN(a0)
-	li	t0, 0x000d0000	/* This is the processor ID of Octeon Pass1 */
+	li	v1, 0x000d0000	/* This is the processor ID of Octeon Pass1 */
 	sd	t1, OCTEON_CP2_AES_RESULT(a0)
-	sd	t2, OCTEON_CP2_AES_RESULT+8(a0)
 	/* Skip to the Pass1 version of the remainder of the COP2 state */
-	beq	t3, t0, 2f
+	beq	v0, v1, 2f
+	 sd	t2, OCTEON_CP2_AES_RESULT+8(a0)
 
 	/* the non-pass1 state when !CvmCtl[NOCRYPTO] */
 	dmfc2	t1, 0x0240
 	dmfc2	t2, 0x0241
+	ori	v1, v1, 0x9500 /* lowest OCTEON III PrId*/
 	dmfc2	t3, 0x0242
+	subu	v1, v0, v1 /* prid - lowest OCTEON III PrId */
 	dmfc2	t0, 0x0243
 	sd	t1, OCTEON_CP2_HSH_DATW(a0)
 	dmfc2	t1, 0x0244
@@ -257,8 +261,16 @@
 	sd	t1, OCTEON_CP2_GFM_MULT+8(a0)
 	sd	t2, OCTEON_CP2_GFM_POLY(a0)
 	sd	t3, OCTEON_CP2_GFM_RESULT(a0)
-	sd	t0, OCTEON_CP2_GFM_RESULT+8(a0)
+	bltz	v1, 4f
+	 sd	t0, OCTEON_CP2_GFM_RESULT+8(a0)
+	/* OCTEON III things*/
+	dmfc2	t0, 0x024F
+	dmfc2	t1, 0x0050
+	sd	t0, OCTEON_CP2_SHA3(a0)
+	sd	t1, OCTEON_CP2_SHA3+8(a0)
+4:
 	jr	ra
+	 nop
 
 2:	/* pass 1 special stuff when !CvmCtl[NOCRYPTO] */
 	dmfc2	t3, 0x0040
@@ -284,7 +296,9 @@
 
 3:	/* pass 1 or CvmCtl[NOCRYPTO] set */
 	jr	ra
+	 nop
 	END(octeon_cop2_save)
+	.set pop
 
 /*
  * void octeon_cop2_restore(struct octeon_cop2_state *a0)
@@ -349,9 +363,9 @@
 	ld	t2, OCTEON_CP2_AES_RESULT+8(a0)
 	mfc0	t3, $15,0	/* Get the processor ID register */
 	dmtc2	t0, 0x0110
-	li	t0, 0x000d0000	/* This is the processor ID of Octeon Pass1 */
+	li	v0, 0x000d0000	/* This is the processor ID of Octeon Pass1 */
 	dmtc2	t1, 0x0100
-	bne	t0, t3, 3f	/* Skip the next stuff for non-pass1 */
+	bne	v0, t3, 3f	/* Skip the next stuff for non-pass1 */
 	 dmtc2	t2, 0x0101
 
 	/* this code is specific for pass 1 */
@@ -379,6 +393,7 @@
 
 3:	/* this is post-pass1 code */
 	ld	t2, OCTEON_CP2_HSH_DATW(a0)
+	ori	v0, v0, 0x9500 /* lowest OCTEON III PrId*/
 	ld	t0, OCTEON_CP2_HSH_DATW+8(a0)
 	ld	t1, OCTEON_CP2_HSH_DATW+16(a0)
 	dmtc2	t2, 0x0240
@@ -432,9 +447,15 @@
 	dmtc2	t2, 0x0259
 	ld	t2, OCTEON_CP2_GFM_RESULT+8(a0)
 	dmtc2	t0, 0x025E
+	subu	v0, t3, v0 /* prid - lowest OCTEON III PrId */
 	dmtc2	t1, 0x025A
-	dmtc2	t2, 0x025B
-
+	bltz	v0, done_restore
+	 dmtc2	t2, 0x025B
+	/* OCTEON III things*/
+	ld	t0, OCTEON_CP2_SHA3(a0)
+	ld	t1, OCTEON_CP2_SHA3+8(a0)
+	dmtc2	t0, 0x0051
+	dmtc2	t1, 0x0050
 done_restore:
 	jr	ra
 	 nop
-- 
2.1.3
