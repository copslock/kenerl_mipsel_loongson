Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2010 21:37:11 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13391 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491047Ab0JNThH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Oct 2010 21:37:07 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cb75bfe0000>; Thu, 14 Oct 2010 12:37:34 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 14 Oct 2010 12:37:14 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 14 Oct 2010 12:37:14 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o9EJaraO016478;
        Thu, 14 Oct 2010 12:36:53 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o9EJao4X016477;
        Thu, 14 Oct 2010 12:36:50 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Implement __read_mostly
Date:   Thu, 14 Oct 2010 12:36:49 -0700
Message-Id: <1287085009-16445-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 14 Oct 2010 19:37:14.0133 (UTC) FILETIME=[33CBDC50:01CB6BD7]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Just do what everyone else is doing by placing __read_mostly things in
the .data.read_mostly section.

mips_io_port_base can not be read-only (const) and writable
(__read_mostly) at the same time.  One of them has to go, so I chose
to eliminate the __read_mostly.  It will still get stuck in a portion
of memory that is not adjacent to things that are written, and thus
not be on a dirty cache line, for whatever that is worth.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/cache.h |    2 ++
 arch/mips/kernel/setup.c      |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/cache.h b/arch/mips/include/asm/cache.h
index 37f175c..650ac9b 100644
--- a/arch/mips/include/asm/cache.h
+++ b/arch/mips/include/asm/cache.h
@@ -17,4 +17,6 @@
 #define SMP_CACHE_SHIFT		L1_CACHE_SHIFT
 #define SMP_CACHE_BYTES		L1_CACHE_BYTES
 
+#define __read_mostly __attribute__((__section__(".data.read_mostly")))
+
 #endif /* _ASM_CACHE_H */
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 4e68a51..6d0c3be 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -69,7 +69,7 @@ static char __initdata builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
  * mips_io_port_base is the begin of the address space to which x86 style
  * I/O ports are mapped.
  */
-const unsigned long mips_io_port_base __read_mostly = -1;
+const unsigned long mips_io_port_base = -1;
 EXPORT_SYMBOL(mips_io_port_base);
 
 static struct resource code_resource = { .name = "Kernel code", };
-- 
1.7.2.3
