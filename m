Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 May 2011 16:00:20 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:35652 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491772Ab1E0OAQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 May 2011 16:00:16 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p4RE0Dpj010133;
        Fri, 27 May 2011 15:00:13 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p4RE0CWO010127;
        Fri, 27 May 2011 15:00:12 +0100
Date:   Fri, 27 May 2011 15:00:11 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Rob Landley <rob@landley.net>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: MIPS panic in 2.6.39 (bisected to 7eaceaccab5f)
Message-ID: <20110527140011.GF30117@linux-mips.org>
References: <4DDB5673.5060206@landley.net>
 <20110524143937.GB30117@linux-mips.org>
 <4DDCB1EB.4020707@landley.net>
 <20110527075512.GE30117@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110527075512.GE30117@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30159
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 27, 2011 at 08:55:13AM +0100, Ralf Baechle wrote:

> > Have you guys been able to reproduce the problem?
> 
> Staring at the disassembly was good enough, I think.  The commit you
> bisected is restructuring some of the hardware probing code for Malta and
> seems to result in gcmp_present being set without _gcmp_base having been
> assigned, thus the null pointer dereference.

Can you test below patch?  Thanks,

  Ralf

Since af3a1f6f4813907e143f87030cde67a9971db533 the Malta code does no
longer probe for presence of GCMP if CMP is not configured.  This means
that the variable gcmp_present well be left at its default value of -1
which normally is meant to indicate that GCMP has not yet been mmapped.
This non-zero value is now interpreted as GCMP being present resulting
in a write attempt to a GCMP register resulting in a crash.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/include/asm/smp-ops.h          |   41 +++++++++++++++++++++++++++--
 arch/mips/mipssim/sim_setup.c            |   17 ++++++------
 arch/mips/mti-malta/malta-init.c         |   13 ++++-----
 arch/mips/pmc-sierra/msp71xx/msp_setup.c |    8 ++---
 4 files changed, 55 insertions(+), 24 deletions(-)

diff --git a/arch/mips/include/asm/smp-ops.h b/arch/mips/include/asm/smp-ops.h
index 9e09af3..48b03ff 100644
--- a/arch/mips/include/asm/smp-ops.h
+++ b/arch/mips/include/asm/smp-ops.h
@@ -56,8 +56,43 @@ static inline void register_smp_ops(struct plat_smp_ops *ops)
 
 #endif /* !CONFIG_SMP */
 
-extern struct plat_smp_ops up_smp_ops;
-extern struct plat_smp_ops cmp_smp_ops;
-extern struct plat_smp_ops vsmp_smp_ops;
+static inline int register_up_smp_ops(void)
+{
+#ifdef CONFIG_SMP_UP
+	extern struct plat_smp_ops up_smp_ops;
+
+	register_smp_ops(&up_smp_ops);
+
+	return 0;
+#else
+	return -ENODEV;
+#endif
+}
+
+static inline int register_cmp_smp_ops(void)
+{
+#ifdef CONFIG_MIPS_CMP
+	extern struct plat_smp_ops cmp_smp_ops;
+
+	register_smp_ops(&cmp_smp_ops);
+
+	return 0;
+#else
+	return -ENODEV;
+#endif
+}
+
+static inline int register_vsmp_smp_ops(void)
+{
+#ifdef CONFIG_MIPS_MT_SMP
+	extern struct plat_smp_ops vsmp_smp_ops;
+
+	register_smp_ops(&vsmp_smp_ops);
+
+	return 0;
+#else
+	return -ENODEV;
+#endif
+}
 
 #endif /* __ASM_SMP_OPS_H */
diff --git a/arch/mips/mipssim/sim_setup.c b/arch/mips/mipssim/sim_setup.c
index 55f22a3..1970069 100644
--- a/arch/mips/mipssim/sim_setup.c
+++ b/arch/mips/mipssim/sim_setup.c
@@ -59,18 +59,17 @@ void __init prom_init(void)
 
 	prom_meminit();
 
-#ifdef CONFIG_MIPS_MT_SMP
-	if (cpu_has_mipsmt)
-		register_smp_ops(&vsmp_smp_ops);
-	else
-		register_smp_ops(&up_smp_ops);
-#endif
+	if (cpu_has_mipsmt) {
+		if (!register_vsmp_smp_ops())
+			return;
+
 #ifdef CONFIG_MIPS_MT_SMTC
-	if (cpu_has_mipsmt)
 		register_smp_ops(&ssmtc_smp_ops);
-	else
-		register_smp_ops(&up_smp_ops);
+			return;
 #endif
+	}
+
+	register_up_smp_ops();
 }
 
 static void __init serial_init(void)
diff --git a/arch/mips/mti-malta/malta-init.c b/arch/mips/mti-malta/malta-init.c
index 31180c3..4163d09e 100644
--- a/arch/mips/mti-malta/malta-init.c
+++ b/arch/mips/mti-malta/malta-init.c
@@ -358,15 +358,14 @@ void __init prom_init(void)
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 	console_config();
 #endif
-#ifdef CONFIG_MIPS_CMP
 	/* Early detection of CMP support */
 	if (gcmp_probe(GCMP_BASE_ADDR, GCMP_ADDRSPACE_SZ))
-		register_smp_ops(&cmp_smp_ops);
-	else
-#endif
-#ifdef CONFIG_MIPS_MT_SMP
-		register_smp_ops(&vsmp_smp_ops);
-#endif
+		if (!register_cmp_smp_ops())
+			return;
+
+	if (!register_vsmp_smp_ops())
+		return;
+
 #ifdef CONFIG_MIPS_MT_SMTC
 	register_smp_ops(&msmtc_smp_ops);
 #endif
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_setup.c b/arch/mips/pmc-sierra/msp71xx/msp_setup.c
index 2413ea6..0abfbe0 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_setup.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_setup.c
@@ -228,13 +228,11 @@ void __init prom_init(void)
 	 */
 	msp_serial_setup();
 
-#ifdef CONFIG_MIPS_MT_SMP
-	register_smp_ops(&vsmp_smp_ops);
-#endif
-
+	if (register_vsmp_smp_ops()) {
 #ifdef CONFIG_MIPS_MT_SMTC
-	register_smp_ops(&msp_smtc_smp_ops);
+		register_smp_ops(&msp_smtc_smp_ops);
 #endif
+	}
 
 #ifdef CONFIG_PMCTWILED
 	/*
