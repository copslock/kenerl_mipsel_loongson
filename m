Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Oct 2017 20:01:00 +0200 (CEST)
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:44922 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990477AbdJUSAw7c8Qp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Oct 2017 20:00:52 +0200
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 56F583F3AA;
        Sat, 21 Oct 2017 20:00:47 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F81Qq4wVcD61; Sat, 21 Oct 2017 20:00:45 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 52C1D3F281;
        Sat, 21 Oct 2017 20:00:41 +0200 (CEST)
Date:   Sat, 21 Oct 2017 20:00:40 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
Message-ID: <20171021180040.GC10522@localhost.localdomain>
References: <alpine.DEB.2.00.1709171001160.16752@tp.orcam.me.uk>
 <20170920140715.GA9255@localhost.localdomain>
 <alpine.DEB.2.00.1709201604400.16752@tp.orcam.me.uk>
 <20170922163753.GA2415@localhost.localdomain>
 <alpine.DEB.2.00.1709300024350.12020@tp.orcam.me.uk>
 <20170930182608.GB7714@localhost.localdomain>
 <alpine.DEB.2.00.1709301929060.12020@tp.orcam.me.uk>
 <20171006202838.GA26707@localhost.localdomain>
 <20171015163937.GA2239@localhost.localdomain>
 <alpine.DEB.2.00.1710171301160.3886@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1710171301160.3886@tp.orcam.me.uk>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
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

Hi Maciej,

>  I think you need to find another libc (or the whole userland), as I 
> previously suggested.

Indeed. I've replaced it all now.

> > Still left to explain is why the kernel stumbles on registers during
> > initialisation, before user applications are invoked.
> 
>  Good luck!

The problem was with the inq and outq macros in the Graphics Synthesizer
driver. A 32-bit kernel now works with 32-bit register save/restore and o32
applications, as intended. Many thanks for all your help in finding this!

I've found an unrelated curiosity. With CONFIG_CPU_HAS_MSA undefined,
handle_msa_fpe_int, do_msa_fpe, etc. are still generated with nonsensical
instructions:

	80025128 <handle_msa_fpe_int>:
	80025128:       787e0859        lq      s8,2137(v1) <<<-----
	8002512c:       00202821        move    a1,at
	80025130:       0000040f        sync.p
	80025134:       40086000        mfc0    t0,c0_sr
	...

	80030f08 <do_msa_fpe>:
	80030f08:       27bdffd8        addiu   sp,sp,-40
	80030f0c:       afb0001c        sw      s0,28(sp)
	80030f10:       00808021        move    s0,a0
	...
	80030f70:       02228824        and     s1,s1,v0
	80030f74:       02200821        move    at,s1
	80030f78:       783e0859        lq      s8,2137(at) <<<-----
	80030f7c:       0000040f        sync.p
	80030f80:       40016000        mfc0    at,c0_sr
	...

I disabled both with the patch below (there seems to be more opportunities
for size reductions overall).

Fredrik

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index ae810da4d499..91855c68e2de 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -439,11 +439,13 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	TRACE_IRQS_OFF
 	.endm
 
+#ifdef CONFIG_CPU_HAS_MSA
 	.macro	__build_clear_msa_fpe
 	_cfcmsa	a1, MSA_CSR
 	CLI
 	TRACE_IRQS_OFF
 	.endm
+#endif
 
 	.macro	__build_clear_ade
 	MFC0	t0, CP0_BADVADDR
@@ -503,10 +505,14 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	BUILD_HANDLER cpu cpu sti silent		/* #11 */
 	BUILD_HANDLER ov ov sti silent			/* #12 */
 	BUILD_HANDLER tr tr sti silent			/* #13 */
+#ifdef CONFIG_CPU_HAS_MSA
 	BUILD_HANDLER msa_fpe msa_fpe msa_fpe silent	/* #14 */
+#endif
 	BUILD_HANDLER fpe fpe fpe silent		/* #15 */
 	BUILD_HANDLER ftlb ftlb none silent		/* #16 */
+#ifdef CONFIG_CPU_HAS_MSA
 	BUILD_HANDLER msa msa sti silent		/* #21 */
+#endif
 	BUILD_HANDLER mdmx mdmx sti silent		/* #22 */
 #ifdef	CONFIG_HARDWARE_WATCHPOINTS
 	/*
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 38dfa27730ff..9bd7b4a0b764 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1457,6 +1457,7 @@ asmlinkage void do_cpu(struct pt_regs *regs)
 	exception_exit(prev_state);
 }
 
+#ifdef CONFIG_CPU_HAS_MSA
 asmlinkage void do_msa_fpe(struct pt_regs *regs, unsigned int msacsr)
 {
 	enum ctx_state prev_state;
@@ -1497,6 +1498,7 @@ asmlinkage void do_msa(struct pt_regs *regs)
 out:
 	exception_exit(prev_state);
 }
+#endif /* CONFIG_CPU_HAS_MSA */
 
 asmlinkage void do_mdmx(struct pt_regs *regs)
 {
@@ -2425,7 +2427,9 @@ void __init trap_init(void)
 	set_except_vector(EXCCODE_CPU, handle_cpu);
 	set_except_vector(EXCCODE_OV, handle_ov);
 	set_except_vector(EXCCODE_TR, handle_tr);
+#ifdef CONFIG_CPU_HAS_MSA
 	set_except_vector(EXCCODE_MSAFPE, handle_msa_fpe);
+#endif
 
 	if (current_cpu_type() == CPU_R6000 ||
 	    current_cpu_type() == CPU_R6000A) {
@@ -2455,7 +2459,9 @@ void __init trap_init(void)
 		set_except_vector(EXCCODE_TLBXI, tlb_do_page_fault_0);
 	}
 
+#ifdef CONFIG_CPU_HAS_MSA
 	set_except_vector(EXCCODE_MSADIS, handle_msa);
+#endif
 	set_except_vector(EXCCODE_MDMX, handle_mdmx);
 
 	if (cpu_has_mcheck)
