Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jun 2011 22:04:55 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:3176 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491161Ab1FUUEZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Jun 2011 22:04:25 +0200
X-TM-IMSS-Message-ID: <19d7909c000ad30d@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 19d7909c000ad30d ; Tue, 21 Jun 2011 13:03:19 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 21 Jun 2011 13:05:24 -0700
Date:   Wed, 22 Jun 2011 01:37:05 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH 2/2] MIPS:Netlogic:Fix section mismatch warnings.
Message-ID: <20110621200659.GA20777@jayachandranc.netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 21 Jun 2011 20:05:24.0878 (UTC) FILETIME=[8ED492E0:01CC304E]
X-archive-position: 30487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17507

Add __init and __cpuinit annotation to functions that need it.

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/netlogic/xlr/setup.c   |    4 ++--
 arch/mips/netlogic/xlr/smp.c     |    2 +-
 arch/mips/netlogic/xlr/smpboot.S |   16 +++++++++++-----
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/mips/netlogic/xlr/setup.c b/arch/mips/netlogic/xlr/setup.c
index 4828025..cee25dd 100644
--- a/arch/mips/netlogic/xlr/setup.c
+++ b/arch/mips/netlogic/xlr/setup.c
@@ -53,7 +53,7 @@ unsigned long netlogic_io_base = (unsigned long)(DEFAULT_NETLOGIC_IO_BASE);
 unsigned long nlm_common_ebase = 0x0;
 struct psb_info nlm_prom_info;
 
-static void nlm_early_serial_setup(void)
+static void __init nlm_early_serial_setup(void)
 {
 	struct uart_port s;
 	nlm_reg_t *uart_base;
@@ -101,7 +101,7 @@ void __init prom_free_prom_memory(void)
 	/* Nothing yet */
 }
 
-static void build_arcs_cmdline(int *argv)
+static void __init build_arcs_cmdline(int *argv)
 {
 	int i, remain, len;
 	char *arg;
diff --git a/arch/mips/netlogic/xlr/smp.c b/arch/mips/netlogic/xlr/smp.c
index d842bce..e237212 100644
--- a/arch/mips/netlogic/xlr/smp.c
+++ b/arch/mips/netlogic/xlr/smp.c
@@ -191,7 +191,7 @@ struct plat_smp_ops nlm_smp_ops = {
 
 unsigned long secondary_entry_point;
 
-int nlm_wakeup_secondary_cpus(u32 wakeup_mask)
+int __cpuinit nlm_wakeup_secondary_cpus(u32 wakeup_mask)
 {
 	unsigned int tid, pid, ipi, i, boot_cpu;
 	void *reset_vec;
diff --git a/arch/mips/netlogic/xlr/smpboot.S b/arch/mips/netlogic/xlr/smpboot.S
index b8e0744..16bf792 100644
--- a/arch/mips/netlogic/xlr/smpboot.S
+++ b/arch/mips/netlogic/xlr/smpboot.S
@@ -32,17 +32,19 @@
  * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+#include <linux/init.h>
+
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/regdef.h>
 #include <asm/mipsregs.h>
 
-
-/* Don't jump to linux function from Bootloader stack. Change it
- * here. Kernel might allocate bootloader memory before all the CPUs are
- * brought up (eg: Inode cache region) and we better don't overwrite this
- * memory
+/*
+ * Early code for secondary CPUs. This will get them out of the bootloader
+ * code and into linux. Needed because the bootloader area will be taken
+ * and initialized by linux.
  */
+	__CPUINIT
 NESTED(prom_pre_boot_secondary_cpus, 16, sp)
 	.set	mips64
 	mfc0	t0, $15, 1	# read ebase
@@ -73,7 +75,11 @@ NESTED(prom_pre_boot_secondary_cpus, 16, sp)
 	jr	t0
 	nop
 END(prom_pre_boot_secondary_cpus)
+	__FINIT
 
+/*
+ * NMI code, used for CPU wakeup, copied to reset entry 
+ */
 NESTED(nlm_boot_smp_nmi, 0, sp)
 	.set push
 	.set noat
-- 
1.7.4.1


-- 
Jayachandran C.
jayachandranc@netlogicmicro.com                  (Netlogic Microsystems)
jchandra@freebsd.org                               (The FreeBSD Project)
