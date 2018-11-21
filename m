Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Nov 2018 23:38:13 +0100 (CET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:58432 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993964AbeKUWiCDW0E- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Nov 2018 23:38:02 +0100
Received: from localhost.localdomain (85-76-84-147-nat.elisa-mobile.fi [85.76.84.147])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id C018B20081;
        Thu, 22 Nov 2018 00:38:01 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 06/24] MIPS: OCTEON: delete unused loopback configuration functions
Date:   Thu, 22 Nov 2018 00:37:27 +0200
Message-Id: <20181121223745.22792-7-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181121223745.22792-1-aaro.koskinen@iki.fi>
References: <20181121223745.22792-1-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Delete unused loopback configuration functions.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 .../executive/cvmx-helper-rgmii.c             | 68 -------------------
 .../executive/cvmx-helper-sgmii.c             | 38 -----------
 .../executive/cvmx-helper-xaui.c              | 39 -----------
 .../cavium-octeon/executive/cvmx-helper.c     | 54 ---------------
 arch/mips/include/asm/octeon/cvmx-gmxx-defs.h | 26 -------
 .../include/asm/octeon/cvmx-helper-rgmii.h    | 17 -----
 .../include/asm/octeon/cvmx-helper-sgmii.h    | 17 -----
 .../include/asm/octeon/cvmx-helper-xaui.h     | 16 -----
 arch/mips/include/asm/octeon/cvmx-helper.h    | 16 -----
 9 files changed, 291 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c b/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
index b8898e2b8a6f..e812ed9a03bb 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
@@ -449,71 +449,3 @@ int __cvmx_helper_rgmii_link_set(int ipd_port,
 
 	return result;
 }
-
-/**
- * Configure a port for internal and/or external loopback. Internal loopback
- * causes packets sent by the port to be received by Octeon. External loopback
- * causes packets received from the wire to sent out again.
- *
- * @ipd_port: IPD/PKO port to loopback.
- * @enable_internal:
- *		   Non zero if you want internal loopback
- * @enable_external:
- *		   Non zero if you want external loopback
- *
- * Returns Zero on success, negative on failure.
- */
-int __cvmx_helper_rgmii_configure_loopback(int ipd_port, int enable_internal,
-					   int enable_external)
-{
-	int interface = cvmx_helper_get_interface_num(ipd_port);
-	int index = cvmx_helper_get_interface_index_num(ipd_port);
-	int original_enable;
-	union cvmx_gmxx_prtx_cfg gmx_cfg;
-	union cvmx_asxx_prt_loop asxx_prt_loop;
-
-	/* Read the current enable state and save it */
-	gmx_cfg.u64 = cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
-	original_enable = gmx_cfg.s.en;
-	/* Force port to be disabled */
-	gmx_cfg.s.en = 0;
-	if (enable_internal) {
-		/* Force speed if we're doing internal loopback */
-		gmx_cfg.s.duplex = 1;
-		gmx_cfg.s.slottime = 1;
-		gmx_cfg.s.speed = 1;
-		cvmx_write_csr(CVMX_GMXX_TXX_CLK(index, interface), 1);
-		cvmx_write_csr(CVMX_GMXX_TXX_SLOT(index, interface), 0x200);
-		cvmx_write_csr(CVMX_GMXX_TXX_BURST(index, interface), 0x2000);
-	}
-	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface), gmx_cfg.u64);
-
-	/* Set the loopback bits */
-	asxx_prt_loop.u64 = cvmx_read_csr(CVMX_ASXX_PRT_LOOP(interface));
-	if (enable_internal)
-		asxx_prt_loop.s.int_loop |= 1 << index;
-	else
-		asxx_prt_loop.s.int_loop &= ~(1 << index);
-	if (enable_external)
-		asxx_prt_loop.s.ext_loop |= 1 << index;
-	else
-		asxx_prt_loop.s.ext_loop &= ~(1 << index);
-	cvmx_write_csr(CVMX_ASXX_PRT_LOOP(interface), asxx_prt_loop.u64);
-
-	/* Force enables in internal loopback */
-	if (enable_internal) {
-		uint64_t tmp;
-		tmp = cvmx_read_csr(CVMX_ASXX_TX_PRT_EN(interface));
-		cvmx_write_csr(CVMX_ASXX_TX_PRT_EN(interface),
-			       (1 << index) | tmp);
-		tmp = cvmx_read_csr(CVMX_ASXX_RX_PRT_EN(interface));
-		cvmx_write_csr(CVMX_ASXX_RX_PRT_EN(interface),
-			       (1 << index) | tmp);
-		original_enable = 1;
-	}
-
-	/* Restore the enable state */
-	gmx_cfg.s.en = original_enable;
-	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface), gmx_cfg.u64);
-	return 0;
-}
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c b/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
index a176358c5a21..f6ebf63dc84c 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
@@ -513,41 +513,3 @@ int __cvmx_helper_sgmii_link_set(int ipd_port,
 	return __cvmx_helper_sgmii_hardware_init_link_speed(interface, index,
 							    link_info);
 }
