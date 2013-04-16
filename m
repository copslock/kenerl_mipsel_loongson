Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Apr 2013 10:54:40 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:41063 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835158Ab3DPIxZ2GGuY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Apr 2013 10:53:25 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 5/7] MIPS: ralink: add memory definition for RT3883
Date:   Tue, 16 Apr 2013 10:49:14 +0200
Message-Id: <1366102156-21281-5-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1366102156-21281-1-git-send-email-blogic@openwrt.org>
References: <1366102156-21281-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36226
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

Populate struct soc_info with the data that describes our RAM window.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/mach-ralink/rt3883.h |    4 ++++
 arch/mips/ralink/rt3883.c                  |    4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/mips/include/asm/mach-ralink/rt3883.h b/arch/mips/include/asm/mach-ralink/rt3883.h
index b91c6c1..e58e06f 100644
--- a/arch/mips/include/asm/mach-ralink/rt3883.h
+++ b/arch/mips/include/asm/mach-ralink/rt3883.h
@@ -244,4 +244,8 @@
 #define RT3883_FLASH_CFG_WIDTH_16BIT	0x1
 #define RT3883_FLASH_CFG_WIDTH_32BIT	0x2
 
+#define RT3883_SDRAM_BASE		0x00000000
+#define RT3883_MEM_SIZE_MIN		2
+#define RT3883_MEM_SIZE_MAX		256
+
 #endif /* _RT3883_REGS_H_ */
diff --git a/arch/mips/ralink/rt3883.c b/arch/mips/ralink/rt3883.c
index 2d90aa9..afbf2ce 100644
--- a/arch/mips/ralink/rt3883.c
+++ b/arch/mips/ralink/rt3883.c
@@ -239,4 +239,8 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
 		name,
 		(id >> RT3883_REVID_VER_ID_SHIFT) & RT3883_REVID_VER_ID_MASK,
 		(id & RT3883_REVID_ECO_ID_MASK));
+
+	soc_info->mem_base = RT3883_SDRAM_BASE;
+	soc_info->mem_size_min = RT3883_MEM_SIZE_MIN;
+	soc_info->mem_size_max = RT3883_MEM_SIZE_MAX;
 }
-- 
1.7.10.4
