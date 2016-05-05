Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 May 2016 23:33:56 +0200 (CEST)
Received: from hall.aurel32.net ([195.154.112.97]:59064 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27028079AbcEEVdzRsuQ5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 May 2016 23:33:55 +0200
Received: from [2001:bc8:30d7:120:daeb:97ff:feb6:3f19] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <aurelien@aurel32.net>)
        id 1ayQu8-0003tN-Ry; Thu, 05 May 2016 23:33:52 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.87)
        (envelope-from <aurelien@aurel32.net>)
        id 1ayQu7-0007oR-Vx; Thu, 05 May 2016 23:33:51 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-mips@linux-mips.org
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Octeon: byteswap initramfs in little endian mode
Date:   Thu,  5 May 2016 23:33:37 +0200
Message-Id: <1462484017-29988-1-git-send-email-aurelien@aurel32.net>
X-Mailer: git-send-email 2.8.1
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53284
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
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

The initramfs if loaded in memory by U-Boot running in big endian mode.
When the kernel is running in little endian mode, we need to byteswap it
as it is accessed byte by byte.

Cc: David Daney <david.daney@cavium.com>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/mips/kernel/setup.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

Note: It might not be the best place to byteswap the initramfs not the
best way to do it. At least it shows the problem and what shoudl be done.
Suggestions to improve the patch are welcome.

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 4f60734..e7d015e 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -263,6 +263,16 @@ static void __init finalize_initrd(void)
 		goto disable;
 	}
 
+#if defined(CONFIG_CPU_CAVIUM_OCTEON) && defined(CONFIG_CPU_LITTLE_ENDIAN)
+	{
+		unsigned long i;
+		pr_info("Cavium Octeon kernel in little endian mode "
+			"detected, byteswapping ramdisk\n");
+		for (i = initrd_start; i < ALIGN(initrd_end, 8); i += 8)
+			*((unsigned long *)i) = swab64(*((unsigned long *)i));
+	}
+#endif
+
 	reserve_bootmem(__pa(initrd_start), size, BOOTMEM_DEFAULT);
 	initrd_below_start_ok = 1;
 
-- 
2.8.1
