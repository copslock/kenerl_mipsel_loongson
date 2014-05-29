Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 12:10:40 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61616 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6819165AbaE2KKYEFPFm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 May 2014 12:10:24 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8009518DEA534;
        Thu, 29 May 2014 11:10:14 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 29 May 2014 11:10:16 +0100
Received: from asmith-linux.le.imgtec.org (192.168.154.62) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Thu, 29 May 2014 11:10:16 +0100
From:   Alex Smith <alex.smith@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>
Subject: [PATCH 1/3] MIPS: octeon: Add interface mode detection for Octeon II
Date:   Thu, 29 May 2014 11:10:01 +0100
Message-ID: <1401358203-60225-2-git-send-email-alex.smith@imgtec.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1401358203-60225-1-git-send-email-alex.smith@imgtec.com>
References: <1401358203-60225-1-git-send-email-alex.smith@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.62]
Return-Path: <Alex.Smith@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.smith@imgtec.com
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

Add interface mode detection for Octeon II. This is necessary to detect
the interface modes correctly on the UBNT E200 board. Code is taken
from the UBNT GPL source release, with some alterations: SRIO, ILK and
RXAUI interface modes are removed and instead return disabled as these
modes are not currently supported.

Tested-by: David Daney <david.daney@cavium.com>
Signed-off-by: Alex Smith <alex.smith@imgtec.com>
---
 arch/mips/cavium-octeon/executive/cvmx-helper.c | 166 ++++++++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
