Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2017 19:55:52 +0200 (CEST)
Received: from lpdvrndsmtp01.broadcom.com ([192.19.229.170]:60520 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994780AbdEXRzpUyNNg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 May 2017 19:55:45 +0200
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 531E430C052;
        Wed, 24 May 2017 10:55:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 531E430C052
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1495648538;
        bh=PCLWR/1mwMyhhu8aAXewQkcVrTpBeyUSpRYYMwtBjrU=;
        h=From:To:Cc:Subject:Date:From;
        b=divWmhje68xu8nh3p2+pWLWVH+/GBjNub0G3InvxS3sS2i95WMYofF3uO2043fZhz
         Y/LjSmAuc5Z3hGTr0ux/hS6ejqy/BO0omRN3ZsNUhhy/nbVfrqidTW1naO2tDid7T0
         O007ev72ra4KVU7mmKLL8886V+TFw3tMwkk6e5ng=
Received: from stb-bld-02.irv.broadcom.com (stb-bld-02.broadcom.com [10.13.134.28])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 2D72F81F1B;
        Wed, 24 May 2017 10:55:38 -0700 (PDT)
From:   justinpopo6@gmail.com
To:     linux-mips@linux-mips.org
Cc:     bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        Justin Chen <justin.chen@broadcom.com>,
        Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH 1/1] BMIPS: Enable HARDIRQS_SW_RESEND
Date:   Wed, 24 May 2017 10:55:16 -0700
Message-Id: <20170524175516.13849-1-justinpopo6@gmail.com>
X-Mailer: git-send-email 2.12.2
Return-Path: <justinpopo6@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: justinpopo6@gmail.com
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

From: Justin Chen <justin.chen@broadcom.com>

HW interrupts triggered when irq_disable() were being ignored. Enable
resending HW interrupts as SW interrupts.

This was causing an issue where the interrupts waking the system up from
a suspend state were not calling their interrupt handlers.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2828ecde133d..349f9bdb655b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -230,6 +230,7 @@ config BMIPS_GENERIC
 	select USB_EHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
 	select USB_OHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
 	select USB_OHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
+	select HARDIRQS_SW_RESEND
 	help
 	  Build a generic DT-based kernel image that boots on select
 	  BCM33xx cable modem chips, BCM63xx DSL chips, and BCM7xxx set-top
-- 
2.12.2
