Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2012 20:47:50 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:38687 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903655Ab2HUSp0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2012 20:45:26 +0200
Received: by dajq27 with SMTP id q27so80730daj.36
        for <multiple recipients>; Tue, 21 Aug 2012 11:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=PoqVl/kgxfAU4DU1EctKGGN/I7BISYjgH3cT+AGHez0=;
        b=dTCegMHup+r1S296f5mPggdhTw1RyQlLFb900tCalmdLVYYcWwO7I5W5sNnZ+WJB+W
         ILpOEiEx58M8mtgabpF7USOE5DOJ55QZc6F/ASO7LdodgIaEMG496qlpdn0KuWHqGMON
         vNRd73ND4+KNrLtViGMyCPQoULFKyBYW4DlJAM4pN5GA4YGLVjWNPngcTNUN0ltJhpQF
         ZjbUkO3HTDUYg17Q1B49Ht+EkgNXUTVe2/hLLv2oKnB9ZTspmkxRr/UdRDyP0JqjTBEL
         bMqIiAKEdha/0tZV1TDSHGn8AEaamzeJEcHhIyaWiULUWOSiNLFvR1Q/qZMePNHM7OzB
         Xu2Q==
Received: by 10.68.116.17 with SMTP id js17mr46611415pbb.109.1345574719854;
        Tue, 21 Aug 2012 11:45:19 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ox5sm1930102pbc.75.2012.08.21.11.45.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Aug 2012 11:45:19 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id q7LIjHS2021511;
        Tue, 21 Aug 2012 11:45:17 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id q7LIjHf8021510;
        Tue, 21 Aug 2012 11:45:17 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 6/8] netdev: octeon_mgmt: Cleanup and modernize MAC address handling.
Date:   Tue, 21 Aug 2012 11:45:10 -0700
Message-Id: <1345574712-21444-7-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.4
In-Reply-To: <1345574712-21444-1-git-send-email-ddaney.cavm@gmail.com>
References: <1345574712-21444-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 34323
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

Use eth_mac_addr(), and generate a random address if none is otherwise
assigned.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/net/ethernet/octeon/octeon_mgmt.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/octeon/octeon_mgmt.c b/drivers/net/ethernet/octeon/octeon_mgmt.c
index 3bae01f..9b526da 100644
--- a/drivers/net/ethernet/octeon/octeon_mgmt.c
+++ b/drivers/net/ethernet/octeon/octeon_mgmt.c
@@ -648,12 +648,10 @@ static void octeon_mgmt_set_rx_filtering(struct net_device *netdev)
 
 static int octeon_mgmt_set_mac_address(struct net_device *netdev, void *addr)
 {
-	struct sockaddr *sa = addr;
+	int r = eth_mac_addr(netdev, addr);
 
-	if (!is_valid_ether_addr(sa->sa_data))
-		return -EADDRNOTAVAIL;
-
-	memcpy(netdev->dev_addr, sa->sa_data, ETH_ALEN);
+	if (r)
+		return r;
 
 	octeon_mgmt_set_rx_filtering(netdev);
 
@@ -1545,8 +1543,12 @@ static int __devinit octeon_mgmt_probe(struct platform_device *pdev)
 
 	mac = of_get_mac_address(pdev->dev.of_node);
 
-	if (mac)
-		memcpy(netdev->dev_addr, mac, 6);
+	if (mac && is_valid_ether_addr(mac)) {
+		memcpy(netdev->dev_addr, mac, ETH_ALEN);
+		netdev->addr_assign_type &= ~NET_ADDR_RANDOM;
+	} else {
+		eth_hw_addr_random(netdev);
+	}
 
 	p->phy_np = of_parse_phandle(pdev->dev.of_node, "phy-handle", 0);
 
-- 
1.7.11.4
