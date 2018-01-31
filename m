Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Jan 2018 23:26:11 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:53522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994802AbeAaWZlUaOTC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 31 Jan 2018 23:25:41 +0100
Received: from localhost.localdomain (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D43521796;
        Wed, 31 Jan 2018 22:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D43521796
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From:   James Hogan <jhogan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-mips@linux-mips.org, Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 2/2] sparc,leon: Select USB_UHCI_BIG_ENDIAN_{MMIO,DESC}
Date:   Wed, 31 Jan 2018 22:24:46 +0000
Message-Id: <fb8ebffece031b246324cef5ad3afd75cf3795dd.1517437177.git-series.jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.a68aa8a51a9733579dc929dcc4367a56b22f0c75.1517437177.git-series.jhogan@kernel.org>
References: <cover.a68aa8a51a9733579dc929dcc4367a56b22f0c75.1517437177.git-series.jhogan@kernel.org>
In-Reply-To: <cover.a68aa8a51a9733579dc929dcc4367a56b22f0c75.1517437177.git-series.jhogan@kernel.org>
References: <cover.a68aa8a51a9733579dc929dcc4367a56b22f0c75.1517437177.git-series.jhogan@kernel.org>
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62384
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

Now that USB_UHCI_BIG_ENDIAN_MMIO and USB_UHCI_BIG_ENDIAN_DESC are moved
outside of the USB_SUPPORT conditional, simply select them from
SPARC_LEON rather than by the symbol's defaults in drivers/usb/Kconfig,
similar to how it is done for USB_EHCI_BIG_ENDIAN_MMIO and
USB_EHCI_BIG_ENDIAN_DESC.

Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: sparclinux@vger.kernel.org
Cc: linux-usb@vger.kernel.org
---
 arch/sparc/Kconfig  | 2 ++
 drivers/usb/Kconfig | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 6bf594ace663..8767e45f1b2b 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -430,6 +430,8 @@ config SPARC_LEON
 	depends on SPARC32
 	select USB_EHCI_BIG_ENDIAN_MMIO
 	select USB_EHCI_BIG_ENDIAN_DESC
+	select USB_UHCI_BIG_ENDIAN_MMIO
+	select USB_UHCI_BIG_ENDIAN_DESC
 	---help---
 	  If you say Y here if you are running on a SPARC-LEON processor.
 	  The LEON processor is a synthesizable VHDL model of the
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 65812a2f60b4..148f3ee70286 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -21,11 +21,9 @@ config USB_EHCI_BIG_ENDIAN_DESC
 
 config USB_UHCI_BIG_ENDIAN_MMIO
 	bool
-	default y if SPARC_LEON
 
 config USB_UHCI_BIG_ENDIAN_DESC
 	bool
-	default y if SPARC_LEON
 
 menuconfig USB_SUPPORT
 	bool "USB support"
-- 
git-series 0.9.1
