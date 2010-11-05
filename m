Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Nov 2010 04:09:12 +0100 (CET)
Received: from mail.perches.com ([173.55.12.10]:4055 "EHLO mail.perches.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490978Ab0KEDIn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Nov 2010 04:08:43 +0100
Received: from Joe-Laptop.home (unknown [192.168.1.162])
        by mail.perches.com (Postfix) with ESMTP id 804092436C;
        Thu,  4 Nov 2010 19:08:27 -0800 (PST)
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/49] arch/mips: Use vzalloc
Date:   Thu,  4 Nov 2010 20:07:26 -0700
Message-Id: <5c276d41d5e8833fc912b3f60088b1d8b991b21b.1288925424.git.joe@perches.com>
X-Mailer: git-send-email 1.7.3.1.g432b3.dirty
In-Reply-To: <alpine.DEB.2.00.1011031108260.11625@router.home>
References: <alpine.DEB.2.00.1011031108260.11625@router.home>
In-Reply-To: <cover.1288925424.git.joe@perches.com>
References: <cover.1288925424.git.joe@perches.com>
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/mips/sibyte/common/sb_tbprof.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/mips/sibyte/common/sb_tbprof.c b/arch/mips/sibyte/common/sb_tbprof.c
index 87ccdb4..48853ab 100644
--- a/arch/mips/sibyte/common/sb_tbprof.c
+++ b/arch/mips/sibyte/common/sb_tbprof.c
@@ -410,14 +410,13 @@ static int sbprof_tb_open(struct inode *inode, struct file *filp)
 		return -EBUSY;
 
 	memset(&sbp, 0, sizeof(struct sbprof_tb));
-	sbp.sbprof_tbbuf = vmalloc(MAX_TBSAMPLE_BYTES);
+	sbp.sbprof_tbbuf = vzalloc(MAX_TBSAMPLE_BYTES);
 	if (!sbp.sbprof_tbbuf) {
 		sbp.open = SB_CLOSED;
 		wmb();
 		return -ENOMEM;
 	}
 
-	memset(sbp.sbprof_tbbuf, 0, MAX_TBSAMPLE_BYTES);
 	init_waitqueue_head(&sbp.tb_sync);
 	init_waitqueue_head(&sbp.tb_read);
 	mutex_init(&sbp.lock);
-- 
1.7.3.1.g432b3.dirty
