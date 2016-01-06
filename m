Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jan 2016 19:52:26 +0100 (CET)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35760 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010073AbcAFSwYiSeoQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jan 2016 19:52:24 +0100
Received: by mail-pf0-f193.google.com with SMTP id e65so22824116pfe.2;
        Wed, 06 Jan 2016 10:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=x3hTt3SCeH47vo/TIxVVCEuVj7DX56fn1NnHV2lh6rc=;
        b=f2AqAayD9l6JV1iwid4yMsTxvM5koUQ6szphHlNqBJJdwCCkgMdWoUOzULjHJNVtjp
         ywMDLGxBgSZTX1F1wmxnNU2KeDWdIj4TkV/S1VQRRHl36MSbpkWHYaZ+5bZxV9uWpNKS
         9UqmXdFFDuWMWYBoOOuS+o1hgsZ7o0GZRKiXU349k3YPNefJN2rbdvVCMoA6B2XZfpaz
         cDuhjIX8Dt7SEnLyCfS4YEn+UgZsEddjWfyi2cNzDlo8i95j9xQXXNhq0ePnatLpcSX/
         iMjVEcGlFqyb3oPJdPp80LwcVUH8rpfqnpgsocmoqskQCqpcZXaS2usAaCmjh5UWehDm
         SvoA==
X-Received: by 10.98.11.209 with SMTP id 78mr118094532pfl.64.1452106338319;
        Wed, 06 Jan 2016 10:52:18 -0800 (PST)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id b88sm117100393pfj.11.2016.01.06.10.52.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Jan 2016 10:52:17 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, cernekee@gmail.com,
        dragan.stancevic@gmail.com, jaedon.shin@gmail.com,
        gregory.0xf0@gmail.com, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] MIPS: BMIPS: Enable ARCH_WANT_OPTIONAL_GPIOLIB
Date:   Wed,  6 Jan 2016 10:51:05 -0800
Message-Id: <1452106265-11384-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Allow BMIPS_GENERIC supported platforms to build GPIO controller
drivers.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 71683a853372..77dd3c0f10f8 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -170,6 +170,7 @@ config BMIPS_GENERIC
 	select USB_EHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
 	select USB_OHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
 	select USB_OHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	help
 	  Build a generic DT-based kernel image that boots on select
 	  BCM33xx cable modem chips, BCM63xx DSL chips, and BCM7xxx set-top
-- 
2.1.0
