Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jan 2010 00:54:34 +0100 (CET)
Received: from ey-out-1920.google.com ([74.125.78.145]:19007 "EHLO
        ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493230Ab0ASXya (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jan 2010 00:54:30 +0100
Received: by ey-out-1920.google.com with SMTP id 26so824749eyw.52
        for <multiple recipients>; Tue, 19 Jan 2010 15:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=QSo3TI4PFMVousZYRi4mp05EtgxCupv0puaNluhr+jU=;
        b=TJ8Ckw7s5Z/nulGUBleMQQ1YsEbLAXOLIv2cTjtpxaZjU+ba7zSlLv6TnJXbLPpXFh
         X4APObFzvNFVGkfumNstVKCD86zgb55u/cLlk2VdsdDg+AQCYNdslndhV9HTLYmXdGiy
         kOl93xygrXUpclArkPdXn/h6GV0ZIF/F6Dxeg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=VeL0biyG8gbeLaLN187U2b+/0C67F/oMrnjYc5RS1N9BXyGv/sk0Wj9m4+FreRnAWP
         4m66jkp+jiSUAlD1j0R//hE7kWBNu+KVQmAEIVdikCSNuOGx3gp0TJN1hxMRpF88R/WP
         VQ536aTkfQ8vocGxvNhVCj9Ked/ovvjYzoZYM=
Received: by 10.213.100.167 with SMTP id y39mr9106969ebn.70.1263945269553;
        Tue, 19 Jan 2010 15:54:29 -0800 (PST)
Received: from zoinx.mars (d133062.upc-d.chello.nl [213.46.133.62])
        by mx.google.com with ESMTPS id 10sm7945352eyd.21.2010.01.19.15.54.28
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 19 Jan 2010 15:54:29 -0800 (PST)
Message-ID: <4B56475F.8070608@gmail.com>
Date:   Wed, 20 Jan 2010 00:59:27 +0100
From:   Roel Kluin <roel.kluin@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091209 Fedora/3.0-4.fc12 Thunderbird/3.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] MIPS: cleanup switches with cases that can be merged
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 25615
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: roel.kluin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 12894

I did a search for switch statements with cases that can be merged, but maybe
some were not intended?
---------------->8------------------------------------------8<-----------------
In these cases the same code was executed.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 arch/mips/include/asm/octeon/octeon-feature.h |    8 ++------
 arch/mips/kernel/cpu-probe.c                  |    3 ---
 arch/mips/math-emu/ieee754dp.c                |    1 -
 arch/mips/math-emu/ieee754sp.c                |    1 -
 arch/mips/pci/pci-octeon.c                    |    6 ++----
 arch/mips/powertv/asic/asic_devices.c         |    4 ----
 arch/mips/sgi-ip32/ip32-irq.c                 |    9 +--------
 7 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/arch/mips/include/asm/octeon/octeon-feature.h b/arch/mips/include/asm/octeon/octeon-feature.h
index ef24a7b..cba6fbe 100644
--- a/arch/mips/include/asm/octeon/octeon-feature.h
+++ b/arch/mips/include/asm/octeon/octeon-feature.h
@@ -99,6 +99,8 @@ static inline int octeon_has_feature(enum octeon_feature feature)
 		return !cvmx_fuse_read(90);
 
 	case OCTEON_FEATURE_PCIE:
+	case OCTEON_FEATURE_MGMT_PORT:
+	case OCTEON_FEATURE_RAID:
 		return OCTEON_IS_MODEL(OCTEON_CN56XX)
 			|| OCTEON_IS_MODEL(OCTEON_CN52XX);
 
@@ -110,12 +112,6 @@ static inline int octeon_has_feature(enum octeon_feature feature)
 	case OCTEON_FEATURE_TRA:
 		return !(OCTEON_IS_MODEL(OCTEON_CN30XX)
 			 || OCTEON_IS_MODEL(OCTEON_CN50XX));
-	case OCTEON_FEATURE_MGMT_PORT:
-		return OCTEON_IS_MODEL(OCTEON_CN56XX)
-			|| OCTEON_IS_MODEL(OCTEON_CN52XX);
-	case OCTEON_FEATURE_RAID:
-		return OCTEON_IS_MODEL(OCTEON_CN56XX)
-			|| OCTEON_IS_MODEL(OCTEON_CN52XX);
 	case OCTEON_FEATURE_USB:
 		return !(OCTEON_IS_MODEL(OCTEON_CN38XX)
 			 || OCTEON_IS_MODEL(OCTEON_CN58XX));
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 80e202e..603e3bd 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -722,9 +722,6 @@ static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "MIPS 4Kc";
 		break;
 	case PRID_IMP_4KEC:
-		c->cputype = CPU_4KEC;
-		__cpu_name[cpu] = "MIPS 4KEc";
-		break;
 	case PRID_IMP_4KECR2:
 		c->cputype = CPU_4KEC;
 		__cpu_name[cpu] = "MIPS 4KEc";
diff --git a/arch/mips/math-emu/ieee754dp.c b/arch/mips/math-emu/ieee754dp.c
index 6d2d89f..2f22fd7 100644
--- a/arch/mips/math-emu/ieee754dp.c
+++ b/arch/mips/math-emu/ieee754dp.c
@@ -148,7 +148,6 @@ ieee754dp ieee754dp_format(int sn, int xe, u64 xm)
 
 			switch(ieee754_csr.rm) {
 			case IEEE754_RN:
-				return ieee754dp_zero(sn);
 			case IEEE754_RZ:
 				return ieee754dp_zero(sn);
 			case IEEE754_RU:    /* toward +Infinity */
diff --git a/arch/mips/math-emu/ieee754sp.c b/arch/mips/math-emu/ieee754sp.c
index 4635340..a19b721 100644
--- a/arch/mips/math-emu/ieee754sp.c
+++ b/arch/mips/math-emu/ieee754sp.c
@@ -149,7 +149,6 @@ ieee754sp ieee754sp_format(int sn, int xe, unsigned xm)
 
 			switch(ieee754_csr.rm) {
 			case IEEE754_RN:
-				return ieee754sp_zero(sn);
 			case IEEE754_RZ:
 				return ieee754sp_zero(sn);
 			case IEEE754_RU:      /* toward +Infinity */
diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index 9cb0c80..d248b70 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -209,16 +209,14 @@ const char *octeon_get_pci_interrupts(void)
 	case CVMX_BOARD_TYPE_NAO38:
 		/* This is really the NAC38 */
 		return "AAAAADABAAAAAAAAAAAAAAAAAAAAAAAA";
-	case CVMX_BOARD_TYPE_THUNDER:
-		return "";
-	case CVMX_BOARD_TYPE_EBH3000:
-		return "";
 	case CVMX_BOARD_TYPE_EBH3100:
 	case CVMX_BOARD_TYPE_CN3010_EVB_HS5:
 	case CVMX_BOARD_TYPE_CN3005_EVB_HS5:
 		return "AAABAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
 	case CVMX_BOARD_TYPE_BBGW_REF:
 		return "AABCD";
+	case CVMX_BOARD_TYPE_THUNDER:
+	case CVMX_BOARD_TYPE_EBH3000:
 	default:
 		return "";
 	}
diff --git a/arch/mips/powertv/asic/asic_devices.c b/arch/mips/powertv/asic/asic_devices.c
index bae8288..36dbcad 100644
--- a/arch/mips/powertv/asic/asic_devices.c
+++ b/arch/mips/powertv/asic/asic_devices.c
@@ -340,10 +340,6 @@ static void __init platform_configure_usb(void)
 
 	switch (asic) {
 	case ASIC_ZEUS:
-		fs_update(0x0000, 0x11, 0x02, 0);
-		bcm1_usb2_ctl = 0x803;
-		break;
-
 	case ASIC_CRONUS:
 	case ASIC_CRONUSLITE:
 		fs_update(0x0000, 0x11, 0x02, 0);
diff --git a/arch/mips/sgi-ip32/ip32-irq.c b/arch/mips/sgi-ip32/ip32-irq.c
index 5c2bf11..d8b6520 100644
--- a/arch/mips/sgi-ip32/ip32-irq.c
+++ b/arch/mips/sgi-ip32/ip32-irq.c
@@ -512,10 +512,6 @@ void __init arch_init_irq(void)
 				"level");
 			break;
 
-		case CRIME_GBE0_IRQ ... CRIME_GBE3_IRQ:
-			set_irq_chip_and_handler_name(irq,
-				&crime_edge_interrupt, handle_edge_irq, "edge");
-			break;
 		case CRIME_CPUERR_IRQ:
 		case CRIME_MEMERR_IRQ:
 			set_irq_chip_and_handler_name(irq,
@@ -523,12 +519,9 @@ void __init arch_init_irq(void)
 				"level");
 			break;
 
+		case CRIME_GBE0_IRQ ... CRIME_GBE3_IRQ:
 		case CRIME_RE_EMPTY_E_IRQ ... CRIME_RE_IDLE_E_IRQ:
 		case CRIME_SOFT0_IRQ ... CRIME_SOFT2_IRQ:
-			set_irq_chip_and_handler_name(irq,
-				&crime_edge_interrupt, handle_edge_irq, "edge");
-			break;
-
 		case CRIME_VICE_IRQ:
 			set_irq_chip_and_handler_name(irq,
 				&crime_edge_interrupt, handle_edge_irq, "edge");
