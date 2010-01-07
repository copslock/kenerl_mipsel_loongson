Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jan 2010 20:06:08 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17181 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492464Ab0AGTGD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jan 2010 20:06:03 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
        id <B4b4630710000>; Thu, 07 Jan 2010 11:05:25 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 7 Jan 2010 11:05:11 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 7 Jan 2010 11:05:10 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id o07J58Yw032196;
        Thu, 7 Jan 2010 11:05:08 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id o07J58Vl032195;
        Thu, 7 Jan 2010 11:05:08 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, gregkh@suse.de
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 7/7] Staging: Octeon Ethernet: Use constants from in.h
Date:   Thu,  7 Jan 2010 11:05:06 -0800
Message-Id: <1262891106-32146-7-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4B463005.8060505@caviumnetworks.com>
References: <4B463005.8060505@caviumnetworks.com>
X-OriginalArrivalTime: 07 Jan 2010 19:05:10.0859 (UTC) FILETIME=[55C589B0:01CA8FCC]
X-archive-position: 25529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 5125

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/staging/octeon/ethernet-defines.h |    3 ---
 drivers/staging/octeon/ethernet-tx.c      |    8 ++++----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-defines.h b/drivers/staging/octeon/ethernet-defines.h
index 9c4910e..00a8561 100644
--- a/drivers/staging/octeon/ethernet-defines.h
+++ b/drivers/staging/octeon/ethernet-defines.h
@@ -98,9 +98,6 @@
 #define MAX_SKB_TO_FREE 10
 #define MAX_OUT_QUEUE_DEPTH 1000
 
-#define IP_PROTOCOL_TCP             6
-#define IP_PROTOCOL_UDP             0x11
-
 #define FAU_NUM_PACKET_BUFFERS_TO_FREE (CVMX_FAU_REG_END - sizeof(uint32_t))
 #define TOTAL_NUMBER_OF_PORTS       (CVMX_PIP_NUM_INPUT_PORTS+1)
 
diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
index bc67e41..62258bd 100644
--- a/drivers/staging/octeon/ethernet-tx.c
+++ b/drivers/staging/octeon/ethernet-tx.c
@@ -359,8 +359,8 @@ dont_put_skbuff_in_hw:
 	if (USE_HW_TCPUDP_CHECKSUM && (skb->protocol == htons(ETH_P_IP)) &&
 	    (ip_hdr(skb)->version == 4) && (ip_hdr(skb)->ihl == 5) &&
 	    ((ip_hdr(skb)->frag_off == 0) || (ip_hdr(skb)->frag_off == 1 << 14))
-	    && ((ip_hdr(skb)->protocol == IP_PROTOCOL_TCP)
-		|| (ip_hdr(skb)->protocol == IP_PROTOCOL_UDP))) {
+	    && ((ip_hdr(skb)->protocol == IPPROTO_TCP)
+		|| (ip_hdr(skb)->protocol == IPPROTO_UDP))) {
 		/* Use hardware checksum calc */
 		pko_command.s.ipoffp1 = sizeof(struct ethhdr) + 1;
 	}
@@ -550,8 +550,8 @@ int cvm_oct_xmit_pow(struct sk_buff *skb, struct net_device *dev)
 		work->word2.s.dec_ipcomp = 0;	/* FIXME */
 #endif
 		work->word2.s.tcp_or_udp =
-		    (ip_hdr(skb)->protocol == IP_PROTOCOL_TCP)
-		    || (ip_hdr(skb)->protocol == IP_PROTOCOL_UDP);
+		    (ip_hdr(skb)->protocol == IPPROTO_TCP)
+		    || (ip_hdr(skb)->protocol == IPPROTO_UDP);
 #if 0
 		/* FIXME */
 		work->word2.s.dec_ipsec = 0;
-- 
1.6.0.6
