Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jan 2011 12:21:20 +0100 (CET)
Received: from hall.aurel32.net ([88.191.126.93]:41210 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490992Ab1ARLUw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Jan 2011 12:20:52 +0100
Received: from [2001:470:d4ed:0:5e26:aff:fe2b:6f5b] (helo=volta.aurel32.net)
        by hall.aurel32.net with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.69)
        (envelope-from <aurelien@aurel32.net>)
        id 1Pf9cJ-0000Lh-Au; Tue, 18 Jan 2011 12:20:51 +0100
Received: from aurel32 by volta.aurel32.net with local (Exim 4.72)
        (envelope-from <aurelien@aurel32.net>)
        id 1Pf9cJ-0004Oe-Mn; Tue, 18 Jan 2011 12:20:51 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH 1/2] MIPS: add CONFIG_VIRTUALIZATION for virtio support
Date:   Tue, 18 Jan 2011 12:20:44 +0100
Message-Id: <1295349645-16805-1-git-send-email-aurelien@aurel32.net>
X-Mailer: git-send-email 1.7.2.3
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28968
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

Add CONFIG_VIRTUALIZATION to the MIPS architecture and include the
the virtio code there. Used to enable the virtio drivers under QEMU.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/mips/Kconfig |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f489ec3..f9d6a83 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2400,4 +2400,20 @@ source "security/Kconfig"
 
 source "crypto/Kconfig"
 
+menuconfig VIRTUALIZATION
+	bool "Virtualization"
+	default n
+	---help---
+	  Say Y here to get to see options for using your Linux host to run other
+	  operating systems inside virtual machines (guests).
+	  This option alone does not add any kernel code.
+
+	  If you say N, all options in this submenu will be skipped and disabled.
+
+if VIRTUALIZATION
+
+source drivers/virtio/Kconfig
+
+endif # VIRTUALIZATION
+
 source "lib/Kconfig"
-- 
1.7.2.3