-
-/**
- * Configure a port for internal and/or external loopback. Internal
- * loopback causes packets sent by the port to be received by
- * Octeon. External loopback causes packets received from the wire to
- * sent out again.
- *
- * @ipd_port: IPD/PKO port to loopback.
- * @enable_internal:
- *		   Non zero if you want internal loopback
- * @enable_external:
- *		   Non zero if you want external loopback
- *
- * Returns Zero on success, negative on failure.
- */
-int __cvmx_helper_sgmii_configure_loopback(int ipd_port, int enable_internal,
-					   int enable_external)
-{
-	int interface = cvmx_helper_get_interface_num(ipd_port);
-	int index = cvmx_helper_get_interface_index_num(ipd_port);
-	union cvmx_pcsx_mrx_control_reg pcsx_mrx_control_reg;
-	union cvmx_pcsx_miscx_ctl_reg pcsx_miscx_ctl_reg;
-
-	pcsx_mrx_control_reg.u64 =
-	    cvmx_read_csr(CVMX_PCSX_MRX_CONTROL_REG(index, interface));
-	pcsx_mrx_control_reg.s.loopbck1 = enable_internal;
-	cvmx_write_csr(CVMX_PCSX_MRX_CONTROL_REG(index, interface),
-		       pcsx_mrx_control_reg.u64);
-
-	pcsx_miscx_ctl_reg.u64 =
-	    cvmx_read_csr(CVMX_PCSX_MISCX_CTL_REG(index, interface));
-	pcsx_miscx_ctl_reg.s.loopbck2 = enable_external;
-	cvmx_write_csr(CVMX_PCSX_MISCX_CTL_REG(index, interface),
-		       pcsx_miscx_ctl_reg.u64);
-
-	__cvmx_helper_sgmii_hardware_init_link(interface, index);
-	return 0;
-}
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c b/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
index 2bb6912a580d..93a498d05184 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
@@ -319,42 +319,3 @@ int __cvmx_helper_xaui_link_set(int ipd_port, cvmx_helper_link_info_t link_info)
 	/* Bring the link up */
 	return __cvmx_helper_xaui_enable(interface);
 }
-
-/**
- * Configure a port for internal and/or external loopback. Internal loopback
- * causes packets sent by the port to be received by Octeon. External loopback
- * causes packets received from the wire to sent out again.
- *
- * @ipd_port: IPD/PKO port to loopback.
- * @enable_internal:
- *		   Non zero if you want internal loopback
- * @enable_external:
- *		   Non zero if you want external loopback
- *
- * Returns Zero on success, negative on failure.
- */
-extern int __cvmx_helper_xaui_configure_loopback(int ipd_port,
-						 int enable_internal,
-						 int enable_external)
-{
-	int interface = cvmx_helper_get_interface_num(ipd_port);
-	union cvmx_pcsxx_control1_reg pcsxx_control1_reg;
-	union cvmx_gmxx_xaui_ext_loopback gmxx_xaui_ext_loopback;
-
-	/* Set the internal loop */
-	pcsxx_control1_reg.u64 =
-	    cvmx_read_csr(CVMX_PCSXX_CONTROL1_REG(interface));
-	pcsxx_control1_reg.s.loopbck1 = enable_internal;
-	cvmx_write_csr(CVMX_PCSXX_CONTROL1_REG(interface),
-		       pcsxx_control1_reg.u64);
-
-	/* Set the external loop */
-	gmxx_xaui_ext_loopback.u64 =
-	    cvmx_read_csr(CVMX_GMXX_XAUI_EXT_LOOPBACK(interface));
-	gmxx_xaui_ext_loopback.s.en = enable_external;
-	cvmx_write_csr(CVMX_GMXX_XAUI_EXT_LOOPBACK(interface),
-		       gmxx_xaui_ext_loopback.u64);
-
-	/* Take the link through a reset */
-	return __cvmx_helper_xaui_enable(interface);
-}
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
index f7ceaf53e57c..11f5fb4e0736 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -1239,57 +1239,3 @@ int cvmx_helper_link_set(int ipd_port, cvmx_helper_link_info_t link_info)
 	return result;
 }
 EXPORT_SYMBOL_GPL(cvmx_helper_link_set);
