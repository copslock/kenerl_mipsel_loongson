Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Oct 2010 22:12:01 +0200 (CEST)
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:40502 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491105Ab0JDUL6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Oct 2010 22:11:58 +0200
Received: id: bigeasy by Chamillionaire.breakpoint.cc with local
        (easymta 1.00 BETA 1)
        id 1P2rO9-0005pk-B0; Mon, 04 Oct 2010 22:11:57 +0200
Date:   Mon, 4 Oct 2010 22:11:57 +0200
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Aurelien Jarno <aurelien@aurel32.net>
Subject: mips/ide: flush dcache also if icache does not snoop dcache
Message-ID: <20101004201157.GA22361@Chamillionaire.breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1286157343.3916.220.camel@localhost>
X-Key-Id: FE3F4706
X-Key-Fingerprint: FFDA BBBB 3563 1B27 75C9  925B 98D5 5C1C FE3F 4706
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <sebastian@breakpoint.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27939
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