index 8553ad5..7e5cf7a 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -106,6 +106,158 @@ int cvmx_helper_ports_on_interface(int interface)
 EXPORT_SYMBOL_GPL(cvmx_helper_ports_on_interface);
 
 /**
+ * @INTERNAL
+ * Return interface mode for CN68xx.
+ */
+static cvmx_helper_interface_mode_t __cvmx_get_mode_cn68xx(int interface)
+{
+	union cvmx_mio_qlmx_cfg qlm_cfg;
+	switch (interface) {
+	case 0:
+		qlm_cfg.u64 = cvmx_read_csr(CVMX_MIO_QLMX_CFG(0));
+		/* QLM is disabled when QLM SPD is 15. */
+		if (qlm_cfg.s.qlm_spd == 15)
+			return CVMX_HELPER_INTERFACE_MODE_DISABLED;
+
+		if (qlm_cfg.s.qlm_cfg == 2)
+			return CVMX_HELPER_INTERFACE_MODE_SGMII;
+		else if (qlm_cfg.s.qlm_cfg == 3)
+			return CVMX_HELPER_INTERFACE_MODE_XAUI;
+		else
+			return CVMX_HELPER_INTERFACE_MODE_DISABLED;
+	case 2:
+	case 3:
+	case 4:
+		qlm_cfg.u64 = cvmx_read_csr(CVMX_MIO_QLMX_CFG(interface));
+		/* QLM is disabled when QLM SPD is 15. */
+		if (qlm_cfg.s.qlm_spd == 15)
+			return CVMX_HELPER_INTERFACE_MODE_DISABLED;
+
+		if (qlm_cfg.s.qlm_cfg == 2)
+			return CVMX_HELPER_INTERFACE_MODE_SGMII;
+		else if (qlm_cfg.s.qlm_cfg == 3)
+			return CVMX_HELPER_INTERFACE_MODE_XAUI;
+		else
+			return CVMX_HELPER_INTERFACE_MODE_DISABLED;
+	case 7:
+		qlm_cfg.u64 = cvmx_read_csr(CVMX_MIO_QLMX_CFG(3));
+		/* QLM is disabled when QLM SPD is 15. */
+		if (qlm_cfg.s.qlm_spd == 15) {
+			return CVMX_HELPER_INTERFACE_MODE_DISABLED;
+		} else if (qlm_cfg.s.qlm_cfg != 0) {
+			qlm_cfg.u64 = cvmx_read_csr(CVMX_MIO_QLMX_CFG(1));
+			if (qlm_cfg.s.qlm_cfg != 0)
+				return CVMX_HELPER_INTERFACE_MODE_DISABLED;
+		}
+		return CVMX_HELPER_INTERFACE_MODE_NPI;
+	case 8:
+		return CVMX_HELPER_INTERFACE_MODE_LOOP;
+	default:
+		return CVMX_HELPER_INTERFACE_MODE_DISABLED;
+	}
+}
+
+/**
+ * @INTERNAL
+ * Return interface mode for an Octeon II
+ */
+static cvmx_helper_interface_mode_t __cvmx_get_mode_octeon2(int interface)
+{
+	union cvmx_gmxx_inf_mode mode;
+
+	if (OCTEON_IS_MODEL(OCTEON_CN68XX))
+		return __cvmx_get_mode_cn68xx(interface);
+
+	if (interface == 2)
+		return CVMX_HELPER_INTERFACE_MODE_NPI;
+
+	if (interface == 3)
+		return CVMX_HELPER_INTERFACE_MODE_LOOP;
+
+	/* Only present in CN63XX & CN66XX Octeon model */
+	if ((OCTEON_IS_MODEL(OCTEON_CN63XX) &&
+	     (interface == 4 || interface == 5)) ||
+	    (OCTEON_IS_MODEL(OCTEON_CN66XX) &&
+	     interface >= 4 && interface <= 7)) {
+		return CVMX_HELPER_INTERFACE_MODE_DISABLED;
+	}
+
+	if (OCTEON_IS_MODEL(OCTEON_CN66XX)) {
+		union cvmx_mio_qlmx_cfg mio_qlm_cfg;
+
+		/* QLM2 is SGMII0 and QLM1 is SGMII1 */
+		if (interface == 0)
+			mio_qlm_cfg.u64 = cvmx_read_csr(CVMX_MIO_QLMX_CFG(2));
+		else if (interface == 1)
+			mio_qlm_cfg.u64 = cvmx_read_csr(CVMX_MIO_QLMX_CFG(1));
+		else
+			return CVMX_HELPER_INTERFACE_MODE_DISABLED;
+
+		if (mio_qlm_cfg.s.qlm_spd == 15)
+			return CVMX_HELPER_INTERFACE_MODE_DISABLED;
+
+		if (mio_qlm_cfg.s.qlm_cfg == 9)
+			return CVMX_HELPER_INTERFACE_MODE_SGMII;
+		else if (mio_qlm_cfg.s.qlm_cfg == 11)
+			return CVMX_HELPER_INTERFACE_MODE_XAUI;
+		else
+			return CVMX_HELPER_INTERFACE_MODE_DISABLED;
+	} else if (OCTEON_IS_MODEL(OCTEON_CN61XX)) {
+		union cvmx_mio_qlmx_cfg qlm_cfg;
+
+		if (interface == 0) {
+			qlm_cfg.u64 = cvmx_read_csr(CVMX_MIO_QLMX_CFG(2));
+			if (qlm_cfg.s.qlm_cfg == 2)
+				return CVMX_HELPER_INTERFACE_MODE_SGMII;
+			else if (qlm_cfg.s.qlm_cfg == 3)
+				return CVMX_HELPER_INTERFACE_MODE_XAUI;
+			else
+				return CVMX_HELPER_INTERFACE_MODE_DISABLED;
+		} else if (interface == 1) {
+			qlm_cfg.u64 = cvmx_read_csr(CVMX_MIO_QLMX_CFG(0));
+			if (qlm_cfg.s.qlm_cfg == 2)
+				return CVMX_HELPER_INTERFACE_MODE_SGMII;
+			else if (qlm_cfg.s.qlm_cfg == 3)
+				return CVMX_HELPER_INTERFACE_MODE_XAUI;
+			else
+				return CVMX_HELPER_INTERFACE_MODE_DISABLED;
+		}
+	} else if (OCTEON_IS_MODEL(OCTEON_CNF71XX)) {
+		if (interface == 0) {
+			union cvmx_mio_qlmx_cfg qlm_cfg;
+			qlm_cfg.u64 = cvmx_read_csr(CVMX_MIO_QLMX_CFG(0));
+			if (qlm_cfg.s.qlm_cfg == 2)
+				return CVMX_HELPER_INTERFACE_MODE_SGMII;
+		}
+		return CVMX_HELPER_INTERFACE_MODE_DISABLED;
+	}
+
+	if (interface == 1 && OCTEON_IS_MODEL(OCTEON_CN63XX))
+		return CVMX_HELPER_INTERFACE_MODE_DISABLED;
+
+	mode.u64 = cvmx_read_csr(CVMX_GMXX_INF_MODE(interface));
+
+	if (OCTEON_IS_MODEL(OCTEON_CN63XX)) {
+		switch (mode.cn63xx.mode) {
+		case 0:
+			return CVMX_HELPER_INTERFACE_MODE_SGMII;
+		case 1:
+			return CVMX_HELPER_INTERFACE_MODE_XAUI;
+		default:
+			return CVMX_HELPER_INTERFACE_MODE_DISABLED;
+		}
+	} else {
+		if (!mode.s.en)
+			return CVMX_HELPER_INTERFACE_MODE_DISABLED;
+
+		if (mode.s.type)
+			return CVMX_HELPER_INTERFACE_MODE_GMII;
+		else
+			return CVMX_HELPER_INTERFACE_MODE_RGMII;
+	}
+}
+
+/**
  * Get the operating mode of an interface. Depending on the Octeon
  * chip and configuration, this function returns an enumeration
  * of the type of packet I/O supported by an interface.
@@ -118,6 +270,20 @@ EXPORT_SYMBOL_GPL(cvmx_helper_ports_on_interface);
 cvmx_helper_interface_mode_t cvmx_helper_interface_get_mode(int interface)
 {
 	union cvmx_gmxx_inf_mode mode;
+
+	if (interface < 0 ||
+	    interface >= cvmx_helper_get_number_of_interfaces())
+		return CVMX_HELPER_INTERFACE_MODE_DISABLED;
+
+	/*
+	 * Octeon II models
+	 */
+	if (OCTEON_IS_MODEL(OCTEON_CN6XXX) || OCTEON_IS_MODEL(OCTEON_CNF71XX))
+		return __cvmx_get_mode_octeon2(interface);
+
+	/*
+	 * Octeon and Octeon Plus models
+	 */
 	if (interface == 2)
 		return CVMX_HELPER_INTERFACE_MODE_NPI;
 
-- 
1.9.3
