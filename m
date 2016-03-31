Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Mar 2016 11:08:51 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32378 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025646AbcCaJGX020Zq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Mar 2016 11:06:23 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id A9F00D1E670AD;
        Thu, 31 Mar 2016 10:06:15 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 31 Mar 2016 10:06:17 +0100
Received: from mredfearn-linux.kl.imgtec.org (192.168.154.116) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 31 Mar 2016 10:06:16 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <kernel-hardening@lists.openwall.com>,
        "Matt Redfearn" <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        "Paul Burton" <paul.burton@imgtec.com>
Subject: [PATCH v2 09/11] MIPS: Introduce plat_get_fdt a platform API to retrieve the FDT
Date:   Thu, 31 Mar 2016 10:05:40 +0100
Message-ID: <1459415142-3412-10-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1459415142-3412-1-git-send-email-matt.redfearn@imgtec.com>
References: <1459415142-3412-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52816
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Early access to the kernel command line requires early access to the FDT
for platforms which pass the command line within the device tree. There
was no common way to retrieve the location of the FDT without incurring
side effects, such as plat_mem_setup which, on Malta at least,
initializes a bunch of other stuff.

This patch adds plat_get_ftd() for IMG platforms.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

Changes in v2: None

 arch/mips/include/asm/bootinfo.h  | 18 ++++++++++++++++++
 arch/mips/mti-malta/malta-setup.c |  7 ++++++-
 arch/mips/mti-sead3/sead3-setup.c |  5 +++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index b603804caac5..9f67033961a6 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -144,4 +144,22 @@ static inline void plat_swiotlb_setup(void) {}
 
 #endif /* CONFIG_SWIOTLB */
 
+#ifdef CONFIG_USE_OF
+/**
+ * plat_get_fdt() - Return a pointer to the platform's device tree blob
+ *
+ * This function provides a platform independent API to get a pointer to the
+ * flattened device tree blob. The interface between bootloader and kernel
+ * is not consistent across platforms so it is necessary to provide this
+ * API such that common startup code can locate the FDT.
+ *
+ * This is used by the KASLR code to get command line arguments and random
+ * seed from the device tree. Any platform wishing to use KASLR should
+ * provide this API and select SYS_SUPPORTS_RELOCATABLE.
+ *
+ * Return: Pointer to the flattened device tree blob.
+ */
+extern void *plat_get_fdt(void);
+#endif /* CONFIG_USE_OF */
+
 #endif /* _ASM_BOOTINFO_H */
diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index 4740c82fb97a..33d5ff5069e5 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -248,10 +248,15 @@ static void __init bonito_quirks_setup(void)
 #endif
 }
 
+void __init *plat_get_fdt(void)
+{
+	return (void *)__dtb_start;
+}
+
 void __init plat_mem_setup(void)
 {
 	unsigned int i;
-	void *fdt = __dtb_start;
+	void *fdt = plat_get_fdt();
 
 	fdt = malta_dt_shim(fdt);
 	__dt_setup_arch(fdt);
diff --git a/arch/mips/mti-sead3/sead3-setup.c b/arch/mips/mti-sead3/sead3-setup.c
index e43f4801a245..9f2f9b2b23ce 100644
--- a/arch/mips/mti-sead3/sead3-setup.c
+++ b/arch/mips/mti-sead3/sead3-setup.c
@@ -83,6 +83,11 @@ static void __init parse_memsize_param(void)
 	}
 }
 
+void __init *plat_get_fdt(void)
+{
+	return (void *)__dtb_start;
+}
+
 void __init plat_mem_setup(void)
 {
 	/* allow command line/bootloader env to override memory size in DT */
-- 
2.5.0
