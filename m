Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Feb 2018 14:13:00 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:60526 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994760AbeBUNMkX0ypT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Feb 2018 14:12:40 +0100
Received: from localhost (LFbn-1-12258-90.w90-92.abo.wanadoo.fr [90.92.71.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C05A01078;
        Wed, 21 Feb 2018 13:12:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>, linux-usb@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH 4.15 152/163] usb: Move USB_UHCI_BIG_ENDIAN_* out of USB_SUPPORT
Date:   Wed, 21 Feb 2018 13:49:41 +0100
Message-Id: <20180221124538.399406513@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <jhogan@kernel.org>

commit ec897569ad7dbc6d595873a487c3fac23f463f76 upstream.

Move the Kconfig symbols USB_UHCI_BIG_ENDIAN_MMIO and
USB_UHCI_BIG_ENDIAN_DESC out of drivers/usb/host/Kconfig, which is
conditional upon USB && USB_SUPPORT, so that it can be freely selected
by platform Kconfig symbols in architecture code.

For example once the MIPS_GENERIC platform selects are fixed in commit
2e6522c56552 ("MIPS: Fix typo BIG_ENDIAN to CPU_BIG_ENDIAN"), the MIPS
32r6_defconfig warns like so:

warning: (MIPS_GENERIC) selects USB_UHCI_BIG_ENDIAN_MMIO which has unmet direct dependencies (USB_SUPPORT && USB)
warning: (MIPS_GENERIC) selects USB_UHCI_BIG_ENDIAN_DESC which has unmet direct dependencies (USB_SUPPORT && USB)

Fixes: 2e6522c56552 ("MIPS: Fix typo BIG_ENDIAN to CPU_BIG_ENDIAN")
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: linux-usb@vger.kernel.org
Cc: linux-mips@linux-mips.org
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Patchwork: https://patchwork.linux-mips.org/patch/18559/
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/Kconfig      |    8 ++++++++
 drivers/usb/host/Kconfig |    8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

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
