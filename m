Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Oct 2011 09:55:12 +0200 (CEST)
Received: from alius.ayous.org ([78.46.213.165]:37467 "EHLO alius.ayous.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491136Ab1JFHzI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Oct 2011 09:55:08 +0200
Received: from eos.turmzimmer.net ([2001:a60:f006:aba::1])
        by alius.turmzimmer.net with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <aba@not.so.argh.org>)
        id 1RBinK-0003hS-Sx; Thu, 06 Oct 2011 07:55:07 +0000
Received: from aba by eos.turmzimmer.net with local (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1RBinE-0005d6-RT; Thu, 06 Oct 2011 09:55:00 +0200
Date:   Thu, 6 Oct 2011 09:55:00 +0200
From:   Andreas Barth <aba@not.so.argh.org>
To:     linux-mips@linux-mips.org, debian-mips@lists.debian.org
Cc:     sebastian@breakpoint.cc
Subject: [PATCH] mips/ide: flush dcache also if icache does not snoop dcache
Message-ID: <20111006075500.GE4110@mails.so.argh.org>
Mail-Followup-To: Andreas Barth <aba@not.so.argh.org>,
        linux-mips@linux-mips.org, debian-mips@lists.debian.org,
        sebastian@breakpoint.cc
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 31209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aba@not.so.argh.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3593

Hi,

we apply this patch in Debian for quite some time (the linked bug
report is available on http://bugs.debian.org/404951 ). There was some
discussion about it in http://comments.gmane.org/gmane.linux.ide/45092
but not concluded (or at least: the patch is not merged).

In case it's useful it should IMHO go upstream. In case anything
should be fixed we should fix whatever is necessary. (I don't have
any own opinion with the patch, except that I want to get patches
merged as far as useful.)

So, my question is: Anything that needs to be changed? Or should we
just continue the situation as is?


Regards,
Andi


From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: mips/ide: flush dcache also if icache does not snoop dcache

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
