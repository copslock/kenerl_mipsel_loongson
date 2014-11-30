Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Nov 2014 11:41:38 +0100 (CET)
Received: from mout.gmx.net ([212.227.15.19]:61712 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006651AbaK3Klh2fovR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 30 Nov 2014 11:41:37 +0100
Received: from neptun.fritz.box ([78.42.221.218]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0MEXHd-1Xfret3utV-00Fksq; Sun, 30 Nov 2014 11:41:31
 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: [PATCH] ioc3: fix incorrect use of htons/ntohs
Date:   Sun, 30 Nov 2014 11:40:54 +0100
Message-Id: <1417344054-4374-1-git-send-email-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 1.9.1
X-Provags-ID:  V03:K0:NiX33ILS5w7Kxg3QDE4Zyk//+pN24RBypE7DT/SveQYN5VMFOKu
 EWdhpB6lGnfAmQaJWYwaAg7BuzKPnW72qN6PgHrZmkgsCF+g+yJVVoNdn8PJJ9R24u0EYut
 bGCplhp5Cs3MLA0KN1elS2yQQI4TTu0eKTP5nDETOKYNAIflos6iaUJ4QvAm4o9clSsF25h
 9AiuwYfLt+cPyYv61l6zw==
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <LinoSanfilippo@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: LinoSanfilippo@gmx.de
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

The protocol type in the ip header struct is a single byte variable. So there
is no need to swap bytes depending on host endianness.

Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
---

Please note that I could not test this, since I dont have access to the
concerning hardware.

 drivers/net/ethernet/sgi/ioc3-eth.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index 7a254da..0bb303d 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -540,8 +540,7 @@ static void ioc3_tcpudp_checksum(struct sk_buff *skb, uint32_t hwsum, int len)
 
 	/* Same as tx - compute csum of pseudo header  */
 	csum = hwsum +
-	       (ih->tot_len - (ih->ihl << 2)) +
-	       htons((uint16_t)ih->protocol) +
+	       (ih->tot_len - (ih->ihl << 2)) + ih->protocol +
 	       (ih->saddr >> 16) + (ih->saddr & 0xffff) +
 	       (ih->daddr >> 16) + (ih->daddr & 0xffff);
 
@@ -1417,7 +1416,7 @@ static int ioc3_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	 */
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		const struct iphdr *ih = ip_hdr(skb);
-		const int proto = ntohs(ih->protocol);
+		const int proto = ih->protocol;
 		unsigned int csoff;
 		uint32_t csum, ehsum;
 		uint16_t *eh;
-- 
1.9.1
