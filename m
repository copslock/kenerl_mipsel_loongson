Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2012 20:48:13 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:54045 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903659Ab2HUSp0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2012 20:45:26 +0200
Received: by pbbrq8 with SMTP id rq8so322102pbb.36
        for <multiple recipients>; Tue, 21 Aug 2012 11:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Vv35rdAB93MDDe5TkidOpGAjJX4jyW0m0TBMOYkeTPw=;
        b=csETSL25uoaP+AprZ+/HeVA7FzwutS6AJxJ+dsJ5Gw30c+LW2u4c7hipv9Avnh2oy9
         YcExky67bQFduab9lO6Mj4uxnRC7hF+OXGAndEJa9YmE5l/AYEWFysT1dYtDr6SX/ONE
         /Ac5IJRP6RNL+7cBy6uzpN/NWmXcZ35KSivXVib4i0442d6YjDTVy84DSf+8qZ5hNPZT
         VzwJWiPzPimAix3XBK5Ar0cha0jIFCIDi9p39wIJqDipv9p9N0E7SCEHrhSAcs1rSjlE
         SD5/s6N093SWRSYKorfveNY9ZjeLp1eMW0m6W9ipA7K3vELUz6Uhicm/G2Vh7LanvVRk
         KOmA==
Received: by 10.68.129.73 with SMTP id nu9mr46799617pbb.59.1345574720317;
        Tue, 21 Aug 2012 11:45:20 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ka4sm1934796pbc.61.2012.08.21.11.45.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Aug 2012 11:45:19 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id q7LIjHtS021515;
        Tue, 21 Aug 2012 11:45:17 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id q7LIjHPS021514;
        Tue, 21 Aug 2012 11:45:17 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 7/8] netdev: octeon_mgmt: Remove some useless 'inline'
Date:   Tue, 21 Aug 2012 11:45:11 -0700
Message-Id: <1345574712-21444-8-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.4
In-Reply-To: <1345574712-21444-1-git-send-email-ddaney.cavm@gmail.com>
References: <1345574712-21444-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 34324
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/net/ethernet/octeon/octeon_mgmt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/octeon/octeon_mgmt.c b/drivers/net/ethernet/octeon/octeon_mgmt.c
index 9b526da..ccb1f81 100644
--- a/drivers/net/ethernet/octeon/octeon_mgmt.c
+++ b/drivers/net/ethernet/octeon/octeon_mgmt.c
@@ -173,22 +173,22 @@ static void octeon_mgmt_set_tx_irq(struct octeon_mgmt *p, int enable)
 	spin_unlock_irqrestore(&p->lock, flags);
 }
 
-static inline void octeon_mgmt_enable_rx_irq(struct octeon_mgmt *p)
+static void octeon_mgmt_enable_rx_irq(struct octeon_mgmt *p)
 {
 	octeon_mgmt_set_rx_irq(p, 1);
 }
 
-static inline void octeon_mgmt_disable_rx_irq(struct octeon_mgmt *p)
+static void octeon_mgmt_disable_rx_irq(struct octeon_mgmt *p)
 {
 	octeon_mgmt_set_rx_irq(p, 0);
 }
 
-static inline void octeon_mgmt_enable_tx_irq(struct octeon_mgmt *p)
+static void octeon_mgmt_enable_tx_irq(struct octeon_mgmt *p)
 {
 	octeon_mgmt_set_tx_irq(p, 1);
 }
 
-static inline void octeon_mgmt_disable_tx_irq(struct octeon_mgmt *p)
+static void octeon_mgmt_disable_tx_irq(struct octeon_mgmt *p)
 {
 	octeon_mgmt_set_tx_irq(p, 0);
 }
-- 
1.7.11.4
