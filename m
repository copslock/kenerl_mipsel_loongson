Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Jan 2018 23:25:47 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:53500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994777AbeAaWZk7NtpC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 31 Jan 2018 23:25:40 +0100
Received: from localhost.localdomain (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D84621798;
        Wed, 31 Jan 2018 22:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D84621798
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From:   James Hogan <jhogan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-mips@linux-mips.org, Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH 1/2] usb: Move USB_UHCI_BIG_ENDIAN_* out of USB_SUPPORT
Date:   Wed, 31 Jan 2018 22:24:45 +0000
Message-Id: <05aec8b194d01871c2e9f62ce38d68b56dff59ca.1517437177.git-series.jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.a68aa8a51a9733579dc929dcc4367a56b22f0c75.1517437177.git-series.jhogan@kernel.org>
References: <cover.a68aa8a51a9733579dc929dcc4367a56b22f0c75.1517437177.git-series.jhogan@kernel.org>
In-Reply-To: <cover.a68aa8a51a9733579dc929dcc4367a56b22f0c75.1517437177.git-series.jhogan@kernel.org>
References: <cover.a68aa8a51a9733579dc929dcc4367a56b22f0c75.1517437177.git-series.jhogan@kernel.org>
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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

Move the Kconfig symbols USB_UHCI_BIG_ENDIAN_MMIO and
USB_UHCI_BIG_ENDIAN_DESC out of drivers/usb/host/Kconfig, which is
conditional upon USB && USB_SUPPORT, so that it can be freely selected
by platform Kconfig symbols in architecture code.

For example once the MIPS_GENERIC platform selects are fixed in the
patch "MIPS: Fix typo BIG_ENDIAN to CPU_BIG_ENDIAN", the MIPS
32r6_defconfig warns like so:

warning: (MIPS_GENERIC) selects USB_UHCI_BIG_ENDIAN_MMIO which has unmet direct dependencies (USB_SUPPORT && USB)
warning: (MIPS_GENERIC) selects USB_UHCI_BIG_ENDIAN_DESC which has unmet direct dependencies (USB_SUPPORT && USB)

Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: linux-usb@vger.kernel.org
---
 drivers/usb/Kconfig      | 8 ++++++++
 drivers/usb/host/Kconfig | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index f699abab1787..65812a2f60b4 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -19,6 +19,14 @@ config USB_EHCI_BIG_ENDIAN_MMIO
 config USB_EHCI_BIG_ENDIAN_DESC
 	bool
 
+config USB_UHCI_BIG_ENDIAN_MMIO
+	bool
+	default y if SPARC_LEON
+
+config USB_UHCI_BIG_ENDIAN_DESC
+	bool
+	default y if SPARC_LEON
+
 menuconfig USB_SUPPORT
 	bool "USB support"
 	depends on HAS_IOMEM
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index b80a94e632af..2763a640359f 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -625,14 +625,6 @@ config USB_UHCI_ASPEED
        bool
        default y if ARCH_ASPEED
 
-config USB_UHCI_BIG_ENDIAN_MMIO
-	bool
-	default y if SPARC_LEON
-
-config USB_UHCI_BIG_ENDIAN_DESC
-	bool
-	default y if SPARC_LEON
-
 config USB_FHCI_HCD
 	tristate "Freescale QE USB Host Controller support"
 	depends on OF_GPIO && QE_GPIO && QUICC_ENGINE
-- 
git-series 0.9.1
