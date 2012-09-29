Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Sep 2012 20:14:01 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:46309 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903300Ab2I2SMf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 29 Sep 2012 20:12:35 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 84FE787B9;
        Sat, 29 Sep 2012 20:12:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tokVlwi-Wlsn; Sat, 29 Sep 2012 20:12:32 +0200 (CEST)
Received: from hauke.lan (unknown [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 3DBEE8F62;
        Sat, 29 Sep 2012 20:12:19 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, john@phrozen.org
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/5] MIPS: BCM47XX: read sprom without prefix if no ieee80211 core
Date:   Sat, 29 Sep 2012 20:12:05 +0200
Message-Id: <1348942326-27195-5-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1348942326-27195-1-git-send-email-hauke@hauke-m.de>
References: <1348942326-27195-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 34562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

If there is no ieee80211 core on the devices like on the BCM4706 read
out the sprom and the other data without using a prefix.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/setup.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 95bf4d7..803764d 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -175,6 +175,8 @@ static int bcm47xx_get_sprom_bcma(struct bcma_bus *bus, struct ssb_sprom *out)
 			snprintf(prefix, sizeof(prefix), "sb/%u/",
 				 core->core_index);
 			bcm47xx_fill_sprom(out, prefix);
+		} else {
+			bcm47xx_fill_sprom(out, NULL);
 		}
 		return 0;
 	default:
-- 
1.7.9.5
