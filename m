Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 20:25:45 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:57807 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014490AbcADTY0YUwLi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Jan 2016 20:24:26 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 4EEEB280520;
        Mon,  4 Jan 2016 20:23:52 +0100 (CET)
Received: from localhost.localdomain (p548C87BE.dip0.t-ipconnect.de [84.140.135.190])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Mon,  4 Jan 2016 20:23:50 +0100 (CET)
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 6/8] MIPS: ralink: fix vendor string for mt7620
Date:   Mon,  4 Jan 2016 20:23:59 +0100
Message-Id: <1451935441-40803-6-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1451935441-40803-1-git-send-email-blogic@openwrt.org>
References: <1451935441-40803-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Ralink was acquired by Mediatek. Represent this in the cpuinfo. It
apparently confused people.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/mt7620.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 4c17dc6..da01e1f 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -572,7 +572,7 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
 	}
 
 	snprintf(soc_info->sys_type, RAMIPS_SYS_TYPE_LEN,
-		"Ralink %s ver:%u eco:%u",
+		"MediaTek %s ver:%u eco:%u",
 		name,
 		(rev >> CHIP_REV_VER_SHIFT) & CHIP_REV_VER_MASK,
 		(rev & CHIP_REV_ECO_MASK));
-- 
1.7.10.4
