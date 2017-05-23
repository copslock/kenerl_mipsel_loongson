Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 May 2017 14:37:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51125 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993915AbdEWMhrVjAGF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 May 2017 14:37:47 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 430E6320D709E;
        Tue, 23 May 2017 13:37:38 +0100 (IST)
Received: from [10.20.78.51] (10.20.78.51) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Tue, 23 May 2017
 13:37:40 +0100
Date:   Tue, 23 May 2017 13:37:05 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 1/4] MIPS16e2: Identify ASE presence
In-Reply-To: <alpine.DEB.2.00.1705180145220.2590@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1705230023360.2590@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1705180145220.2590@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.51]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

Identify the presence of the MIPS16e2 ASE as per the architecture 
specification[1], by checking for CP0 Config5.CA2 bit being 1[2].

References:

[1] "MIPS32 Architecture for Programmers: MIPS16e2 Application-Specific
    Extension Technical Reference Manual", Imagination Technologies
    Ltd., Document Number: MD01172, Revision 01.00, April 26, 2016,
    Section 1.2 "Software Detection of the ASE", p. 5

[2] "MIPS32 interAptiv Multiprocessing System Software User's Manual",
    Imagination Technologies Ltd., Document Number: MD00904, Revision 
    02.01, June 15, 2016, Section 2.2.1.6 "Device Configuration 5 -- 
    Config5 (CP0 Register 16, Select 5)", pp. 71-72

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
 NB the designation of the CP0 Config5.CA2 bit has not yet made it to a 
published release of the architecture specification, so the definition in 
the interAptiv MR2 core manual will have to do for the time being.

  Maciej

linux-mips16e2-ase-ident.diff
Index: linux-sfr-test/arch/mips/include/asm/cpu-features.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/cpu-features.h	2017-05-22 22:42:15.904852000 +0100
+++ linux-sfr-test/arch/mips/include/asm/cpu-features.h	2017-05-22 22:48:43.819622000 +0100
@@ -138,6 +138,9 @@
 #ifndef cpu_has_mips16
 #define cpu_has_mips16		(cpu_data[0].ases & MIPS_ASE_MIPS16)
 #endif
+#ifndef cpu_has_mips16e2
+#define cpu_has_mips16e2	(cpu_data[0].ases & MIPS_ASE_MIPS16E2)
+#endif
 #ifndef cpu_has_mdmx
 #define cpu_has_mdmx		(cpu_data[0].ases & MIPS_ASE_MDMX)
 #endif
Index: linux-sfr-test/arch/mips/include/asm/cpu.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/cpu.h	2017-05-22 22:42:15.905865000 +0100
+++ linux-sfr-test/arch/mips/include/asm/cpu.h	2017-05-22 22:48:43.827611000 +0100
@@ -430,5 +430,6 @@ enum cpu_type_enum {
 #define MIPS_ASE_VZ		0x00000080 /* Virtualization ASE */
 #define MIPS_ASE_MSA		0x00000100 /* MIPS SIMD Architecture */
 #define MIPS_ASE_DSP3		0x00000200 /* Signal Processing ASE Rev 3*/
+#define MIPS_ASE_MIPS16E2	0x00000400 /* MIPS16e2 */
 
 #endif /* _ASM_CPU_H */
Index: linux-sfr-test/arch/mips/include/asm/mipsregs.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/mipsregs.h	2017-05-22 22:42:16.046860000 +0100
+++ linux-sfr-test/arch/mips/include/asm/mipsregs.h	2017-05-22 22:48:43.766613000 +0100
@@ -652,6 +652,7 @@
 #define MIPS_CONF5_SBRI		(_ULCAST_(1) << 6)
 #define MIPS_CONF5_FRE		(_ULCAST_(1) << 8)
 #define MIPS_CONF5_UFE		(_ULCAST_(1) << 9)
+#define MIPS_CONF5_CA2		(_ULCAST_(1) << 14)
 #define MIPS_CONF5_MSAEN	(_ULCAST_(1) << 27)
 #define MIPS_CONF5_EVA		(_ULCAST_(1) << 28)
 #define MIPS_CONF5_CV		(_ULCAST_(1) << 29)
Index: linux-sfr-test/arch/mips/kernel/cpu-probe.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/cpu-probe.c	2017-05-22 22:41:59.908735000 +0100
+++ linux-sfr-test/arch/mips/kernel/cpu-probe.c	2017-05-22 22:48:43.798611000 +0100
@@ -861,6 +861,8 @@ static inline unsigned int decode_config
 		c->options |= MIPS_CPU_MVH;
 	if (cpu_has_mips_r6 && (config5 & MIPS_CONF5_VP))
 		c->options |= MIPS_CPU_VP;
+	if (config5 & MIPS_CONF5_CA2)
+		c->ases |= MIPS_ASE_MIPS16E2;
 
 	return config5 & MIPS_CONF_M;
 }
