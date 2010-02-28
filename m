Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Feb 2010 16:37:05 +0100 (CET)
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:33638 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492278Ab0B1Pfs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Feb 2010 16:35:48 +0100
Received: id: bigeasy by Chamillionaire.breakpoint.cc authenticated by bigeasy with local
        (easymta 1.00 BETA 1)
        id 1NllBJ-0004M9-9F; Sun, 28 Feb 2010 16:35:45 +0100
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, "David S. Miller" <davem@davemloft.net>,
        linux-ide@vger.kernel.org,
        Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH 1/3] mips/ide: flush dcache also if icache does not snoop dcache
Date:   Sun, 28 Feb 2010 16:35:39 +0100
Message-Id: <1267371341-16684-2-git-send-email-sebastian@breakpoint.cc>
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <1267371341-16684-1-git-send-email-sebastian@breakpoint.cc>
References: <1267371341-16684-1-git-send-email-sebastian@breakpoint.cc>
Return-Path: <bigeasy@Chamillionaire.breakpoint.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sebastian@breakpoint.cc
Precedence: bulk
X-list: linux-mips

If this is not done then the new just read data which remains in dcache
will not make it into icache on time. Thus the CPU loads invalid data
and executes crap. The result is that the user is not able to execute
anything from its IDE based media while reading plain data is still
working well.
This problem has been reported as Debian #404951.

Cc: stable@kernel.org
Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 arch/mips/include/asm/mach-generic/ide.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/mach-generic/ide.h b/arch/mips/include/asm/mach-generic/ide.h
index 9c93a5b..e80e47f 100644
--- a/arch/mips/include/asm/mach-generic/ide.h
+++ b/arch/mips/include/asm/mach-generic/ide.h
@@ -23,7 +23,7 @@
 static inline void __ide_flush_prologue(void)
 {
 #ifdef CONFIG_SMP
-	if (cpu_has_dc_aliases)
+	if (cpu_has_dc_aliases || !cpu_has_ic_fills_f_dc)
 		preempt_disable();
 #endif
 }
@@ -31,14 +31,14 @@ static inline void __ide_flush_prologue(void)
 static inline void __ide_flush_epilogue(void)
 {
 #ifdef CONFIG_SMP
-	if (cpu_has_dc_aliases)
+	if (cpu_has_dc_aliases || !cpu_has_ic_fills_f_dc)
 		preempt_enable();
 #endif
 }
 
 static inline void __ide_flush_dcache_range(unsigned long addr, unsigned long size)
 {
-	if (cpu_has_dc_aliases) {
+	if (cpu_has_dc_aliases || !cpu_has_ic_fills_f_dc) {
 		unsigned long end = addr + size;
 
 		while (addr < end) {
-- 
1.6.6
