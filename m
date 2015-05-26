Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2015 12:54:14 +0200 (CEST)
Received: from albert.telenet-ops.be ([195.130.137.90]:44573 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007089AbbEZKyNGKAOP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 May 2015 12:54:13 +0200
Received: from ayla.of.borg ([84.193.93.87])
        by albert.telenet-ops.be with bizsmtp
        id YauE1q0091t5w8s06auEA4; Tue, 26 May 2015 12:54:14 +0200
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.82)
        (envelope-from <geert@linux-m68k.org>)
        id 1YxCUv-0008L6-Vy; Tue, 26 May 2015 12:54:14 +0200
Received: from geert by ramsan with local (Exim 4.82)
        (envelope-from <geert@linux-m68k.org>)
        id 1YxCV1-0002DD-Pl; Tue, 26 May 2015 12:54:19 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-mips@linux-mips.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] MIPS: Fuloong 2E: Replace CONFIG_USB_ISP1760_HCD by CONFIG_USB_ISP1760
Date:   Tue, 26 May 2015 12:54:18 +0200
Message-Id: <1432637658-8470-1-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 1.9.1
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert+renesas@glider.be
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

Since commit 100832abf065bc18 ("usb: isp1760: Make HCD support
optional"), CONFIG_USB_ISP1760_HCD is automatically selected when
needed.  Enabling that option in the defconfig is now a no-op, and no
longer enables ISP1760 HCD support.

Re-enable the ISP1760 driver in the defconfig by enabling
USB_ISP1760_HOST_ROLE instead.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/mips/configs/fuloong2e_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/configs/fuloong2e_defconfig b/arch/mips/configs/fuloong2e_defconfig
index 002680648dcb2230..b2a577ebce0b08f7 100644
--- a/arch/mips/configs/fuloong2e_defconfig
+++ b/arch/mips/configs/fuloong2e_defconfig
@@ -194,7 +194,7 @@ CONFIG_USB_WUSB_CBAF=m
 CONFIG_USB_C67X00_HCD=m
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
-CONFIG_USB_ISP1760_HCD=m
+CONFIG_USB_ISP1760=m
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_UHCI_HCD=m
 CONFIG_USB_R8A66597_HCD=m
-- 
1.9.1
