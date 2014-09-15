Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Sep 2014 18:23:57 +0200 (CEST)
Received: from mail-ig0-f173.google.com ([209.85.213.173]:40803 "EHLO
        mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008815AbaIOQXzile2o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Sep 2014 18:23:55 +0200
Received: by mail-ig0-f173.google.com with SMTP id l13so4208920iga.12
        for <linux-mips@linux-mips.org>; Mon, 15 Sep 2014 09:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=jevKCM5xvrDEdzSn/GQsJOpf5DN2vBwYoJlf9W7pTbk=;
        b=nHkLV5S4xim3H0/XnppWylIdYMF5x6TfcIrVbgjgTcfvvjFbH/9ialdqFAW98+69Wb
         EQViV+wmJXQXeC3KJ8vBvGGz5c0PBYEDvEgNPqX4I6vIdl9i6AyaRj9vNvvkDdulsvNu
         rsW43rsF6Fj8kHB/34kEQkm3HNDNiCp3pDSgyLTBhMK0Ztg6vwlU8WiDer8jnyLcWcNj
         j8w5IcUFfsQBWL2l322R1/SI8O4aW4zxRLc3jib32y37dRl714qrUDbIWV1rUWM+WPfo
         UaLfhaPuD1K43GCl1l4p8jDz5Qv9x6F0lsgpxHXa/NTfFjCp/3VX/4CnOju/XJJoukjJ
         lfhw==
X-Received: by 10.50.30.72 with SMTP id q8mr23197791igh.14.1410798229382;
        Mon, 15 Sep 2014 09:23:49 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id p5sm10485955iga.5.2014.09.15.09.23.48
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 15 Sep 2014 09:23:48 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id s8FGNlAe021453;
        Mon, 15 Sep 2014 09:23:47 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id s8FGNjZu021452;
        Mon, 15 Sep 2014 09:23:45 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Joe Perches <joe@perches.com>
Subject: [PATCH] netdev: octeon_mgmt: Fix ISO C90 forbids mixed declarations and code warning.
Date:   Mon, 15 Sep 2014 09:23:43 -0700
Message-Id: <1410798223-21420-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

We were getting:

  drivers/net/ethernet/octeon/octeon_mgmt.c:295:4: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]

The idea of the fix from Joe Perches.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Joe Perches <joe@perches.com>
---

This patch should supersede previous patches from Heinrich Schuchardt,
and may be preferable as it touches fewer lines of code.

 drivers/net/ethernet/octeon/octeon_mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/octeon/octeon_mgmt.c b/drivers/net/ethernet/octeon/octeon_mgmt.c
index 979c698..5e10c1d 100644
--- a/drivers/net/ethernet/octeon/octeon_mgmt.c
+++ b/drivers/net/ethernet/octeon/octeon_mgmt.c
@@ -290,12 +290,12 @@ static void octeon_mgmt_clean_tx_buffers(struct octeon_mgmt *p)
 		/* Read the hardware TX timestamp if one was recorded */
 		if (unlikely(re.s.tstamp)) {
 			struct skb_shared_hwtstamps ts;
-			memset(&ts, 0, sizeof(ts));
 			/* Read the timestamp */
 			u64 ns = cvmx_read_csr(CVMX_MIXX_TSTAMP(p->port));
 			/* Remove the timestamp from the FIFO */
 			cvmx_write_csr(CVMX_MIXX_TSCTL(p->port), 0);
 			/* Tell the kernel about the timestamp */
+			memset(&ts, 0, sizeof(ts));
 			ts.hwtstamp = ns_to_ktime(ns);
 			skb_tstamp_tx(skb, &ts);
 		}
-- 
1.7.11.7
