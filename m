Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 May 2015 13:27:49 +0200 (CEST)
Received: from aserp1040.oracle.com ([141.146.126.69]:19400 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026667AbbEKL02jbSNw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 May 2015 13:26:28 +0200
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t4BBQG5h011263
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 11 May 2015 11:26:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t4BBQFL4008350
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 11 May 2015 11:26:15 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t4BBQFE8006751;
        Mon, 11 May 2015 11:26:15 GMT
Received: from lappy.hsd1.nh.comcast.net (/10.159.243.153)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 May 2015 04:26:15 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     Huacai Chen <chenhc@lemote.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 3.18 stable tree] MIPS: Hibernate: flush TLB entries earlier
Date:   Mon, 11 May 2015 07:17:16 -0400
Message-Id: <1431343152-19437-55-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1431343152-19437-1-git-send-email-sasha.levin@oracle.com>
References: <1431343152-19437-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: aserv0022.oracle.com [141.146.126.234]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47308
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sasha.levin@oracle.com
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

From: Huacai Chen <chenhc@lemote.com>

This patch has been added to the 3.18 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit a843d00d038b11267279e3b5388222320f9ddc1d ]

We found that TLB mismatch not only happens after kernel resume, but
also happens during snapshot restore. So move it to the beginning of
swsusp_arch_suspend().

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Cc: <stable@vger.kernel.org>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: stable@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/9621/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/mips/power/hibernate.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/power/hibernate.S b/arch/mips/power/hibernate.S
index 32a7c82..e7567c8 100644
--- a/arch/mips/power/hibernate.S
+++ b/arch/mips/power/hibernate.S
@@ -30,6 +30,8 @@ LEAF(swsusp_arch_suspend)
 END(swsusp_arch_suspend)
 
 LEAF(swsusp_arch_resume)
+	/* Avoid TLB mismatch during and after kernel resume */
+	jal local_flush_tlb_all
 	PTR_L t0, restore_pblist
 0:
 	PTR_L t1, PBE_ADDRESS(t0)   /* source */
@@ -43,7 +45,6 @@ LEAF(swsusp_arch_resume)
 	bne t1, t3, 1b
 	PTR_L t0, PBE_NEXT(t0)
 	bnez t0, 0b
-	jal local_flush_tlb_all /* Avoid TLB mismatch after kernel resume */
 	PTR_LA t0, saved_regs
 	PTR_L ra, PT_R31(t0)
 	PTR_L sp, PT_R29(t0)
-- 
2.1.0
