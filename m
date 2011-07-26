Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jul 2011 20:05:17 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:53351 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490962Ab1GZSFK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jul 2011 20:05:10 +0200
Received: by gwb1 with SMTP id 1so512417gwb.36
        for <multiple recipients>; Tue, 26 Jul 2011 11:05:03 -0700 (PDT)
Received: by 10.90.249.40 with SMTP id w40mr5973202agh.4.1311703503501;
        Tue, 26 Jul 2011 11:05:03 -0700 (PDT)
Received: from [192.168.6.91] ([64.134.25.244])
        by mx.google.com with ESMTPS id j20sm578239anb.0.2011.07.26.11.05.01
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 11:05:02 -0700 (PDT)
Message-ID: <4E2F01CB.7090206@landley.net>
Date:   Tue, 26 Jul 2011 13:04:59 -0500
From:   Rob Landley <rob@landley.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Thunderbird/3.1.11
MIME-Version: 1.0
To:     ralf@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Mips still broken in v3.0 with v2.6.39 bug?
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 30729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rob@landley.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18947

I still need to apply this patch:

Date: Fri, 27 May 2011 15:00:11 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: MIPS panic in 2.6.39 (bisected to 7eaceaccab5f)
Message-ID: <20110527140011.GF30117@linux-mips.org>
References: <4DDB5673.5060206@landley.net>
 <20110524143937.GB30117@linux-mips.org>
 <4DDCB1EB.4020707@landley.net>
 <20110527075512.GE30117@linux-mips.org>
In-Reply-To: <20110527075512.GE30117@linux-mips.org>

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
 arch/mips/mti-malta/malta-init.c         |   14 +++++-----
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
index 31180c3..3a73d69 100644
--- a/arch/mips/mti-malta/malta-init.c
+++ b/arch/mips/mti-malta/malta-init.c
@@ -29,6 +29,7 @@
 #include <asm/system.h>
 #include <asm/cacheflush.h>
 #include <asm/traps.h>
+#include <asm/smp-ops.h>
 
 #include <asm/gcmpregs.h>
 #include <asm/mips-boards/prom.h>
@@ -358,15 +359,14 @@ void __init prom_init(void)
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
