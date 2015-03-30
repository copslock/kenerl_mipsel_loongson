Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Mar 2015 18:03:48 +0200 (CEST)
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:41452 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014777AbbC3QBYg92Sy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Mar 2015 18:01:24 +0200
Received: from localhost (localhost [127.0.0.1])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 7314A460B22
        for <linux-mips@linux-mips.org>; Mon, 30 Mar 2015 17:01:25 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
        by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FHu-lESNV0VG for <linux-mips@linux-mips.org>;
        Mon, 30 Mar 2015 17:01:19 +0100 (BST)
Received: from pm-laptop.codethink.co.uk (pm-laptop.dyn.ducie.codethink.co.uk [10.24.1.94])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 6ABEC460C33
        for <linux-mips@linux-mips.org>; Mon, 30 Mar 2015 17:01:04 +0100 (BST)
Received: from pm by pm-laptop.codethink.co.uk with local (Exim 4.84)
        (envelope-from <paul.martin@codethink.co.uk>)
        id 1Ycc7c-0007oF-6H
        for linux-mips@linux-mips.org; Mon, 30 Mar 2015 17:01:04 +0100
From:   Paul Martin <paul.martin@codethink.co.uk>
To:     linux-mips@linux-mips.org
Subject: [PATCH 08/10] MIPS: OCTEON: Fix to IP checksum offloading in Little Endian
Date:   Mon, 30 Mar 2015 17:01:01 +0100
Message-Id: <1427731263-29950-9-git-send-email-paul.martin@codethink.co.uk>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1427731263-29950-1-git-send-email-paul.martin@codethink.co.uk>
References: <1427731263-29950-1-git-send-email-paul.martin@codethink.co.uk>
Return-Path: <paul.martin@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.martin@codethink.co.uk
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

When hardware checksum generation is switched on the checksum
generation was only being signalled to the hardware correctly
in Big Endian mode.

Signed-off-by: Paul Martin <paul.martin@codethink.co.uk>
---
 drivers/staging/octeon/ethernet-tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
index a078b90..5b9ac1f 100644
--- a/drivers/staging/octeon/ethernet-tx.c
+++ b/drivers/staging/octeon/ethernet-tx.c
@@ -413,7 +413,7 @@ dont_put_skbuff_in_hw:
 	/* Check if we can use the hardware checksumming */
 	if (USE_HW_TCPUDP_CHECKSUM && (skb->protocol == htons(ETH_P_IP)) &&
 	    (ip_hdr(skb)->version == 4) && (ip_hdr(skb)->ihl == 5) &&
-	    ((ip_hdr(skb)->frag_off == 0) || (ip_hdr(skb)->frag_off == 1 << 14))
+	    ((ip_hdr(skb)->frag_off == 0) || (ip_hdr(skb)->frag_off == htons(1 << 14)))
 	    && ((ip_hdr(skb)->protocol == IPPROTO_TCP)
 		|| (ip_hdr(skb)->protocol == IPPROTO_UDP))) {
 		/* Use hardware checksum calc */
-- 
2.1.4
