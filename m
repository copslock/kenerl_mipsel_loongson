Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Mar 2017 17:16:52 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:49266 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992143AbdCXQNksRBPA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Mar 2017 17:13:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eYC2+RUFMjZF+LCWjN3rXSfc2L0EccAqlW9t3GDMPXw=; b=dTVlkACDc9dTE2bQ+vK17722m
        V5Z1X+i1SWjnJsvkQcawL1znsrV+GXKgRQEVtc9+f9X3X03glaxMtfuDZJYhSsXRielBJd+a1Z9xR
        Tu4RNWRB+7VaG5LwF/v4GTFNKEBc8UTuw6L4BvgHXWoYUbma1RHEk3oTHHWjfCFD2cDYCzl1ohPqe
        tFbQXwz7Gu6hgjs3U7kfhG1DJZrwgGucgsn8LsGWKcOh6OI3JDBt5TljFORfYDsADp8sCfdx07S++
        8BQuyM6HDqCQ/Wk513MUNce39RVaVy/XmmL/QfF7fG2a1F7BBf2Vuwws3O1igwv/aGQMwrb08IYsE
        0AVZ6hWYw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.87 #1 (Red Hat Linux))
        id 1crRqK-0004vD-M6; Fri, 24 Mar 2017 16:13:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <mawilcox@microsoft.com>
Subject: [PATCH v3 6/7] sym53c8xx_2: Convert to use memset32
Date:   Fri, 24 Mar 2017 09:13:17 -0700
Message-Id: <20170324161318.18718-7-willy@infradead.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170324161318.18718-1-willy@infradead.org>
References: <20170324161318.18718-1-willy@infradead.org>
Return-Path: <willy@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: willy@infradead.org
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

From: Matthew Wilcox <mawilcox@microsoft.com>

memset32() can be used to initialise these three arrays.  Minor code
footprint reduction.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 drivers/scsi/sym53c8xx_2/sym_hipd.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/sym53c8xx_2/sym_hipd.c b/drivers/scsi/sym53c8xx_2/sym_hipd.c
index 6b349e301869..b886b10e3499 100644
--- a/drivers/scsi/sym53c8xx_2/sym_hipd.c
+++ b/drivers/scsi/sym53c8xx_2/sym_hipd.c
@@ -4985,13 +4985,10 @@ struct sym_lcb *sym_alloc_lcb (struct sym_hcb *np, u_char tn, u_char ln)
 	 *  Compute the bus address of this table.
 	 */
 	if (ln && !tp->luntbl) {
-		int i;
-
 		tp->luntbl = sym_calloc_dma(256, "LUNTBL");
 		if (!tp->luntbl)
 			goto fail;
-		for (i = 0 ; i < 64 ; i++)
-			tp->luntbl[i] = cpu_to_scr(vtobus(&np->badlun_sa));
+		memset32(tp->luntbl, cpu_to_scr(vtobus(&np->badlun_sa)), 64);
 		tp->head.luntbl_sa = cpu_to_scr(vtobus(tp->luntbl));
 	}
 
@@ -5077,8 +5074,7 @@ static void sym_alloc_lcb_tags (struct sym_hcb *np, u_char tn, u_char ln)
 	/*
 	 *  Initialize the task table with invalid entries.
 	 */
-	for (i = 0 ; i < SYM_CONF_MAX_TASK ; i++)
-		lp->itlq_tbl[i] = cpu_to_scr(np->notask_ba);
+	memset32(lp->itlq_tbl, cpu_to_scr(np->notask_ba), SYM_CONF_MAX_TASK);
 
 	/*
 	 *  Fill up the tag buffer with tag numbers.
@@ -5764,8 +5760,7 @@ int sym_hcb_attach(struct Scsi_Host *shost, struct sym_fw *fw, struct sym_nvram
 		goto attach_failed;
 
 	np->badlun_sa = cpu_to_scr(SCRIPTB_BA(np, resel_bad_lun));
-	for (i = 0 ; i < 64 ; i++)	/* 64 luns/target, no less */
-		np->badluntbl[i] = cpu_to_scr(vtobus(&np->badlun_sa));
+	memset32(np->badluntbl, cpu_to_scr(vtobus(&np->badlun_sa)), 64);
 
 	/*
 	 *  Prepare the bus address array that contains the bus 
-- 
2.11.0
