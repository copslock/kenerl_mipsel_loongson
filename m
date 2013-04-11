Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Apr 2013 19:25:02 +0200 (CEST)
Received: from 84-245-11-97.dsl.cambrium.nl ([84.245.11.97]:55573 "EHLO
        grubby.stderr.nl" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S6822682Ab3DKRY6Cb87M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Apr 2013 19:24:58 +0200
Received: from matthijs by grubby.stderr.nl with local (Exim 4.80)
        (envelope-from <matthijs@stdin.nl>)
        id 1UQLF3-0001pD-0A; Thu, 11 Apr 2013 19:24:57 +0200
From:   Matthijs Kooijman <matthijs@stdin.nl>
To:     John Crispin <blogic@openwrt.org>
Cc:     linux-mips@linux-mips.org, Matthijs Kooijman <matthijs@stdin.nl>
Subject: [PATCH 2/2] MIPS: ralink: setup dma_mask for the rt305x dwc2 usb controller
Date:   Thu, 11 Apr 2013 19:24:50 +0200
Message-Id: <1365701090-6916-2-git-send-email-matthijs@stdin.nl>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1365701090-6916-1-git-send-email-matthijs@stdin.nl>
References: <1365701090-6916-1-git-send-email-matthijs@stdin.nl>
Return-Path: <matthijs@stdin.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matthijs@stdin.nl
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

---
 arch/mips/ralink/rt305x-usb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/ralink/rt305x-usb.c b/arch/mips/ralink/rt305x-usb.c
index 793fc82..7d87740 100644
--- a/arch/mips/ralink/rt305x-usb.c
+++ b/arch/mips/ralink/rt305x-usb.c
@@ -108,6 +108,7 @@ error_out:
 
 static u64 rt3352_ohci_dmamask = DMA_BIT_MASK(32);
 static u64 rt3352_ehci_dmamask = DMA_BIT_MASK(32);
+static u64 rt3050_dwc2_dmamask = DMA_BIT_MASK(32);
 
 void ralink_usb_platform(void)
 {
@@ -117,4 +118,8 @@ void ralink_usb_platform(void)
 		ralink_add_usb("ehci-platform",
 				&rt3352_ehci_data, &rt3352_ehci_dmamask);
 	}
+	if (soc_is_rt305x() || soc_is_rt3350()) {
+		ralink_add_usb("ralink,rt3050-otg",
+				NULL, &rt3050_dwc2_dmamask);
+	}
 }
-- 
1.8.0
