Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jun 2018 08:29:40 +0200 (CEST)
Received: from smtprelay0161.hostedemail.com ([216.40.44.161]:49869 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23994653AbeFWG3dnDRF- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jun 2018 08:29:33 +0200
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id DE89C211D6;
        Sat, 23 Jun 2018 06:29:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: run76_35f9b93c7393b
X-Filterd-Recvd-Size: 1667
Received: from joe-laptop.perches.com (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sat, 23 Jun 2018 06:29:30 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: ath25: Convert random_ether_addr to eth_random_addr
Date:   Fri, 22 Jun 2018 23:29:28 -0700
Message-Id: <2a63f5c5d19e51471347a1a45b5b5cd4697dcb23.1529735299.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
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

random_ether_addr is a #define for eth_random_addr which is
generally preferred in kernel code by ~3:1

Convert the uses of random_ether_addr to enable removing the #define

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/mips/ath25/board.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/ath25/board.c b/arch/mips/ath25/board.c
index 6d11ae581ea7..989e71015ee6 100644
--- a/arch/mips/ath25/board.c
+++ b/arch/mips/ath25/board.c
@@ -146,10 +146,10 @@ int __init ath25_find_config(phys_addr_t base, unsigned long size)
 			pr_info("Fixing up empty mac addresses\n");
 			config->reset_config_gpio = 0xffff;
 			config->sys_led_gpio = 0xffff;
-			random_ether_addr(config->wlan0_mac);
+			eth_random_addr(config->wlan0_mac);
 			config->wlan0_mac[0] &= ~0x06;
-			random_ether_addr(config->enet0_mac);
-			random_ether_addr(config->enet1_mac);
+			eth_random_addr(config->enet0_mac);
+			eth_random_addr(config->enet1_mac);
 		}
 	}
 
-- 
2.15.0
