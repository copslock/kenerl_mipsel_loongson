Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Mar 2017 13:16:25 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:44724 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992214AbdCJMQQAPEf0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Mar 2017 13:16:16 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2ACGCsr024395;
        Fri, 10 Mar 2017 13:16:12 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2ACGBph024394;
        Fri, 10 Mar 2017 13:16:11 +0100
Date:   Fri, 10 Mar 2017 13:16:11 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mips@linux-mips.org, james.hogan@imgtec.com,
        paul.burton@imgtec.com, marcin.nowakowski@imgtec.com,
        justinpopo6@gmail.com, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 1/2] MIPS: kexec: Provide bootloader arguments by default
Message-ID: <20170310121611.GB22089@linux-mips.org>
References: <20170308014641.16267-1-f.fainelli@gmail.com>
 <20170308014641.16267-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170308014641.16267-2-f.fainelli@gmail.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57133
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

On Tue, Mar 07, 2017 at 05:46:40PM -0800, Florian Fainelli wrote:

> In case we do not implement a _machine_kexec_shutdown callback to do
> platform specific kexec shutdown operations, the most sensible thing to
> do is to provide the kexec'd kernel with the same arguments we initially
> booted with.

Seems this is really only necessary because we have separate sets of incoming
and outgoing kernel arguments in kexec_args[] and fw_arg0 ... fw_arg3.
Confusingly the one is also an array while the other set consists of
three variables.  Cleaning that is a bigger job but something like below
should do the trick.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/alchemy/board-gpr.c          |  6 +++---
 arch/mips/alchemy/board-mtx1.c         |  6 +++---
 arch/mips/alchemy/board-xxs1500.c      |  6 +++---
 arch/mips/alchemy/devboards/platform.c |  6 +++---
 arch/mips/ar7/prom.c                   |  4 ++--
 arch/mips/bmips/setup.c                |  4 ++--
 arch/mips/cavium-octeon/setup.c        | 14 +++++++-------
 arch/mips/cobalt/setup.c               |  6 +++---
 arch/mips/dec/prom/init.c              |  8 ++++----
 arch/mips/emma/common/prom.c           |  4 ++--
 arch/mips/fw/arc/init.c                |  6 +++---
 arch/mips/fw/lib/cmdline.c             | 10 +++++-----
 arch/mips/fw/sni/sniprom.c             |  4 ++--
 arch/mips/generic/init.c               |  8 ++++----
 arch/mips/generic/kexec.c              |  4 ++--
 arch/mips/include/asm/bootinfo.h       |  3 ++-
 arch/mips/include/asm/kexec.h          |  4 ++--
 arch/mips/jz4740/prom.c                |  2 +-
 arch/mips/kernel/head.S                |  8 ++++----
 arch/mips/kernel/relocate_kernel.S     | 28 ++++++++--------------------
 arch/mips/kernel/setup.c               |  2 +-
 arch/mips/lantiq/prom.c                |  4 ++--
 arch/mips/lasat/prom.c                 |  4 ++--
 arch/mips/loongson32/common/prom.c     |  6 +++---
 arch/mips/loongson64/common/cmdline.c  |  4 ++--
 arch/mips/loongson64/common/env.c      |  4 ++--
 arch/mips/netlogic/xlp/setup.c         |  2 +-
 arch/mips/netlogic/xlr/setup.c         |  6 +++---
 arch/mips/paravirt/setup.c             |  4 ++--
 arch/mips/pic32/pic32mzda/init.c       |  4 ++--
 arch/mips/pistachio/init.c             |  4 ++--
 arch/mips/pmcs-msp71xx/msp_setup.c     |  8 ++++----
 arch/mips/pnx833x/common/prom.c        |  4 ++--
 arch/mips/pnx833x/stb22x/board.c       |  6 +++---
 arch/mips/ralink/prom.c                | 10 +++++-----
 arch/mips/rb532/prom.c                 |  4 ++--
 arch/mips/sibyte/common/cfe.c          |  6 +++---
 arch/mips/txx9/generic/setup.c         | 10 +++++-----
 arch/mips/vr41xx/common/init.c         |  4 ++--
 39 files changed, 113 insertions(+), 124 deletions(-)

diff --git a/arch/mips/alchemy/board-gpr.c b/arch/mips/alchemy/board-gpr.c
index 6fb6b3f..5b61223 100644
--- a/arch/mips/alchemy/board-gpr.c
+++ b/arch/mips/alchemy/board-gpr.c
@@ -47,9 +47,9 @@ void __init prom_init(void)
 	unsigned char *memsize_str;
 	unsigned long memsize;
 
-	prom_argc = fw_arg0;
-	prom_argv = (char **)fw_arg1;
-	prom_envp = (char **)fw_arg2;
+	prom_argc = karg_regs[0];
+	prom_argv = (char **)karg_regs[1];
+	prom_envp = (char **)karg_regs[2];
 
 	prom_init_cmdline();
 
