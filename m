Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Feb 2017 21:21:40 +0100 (CET)
Received: from smtp3-g21.free.fr ([IPv6:2a01:e0c:1:1599::12]:18577 "EHLO
        smtp3-g21.free.fr" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991532AbdBEUVd23HtB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 5 Feb 2017 21:21:33 +0100
Received: from localhost.localdomain (unknown [78.50.169.77])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id BE4E413F88A;
        Sun,  5 Feb 2017 21:21:22 +0100 (CET)
From:   Alban <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Alban Bedel <albeu@free.fr>, Ralf Baechle <ralf@linux-mips.org>,
        Jonas Gorski <jogo@openwrt.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Allow compressed images to be loaded at the usual address
Date:   Sun,  5 Feb 2017 21:21:15 +0100
Message-Id: <1486326077-17091-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.7.4
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

From: Alban Bedel <albeu@free.fr>

Normally compressed images have to be loaded at a different address to
allow the decompressor to run. This add an option to let vmlinuz copy
itself to the correct address from the normal vmlinux address.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/Kconfig                |  8 ++++++++
 arch/mips/boot/compressed/head.S | 13 +++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b3c5bde..8074fc5 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2961,6 +2961,14 @@ choice
 		bool "Extend builtin kernel arguments with bootloader arguments"
 endchoice
 
+config ZBOOT_VMLINUZ_AT_VMLINUX_LOAD_ADDRESS
+	bool "Load compressed images at the same address as uncompressed"
+	depends on SYS_SUPPORTS_ZBOOT
+	help
+	  vmlinux and vmlinuz normally have different load addresses, with
+	  this option vmlinuz expect to be loaded at the same address as
+	  vmlinux.
+
 endmenu
 
 config LOCKDEP_SUPPORT
diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed/head.S
index 409cb48..a215171 100644
--- a/arch/mips/boot/compressed/head.S
+++ b/arch/mips/boot/compressed/head.S
@@ -25,6 +25,19 @@ start:
 	move	s2, a2
 	move	s3, a3
 
+#ifdef CONFIG_ZBOOT_VMLINUZ_AT_VMLINUX_LOAD_ADDRESS
+	/* Move the text, data section and DTB to the correct address */
+	PTR_LA	a0, .text
+	PTR_LI	a1, VMLINUX_LOAD_ADDRESS
+	PTR_LA	a2, _edata
+0:
+	lw	a3, 0(a1)
+	sw	a3, 0(a0)
+	addiu	a1, a1, 4
+	bne	a2, a0, 0b
+	 addiu	a0, a0, 4
+#endif
+
 	/* Clear BSS */
 	PTR_LA	a0, _edata
 	PTR_LA	a2, _end
-- 
2.7.4
