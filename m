Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2011 19:13:16 +0100 (CET)
Received: from smtp4-g21.free.fr ([212.27.42.4]:52239 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904138Ab1KDSMJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Nov 2011 19:12:09 +0100
Received: from sakura.staff.proxad.net (unknown [213.36.7.13])
        by smtp4-g21.free.fr (Postfix) with ESMTP id B44824C822E;
        Fri,  4 Nov 2011 19:11:59 +0100 (CET)
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
        id A37FF552F0B; Fri,  4 Nov 2011 19:11:58 +0100 (CET)
From:   Maxime Bizon <mbizon@freebox.fr>
To:     ralf@linux-mips.org
Cc:     Maxime Bizon <mbizon@freebox.fr>, linux-mips@linux-mips.org
Subject: [PATCH v2 03/11] MIPS: BCM63XX: call board_register_device from device_initcall()
Date:   Fri,  4 Nov 2011 19:09:27 +0100
Message-Id: <1320430175-13725-4-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1320430175-13725-1-git-send-email-mbizon@freebox.fr>
References: <1320430175-13725-1-git-send-email-mbizon@freebox.fr>
To:     ralf@linux-mips.org
X-archive-position: 31393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

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
1.7.1.1