diff --git a/arch/mips/alchemy/board-mtx1.c b/arch/mips/alchemy/board-mtx1.c
index 85bb756..0f103ff 100644
--- a/arch/mips/alchemy/board-mtx1.c
+++ b/arch/mips/alchemy/board-mtx1.c
@@ -46,9 +46,9 @@ void __init prom_init(void)
 	unsigned char *memsize_str;
 	unsigned long memsize;
 
-	prom_argc = fw_arg0;
-	prom_argv = (char **)fw_arg1;
-	prom_envp = (char **)fw_arg2;
+	prom_argc = karg_regs[0];
+	prom_argv = (char **)karg_regs[1];
+	prom_envp = (char **)karg_regs[2];
 
 	prom_init_cmdline();
 
diff --git a/arch/mips/alchemy/board-xxs1500.c b/arch/mips/alchemy/board-xxs1500.c
index 0fc53e0..cbb1455 100644
--- a/arch/mips/alchemy/board-xxs1500.c
+++ b/arch/mips/alchemy/board-xxs1500.c
@@ -42,9 +42,9 @@ void __init prom_init(void)
 	unsigned char *memsize_str;
 	unsigned long memsize;
 
-	prom_argc = fw_arg0;
-	prom_argv = (char **)fw_arg1;
-	prom_envp = (char **)fw_arg2;
+	prom_argc = karg_regs[0];
+	prom_argv = (char **)karg_regs[1];
+	prom_envp = (char **)karg_regs[2];
 
 	prom_init_cmdline();
 
diff --git a/arch/mips/alchemy/devboards/platform.c b/arch/mips/alchemy/devboards/platform.c
index be139a0..00515d9 100644
--- a/arch/mips/alchemy/devboards/platform.c
+++ b/arch/mips/alchemy/devboards/platform.c
@@ -23,9 +23,9 @@ void __init prom_init(void)
 	unsigned char *memsize_str;
 	unsigned long memsize;
 
-	prom_argc = (int)fw_arg0;
-	prom_argv = (char **)fw_arg1;
-	prom_envp = (char **)fw_arg2;
+	prom_argc = (int)karg_regs[0];
+	prom_argv = (char **)karg_regs[1];
+	prom_envp = (char **)karg_regs[2];
 
 	prom_init_cmdline();
 	memsize_str = prom_getenv("memsize");
diff --git a/arch/mips/ar7/prom.c b/arch/mips/ar7/prom.c
index 4fd8333..a27d803 100644
--- a/arch/mips/ar7/prom.c
+++ b/arch/mips/ar7/prom.c
@@ -243,8 +243,8 @@ static void __init console_config(void)
 
 void __init prom_init(void)
 {
-	ar7_init_cmdline(fw_arg0, (char **)fw_arg1);
-	ar7_init_env((struct env_var *)fw_arg2);
+	ar7_init_cmdline(karg_regs[0], (char **)karg_regs[1]);
+	ar7_init_env((struct env_var *)karg_regs[2]);
 	console_config();
 
 	ar7_gpio_init();
diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index 3b6f687..9750ddd 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -170,8 +170,8 @@ void __init plat_mem_setup(void)
 	else
 #endif
 	/* intended to somewhat resemble ARM; see Documentation/arm/Booting */
-	if (fw_arg0 == 0 && fw_arg1 == 0xffffffff)
-		dtb = phys_to_virt(fw_arg2);
+	if (karg_regs[0] == 0 && karg_regs[1] == 0xffffffff)
+		dtb = phys_to_virt(karg_regs[2]);
 	else if (fw_passed_dtb) /* UHI interface */
 		dtb = (void *)fw_passed_dtb;
 	else if (__dtb_start != __dtb_end)
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index d9dbeb0..292e5aa 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -240,11 +240,11 @@ static void octeon_generic_shutdown(void)
 			if (ptr[i].size)
 				cvmx_bootmem_free_named(ptr[i].name);
 	}
-	kexec_args[2] = 1UL; /* running on octeon_main_processor */
-	kexec_args[3] = (unsigned long)octeon_boot_desc_ptr;
+	karg_regs[2] = 1UL; /* running on octeon_main_processor */
+	karg_regs[3] = (unsigned long)octeon_boot_desc_ptr;
 #ifdef CONFIG_SMP
-	secondary_kexec_args[2] = 0UL; /* running on secondary cpu */
-	secondary_kexec_args[3] = (unsigned long)octeon_boot_desc_ptr;
+	secondary_karg_regs[2] = 0UL; /* running on secondary cpu */
+	secondary_karg_regs[3] = (unsigned long)octeon_boot_desc_ptr;
 #endif
 }
 
