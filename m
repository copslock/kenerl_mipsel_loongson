Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2017 07:16:40 +0100 (CET)
Received: from woodpecker.gentoo.org ([IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4]:37281
        "EHLO smtp.gentoo.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992240AbdBGGORTyv0r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Feb 2017 07:14:17 +0100
Received: from helcaraxe.arda (c-73-201-78-97.hsd1.md.comcast.net [73.201.78.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kumba)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 9118B3416A6;
        Tue,  7 Feb 2017 06:14:08 +0000 (UTC)
From:   Joshua Kinard <kumba@gentoo.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>
Subject: [PATCH 07/12] MIPS: BRIDGE: Add XBRIDGE revs and SWAP bit
Date:   Tue,  7 Feb 2017 01:13:51 -0500
Message-Id: <20170207061356.8270-8-kumba@gentoo.org>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170207061356.8270-1-kumba@gentoo.org>
References: <20170207061356.8270-1-kumba@gentoo.org>
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

From: Joshua Kinard <kumba@gentoo.org>

Add macros for the two known XBRIDGE revisions commonly found on IP35
hardware.  Both macros are sourced from the IA64 copy of bridge.h from
Linux-2.4.18.  Additionally, per the XBRIDGE ASIC specification, bit 55
of the Crosstalk address selects whether to use byte-swapping or not on
the XBRIDGE.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/include/asm/pci/bridge.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/include/asm/pci/bridge.h b/arch/mips/include/asm/pci/bridge.h
index 3c214feab772..f173875b4233 100644
--- a/arch/mips/include/asm/pci/bridge.h
+++ b/arch/mips/include/asm/pci/bridge.h
@@ -484,6 +484,8 @@ struct bridge_widget {
 #define BRIDGE_REV_B			0x2
 #define BRIDGE_REV_C			0x3
 #define BRIDGE_REV_D			0x4
+#define XBRIDGE_REV_A			0x1
+#define XBRIDGE_REV_B			0x2
 
 /* Bridge widget status register bits definition */
 #define BRIDGE_STAT_LLP_REC_CNT		GENMASK(31, 24)
@@ -937,6 +939,7 @@ struct bridge_err_cmdword_s {
 #define PCI64_ATTR_PREC		BIT_ULL(58)	/* Precise */
 #define PCI64_ATTR_VIRTUAL	BIT_ULL(57)	/* Virtual Request */
 #define PCI64_ATTR_BAR		BIT_ULL(56)	/* Barrier */
+#define PCI64_ATTR_SWAP		BIT_ULL(55)	/* Byte swap (XBRIDGE) */
 #define PCI64_ATTR_RMF_MASK	GENMASK_ULL(55, 48)
 #define PCI64_ATTR_RMF_SHFT	48
 
-- 
2.11.1