-
-/**
- * Configure a port for internal and/or external loopback. Internal loopback
- * causes packets sent by the port to be received by Octeon. External loopback
- * causes packets received from the wire to sent out again.
- *
- * @ipd_port: IPD/PKO port to loopback.
- * @enable_internal:
- *		   Non zero if you want internal loopback
- * @enable_external:
- *		   Non zero if you want external loopback
- *
- * Returns Zero on success, negative on failure.
- */
-int cvmx_helper_configure_loopback(int ipd_port, int enable_internal,
-				   int enable_external)
-{
-	int result = -1;
-	int interface = cvmx_helper_get_interface_num(ipd_port);
-	int index = cvmx_helper_get_interface_index_num(ipd_port);
-
-	if (index >= cvmx_helper_ports_on_interface(interface))
-		return -1;
-
-	switch (cvmx_helper_interface_get_mode(interface)) {
-	case CVMX_HELPER_INTERFACE_MODE_DISABLED:
-	case CVMX_HELPER_INTERFACE_MODE_PCIE:
-	case CVMX_HELPER_INTERFACE_MODE_SPI:
-	case CVMX_HELPER_INTERFACE_MODE_NPI:
-	case CVMX_HELPER_INTERFACE_MODE_LOOP:
-		break;
-	case CVMX_HELPER_INTERFACE_MODE_XAUI:
-		result =
-		    __cvmx_helper_xaui_configure_loopback(ipd_port,
-							  enable_internal,
-							  enable_external);
-		break;
-	case CVMX_HELPER_INTERFACE_MODE_RGMII:
-	case CVMX_HELPER_INTERFACE_MODE_GMII:
-		result =
-		    __cvmx_helper_rgmii_configure_loopback(ipd_port,
-							   enable_internal,
-							   enable_external);
-		break;
-	case CVMX_HELPER_INTERFACE_MODE_SGMII:
-	case CVMX_HELPER_INTERFACE_MODE_PICMG:
-		result =
-		    __cvmx_helper_sgmii_configure_loopback(ipd_port,
-							   enable_internal,
-							   enable_external);
-		break;
-	}
-	return result;
-}
diff --git a/arch/mips/include/asm/octeon/cvmx-gmxx-defs.h b/arch/mips/include/asm/octeon/cvmx-gmxx-defs.h
index 80e4f8358b81..1c1eb7e4489b 100644
--- a/arch/mips/include/asm/octeon/cvmx-gmxx-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-gmxx-defs.h
@@ -6902,30 +6902,4 @@ union cvmx_gmxx_tx_xaui_ctl {
 	struct cvmx_gmxx_tx_xaui_ctl_s cnf71xx;
 };
 
-union cvmx_gmxx_xaui_ext_loopback {
-	uint64_t u64;
-	struct cvmx_gmxx_xaui_ext_loopback_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_5_63:59;
-		uint64_t en:1;
-		uint64_t thresh:4;
-#else
-		uint64_t thresh:4;
-		uint64_t en:1;
-		uint64_t reserved_5_63:59;
-#endif
-	} s;
-	struct cvmx_gmxx_xaui_ext_loopback_s cn52xx;
-	struct cvmx_gmxx_xaui_ext_loopback_s cn52xxp1;
-	struct cvmx_gmxx_xaui_ext_loopback_s cn56xx;
-	struct cvmx_gmxx_xaui_ext_loopback_s cn56xxp1;
-	struct cvmx_gmxx_xaui_ext_loopback_s cn61xx;
-	struct cvmx_gmxx_xaui_ext_loopback_s cn63xx;
-	struct cvmx_gmxx_xaui_ext_loopback_s cn63xxp1;
-	struct cvmx_gmxx_xaui_ext_loopback_s cn66xx;
-	struct cvmx_gmxx_xaui_ext_loopback_s cn68xx;
-	struct cvmx_gmxx_xaui_ext_loopback_s cn68xxp1;
-	struct cvmx_gmxx_xaui_ext_loopback_s cnf71xx;
-};
-
 #endif
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-rgmii.h b/arch/mips/include/asm/octeon/cvmx-helper-rgmii.h
index f7a95d7de140..ac42b5066bd9 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-rgmii.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper-rgmii.h
@@ -90,21 +90,4 @@ extern cvmx_helper_link_info_t __cvmx_helper_rgmii_link_get(int ipd_port);
 extern int __cvmx_helper_rgmii_link_set(int ipd_port,
 					cvmx_helper_link_info_t link_info);
 
