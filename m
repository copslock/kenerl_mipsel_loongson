Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2012 12:17:42 +0200 (CEST)
Received: from zmc.proxad.net ([212.27.53.206]:39230 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816384Ab2JWKRjxMhiQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Oct 2012 12:17:39 +0200
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 85F802BFDE7;
        Tue, 23 Oct 2012 12:17:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HTn+59ZdkX6h; Tue, 23 Oct 2012 12:17:34 +0200 (CEST)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id EDBA12BDB9C;
        Tue, 23 Oct 2012 12:17:34 +0200 (CEST)
From:   Florian Fainelli <florian@openwrt.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-mips@linux-mips.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, manuel.lauss@gmail.com,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH] MIPS: Alchemy: update development boards defconfigs with USB platform drivers
Date:   Tue, 23 Oct 2012 12:16:08 +0200
Message-Id: <1350987368-13144-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 34749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Commit 2be350fa (MIPS: Alchemy: use the ehci platform driver) and commit
e223a4cc (MIPS: Alchemy: use the OHCI platform driver) have change the Alchemy
platform code to register an EHCI and OHCI platform driver, the defconfig file
must thus be accordingly updated to build these drivers by default.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/configs/db1235_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/configs/db1235_defconfig b/arch/mips/configs/db1235_defconfig
index c48998f..14752dd 100644
--- a/arch/mips/configs/db1235_defconfig
+++ b/arch/mips/configs/db1235_defconfig
@@ -346,8 +346,10 @@ CONFIG_USB=y
 CONFIG_USB_DYNAMIC_MINORS=y
 CONFIG_USB_SUSPEND=y
 CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_HCD_PLATFORM=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
 CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
 CONFIG_MMC_CLKGATE=y
-- 
1.7.9.5
