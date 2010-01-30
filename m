Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2010 18:37:40 +0100 (CET)
Received: from sakura.staff.proxad.net ([213.228.1.107]:53016 "EHLO
        sakura.staff.proxad.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493005Ab0A3RfO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jan 2010 18:35:14 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
        id 7ED59551082; Sat, 30 Jan 2010 18:35:14 +0100 (CET)
From:   Maxime Bizon <mbizon@freebox.fr>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 6/7] MIPS: bcm63xx: call board_register_device from device_initcall()
Date:   Sat, 30 Jan 2010 18:34:57 +0100
Message-Id: <1264872898-28149-7-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1264872898-28149-1-git-send-email-mbizon@freebox.fr>
References: <1264872898-28149-1-git-send-email-mbizon@freebox.fr>
X-archive-position: 25763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19474

Some device registration (eg leds), expect subsystem initcall to be
run first, so move board device registration to device_initcall().

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 arch/mips/bcm63xx/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/bcm63xx/setup.c b/arch/mips/bcm63xx/setup.c
index d005659..04a3499 100644
--- a/arch/mips/bcm63xx/setup.c
+++ b/arch/mips/bcm63xx/setup.c
@@ -124,4 +124,4 @@ int __init bcm63xx_register_devices(void)
 	return board_register_devices();
 }
 
-arch_initcall(bcm63xx_register_devices);
+device_initcall(bcm63xx_register_devices);
-- 
1.6.3.3
