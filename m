Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jun 2013 13:09:36 +0200 (CEST)
Received: from mail-pb0-f41.google.com ([209.85.160.41]:42801 "EHLO
        mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819546Ab3FULJfcEilg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Jun 2013 13:09:35 +0200
Received: by mail-pb0-f41.google.com with SMTP id rp16so7684844pbb.28
        for <multiple recipients>; Fri, 21 Jun 2013 04:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=QDCQvxuuhqCVe9VMOdL4+QU1YHZDygiBl6/arY/arsI=;
        b=SQ6yhaIBw2pyWc8ti6752P13SVU0rnnvPb1ubTDVmEKIUjk8kKxAO72AbFuKudEML2
         i7H0codp0SOD5n2lhs8um89C8H+sxCKQSA+DSWlqLgzgwE14R07ti9Z+IH6HX6M1CJup
         UDtfbK0niEvRjWfVXitUOVMA6jEqhz0ieYEDRhPeIQ/K+1tXV3mf9eitKYHmj6KU+14l
         hAMMism4/hj26M9cBxvTcTX9dbU5MqvsBWY7kmrB2hg88HUFyEyDb29y31T6jfP5jlBm
         T702jdF4LTQ04LoAbbp/1mDizh+reiLSHNYeiJx+k00r53ofj1Cpk2SrppVu56b461x9
         tcEw==
X-Received: by 10.68.168.165 with SMTP id zx5mr11848081pbb.189.1371812969085;
        Fri, 21 Jun 2013 04:09:29 -0700 (PDT)
Received: from hades.local (111-243-154-157.dynamic.hinet.net. [111.243.154.157])
        by mx.google.com with ESMTPSA id gb2sm4037304pbd.38.2013.06.21.04.09.26
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Jun 2013 04:09:28 -0700 (PDT)
Date:   Fri, 21 Jun 2013 19:09:23 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Fix typos and cleanup comment
Message-ID: <20130621110923.GA23231@hades.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tung7970@gmail.com
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

Signed-off-by: Tony Wu <tung7970@gmail.com>
---
 arch/mips/include/asm/gic.h |    2 +-
 arch/mips/kernel/process.c  |    3 ---
 arch/mips/mm/tlbex.c        |    2 +-
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
index 7153b32..b2e3e93 100644
--- a/arch/mips/include/asm/gic.h
+++ b/arch/mips/include/asm/gic.h
@@ -347,7 +347,7 @@ struct gic_shared_intr_map {
 #define GIC_CPU_INT2		2 /* .		      */
 #define GIC_CPU_INT3		3 /* .		      */
 #define GIC_CPU_INT4		4 /* .		      */
-#define GIC_CPU_INT5		5 /* Core Interrupt 5 */
+#define GIC_CPU_INT5		5 /* Core Interrupt 7 */
 
 /* Local GIC interrupts. */
 #define GIC_INT_TMR		(GIC_CPU_INT5)
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 706bda8..a748f04 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -201,9 +201,6 @@ int dump_task_fpu(struct task_struct *t, elf_fpregset_t *fpr)
 	return 1;
 }
 
-/*
- *
- */
 struct mips_frame_info {
 	void		*func;
 	unsigned long	func_size;
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index afeef93..fb25aad 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -961,7 +961,7 @@ build_get_pgde32(u32 **p, unsigned int tmp, unsigned int ptr)
 	uasm_i_srl(p, ptr, ptr, 19);
 #else
 	/*
-	 * smp_processor_id() << 3 is stored in CONTEXT.
+	 * smp_processor_id() << 2 is stored in CONTEXT.
 	 */
 	uasm_i_mfc0(p, ptr, C0_CONTEXT);
 	UASM_i_LA_mostly(p, tmp, pgdc);
-- 
1.7.10.2
