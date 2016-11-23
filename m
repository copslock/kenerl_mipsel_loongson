Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2016 14:46:11 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11377 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993041AbcKWNoKEW1-G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Nov 2016 14:44:10 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 35DC6998E6556;
        Wed, 23 Nov 2016 13:43:57 +0000 (GMT)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 23 Nov 2016 13:44:00 +0000
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 05/10] MIPS: platform: allow for DTB to be moved during kernel relocation
Date:   Wed, 23 Nov 2016 14:43:47 +0100
Message-ID: <1479908632-30392-6-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1479908632-30392-1-git-send-email-marcin.nowakowski@imgtec.com>
References: <1479908632-30392-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

Add plat_fdt_relocated(void*) API to allow the kernel relocation code to
update platform's information about the DTB location if the DTB had to
be moved due to being placed in a location used by the relocated kernel.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 arch/mips/generic/init.c         | 13 +++++++++++++
 arch/mips/include/asm/bootinfo.h | 13 +++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/mips/generic/init.c b/arch/mips/generic/init.c
index d493ccb..4af6192 100644
--- a/arch/mips/generic/init.c
+++ b/arch/mips/generic/init.c
@@ -88,6 +88,19 @@ void __init *plat_get_fdt(void)
 	return (void *)fdt;
 }
 
+void __init plat_fdt_relocated(void *new_location)
+{
+	/*
+	 * reset fdt as the cached value would point to the location
+	 * before relocations happened and update the location argument
+	 * if it was passed using UHI
+	 */
+	fdt = NULL;
+
+	if (fw_arg0 == -2)
+		fw_arg1 = (unsigned long)new_location;
+}
+
 void __init plat_mem_setup(void)
 {
 	if (mach && mach->fixup_fdt)
diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index ee9f5f2..e26a093 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -164,6 +164,19 @@ static inline void plat_swiotlb_setup(void) {}
  * Return: Pointer to the flattened device tree blob.
  */
 extern void *plat_get_fdt(void);
+
+#ifdef CONFIG_RELOCATABLE
+
+/**
+ * plat_fdt_relocated() - Update platform's information about relocated dtb
+ *
+ * This function provides a platform-independent API to set platform's
+ * information about relocated DTB if it needs to be moved due to kernel
+ * relocation occurring at boot.
+ */
+void plat_fdt_relocated(void *new_location);
+
+#endif /* CONFIG_RELOCATABLE */
 #endif /* CONFIG_USE_OF */
 
 #endif /* _ASM_BOOTINFO_H */
-- 
2.7.4
