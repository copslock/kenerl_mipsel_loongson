Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jul 2018 17:21:31 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33924 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993860AbeGBPVXOU94N (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 2 Jul 2018 17:21:23 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id w62FKUpZ439160;
        Mon, 2 Jul 2018 17:20:30 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id w62FKTBa439158;
        Mon, 2 Jul 2018 17:20:29 +0200
Date:   Mon, 2 Jul 2018 17:20:29 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Remove no-op cast in show_regs()
Message-ID: <20180702152029.GA437552@linux-mips.org>
References: <20180622180703.18324-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622180703.18324-1-paul.burton@mips.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, Jun 22, 2018 at 11:07:03AM -0700, Paul Burton wrote:

> In show_regs() we have a regs argument of type struct pt_regs *, and we
> explicitly cast it to that same type as part of calling __show_regs().
> 
> Casting regs to the same type that it is declared as does nothing at
> all, so remove the useless cast.

Good catch but there's no dump_stack() in v4.18-rc3 so this doesn't apply.
That's trivial to patch up but since pointless casts are one of my pet
peeve I used a semantic patch from a dark local repository to hunt down a
few more.

@identitycast@
type T;
T *A;
@@
-	(T *) A
+	A

Julia, I guess this isn't bulletproof but maybe something similar should
be considered for scripts/coccinelle?

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/kernel/relocate.c           |  2 +-
 arch/mips/kernel/traps.c              |  2 +-
 arch/mips/loongson64/loongson-3/smp.c | 10 +++++-----
 arch/mips/pmcs-msp71xx/msp_usb.c      |  4 ++--
 arch/mips/sgi-ip22/ip28-berr.c        |  2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/mips/kernel/relocate.c b/arch/mips/kernel/relocate.c
index cbf4cc0b0b6c..ae7d9cf2c849 100644
--- a/arch/mips/kernel/relocate.c
+++ b/arch/mips/kernel/relocate.c
@@ -146,7 +146,7 @@ int __init do_relocations(void *kbase_old, void *kbase_new, long offset)
 			break;
 
 		type = (*r >> 24) & 0xff;
-		loc_orig = (void *)(kbase_old + ((*r & 0x00ffffff) << 2));
+		loc_orig = (kbase_old + ((*r & 0x00ffffff) << 2));
 		loc_new = RELOCATED(loc_orig);
 
 		if (reloc_handlers_rel[type] == NULL) {
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index d67fa74622ee..2935aa608d2f 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -350,7 +350,7 @@ static void __show_regs(const struct pt_regs *regs)
  */
 void show_regs(struct pt_regs *regs)
 {
-	__show_regs((struct pt_regs *)regs);
+	__show_regs(regs);
 }
 
 void show_registers(struct pt_regs *regs)
diff --git a/arch/mips/loongson64/loongson-3/smp.c b/arch/mips/loongson64/loongson-3/smp.c
index 8501109bb0f0..e231c2cb4a64 100644
--- a/arch/mips/loongson64/loongson-3/smp.c
+++ b/arch/mips/loongson64/loongson-3/smp.c
@@ -349,7 +349,7 @@ static void loongson3_smp_finish(void)
 	write_c0_compare(read_c0_count() + mips_hpt_frequency/HZ);
 	local_irq_enable();
 	loongson3_ipi_write64(0,
-			(void *)(ipi_mailbox_buf[cpu_logical_map(cpu)]+0x0));
+			(ipi_mailbox_buf[cpu_logical_map(cpu)] + 0x0));
 	pr_info("CPU#%d finished, CP0_ST=%x\n",
 			smp_processor_id(), read_c0_status());
 }
@@ -416,13 +416,13 @@ static int loongson3_boot_secondary(int cpu, struct task_struct *idle)
 			cpu, startargs[0], startargs[1], startargs[2]);
 
 	loongson3_ipi_write64(startargs[3],
-			(void *)(ipi_mailbox_buf[cpu_logical_map(cpu)]+0x18));
+			(ipi_mailbox_buf[cpu_logical_map(cpu)] + 0x18));
 	loongson3_ipi_write64(startargs[2],
-			(void *)(ipi_mailbox_buf[cpu_logical_map(cpu)]+0x10));
+			(ipi_mailbox_buf[cpu_logical_map(cpu)] + 0x10));
 	loongson3_ipi_write64(startargs[1],
-			(void *)(ipi_mailbox_buf[cpu_logical_map(cpu)]+0x8));
+			(ipi_mailbox_buf[cpu_logical_map(cpu)] + 0x8));
 	loongson3_ipi_write64(startargs[0],
-			(void *)(ipi_mailbox_buf[cpu_logical_map(cpu)]+0x0));
+			(ipi_mailbox_buf[cpu_logical_map(cpu)] + 0x0));
 	return 0;
 }
 
diff --git a/arch/mips/pmcs-msp71xx/msp_usb.c b/arch/mips/pmcs-msp71xx/msp_usb.c
index c87c5f810cd1..d38ac70b5a2e 100644
--- a/arch/mips/pmcs-msp71xx/msp_usb.c
+++ b/arch/mips/pmcs-msp71xx/msp_usb.c
@@ -133,13 +133,13 @@ static int __init msp_usb_setup(void)
 	 * "D" for device-mode.	 If it works for Ethernet, why not USB...
 	 *  -- hammtrev, 2007/03/22
 	 */
-	snprintf((char *)&envstr[0], sizeof(envstr), "usbmode");
+	snprintf(&envstr[0], sizeof(envstr), "usbmode");
 
 	/* set default host mode */
 	val = 1;
 
 	/* get environment string */
-	strp = prom_getenv((char *)&envstr[0]);
+	strp = prom_getenv(&envstr[0]);
 	if (strp) {
 		/* compare string */
 		if (!strcmp(strp, "device"))
diff --git a/arch/mips/sgi-ip22/ip28-berr.c b/arch/mips/sgi-ip22/ip28-berr.c
index 2ed8e4990b7a..082541d33161 100644
--- a/arch/mips/sgi-ip22/ip28-berr.c
+++ b/arch/mips/sgi-ip22/ip28-berr.c
@@ -464,7 +464,7 @@ void ip22_be_interrupt(int irq)
 		die_if_kernel("Oops", regs);
 		force_sig(SIGBUS, current);
 	} else if (debug_be_interrupt)
-		show_regs((struct pt_regs *)regs);
+		show_regs(regs);
 }
 
 static int ip28_be_handler(struct pt_regs *regs, int is_fixup)