@@ -672,9 +672,9 @@ void __init prom_init(void)
 #endif
 	/*
 	 * The bootloader passes a pointer to the boot descriptor in
-	 * $a3, this is available as fw_arg3.
+	 * $a3, this is available as karg_regs[3].
 	 */
-	octeon_boot_desc_ptr = (struct octeon_boot_descriptor *)fw_arg3;
+	octeon_boot_desc_ptr = (struct octeon_boot_descriptor *)karg_regs[3];
 	octeon_bootinfo =
 		cvmx_phys_to_ptr(octeon_boot_desc_ptr->cvmx_desc_vaddr);
 	cvmx_bootmem_init(cvmx_phys_to_ptr(octeon_bootinfo->phy_mem_desc_addr));
@@ -953,7 +953,7 @@ void __init fw_init_cmdline(void)
 {
 	int i;
 
-	octeon_boot_desc_ptr = (struct octeon_boot_descriptor *)fw_arg3;
+	octeon_boot_desc_ptr = (struct octeon_boot_descriptor *)karg_regs[3];
 	for (i = 0; i < octeon_boot_desc_ptr->argc; i++) {
 		const char *arg =
 			cvmx_phys_to_ptr(octeon_boot_desc_ptr->argv[i]);
diff --git a/arch/mips/cobalt/setup.c b/arch/mips/cobalt/setup.c
index c136a18..fc1aa3b 100644
--- a/arch/mips/cobalt/setup.c
+++ b/arch/mips/cobalt/setup.c
@@ -102,9 +102,9 @@ void __init prom_init(void)
 	int argc, i;
 	char **argv;
 
-	memsz = fw_arg0 & 0x7fff0000;
-	argc = fw_arg0 & 0x0000ffff;
-	argv = (char **)fw_arg1;
+	memsz = karg_regs[0] & 0x7fff0000;
+	argc = karg_regs[0] & 0x0000ffff;
+	argv = (char **)karg_regs[1];
 
 	for (i = 1; i < argc; i++) {
 		strlcat(arcs_cmdline, argv[i], COMMAND_LINE_SIZE);
diff --git a/arch/mips/dec/prom/init.c b/arch/mips/dec/prom/init.c
index 4e1761e..b3fb6b3 100644
--- a/arch/mips/dec/prom/init.c
+++ b/arch/mips/dec/prom/init.c
@@ -90,10 +90,10 @@ void __init prom_init(void)
 	extern void dec_machine_halt(void);
 	static char cpu_msg[] __initdata =
 		"Sorry, this kernel is compiled for a wrong CPU type!\n";
-	s32 argc = fw_arg0;
-	s32 *argv = (void *)fw_arg1;
-	u32 magic = fw_arg2;
-	s32 *prom_vec = (void *)fw_arg3;
+	s32 argc = karg_regs[0];
+	s32 *argv = (void *)karg_regs[1];
+	u32 magic = karg_regs[2];
+	s32 *prom_vec = (void *)karg_regs[3];
 
 	/*
 	 * Determine which PROM we have
diff --git a/arch/mips/emma/common/prom.c b/arch/mips/emma/common/prom.c
index cae4225..bc64126 100644
--- a/arch/mips/emma/common/prom.c
+++ b/arch/mips/emma/common/prom.c
@@ -40,8 +40,8 @@ const char *get_system_type(void)
 /* [jsun@junsun.net] PMON passes arguments in C main() style */
 void __init prom_init(void)
 {
-	int argc = fw_arg0;
-	char **arg = (char **)fw_arg1;
+	int argc = karg_regs[0];
+	char **arg = (char **)karg_regs[1];
 	int i;
 
 	/* if user passes kernel args, ignore the default one */
diff --git a/arch/mips/fw/arc/init.c b/arch/mips/fw/arc/init.c
index 629b24d..557aace 100644
--- a/arch/mips/fw/arc/init.c
+++ b/arch/mips/fw/arc/init.c
@@ -27,9 +27,9 @@ void __init prom_init(void)
 
 	romvec = ROMVECTOR;
 
-	prom_argc = fw_arg0;
-	_prom_argv = (LONG *) fw_arg1;
-	_prom_envp = (LONG *) fw_arg2;
+	prom_argc = karg_regs[0];
+	_prom_argv = (LONG *) karg_regs[1];
+	_prom_envp = (LONG *) karg_regs[2];
 
 	if (pb->magic != 0x53435241) {
 		printk(KERN_CRIT "Aieee, bad prom vector magic %08lx\n",
diff --git a/arch/mips/fw/lib/cmdline.c b/arch/mips/fw/lib/cmdline.c
index 6ecda64..1e786cd 100644
--- a/arch/mips/fw/lib/cmdline.c
+++ b/arch/mips/fw/lib/cmdline.c
@@ -21,19 +21,19 @@ void __init fw_init_cmdline(void)
 	int i;
 
 	/* Validate command line parameters. */
-	if ((fw_arg0 >= CKSEG0) || (fw_arg1 < CKSEG0)) {
+	if ((karg_regs[0] >= CKSEG0) || (karg_regs[1] < CKSEG0)) {
 		fw_argc = 0;
 		_fw_argv = NULL;
 	} else {
-		fw_argc = (fw_arg0 & 0x0000ffff);
-		_fw_argv = (int *)fw_arg1;
+		fw_argc = (karg_regs[0] & 0x0000ffff);
+		_fw_argv = (int *)karg_regs[1];
 	}
 
 	/* Validate environment pointer. */
-	if (fw_arg2 < CKSEG0)
+	if (karg_regs[2] < CKSEG0)
 		_fw_envp = NULL;
 	else
-		_fw_envp = (int *)fw_arg2;
+		_fw_envp = (int *)karg_regs[2];
 
 	for (i = 1; i < fw_argc; i++) {
 		strlcat(arcs_cmdline, fw_argv(i), COMMAND_LINE_SIZE);
diff --git a/arch/mips/fw/sni/sniprom.c b/arch/mips/fw/sni/sniprom.c
index 6aa264b..1da23f9 100644
--- a/arch/mips/fw/sni/sniprom.c
+++ b/arch/mips/fw/sni/sniprom.c
@@ -137,8 +137,8 @@ static void __init sni_mem_init(void)
 
 void __init prom_init(void)
 {
-	int argc = fw_arg0;
-	u32 *argv = (u32 *)CKSEG0ADDR(fw_arg1);
+	int argc = karg_regs[0];
+	u32 *argv = (u32 *)CKSEG0ADDR(karg_regs[1]);
 	int i;
 
 	sni_mem_init();
diff --git a/arch/mips/generic/init.c b/arch/mips/generic/init.c
index 4af6192..de32fdf 100644
--- a/arch/mips/generic/init.c
+++ b/arch/mips/generic/init.c
@@ -43,14 +43,14 @@ void __init *plat_get_fdt(void)
 		/* Already set up */
 		return (void *)fdt;
 
-	if ((fw_arg0 == -2) && !fdt_check_header((void *)fw_arg1)) {
+	if ((karg_regs[0] == -2) && !fdt_check_header((void *)karg_regs[1])) {
 		/*
 		 * We booted using the UHI boot protocol, so we have been
 		 * provided with the appropriate device tree for the board.
 		 * Make use of it & search for any machine struct based upon
 		 * the root compatible string.
 		 */
-		fdt = (void *)fw_arg1;
+		fdt = (void *)karg_regs[1];
 
 		for_each_mips_machine(check_mach) {
 			match = mips_machine_is_compatible(check_mach, fdt);
@@ -97,8 +97,8 @@ void __init plat_fdt_relocated(void *new_location)
 	 */
 	fdt = NULL;
 
-	if (fw_arg0 == -2)
-		fw_arg1 = (unsigned long)new_location;
+	if (karg_regs[0] == -2)
+		karg_regs[1] = (unsigned long)new_location;
 }
 
 void __init plat_mem_setup(void)
diff --git a/arch/mips/generic/kexec.c b/arch/mips/generic/kexec.c
index e9fb735..243f756 100644
--- a/arch/mips/generic/kexec.c
+++ b/arch/mips/generic/kexec.c
@@ -28,8 +28,8 @@ static int generic_kexec_prepare(struct kimage *image)
 		if (fdt_check_header(&fdt))
 			continue;
 
-		kexec_args[0] = -2;
-		kexec_args[1] = (unsigned long)
+		karg_regs[0] = -2;
+		karg_regs[1] = (unsigned long)
 			phys_to_virt((unsigned long)image->segment[i].mem);
 		break;
 	}
diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index e26a093..f8aecf3 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -124,8 +124,9 @@ extern char arcs_cmdline[COMMAND_LINE_SIZE];
 
 /*
  * Registers a0, a1, a3 and a4 as passed to the kernel entry by firmware
+ * or kexec.
  */
-extern unsigned long fw_arg0, fw_arg1, fw_arg2, fw_arg3;
+extern unsigned long karg_regs[4];
 
 #ifdef CONFIG_USE_OF
 extern unsigned long fw_passed_dtb;
diff --git a/arch/mips/include/asm/kexec.h b/arch/mips/include/asm/kexec.h
index 493a3cc..31b6b0b 100644
--- a/arch/mips/include/asm/kexec.h
+++ b/arch/mips/include/asm/kexec.h
@@ -35,14 +35,14 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 
 #ifdef CONFIG_KEXEC
 struct kimage;
-extern unsigned long kexec_args[4];
+extern unsigned long karg_regs[4];
 extern int (*_machine_kexec_prepare)(struct kimage *);
 extern void (*_machine_kexec_shutdown)(void);
 extern void (*_machine_crash_shutdown)(struct pt_regs *regs);
 extern void default_machine_crash_shutdown(struct pt_regs *regs);
 #ifdef CONFIG_SMP
 extern const unsigned char kexec_smp_wait[];
-extern unsigned long secondary_kexec_args[4];
+extern unsigned long secondary_karg_regs[4];
 extern void (*relocated_kexec_smp_wait) (void *);
 extern atomic_t kexec_ready_to_reboot;
 extern void (*_crash_smp_send_stop)(void);
diff --git a/arch/mips/jz4740/prom.c b/arch/mips/jz4740/prom.c
index 47e8571..3228e90 100644
--- a/arch/mips/jz4740/prom.c
+++ b/arch/mips/jz4740/prom.c
@@ -45,7 +45,7 @@ static __init void jz4740_init_cmdline(int argc, char *argv[])
 
 void __init prom_init(void)
 {
-	jz4740_init_cmdline((int)fw_arg0, (char **)fw_arg1);
+	jz4740_init_cmdline((int)karg_regs[0], (char **)karg_regs[1]);
 	mips_machtype = MACH_INGENIC_JZ4740;
 }
 
diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index cf05220..013cba6 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -120,10 +120,10 @@ dtb_found:
 	LONG_S		zero, (t0)
 	bne		t0, t1, 1b
 
-	LONG_S		a0, fw_arg0		# firmware arguments
-	LONG_S		a1, fw_arg1
-	LONG_S		a2, fw_arg2
-	LONG_S		a3, fw_arg3
+	LONG_S		a0, karg_regs + 0 * LONGSIZE	# firmware arguments
+	LONG_S		a1, karg_regs + 1 * LONGSIZE
+	LONG_S		a2, karg_regs + 2 * LONGSIZE
+	LONG_S		a3, karg_regs + 3 * LONGSIZE
 
 #ifdef CONFIG_USE_OF
 	LONG_S		t2, fw_passed_dtb
diff --git a/arch/mips/kernel/relocate_kernel.S b/arch/mips/kernel/relocate_kernel.S
index c6bbf21..3a60225 100644
--- a/arch/mips/kernel/relocate_kernel.S
+++ b/arch/mips/kernel/relocate_kernel.S
@@ -14,10 +14,10 @@
 #include <asm/addrspace.h>
 
 LEAF(relocate_new_kernel)
-	PTR_L a0,	arg0
-	PTR_L a1,	arg1
-	PTR_L a2,	arg2
-	PTR_L a3,	arg3
+	PTR_L		a0, karg_regs + 0 * LONGSIZE
+	PTR_L		a1, karg_regs + 1 * LONGSIZE
+	PTR_L		a2, karg_regs + 2 * LONGSIZE
+	PTR_L		a3, karg_regs + 3 * LONGSIZE
 
 	PTR_L		s0, kexec_indirection_page
 	PTR_L		s1, kexec_start_address
@@ -144,31 +144,19 @@ LEAF(kexec_smp_wait)
        .align  3
 #endif
 
-/* All parameters to new kernel are passed in registers a0-a3.
- * kexec_args[0..3] are uses to prepare register values.
- */
-
-kexec_args:
-	EXPORT(kexec_args)
-arg0:	PTR		0x0
-arg1:	PTR		0x0
-arg2:	PTR		0x0
-arg3:	PTR		0x0
-	.size	kexec_args,PTRSIZE*4
-
 #ifdef CONFIG_SMP
 /*
  * Secondary CPUs may have different kernel parameters in
- * their registers a0-a3. secondary_kexec_args[0..3] are used
+ * their registers a0-a3. secondary_karg_regs[0..3] are used
  * to prepare register values.
  */
-secondary_kexec_args:
-	EXPORT(secondary_kexec_args)
+secondary_karg_regs:
+	EXPORT(secondary_karg_regs)
 s_arg0: PTR		0x0
 s_arg1: PTR		0x0
 s_arg2: PTR		0x0
 s_arg3: PTR		0x0
-	.size	secondary_kexec_args,PTRSIZE*4
+	.size	secondary_karg_regs,PTRSIZE*4
 kexec_flag:
 	LONG		0x1
 
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 01d1dbd..9c4b6fb 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -981,7 +981,7 @@ void __init setup_arch(char **cmdline_p)
 }
 
 unsigned long kernelsp[NR_CPUS];
-unsigned long fw_arg0, fw_arg1, fw_arg2, fw_arg3;
+unsigned long karg_regs[4];
 
 #ifdef CONFIG_USE_OF
 unsigned long fw_passed_dtb;
diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index 96773be..ebea467 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -53,8 +53,8 @@ void __init prom_free_prom_memory(void)
 
 static void __init prom_init_cmdline(void)
 {
-	int argc = fw_arg0;
-	char **argv = (char **) KSEG1ADDR(fw_arg1);
+	int argc = karg_regs[0];
+	char **argv = (char **) KSEG1ADDR(karg_regs[1]);
 	int i;
 
 	arcs_cmdline[0] = '\0';
diff --git a/arch/mips/lasat/prom.c b/arch/mips/lasat/prom.c
index 20fde19..b30f3c0 100644
--- a/arch/mips/lasat/prom.c
+++ b/arch/mips/lasat/prom.c
@@ -81,8 +81,8 @@ static struct at93c_defs at93c_defs[N_MACHTYPES] = {
 
 void __init prom_init(void)
 {
-	int argc = fw_arg0;
-	char **argv = (char **) fw_arg1;
+	int argc = karg_regs[0];
+	char **argv = (char **) karg_regs[1];
 
 	setup_prom_vectors();
 
diff --git a/arch/mips/loongson32/common/prom.c b/arch/mips/loongson32/common/prom.c
index 6860098..85e0693 100644
--- a/arch/mips/loongson32/common/prom.c
+++ b/arch/mips/loongson32/common/prom.c
@@ -58,9 +58,9 @@ void __init prom_init_cmdline(void)
 void __init prom_init(void)
 {
 	void __iomem *uart_base;
-	prom_argc = fw_arg0;
-	prom_argv = (char **)fw_arg1;
-	prom_envp = (char **)fw_arg2;
+	prom_argc = karg_regs[0];
+	prom_argv = (char **)karg_regs[1];
+	prom_envp = (char **)karg_regs[2];
 
 	prom_init_cmdline();
 
diff --git a/arch/mips/loongson64/common/cmdline.c b/arch/mips/loongson64/common/cmdline.c
index 01fbed1..2cf9bc7 100644
--- a/arch/mips/loongson64/common/cmdline.c
+++ b/arch/mips/loongson64/common/cmdline.c
@@ -30,8 +30,8 @@ void __init prom_init_cmdline(void)
 	long l;
 
 	/* firmware arguments are initialized in head.S */
-	prom_argc = fw_arg0;
-	_prom_argv = (int *)fw_arg1;
+	prom_argc = karg_regs[0];
+	_prom_argv = (int *)karg_regs[1];
 
 	/* arg[0] is "g", the rest is boot parameters */
 	arcs_cmdline[0] = '\0';
diff --git a/arch/mips/loongson64/common/env.c b/arch/mips/loongson64/common/env.c
index 6afa218..d2835fa 100644
--- a/arch/mips/loongson64/common/env.c
+++ b/arch/mips/loongson64/common/env.c
@@ -52,7 +52,7 @@ void __init prom_init_env(void)
 	long l;
 
 	/* firmware arguments are initialized in head.S */
-	_prom_envp = (int *)fw_arg2;
+	_prom_envp = (int *)karg_regs[2];
 
 	l = (long)*_prom_envp;
 	while (l != 0) {
@@ -76,7 +76,7 @@ void __init prom_init_env(void)
 	struct irq_source_routing_table *eirq_source;
 
 	/* firmware arguments are initialized in head.S */
-	boot_p = (struct boot_params *)fw_arg2;
+	boot_p = (struct boot_params *)karg_regs[2];
 	loongson_p = &(boot_p->efi.smbios.lp);
 
 	esys = (struct system_loongson *)
diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index f743fd9..f95846e 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -165,7 +165,7 @@ void __init prom_init(void)
 	nlm_init_boot_cpu();
 	xlp_mmu_init();
 	nlm_node_init(0);
-	xlp_dt_init((void *)(long)fw_arg0);
+	xlp_dt_init((void *)(long)karg_regs[0]);
 
 	/* Update reset entry point with CPU init code */
 	reset_vec = (void *)CKSEG1ADDR(RESET_VEC_PHYS);
diff --git a/arch/mips/netlogic/xlr/setup.c b/arch/mips/netlogic/xlr/setup.c
index 72ceddc..b2a8d0b 100644
--- a/arch/mips/netlogic/xlr/setup.c
+++ b/arch/mips/netlogic/xlr/setup.c
@@ -182,9 +182,9 @@ void __init prom_init(void)
 #endif
 
 	/* truncate to 32 bit and sign extend all args */
-	argv = (int *)(long)(int)fw_arg1;
-	envp = (int *)(long)(int)fw_arg2;
-	prom_infop = (struct psb_info *)(long)(int)fw_arg3;
+	argv = (int *)(long)(int)karg_regs[1];
+	envp = (int *)(long)(int)karg_regs[2];
+	prom_infop = (struct psb_info *)(long)(int)karg_regs[3];
 
 	nlm_prom_info = *prom_infop;
 	nlm_init_node();
diff --git a/arch/mips/paravirt/setup.c b/arch/mips/paravirt/setup.c
index cb8448b..635e580 100644
--- a/arch/mips/paravirt/setup.c
+++ b/arch/mips/paravirt/setup.c
@@ -39,8 +39,8 @@ static void pv_machine_halt(void)
 void __init prom_init(void)
 {
 	int i;
-	int argc = fw_arg0;
-	char **argv = (char **)fw_arg1;
+	int argc = karg_regs[0];
+	char **argv = (char **)karg_regs[1];
 
 #ifdef CONFIG_32BIT
 	set_io_port_base(KSEG1ADDR(0x1e000000));
diff --git a/arch/mips/pic32/pic32mzda/init.c b/arch/mips/pic32/pic32mzda/init.c
index 5159971..061f92e 100644
--- a/arch/mips/pic32/pic32mzda/init.c
+++ b/arch/mips/pic32/pic32mzda/init.c
@@ -33,7 +33,7 @@ static ulong get_fdtaddr(void)
 {
 	ulong ftaddr = 0;
 
-	if (fw_passed_dtb && !fw_arg2 && !fw_arg3)
+	if (fw_passed_dtb && !karg_regs[2] && !karg_regs[3])
 		return (ulong)fw_passed_dtb;
 
 	if (__dtb_start < __dtb_end)
@@ -96,7 +96,7 @@ static __init void pic32_init_cmdline(int argc, char *argv[])
 
 void __init prom_init(void)
 {
-	pic32_init_cmdline((int)fw_arg0, (char **)fw_arg1);
+	pic32_init_cmdline((int)karg_regs[0], (char **)karg_regs[1]);
 }
 
 void __init prom_free_prom_memory(void)
diff --git a/arch/mips/pistachio/init.c b/arch/mips/pistachio/init.c
index 1c91cad7..39e65d4 100644
--- a/arch/mips/pistachio/init.c
+++ b/arch/mips/pistachio/init.c
@@ -61,9 +61,9 @@ const char *get_system_type(void)
 
 void __init *plat_get_fdt(void)
 {
-	if (fw_arg0 != -2)
+	if (karg_regs[0] != -2)
 		panic("Device-tree not present");
-	return (void *)fw_arg1;
+	return (void *)karg_regs[1];
 }
 
 void __init plat_mem_setup(void)
diff --git a/arch/mips/pmcs-msp71xx/msp_setup.c b/arch/mips/pmcs-msp71xx/msp_setup.c
index a63b736..73fd256 100644
--- a/arch/mips/pmcs-msp71xx/msp_setup.c
+++ b/arch/mips/pmcs-msp71xx/msp_setup.c
@@ -153,16 +153,16 @@ void __init prom_init(void)
 	unsigned long family;
 	unsigned long revision;
 
-	prom_argc = fw_arg0;
-	prom_argv = (char **)fw_arg1;
-	prom_envp = (char **)fw_arg2;
+	prom_argc = karg_regs[0];
+	prom_argv = (char **)karg_regs[1];
+	prom_envp = (char **)karg_regs[2];
 
 	/*
 	 * Someday we can use this with PMON2000 to get a
 	 * platform call prom routines for output etc. without
 	 * having to use grody hacks.  For now it's unused.
 	 *
-	 * struct callvectors *cv = (struct callvectors *) fw_arg3;
+	 * struct callvectors *cv = (struct callvectors *) karg_regs[3];
 	 */
 	family = identify_family();
 	revision = identify_revision();
diff --git a/arch/mips/pnx833x/common/prom.c b/arch/mips/pnx833x/common/prom.c
index dfafdd7..8d21771 100644
--- a/arch/mips/pnx833x/common/prom.c
+++ b/arch/mips/pnx833x/common/prom.c
@@ -28,8 +28,8 @@
 
 void __init prom_init_cmdline(void)
 {
-	int argc = fw_arg0;
-	char **argv = (char **)fw_arg1;
+	int argc = karg_regs[0];
+	char **argv = (char **)karg_regs[1];
 	char *c = &(arcs_cmdline[0]);
 	int i;
 
diff --git a/arch/mips/pnx833x/stb22x/board.c b/arch/mips/pnx833x/stb22x/board.c
index 2ac5203..ad72da8 100644
--- a/arch/mips/pnx833x/stb22x/board.c
+++ b/arch/mips/pnx833x/stb22x/board.c
@@ -59,9 +59,9 @@ void __init prom_init(void)
 {
 	unsigned long memsize;
 
-	prom_argc = fw_arg0;
-	prom_argv = (char **)fw_arg1;
-	prom_envp = (char **)fw_arg2;
+	prom_argc = karg_regs[0];
+	prom_argv = (char **)karg_regs[1];
+	prom_envp = (char **)karg_regs[2];
 
 	prom_init_cmdline();
 
diff --git a/arch/mips/ralink/prom.c b/arch/mips/ralink/prom.c
index 23198c9..155681b 100644
--- a/arch/mips/ralink/prom.c
+++ b/arch/mips/ralink/prom.c
@@ -36,12 +36,12 @@ static __init void prom_init_cmdline(void)
 	char **argv;
 	int i;
 
-	pr_debug("prom: fw_arg0=%08x fw_arg1=%08x fw_arg2=%08x fw_arg3=%08x\n",
-	       (unsigned int)fw_arg0, (unsigned int)fw_arg1,
-	       (unsigned int)fw_arg2, (unsigned int)fw_arg3);
+	pr_debug("prom: karg_regs[0]=%08x karg_regs[1]=%08x karg_regs[2]=%08x karg_regs[3]=%08x\n",
+	       (unsigned int)karg_regs[0], (unsigned int)karg_regs[1],
+	       (unsigned int)karg_regs[2], (unsigned int)karg_regs[3]);
 
-	argc = fw_arg0;
-	argv = (char **) KSEG1ADDR(fw_arg1);
+	argc = karg_regs[0];
+	argv = (char **) KSEG1ADDR(karg_regs[1]);
 
 	if (!argv) {
 		pr_debug("argv=%p is invalid, skipping\n",
diff --git a/arch/mips/rb532/prom.c b/arch/mips/rb532/prom.c
index 6484e4a..581c252 100644
--- a/arch/mips/rb532/prom.c
+++ b/arch/mips/rb532/prom.c
@@ -75,8 +75,8 @@ void __init prom_setup_cmdline(void)
 	char **prom_argv;
 	int i;
 
-	prom_argc = fw_arg0;
-	prom_argv = (char **) fw_arg1;
+	prom_argc = karg_regs[0];
+	prom_argv = (char **) karg_regs[1];
 
 	cp = cmd_line;
 		/* Note: it is common that parameters start
diff --git a/arch/mips/sibyte/common/cfe.c b/arch/mips/sibyte/common/cfe.c
index c1a11a1..bf12f3b 100644
--- a/arch/mips/sibyte/common/cfe.c
+++ b/arch/mips/sibyte/common/cfe.c
@@ -239,9 +239,9 @@ void __init prom_init(void)
 {
 	uint64_t cfe_ept, cfe_handle;
 	unsigned int cfe_eptseal;
-	int argc = fw_arg0;
-	char **envp = (char **) fw_arg2;
-	int *prom_vec = (int *) fw_arg3;
+	int argc = karg_regs[0];
+	char **envp = (char **) karg_regs[2];
+	int *prom_vec = (int *) karg_regs[3];
 
 	_machine_restart   = cfe_linux_restart;
 	_machine_halt	   = cfe_linux_halt;
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 1791a44..62d53d6 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -115,7 +115,7 @@ static void __init prom_init_cmdline(void)
 	int *argv32;
 	int i;			/* Always ignore the "-c" at argv[0] */
 
-	if (fw_arg0 >= CKSEG0 || fw_arg1 < CKSEG0) {
+	if (karg_regs[0] >= CKSEG0 || karg_regs[1] < CKSEG0) {
 		/*
 		 * argc is not a valid number, or argv32 is not a valid
 		 * pointer
@@ -123,8 +123,8 @@ static void __init prom_init_cmdline(void)
 		argc = 0;
 		argv32 = NULL;
 	} else {
-		argc = (int)fw_arg0;
-		argv32 = (int *)fw_arg1;
+		argc = (int)karg_regs[0];
+		argv32 = (int *)karg_regs[1];
 	}
 
 	arcs_cmdline[0] = '\0';
@@ -357,10 +357,10 @@ const char *__init prom_getenv(const char *name)
 {
 	const s32 *str;
 
-	if (fw_arg2 < CKSEG0)
+	if (karg_regs[2] < CKSEG0)
 		return NULL;
 
-	str = (const s32 *)fw_arg2;
+	str = (const s32 *)karg_regs[2];
 	/* YAMON style ("name", "value" pairs) */
 	while (str[0] && str[1]) {
 		if (!strcmp((const char *)(unsigned long)str[0], name))
diff --git a/arch/mips/vr41xx/common/init.c b/arch/mips/vr41xx/common/init.c
index 2391632..1df508f 100644
--- a/arch/mips/vr41xx/common/init.c
+++ b/arch/mips/vr41xx/common/init.c
@@ -62,8 +62,8 @@ void __init prom_init(void)
 	int argc, i;
 	char **argv;
 
-	argc = fw_arg0;
-	argv = (char **)fw_arg1;
+	argc = karg_regs[0];
+	argv = (char **)karg_regs[1];
 
 	for (i = 1; i < argc; i++) {
 		strlcat(arcs_cmdline, argv[i], COMMAND_LINE_SIZE);
