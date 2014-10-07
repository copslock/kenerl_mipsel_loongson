Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 05:58:01 +0200 (CEST)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:65467 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009202AbaJGD6AYu-lM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 05:58:00 +0200
Received: by mail-pa0-f46.google.com with SMTP id fa1so6350975pad.5
        for <multiple recipients>; Mon, 06 Oct 2014 20:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=cU+KDGyex4pm2jPv+iJ6sWXAztx+HpE2RW7xqaXePmg=;
        b=DIdOWolbZlMC8QDoOP1qoNxc4PyHt6ecIaTmpgsQx6xHL4R2YwKy0Pfqbk+k190v9w
         aDQmr0k7kY5nIjIugMY7BFv3O4ySJP0HRzFf3DJmyRRsuvpIFtWYVOMQ2D3ihPp/YNX5
         8qcrzsk4PKxV0qrLBurt9BzcbOGi9jHW7mH5m3IxwZLdz71j5a12uaCeed4ysVAu4TRr
         9iOj2dgtU+5RndFyaovGIvAVr1j/5pgUj6vJugJ/sKj5yKq2WHnt6G4kd7tqfWiI8RXW
         RGrB0Q+2ndugG3lBeVIXRv+4fy//3qpprwv18ba4htGGlIHAtOnt5mJwiA1njWRFjuoy
         KoEQ==
X-Received: by 10.66.185.49 with SMTP id ez17mr1061314pac.58.1412654273770;
        Mon, 06 Oct 2014 20:57:53 -0700 (PDT)
Received: from masabert (p89164-omed01.osaka.ocn.ne.jp. [153.140.100.164])
        by mx.google.com with ESMTPSA id 16sm12469494pdj.42.2014.10.06.20.57.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Oct 2014 20:57:52 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id B591DE0356; Tue,  7 Oct 2014 12:57:47 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, ralf@linux-mips.org,
        linux-mips@linux-mips.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] MIPS: rtlx: Remove unnecessary KERN_DEBUG in rtlx.c
Date:   Tue,  7 Oct 2014 12:57:45 +0900
Message-Id: <1412654265-31983-1-git-send-email-standby24x7@gmail.com>
X-Mailer: git-send-email 2.1.1.273.g97b8860
Return-Path: <standby24x7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: standby24x7@gmail.com
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

This patch remove unnecessary KERNL_DEBUG in pr_debug() within rtlx.c.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 arch/mips/kernel/rtlx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/rtlx.c b/arch/mips/kernel/rtlx.c
index 31b1b76..c5c4fd5 100644
--- a/arch/mips/kernel/rtlx.c
+++ b/arch/mips/kernel/rtlx.c
@@ -94,12 +94,12 @@ int rtlx_open(int index, int can_sleep)
 	int ret = 0;
 
 	if (index >= RTLX_CHANNELS) {
-		pr_debug(KERN_DEBUG "rtlx_open index out of range\n");
+		pr_debug("rtlx_open index out of range\n");
 		return -ENOSYS;
 	}
 
 	if (atomic_inc_return(&channel_wqs[index].in_open) > 1) {
-		pr_debug(KERN_DEBUG "rtlx_open channel %d already opened\n", index);
+		pr_debug("rtlx_open channel %d already opened\n", index);
 		ret = -EBUSY;
 		goto out_fail;
 	}
-- 
2.1.1.273.g97b8860
