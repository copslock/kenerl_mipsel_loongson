Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Mar 2016 11:08:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62136 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025516AbcCaJGWYL3Dq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Mar 2016 11:06:22 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 337812C69E186;
        Thu, 31 Mar 2016 10:06:14 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 31 Mar 2016 10:06:16 +0100
Received: from mredfearn-linux.kl.imgtec.org (192.168.154.116) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 31 Mar 2016 10:06:16 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <kernel-hardening@lists.openwall.com>,
        "Matt Redfearn" <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 08/11] MIPS: Add CONFIG_RELOCATABLE Kconfig option
Date:   Thu, 31 Mar 2016 10:05:39 +0100
Message-ID: <1459415142-3412-9-git-send-email-matt.redfearn@imgtec.com>
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
X-archive-position: 52815
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

Add option to KConfig to enable the kernel to relocate itself at
runtime.

Relocation is supported R2 and later of the MIPS architecture, 32bit
and 64bit. The platform is also required to provide support through
plat_get_fdt() added in a later patch.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

Changes in v2: None

 arch/mips/Kconfig | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 6f55e1a5d645..4bf1814e57a5 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -473,6 +473,7 @@ config MIPS_MALTA
 	select SYS_SUPPORTS_MULTITHREADING
 	select SYS_SUPPORTS_SMARTMIPS
 	select SYS_SUPPORTS_ZBOOT
+	select SYS_SUPPORTS_RELOCATABLE
 	select USE_OF
 	select ZONE_DMA32 if 64BIT
 	select BUILTIN_DTB
@@ -516,6 +517,7 @@ config MIPS_SEAD3
 	select SYS_SUPPORTS_SMARTMIPS
 	select SYS_SUPPORTS_MICROMIPS
 	select SYS_SUPPORTS_MIPS16
+	select SYS_SUPPORTS_RELOCATABLE
 	select USB_EHCI_BIG_ENDIAN_DESC
 	select USB_EHCI_BIG_ENDIAN_MMIO
 	select USE_OF
@@ -1156,6 +1158,13 @@ config ISA_DMA_API
 config HOLES_IN_ZONE
 	bool
 
+config SYS_SUPPORTS_RELOCATABLE
+	bool
+	help
+	 Selected if the platform supports relocating the kernel.
+	 The platform must provide plat_get_fdt() if it selects CONFIG_USE_OF
+	 to allow access to command line and entropy sources.
+
 #
 # Endianness selection.  Sufficiently obscure so many users don't know what to
 # answer,so we try hard to limit the available choices.  Also the use of a
@@ -2478,6 +2487,15 @@ config NUMA
 config SYS_SUPPORTS_NUMA
 	bool
 
+config RELOCATABLE
+	bool "Relocatable kernel"
+	depends on SYS_SUPPORTS_RELOCATABLE && (CPU_MIPS32_R2 || CPU_MIPS64_R2 || CPU_MIPS32_R6 || CPU_MIPS64_R6)
+	help
+	  This builds a kernel image that retains relocation information
+	  so it can be loaded someplace besides the default 1MB.
+	  The relocations make the kernel binary about 15% larger,
+	  but are discarded at runtime
+
 config RELOCATION_TABLE_SIZE
 	hex "Relocation table size"
 	depends on RELOCATABLE
-- 
2.5.0
