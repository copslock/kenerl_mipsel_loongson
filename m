Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Sep 2011 03:08:09 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:64063 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491985Ab1IZBID (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Sep 2011 03:08:03 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p8Q17oZC015245
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 25 Sep 2011 18:07:51 -0700 (PDT)
Received: from lirq-OptiPlex-780.corp.ad.wrs.com (128.224.162.179) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
 14.1.255.0; Sun, 25 Sep 2011 18:07:50 -0700
From:   <rongqing.li@windriver.com>
To:     <linux-mips@linux-mips.org>, <netdev@vger.kernel.org>
CC:     <ralf@linux-mips.org>, <david.daney@cavium.com>
Subject: [PATCH] staging/octeon: Software should check the checksum of no tcp/udp packets
Date:   Mon, 26 Sep 2011 09:08:00 +0800
Message-ID: <1316999280-11999-1-git-send-email-rongqing.li@windriver.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Content-Type: text/plain
X-archive-position: 31158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rongqing.li@windriver.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14236

From: Roy.Li <rongqing.li@windriver.com>

Icmp packets with wrong checksum are never dropped since
skb->ip_summed is set to CHECKSUM_UNNECESSARY.

When icmp packets with wrong checksum pass through the octeon
net driver, the not_IP, IP_exc, L4_error hardware indicators
show no error. so the driver sets CHECKSUM_UNNECESSARY on
skb->ip_summed.

L4_error only works for TCP/UDP, not for ICMP.

Signed-off-by: Roy.Li <rongqing.li@windriver.com>
---
 drivers/staging/octeon/ethernet-rx.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-rx.c b/drivers/staging/octeon/ethernet-rx.c
index 1a7c19a..1747024 100644
--- a/drivers/staging/octeon/ethernet-rx.c
+++ b/drivers/staging/octeon/ethernet-rx.c
@@ -411,7 +411,8 @@ static int cvm_oct_napi_poll(struct napi_struct *napi, int budget)
 				skb->protocol = eth_type_trans(skb, dev);
 				skb->dev = dev;
 
-				if (unlikely(work->word2.s.not_IP || work->word2.s.IP_exc || work->word2.s.L4_error))
+				if (unlikely(work->word2.s.not_IP || work->word2.s.IP_exc ||
+					work->word2.s.L4_error || !work->word2.s.tcp_or_udp))
 					skb->ip_summed = CHECKSUM_NONE;
 				else
 					skb->ip_summed = CHECKSUM_UNNECESSARY;
-- 
1.7.1
