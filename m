Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 16:02:49 +0100 (CET)
Received: from aserp1040.oracle.com ([141.146.126.69]:27562 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008721AbcBJPCoEYs6- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 16:02:44 +0100
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u1AF1VjU008455
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 10 Feb 2016 15:01:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id u1AF1VFv007699
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Wed, 10 Feb 2016 15:01:31 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id u1AF1RZW029618;
        Wed, 10 Feb 2016 15:01:29 GMT
Received: from lappy.us.oracle.com (/10.154.137.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Feb 2016 07:01:27 -0800
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     Tariq Saeed <tariq.x.saeed@oracle.com>,
        Huacai Chen <chenhc@lemote.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 3.18 stable tree] MIPS: Fix some missing CONFIG_CPU_MIPSR6 #ifdefs
Date:   Wed, 10 Feb 2016 09:58:42 -0500
Message-Id: <1455116401-27978-111-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1455116401-27978-1-git-send-email-sasha.levin@oracle.com>
References: <1455116401-27978-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: aserv0022.oracle.com [141.146.126.234]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51974
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

From: Tariq Saeed <tariq.x.saeed@oracle.com>

This patch has been added to the 3.18 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit 4f33f6c522948fffc345261896042b58dea23754 ]

Commit be0c37c985eddc4 (MIPS: Rearrange PTE bits into fixed positions.)
defines fixed PTE bits for MIPS R2. Then, commit d7b631419b3d230a4d383
(MIPS: pgtable-bits: Fix XPA damage to R6 definitions.) adds the MIPS
R6 definitions in the same way as MIPS R2. But some R6 #ifdefs in the
later commit are missing, so in this patch I fix that.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/12164/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 fs/ocfs2/dlmglue.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 60d6fd9..12fe56b 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -1373,6 +1373,7 @@ static int __ocfs2_cluster_lock(struct ocfs2_super *osb,
 	unsigned long flags;
 	unsigned int gen;
 	int noqueue_attempted = 0;
+	int kick_dc = 0;
 
 	ocfs2_init_mask_waiter(&mw);
 
@@ -1501,7 +1502,12 @@ update_holders:
 unlock:
 	lockres_clear_flags(lockres, OCFS2_LOCK_UPCONVERT_FINISHING);
 
+	/* ocfs2_unblock_lock reques on seeing OCFS2_LOCK_UPCONVERT_FINISHING */
+	kick_dc = (lockres->l_flags & OCFS2_LOCK_BLOCKED);
+
 	spin_unlock_irqrestore(&lockres->l_lock, flags);
+	if (kick_dc)
+		ocfs2_wake_downconvert_thread(osb);
 out:
 	/*
 	 * This is helping work around a lock inversion between the page lock
-- 
2.5.0