-/**
- * Configure a port for internal and/or external loopback. Internal loopback
- * causes packets sent by the port to be received by Octeon. External loopback
- * causes packets received from the wire to sent out again.
- *
- * @ipd_port: IPD/PKO port to loopback.
- * @enable_internal:
- *		   Non zero if you want internal loopback
- * @enable_external:
- *		   Non zero if you want external loopback
- *
- * Returns Zero on success, negative on failure.
- */
-extern int __cvmx_helper_rgmii_configure_loopback(int ipd_port,
-						  int enable_internal,
-						  int enable_external);
-
 #endif
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-sgmii.h b/arch/mips/include/asm/octeon/cvmx-helper-sgmii.h
index 63fd21335e4b..3a54dea58c0a 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-sgmii.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper-sgmii.h
@@ -84,21 +84,4 @@ extern cvmx_helper_link_info_t __cvmx_helper_sgmii_link_get(int ipd_port);
 extern int __cvmx_helper_sgmii_link_set(int ipd_port,
 					cvmx_helper_link_info_t link_info);
 
-/**
- * Configure a port for internal and/or external loopback. Internal loopback
- * causes packets sent by the port to be received by Octeon. External loopback
- * causes packets received from the wire to sent out again.
- *
- * @ipd_port: IPD/PKO port to loopback.
- * @enable_internal:
- *		   Non zero if you want internal loopback
- * @enable_external:
- *		   Non zero if you want external loopback
- *
- * Returns Zero on success, negative on failure.
- */
-extern int __cvmx_helper_sgmii_configure_loopback(int ipd_port,
-						  int enable_internal,
-						  int enable_external);
-
 #endif
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-xaui.h b/arch/mips/include/asm/octeon/cvmx-helper-xaui.h
index f8ce53f6f28f..51f45b495680 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-xaui.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper-xaui.h
@@ -84,20 +84,4 @@ extern cvmx_helper_link_info_t __cvmx_helper_xaui_link_get(int ipd_port);
 extern int __cvmx_helper_xaui_link_set(int ipd_port,
 				       cvmx_helper_link_info_t link_info);
 
-/**
- * Configure a port for internal and/or external loopback. Internal loopback
- * causes packets sent by the port to be received by Octeon. External loopback
- * causes packets received from the wire to sent out again.
- *
- * @ipd_port: IPD/PKO port to loopback.
- * @enable_internal:
- *		   Non zero if you want internal loopback
- * @enable_external:
- *		   Non zero if you want external loopback
- *
- * Returns Zero on success, negative on failure.
- */
-extern int __cvmx_helper_xaui_configure_loopback(int ipd_port,
-						 int enable_internal,
-						 int enable_external);
 #endif
diff --git a/arch/mips/include/asm/octeon/cvmx-helper.h b/arch/mips/include/asm/octeon/cvmx-helper.h
index 0ed87cb67e7f..f77d946d482e 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper.h
@@ -195,20 +195,4 @@ extern int cvmx_helper_link_set(int ipd_port,
 extern int cvmx_helper_interface_probe(int interface);
 extern int cvmx_helper_interface_enumerate(int interface);
 
-/**
- * Configure a port for internal and/or external loopback. Internal loopback
- * causes packets sent by the port to be received by Octeon. External loopback
- * causes packets received from the wire to sent out again.
- *
- * @ipd_port: IPD/PKO port to loopback.
- * @enable_internal:
- *		   Non zero if you want internal loopback
- * @enable_external:
- *		   Non zero if you want external loopback
- *
- * Returns Zero on success, negative on failure.
- */
-extern int cvmx_helper_configure_loopback(int ipd_port, int enable_internal,
-					  int enable_external);
-
 #endif /* __CVMX_HELPER_H__ */
-- 
2.17.0
