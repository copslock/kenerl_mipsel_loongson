Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2016 23:59:51 +0200 (CEST)
Received: from mailrelay104.isp.belgacom.be ([195.238.20.131]:41908 "EHLO
        mailrelay104.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993467AbcHLV7ouSNRP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Aug 2016 23:59:44 +0200
X-Belgacom-Dynamic: yes
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AIBADRRa5X/0VLtVtegnJTgVK0fYIpg?=
 =?us-ascii?q?g+BfYYXBAKBSTkUAgEBAQEBAV0nhTsjgRokE4g1tSCLD4YqiF2GCwWZPY8VAoF?=
 =?us-ascii?q?TjW5Ij2ceNoFBAQuCLzoyhVWBRQEBAQ?=
Received: from 69.75-181-91.adsl-dyn.isp.belgacom.be (HELO localhost.localdomain) ([91.181.75.69])
  by relay.skynet.be with ESMTP; 12 Aug 2016 23:59:39 +0200
From:   Fabian Frederick <fabf@skynet.be>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Rob Herring <robh@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, fabf@skynet.be
Subject: [PATCH 1/1 linux-next] mips: pistachio_defconfig: remove ANDROID_TIMED_OUTPUT
Date:   Fri, 12 Aug 2016 23:59:19 +0200
Message-Id: <1471039159-13596-1-git-send-email-fabf@skynet.be>
X-Mailer: git-send-email 2.8.1
Return-Path: <fabf@skynet.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fabf@skynet.be
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

According to commit 9f6b68774f29
("android: remove timed output/gpio driver")

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 arch/mips/configs/pistachio_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/configs/pistachio_defconfig b/arch/mips/configs/pistachio_defconfig
index 6986313..7d32fbb 100644
--- a/arch/mips/configs/pistachio_defconfig
+++ b/arch/mips/configs/pistachio_defconfig
@@ -263,7 +263,6 @@ CONFIG_DMADEVICES=y
 CONFIG_IMG_MDC_DMA=y
 CONFIG_STAGING=y
 CONFIG_ASHMEM=y
-# CONFIG_ANDROID_TIMED_OUTPUT is not set
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_MEMORY=y
 CONFIG_IIO=y
-- 
2.8.1
