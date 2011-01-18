Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jan 2011 12:20:56 +0100 (CET)
Received: from hall.aurel32.net ([88.191.126.93]:41211 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490997Ab1ARLUw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Jan 2011 12:20:52 +0100
Received: from [2001:470:d4ed:0:5e26:aff:fe2b:6f5b] (helo=volta.aurel32.net)
        by hall.aurel32.net with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.69)
        (envelope-from <aurelien@aurel32.net>)
        id 1Pf9cJ-0000Li-FL; Tue, 18 Jan 2011 12:20:51 +0100
Received: from aurel32 by volta.aurel32.net with local (Exim 4.72)
        (envelope-from <aurelien@aurel32.net>)
        id 1Pf9cJ-0004Oh-VM; Tue, 18 Jan 2011 12:20:52 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH 2/2] MIPS: Malta: enable Cirrus FB console
Date:   Tue, 18 Jan 2011 12:20:45 +0100
Message-Id: <1295349645-16805-2-git-send-email-aurelien@aurel32.net>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1295349645-16805-1-git-send-email-aurelien@aurel32.net>
References: <1295349645-16805-1-git-send-email-aurelien@aurel32.net>
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

While most users of a physical Malta board are using the serial port
as the console, a lot of QEMU users would prefer to interact with a
graphical console. Enable the Cirrus FB support in the Malta default
configuration to make that possible. Note that the default console will
still be the serial port, users have to pass "console=tty0" to the
kernel to use the Cirrus FB.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/mips/configs/malta_defconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index b455d0f..9d03b68 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -369,7 +369,10 @@ CONFIG_VT_HW_CONSOLE_BINDING=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_HWMON is not set
+CONFIG_FB=y
+CONFIG_FB_CIRRUS=y
 # CONFIG_VGA_CONSOLE is not set
+CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_HID=m
 CONFIG_LEDS_CLASS=m
 CONFIG_LEDS_TRIGGER_TIMER=m
-- 
1.7.2.3
