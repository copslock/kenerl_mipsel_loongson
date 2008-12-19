Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2008 23:44:06 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:14564 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24207935AbYLSXn0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Dec 2008 23:43:26 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B494c31950000>; Fri, 19 Dec 2008 18:43:17 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 19 Dec 2008 15:43:17 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 19 Dec 2008 15:43:17 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mBJNhDib011903;
	Fri, 19 Dec 2008 15:43:13 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mBJNhDJq011902;
	Fri, 19 Dec 2008 15:43:13 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, netdev@vger.kernel.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 3/3] netdev: New driver for OCTEON's MGMT ethernet devices.
Date:	Fri, 19 Dec 2008 15:43:12 -0800
Message-Id: <1229730192-11870-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <494C312E.9000901@caviumnetworks.com>
References: <494C312E.9000901@caviumnetworks.com>
X-OriginalArrivalTime: 19 Dec 2008 23:43:17.0496 (UTC) FILETIME=[91284780:01C96233]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21633
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/octeon/cvmx-mdio.h |  577 +++++++++++++++++++++
 drivers/net/Kconfig                      |    8 +
 drivers/net/Makefile                     |    1 +
 drivers/net/octeon/Makefile              |   11 +
 drivers/net/octeon/cvmx-mgmt-port.c      |  818 ++++++++++++++++++++++++++++++
 drivers/net/octeon/cvmx-mgmt-port.h      |  168 ++++++
 drivers/net/octeon/octeon-mgmt-port.c    |  389 ++++++++++++++
 7 files changed, 1972 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/octeon/cvmx-mdio.h
 create mode 100644 drivers/net/octeon/Makefile
 create mode 100644 drivers/net/octeon/cvmx-mgmt-port.c
 create mode 100644 drivers/net/octeon/cvmx-mgmt-port.h
 create mode 100644 drivers/net/octeon/octeon-mgmt-port.c

diff --git a/arch/mips/include/asm/octeon/cvmx-mdio.h b/arch/mips/include/asm/octeon/cvmx-mdio.h
new file mode 100644
index 0000000..89b0cc8
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-mdio.h
@@ -0,0 +1,577 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/**
+ *
+ * Interface to the SMI/MDIO hardware, including support for both IEEE 802.3
+ * clause 22 and clause 45 operations.
+ *
+ */
+
+#ifndef __CVMX_MIO_H__
+#define __CVMX_MIO_H__
+
+#include "cvmx-smix-defs.h"
+
+/**
+ * PHY register 0 from the 802.3 spec
+ */
+#define CVMX_MDIO_PHY_REG_CONTROL 0
+union cvmx_mdio_phy_reg_control {
+	uint16_t u16;
+	struct {
+		uint16_t reset:1;
+		uint16_t loopback:1;
+		uint16_t speed_lsb:1;
+		uint16_t autoneg_enable:1;
+		uint16_t power_down:1;
+		uint16_t isolate:1;
+		uint16_t restart_autoneg:1;
+		uint16_t duplex:1;
+		uint16_t collision_test:1;
+		uint16_t speed_msb:1;
+		uint16_t unidirectional_enable:1;
+		uint16_t reserved_0_4:5;
+	} s;
+};
+
+/**
+ * PHY register 1 from the 802.3 spec
+ */
+#define CVMX_MDIO_PHY_REG_STATUS 1
+union cvmx_mdio_phy_reg_status {
+	uint16_t u16;
+	struct {
+		uint16_t capable_100base_t4:1;
+		uint16_t capable_100base_x_full:1;
+		uint16_t capable_100base_x_half:1;
+		uint16_t capable_10_full:1;
+		uint16_t capable_10_half:1;
+		uint16_t capable_100base_t2_full:1;
+		uint16_t capable_100base_t2_half:1;
+		uint16_t capable_extended_status:1;
+		uint16_t capable_unidirectional:1;
+		uint16_t capable_mf_preamble_suppression:1;
+		uint16_t autoneg_complete:1;
+		uint16_t remote_fault:1;
+		uint16_t capable_autoneg:1;
+		uint16_t link_status:1;
+		uint16_t jabber_detect:1;
+		uint16_t capable_extended_registers:1;
+
+	} s;
+};
+
+/**
+ * PHY register 2 from the 802.3 spec
+ */
+#define CVMX_MDIO_PHY_REG_ID1 2
+union cvmx_mdio_phy_reg_id1 {
+	uint16_t u16;
+	struct {
+		uint16_t oui_bits_3_18;
+	} s;
+};
+
+/**
+ * PHY register 3 from the 802.3 spec
+ */
+#define CVMX_MDIO_PHY_REG_ID2 3
+union cvmx_mdio_phy_reg_id2 {
+	uint16_t u16;
+	struct {
+		uint16_t oui_bits_19_24:6;
+		uint16_t model:6;
+		uint16_t revision:4;
+	} s;
+};
+
+/**
+ * PHY register 4 from the 802.3 spec
+ */
+#define CVMX_MDIO_PHY_REG_AUTONEG_ADVER 4
+union cvmx_mdio_phy_reg_autoneg_adver {
+	uint16_t u16;
+	struct {
+		uint16_t next_page:1;
+		uint16_t reserved_14:1;
+		uint16_t remote_fault:1;
+		uint16_t reserved_12:1;
+		uint16_t asymmetric_pause:1;
+		uint16_t pause:1;
+		uint16_t advert_100base_t4:1;
+		uint16_t advert_100base_tx_full:1;
+		uint16_t advert_100base_tx_half:1;
+		uint16_t advert_10base_tx_full:1;
+		uint16_t advert_10base_tx_half:1;
+		uint16_t selector:5;
+	} s;
+};
+
+/**
+ * PHY register 5 from the 802.3 spec
+ */
+#define CVMX_MDIO_PHY_REG_LINK_PARTNER_ABILITY 5
+union cvmx_mdio_phy_reg_link_partner_ability {
+	uint16_t u16;
+	struct {
+		uint16_t next_page:1;
+		uint16_t ack:1;
+		uint16_t remote_fault:1;
+		uint16_t reserved_12:1;
+		uint16_t asymmetric_pause:1;
+		uint16_t pause:1;
+		uint16_t advert_100base_t4:1;
+		uint16_t advert_100base_tx_full:1;
+		uint16_t advert_100base_tx_half:1;
+		uint16_t advert_10base_tx_full:1;
+		uint16_t advert_10base_tx_half:1;
+		uint16_t selector:5;
+	} s;
+};
+
+/**
+ * PHY register 6 from the 802.3 spec
+ */
+#define CVMX_MDIO_PHY_REG_AUTONEG_EXPANSION 6
+union cvmx_mdio_phy_reg_autoneg_expansion {
+	uint16_t u16;
+	struct {
+		uint16_t reserved_5_15:11;
+		uint16_t parallel_detection_fault:1;
+		uint16_t link_partner_next_page_capable:1;
+		uint16_t local_next_page_capable:1;
+		uint16_t page_received:1;
+		uint16_t link_partner_autoneg_capable:1;
+
+	} s;
+};
+
+/**
+ * PHY register 9 from the 802.3 spec
+ */
+#define CVMX_MDIO_PHY_REG_CONTROL_1000 9
+union cvmx_mdio_phy_reg_control_1000 {
+	uint16_t u16;
+	struct {
+		uint16_t test_mode:3;
+		uint16_t manual_master_slave:1;
+		uint16_t master:1;
+		uint16_t port_type:1;
+		uint16_t advert_1000base_t_full:1;
+		uint16_t advert_1000base_t_half:1;
+		uint16_t reserved_0_7:8;
+	} s;
+};
+
+/**
+ * PHY register 10 from the 802.3 spec
+ */
+#define CVMX_MDIO_PHY_REG_STATUS_1000 10
+union cvmx_mdio_phy_reg_status_1000 {
+	uint16_t u16;
+	struct {
+		uint16_t master_slave_fault:1;
+		uint16_t is_master:1;
+		uint16_t local_receiver_ok:1;
+		uint16_t remote_receiver_ok:1;
+		uint16_t remote_capable_1000base_t_full:1;
+		uint16_t remote_capable_1000base_t_half:1;
+		uint16_t reserved_8_9:2;
+		uint16_t idle_error_count:8;
+	} s;
+};
+
+/**
+ * PHY register 15 from the 802.3 spec
+ */
+#define CVMX_MDIO_PHY_REG_EXTENDED_STATUS 15
+union cvmx_mdio_phy_reg_extended_status {
+	uint16_t u16;
+	struct {
+		uint16_t capable_1000base_x_full:1;
+		uint16_t capable_1000base_x_half:1;
+		uint16_t capable_1000base_t_full:1;
+		uint16_t capable_1000base_t_half:1;
+		uint16_t reserved_0_11:12;
+	} s;
+};
+
+/**
+ * PHY register 13 from the 802.3 spec
+ */
+#define CVMX_MDIO_PHY_REG_MMD_CONTROL 13
+union cvmx_mdio_phy_reg_mmd_control {
+	uint16_t u16;
+	struct {
+		uint16_t function:2;
+		uint16_t reserved_5_13:9;
+		uint16_t devad:5;
+	} s;
+};
+
+/**
+ * PHY register 14 from the 802.3 spec
+ */
+#define CVMX_MDIO_PHY_REG_MMD_ADDRESS_DATA 14
+union cvmx_mdio_phy_reg_mmd_address_data {
+	uint16_t u16;
+	struct {
+		uint16_t address_data:16;
+	} s;
+};
+
+/* Operating request encodings. */
+#define MDIO_CLAUSE_22_WRITE    0
+#define MDIO_CLAUSE_22_READ     1
+
+#define MDIO_CLAUSE_45_ADDRESS  0
+#define MDIO_CLAUSE_45_WRITE    1
+#define MDIO_CLAUSE_45_READ_INC 2
+#define MDIO_CLAUSE_45_READ     3
+
+/* MMD identifiers, mostly for accessing devices withing XENPAK modules. */
+#define CVMX_MMD_DEVICE_PMA_PMD      1
+#define CVMX_MMD_DEVICE_WIS          2
+#define CVMX_MMD_DEVICE_PCS          3
+#define CVMX_MMD_DEVICE_PHY_XS       4
+#define CVMX_MMD_DEVICE_DTS_XS       5
+#define CVMX_MMD_DEVICE_TC           6
+#define CVMX_MMD_DEVICE_CL22_EXT     29
+#define CVMX_MMD_DEVICE_VENDOR_1     30
+#define CVMX_MMD_DEVICE_VENDOR_2     31
+
+/**
+ * Perform an MII read. This function is used to read PHY
+ * registers controlling auto negotiation.
+ *
+ * @bus_id:   MDIO bus number. Zero on most chips, but some chips (ex CN56XX)
+ *                 support multiple busses.
+ * @phy_id:   The MII phy id
+ * @location: Register location to read
+ *
+ * Returns Result from the read or -1 on failure
+ */
+static inline int cvmx_mdio_read(int bus_id, int phy_id, int location)
+{
+	union cvmx_smix_cmd smi_cmd;
+	union cvmx_smix_rd_dat smi_rd;
+	int timeout = 1000;
+
+	smi_cmd.u64 = 0;
+	smi_cmd.s.phy_op = MDIO_CLAUSE_22_READ;
+	smi_cmd.s.phy_adr = phy_id;
+	smi_cmd.s.reg_adr = location;
+	cvmx_write_csr(CVMX_SMIX_CMD(bus_id), smi_cmd.u64);
+
+	do {
+		cvmx_wait(1000);
+		smi_rd.u64 = cvmx_read_csr(CVMX_SMIX_RD_DAT(bus_id));
+	} while (smi_rd.s.pending && timeout--);
+
+	if (smi_rd.s.val)
+		return smi_rd.s.dat;
+	else
+		return -1;
+}
+
+/**
+ * Perform an MII write. This function is used to write PHY
+ * registers controlling auto negotiation.
+ *
+ * @bus_id:   MDIO bus number. Zero on most chips, but some chips (ex CN56XX)
+ *                 support multiple busses.
+ * @phy_id:   The MII phy id
+ * @location: Register location to write
+ * @val:      Value to write
+ *
+ * Returns -1 on error
+ *         0 on success
+ */
+static inline int cvmx_mdio_write(int bus_id, int phy_id, int location, int val)
+{
+	union cvmx_smix_cmd smi_cmd;
+	union cvmx_smix_wr_dat smi_wr;
+	int timeout = 1000;
+
+	smi_wr.u64 = 0;
+	smi_wr.s.dat = val;
+	cvmx_write_csr(CVMX_SMIX_WR_DAT(bus_id), smi_wr.u64);
+
+	smi_cmd.u64 = 0;
+	smi_cmd.s.phy_op = MDIO_CLAUSE_22_WRITE;
+	smi_cmd.s.phy_adr = phy_id;
+	smi_cmd.s.reg_adr = location;
+	cvmx_write_csr(CVMX_SMIX_CMD(bus_id), smi_cmd.u64);
+
+	do {
+		cvmx_wait(1000);
+		smi_wr.u64 = cvmx_read_csr(CVMX_SMIX_WR_DAT(bus_id));
+	} while (smi_wr.s.pending && --timeout);
+	if (timeout <= 0)
+		return -1;
+
+	return 0;
+}
+
+/**
+ * Perform an IEEE 802.3 clause 45 MII read using clause 22 operations. This
+ * function is used to read PHY registers controlling auto negotiation.
+ *
+ * @bus_id:   MDIO bus number. Zero on most chips, but some chips (ex CN56XX)
+ *                 support multiple busses.
+ * @phy_id:   The MII phy id
+ * @device:   MDIO Managable Device (MMD) id
+ * @location: Register location to read
+ *
+ * Returns Result from the read or -1 on failure
+ */
+
+static inline int cvmx_mdio_45_via_22_read(int bus_id, int phy_id, int device,
+					   int location)
+{
+	union cvmx_mdio_phy_reg_mmd_control mmd_control;
+
+	/*
+	 * a) To Register 13, write the Function field to 00 (address)
+	 *    and DEVAD field to the device address value for the
+	 *    desired MMD;
+	 */
+	mmd_control.u16 = 0;
+	mmd_control.s.function = MDIO_CLAUSE_45_ADDRESS;
+	mmd_control.s.devad = device;
+	cvmx_mdio_write(bus_id, phy_id, CVMX_MDIO_PHY_REG_MMD_CONTROL,
+			mmd_control.u16);
+
+	/*
+	 *  b) To Register 14, write the desired address value to the
+	 *     MMD's address register;
+	 */
+	cvmx_mdio_write(bus_id, phy_id, CVMX_MDIO_PHY_REG_MMD_ADDRESS_DATA,
+			location);
+
+	/*
+	 * c) To Register 13, write the Function field to 01 (Data, no
+	 *    post increment) and DEVAD field to the same device
+	 *    address value for the desired MMD;
+	 */
+	mmd_control.u16 = 0;
+	mmd_control.s.function = MDIO_CLAUSE_45_READ;
+	mmd_control.s.devad = device;
+	cvmx_mdio_write(bus_id, phy_id, CVMX_MDIO_PHY_REG_MMD_CONTROL,
+			mmd_control.u16);
+
+	/*
+	 * d) From Register 14, read the content of the MMD's selected
+	 *    register.
+	 */
+	return cvmx_mdio_read(bus_id, phy_id,
+			      CVMX_MDIO_PHY_REG_MMD_ADDRESS_DATA);
+}
+
+/**
+ * Perform an IEEE 802.3 clause 45 MII write using clause 22
+ * operations. This function is used to write PHY registers
+ * controlling auto negotiation.
+ *
+ * @bus_id:   MDIO bus number. Zero on most chips, but some chips (ex CN56XX)
+ *                 support multiple busses.
+ * @phy_id:   The MII phy id
+ * @device:   MDIO Managable Device (MMD) id
+ * @location: Register location to write
+ * @val:      Value to write
+ *
+ * Returns -1 on error
+ *         0 on success
+ */
+static inline int cvmx_mdio_45_via_22_write(int bus_id, int phy_id, int device,
+					    int location, int val)
+{
+	union cvmx_mdio_phy_reg_mmd_control mmd_control;
+
+	/*
+	 * a) To Register 13, write the Function field to 00 (address)
+	 *    and DEVAD field to the device address value for the
+	 *    desired MMD;
+	 */
+	mmd_control.u16 = 0;
+	mmd_control.s.function = MDIO_CLAUSE_45_ADDRESS;
+	mmd_control.s.devad = device;
+	cvmx_mdio_write(bus_id, phy_id, CVMX_MDIO_PHY_REG_MMD_CONTROL,
+			mmd_control.u16);
+
+	/*
+	 * b) To Register 14, write the desired address value to the
+	 *    MMD's address register;
+	 */
+	cvmx_mdio_write(bus_id, phy_id, CVMX_MDIO_PHY_REG_MMD_ADDRESS_DATA,
+			location);
+
+	/*
+	 * c) To Register 13, write the Function field to 01 (Data, no
+	 *    post increment) and DEVAD field to the same device
+	 *    address value for the desired MMD;
+	 */
+	mmd_control.u16 = 0;
+	mmd_control.s.function = MDIO_CLAUSE_45_READ;
+	mmd_control.s.devad = device;
+	cvmx_mdio_write(bus_id, phy_id, CVMX_MDIO_PHY_REG_MMD_CONTROL,
+			mmd_control.u16);
+
+	/*
+	 * d) To Register 14, write the content of the MMD's selected
+	 *    register.
+	 */
+	return cvmx_mdio_write(bus_id, phy_id,
+			       CVMX_MDIO_PHY_REG_MMD_ADDRESS_DATA, val);
+
+	return 0;
+}
+
+/**
+ * Perform an IEEE 802.3 clause 45 MII read. This function is used to read PHY
+ * registers controlling auto negotiation.
+ *
+ * @bus_id:   MDIO bus number. Zero on most chips, but some chips (ex CN56XX)
+ *                 support multiple busses.
+ * @phy_id:   The MII phy id
+ * @device:   MDIO Managable Device (MMD) id
+ * @location: Register location to read
+ *
+ * Returns Result from the read or -1 on failure
+ */
+
+static inline int cvmx_mdio_45_read(int bus_id, int phy_id, int device,
+				    int location)
+{
+	union cvmx_smix_cmd smi_cmd;
+	union cvmx_smix_rd_dat smi_rd;
+	union cvmx_smix_wr_dat smi_wr;
+	int timeout = 1000;
+
+	smi_wr.u64 = 0;
+	smi_wr.s.dat = location;
+	cvmx_write_csr(CVMX_SMIX_WR_DAT(bus_id), smi_wr.u64);
+
+	smi_cmd.u64 = 0;
+	smi_cmd.s.phy_op = MDIO_CLAUSE_45_ADDRESS;
+	smi_cmd.s.phy_adr = phy_id;
+	smi_cmd.s.reg_adr = device;
+	cvmx_write_csr(CVMX_SMIX_CMD(bus_id), smi_cmd.u64);
+
+	do {
+		cvmx_wait(1000);
+		smi_wr.u64 = cvmx_read_csr(CVMX_SMIX_WR_DAT(bus_id));
+	} while (smi_wr.s.pending && --timeout);
+	if (timeout <= 0)
+		return -1;
+
+	smi_cmd.u64 = 0;
+	smi_cmd.s.phy_op = MDIO_CLAUSE_45_READ;
+	smi_cmd.s.phy_adr = phy_id;
+	smi_cmd.s.reg_adr = device;
+	cvmx_write_csr(CVMX_SMIX_CMD(bus_id), smi_cmd.u64);
+
+	do {
+		cvmx_wait(1000);
+		smi_rd.u64 = cvmx_read_csr(CVMX_SMIX_RD_DAT(bus_id));
+	} while (smi_rd.s.pending && timeout--);
+
+	if (0 == timeout)
+		cvmx_dprintf("cvmx_mdio_45_read: bus_id %d phy_id %2d "
+			     "device %2d register %2d   TIME OUT\n",
+			     bus_id, phy_id, device, location);
+
+	if (smi_rd.s.val)
+		return smi_rd.s.dat;
+	else {
+		cvmx_dprintf("cvmx_mdio_45_read: bus_id %d phy_id %2d "
+			     "device %2d register %2d   INVALID READ\n",
+			     bus_id, phy_id, device, location);
+		return -1;
+	}
+}
+
+/**
+ * Perform an IEEE 802.3 clause 45 MII write. This function is used to
+ * write PHY registers controlling auto negotiation.
+ *
+ * @bus_id:   MDIO bus number. Zero on most chips, but some chips (ex CN56XX)
+ *                 support multiple busses.
+ * @phy_id:   The MII phy id
+ * @device:   MDIO Managable Device (MMD) id
+ * @location: Register location to write
+ * @val:      Value to write
+ *
+ * Returns -1 on error
+ *         0 on success
+ */
+static inline int cvmx_mdio_45_write(int bus_id, int phy_id, int device,
+				     int location, int val)
+{
+	union cvmx_smix_cmd smi_cmd;
+	union cvmx_smix_wr_dat smi_wr;
+	int timeout = 1000;
+
+	smi_wr.u64 = 0;
+	smi_wr.s.dat = location;
+	cvmx_write_csr(CVMX_SMIX_WR_DAT(bus_id), smi_wr.u64);
+
+	smi_cmd.u64 = 0;
+	smi_cmd.s.phy_op = MDIO_CLAUSE_45_ADDRESS;
+	smi_cmd.s.phy_adr = phy_id;
+	smi_cmd.s.reg_adr = device;
+	cvmx_write_csr(CVMX_SMIX_CMD(bus_id), smi_cmd.u64);
+
+	do {
+		cvmx_wait(1000);
+		smi_wr.u64 = cvmx_read_csr(CVMX_SMIX_WR_DAT(bus_id));
+	} while (smi_wr.s.pending && --timeout);
+	if (timeout <= 0)
+		return -1;
+
+	smi_wr.u64 = 0;
+	smi_wr.s.dat = val;
+	cvmx_write_csr(CVMX_SMIX_WR_DAT(bus_id), smi_wr.u64);
+
+	smi_cmd.u64 = 0;
+	smi_cmd.s.phy_op = MDIO_CLAUSE_45_WRITE;
+	smi_cmd.s.phy_adr = phy_id;
+	smi_cmd.s.reg_adr = device;
+	cvmx_write_csr(CVMX_SMIX_CMD(bus_id), smi_cmd.u64);
+
+	do {
+		cvmx_wait(1000);
+		smi_wr.u64 = cvmx_read_csr(CVMX_SMIX_WR_DAT(bus_id));
+	} while (smi_wr.s.pending && --timeout);
+	if (timeout <= 0)
+		return -1;
+
+	return 0;
+}
+
+#endif
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index e9625a5..8c9d29e 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1864,6 +1864,14 @@ config ATL2
 	  To compile this driver as a module, choose M here.  The module
 	  will be called atl2.
 
+config OCTEON_MGMT
+	tristate "OCTEON Management port ethernet driver (CN5XXX)"
+	depends on CPU_CAVIUM_OCTEON
+	default y
+	help
+	  This option enables the ethernet driver for the management port on
+	  CN52XX, CN57XX, CN56XX, CN55XX, and CN54XX chips.
+
 source "drivers/net/fs_enet/Kconfig"
 
 endif # NET_ETHERNET
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 4a92305..4cbc22e 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -228,6 +228,7 @@ obj-$(CONFIG_PASEMI_MAC) += pasemi_mac_driver.o
 pasemi_mac_driver-objs := pasemi_mac.o pasemi_mac_ethtool.o
 obj-$(CONFIG_MLX4_CORE) += mlx4/
 obj-$(CONFIG_ENC28J60) += enc28j60.o
+obj-$(CONFIG_OCTEON_MGMT) += octeon/
 
 obj-$(CONFIG_XTENSA_XT2000_SONIC) += xtsonic.o
 
diff --git a/drivers/net/octeon/Makefile b/drivers/net/octeon/Makefile
new file mode 100644
index 0000000..f32f394
--- /dev/null
+++ b/drivers/net/octeon/Makefile
@@ -0,0 +1,11 @@
+# Makefile for the Cavium OCTEON Ethernet drivers.
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+# Copyright (C) 2008 Cavium Networks
+
+obj-$(CONFIG_OCTEON_MGMT) += octeon_mgmt.o
+
+octeon_mgmt-objs := octeon-mgmt-port.o cvmx-mgmt-port.o
\ No newline at end of file
diff --git a/drivers/net/octeon/cvmx-mgmt-port.c b/drivers/net/octeon/cvmx-mgmt-port.c
new file mode 100644
index 0000000..f60255a
--- /dev/null
+++ b/drivers/net/octeon/cvmx-mgmt-port.c
@@ -0,0 +1,818 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/**
+ *
+ * Support functions for managing the MII management port
+ *
+ */
+
+#include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-spinlock.h>
+#include <asm/octeon/cvmx-bootmem.h>
+#include <asm/octeon/cvmx-mdio.h>
+
+#include <asm/octeon/cvmx-mixx-defs.h>
+#include <asm/octeon/cvmx-agl-defs.h>
+
+#include "cvmx-mgmt-port.h"
+
+#define CVMX_MGMT_PORT_NUM_PORTS        2
+/* Number of TX ring buffer entries and buffers */
+#define CVMX_MGMT_PORT_NUM_TX_BUFFERS   16
+/* Number of RX ring buffer entries and buffers */
+#define CVMX_MGMT_PORT_NUM_RX_BUFFERS   128
+
+#define CVMX_MGMT_PORT_TX_BUFFER_SIZE   12288
+#define CVMX_MGMT_PORT_RX_BUFFER_SIZE   1536
+
+/**
+ * Format of the TX/RX ring buffer entries
+ */
+union cvmx_mgmt_port_ring_entry {
+	uint64_t u64;
+	struct {
+		uint64_t reserved_62_63:2;
+		/* Length of the buffer/packet in bytes */
+		uint64_t len:14;
+		/* The RX error code */
+		uint64_t code:8;
+		/* Physical address of the buffer */
+		uint64_t addr:40;
+	} s;
+};
+
+/**
+ * Per port state required for each mgmt port
+ */
+struct cvmx_mgmt_port_state {
+	/* Used for exclusive access to this structure */
+	cvmx_spinlock_t lock;
+	/* Where the next TX will write in the tx_ring and tx_buffers */
+	int tx_write_index;
+	/* Where the next RX will be in the rx_ring and rx_buffers */
+	int rx_read_index;
+	/* The SMI/MDIO PHY address */
+	int phy_id;
+	/* Our MAC address */
+	uint64_t mac;
+	union cvmx_mgmt_port_ring_entry tx_ring[CVMX_MGMT_PORT_NUM_TX_BUFFERS];
+	union cvmx_mgmt_port_ring_entry rx_ring[CVMX_MGMT_PORT_NUM_RX_BUFFERS];
+	char tx_buffers[CVMX_MGMT_PORT_NUM_TX_BUFFERS]
+	    [CVMX_MGMT_PORT_TX_BUFFER_SIZE];
+	char rx_buffers[CVMX_MGMT_PORT_NUM_RX_BUFFERS]
+	    [CVMX_MGMT_PORT_RX_BUFFER_SIZE];
+};
+
+/**
+ * Pointers to each mgmt port's state
+ */
+struct cvmx_mgmt_port_state *cvmx_mgmt_port_state_ptr;
+
+/**
+ * Return the number of management ports supported by this chip
+ *
+ * Returns Number of ports
+ */
+int __cvmx_mgmt_port_num_ports(void)
+{
+	if (OCTEON_IS_MODEL(OCTEON_CN56XX))
+		return 1;
+	else if (OCTEON_IS_MODEL(OCTEON_CN52XX))
+		return 2;
+	else
+		return 0;
+}
+
+/**
+ * Called to initialize a management port for use. Multiple calls
+ * to this function accross applications is safe.
+ *
+ * @port:   Port to initialize
+ *
+ * Returns CVMX_MGMT_PORT_SUCCESS or an error code
+ */
+enum cvmx_mgmt_port_result cvmx_mgmt_port_initialize(int port)
+{
+	char *alloc_name = "cvmx_mgmt_port";
+	union cvmx_mixx_oring1 oring1;
+	union cvmx_mixx_ctl mix_ctl;
+
+	if ((port < 0) || (port >= __cvmx_mgmt_port_num_ports()))
+		return CVMX_MGMT_PORT_INVALID_PARAM;
+
+	cvmx_mgmt_port_state_ptr =
+	    cvmx_bootmem_alloc_named(CVMX_MGMT_PORT_NUM_PORTS *
+				     sizeof(struct cvmx_mgmt_port_state), 128,
+				     alloc_name);
+	if (cvmx_mgmt_port_state_ptr) {
+		memset(cvmx_mgmt_port_state_ptr, 0,
+		       CVMX_MGMT_PORT_NUM_PORTS *
+		       sizeof(struct cvmx_mgmt_port_state));
+	} else {
+		struct cvmx_bootmem_named_block_desc *block_desc =
+		    cvmx_bootmem_find_named_block(alloc_name);
+		if (block_desc)
+			cvmx_mgmt_port_state_ptr =
+			    cvmx_phys_to_ptr(block_desc->base_addr);
+		else {
+			cvmx_dprintf("ERROR: cvmx_mgmt_port_initialize: "
+				     "Unable to get named block %s.\n",
+				     alloc_name);
+			return CVMX_MGMT_PORT_NO_MEMORY;
+		}
+	}
+
+	/*
+	 * Reset the MIX block if the previous user had a different TX
+	 * ring size.
+	 */
+	mix_ctl.u64 = cvmx_read_csr(CVMX_MIXX_CTL(port));
+	if (!mix_ctl.s.reset) {
+		oring1.u64 = cvmx_read_csr(CVMX_MIXX_ORING1(port));
+		if (oring1.s.osize != CVMX_MGMT_PORT_NUM_TX_BUFFERS) {
+			mix_ctl.u64 = cvmx_read_csr(CVMX_MIXX_CTL(port));
+			mix_ctl.s.en = 0;
+			cvmx_write_csr(CVMX_MIXX_CTL(port), mix_ctl.u64);
+			do {
+				mix_ctl.u64 =
+				    cvmx_read_csr(CVMX_MIXX_CTL(port));
+			} while (mix_ctl.s.busy);
+			mix_ctl.s.reset = 1;
+			cvmx_write_csr(CVMX_MIXX_CTL(port), mix_ctl.u64);
+			cvmx_read_csr(CVMX_MIXX_CTL(port));
+			memset(cvmx_mgmt_port_state_ptr + port, 0,
+			       sizeof(struct cvmx_mgmt_port_state));
+		}
+	}
+
+	if (cvmx_mgmt_port_state_ptr[port].tx_ring[0].u64 == 0) {
+		struct cvmx_mgmt_port_state *state =
+			cvmx_mgmt_port_state_ptr + port;
+		int i;
+		union cvmx_mixx_bist mix_bist;
+		union cvmx_agl_gmx_bist agl_gmx_bist;
+		union cvmx_mixx_oring1 oring1;
+		union cvmx_mixx_iring1 iring1;
+		union cvmx_mixx_ctl mix_ctl;
+
+		/* Make sure BIST passed */
+		mix_bist.u64 = cvmx_read_csr(CVMX_MIXX_BIST(port));
+		if (mix_bist.u64)
+			cvmx_dprintf("WARNING: cvmx_mgmt_port_initialize: "
+				     "Managment port MIX failed BIST "
+				     "(0x%016llx)\n",
+				     (unsigned long long)mix_bist.u64);
+
+		agl_gmx_bist.u64 = cvmx_read_csr(CVMX_AGL_GMX_BIST);
+		if (agl_gmx_bist.u64)
+			cvmx_dprintf("WARNING: cvmx_mgmt_port_initialize: "
+				     "Managment port AGL failed BIST "
+				     "(0x%016llx)\n",
+				     (unsigned long long)agl_gmx_bist.u64);
+
+		/* Clear all state information */
+		memset(state, 0, sizeof(*state));
+
+		/* Take the control logic out of reset */
+		mix_ctl.u64 = cvmx_read_csr(CVMX_MIXX_CTL(port));
+		mix_ctl.s.reset = 0;
+		cvmx_write_csr(CVMX_MIXX_CTL(port), mix_ctl.u64);
+
+		/* Set the PHY address */
+		if (cvmx_sysinfo_get()->board_type == CVMX_BOARD_TYPE_SIM)
+			state->phy_id = -1;
+		else
+			/* Will need to be change to match the board */
+			state->phy_id = port;
+
+		/* Create a default MAC address */
+		state->mac = 0x000000dead000000ull;
+		state->mac += 0xffffff & CAST64(state);
+
+		/* Setup the TX ring */
+		for (i = 0; i < CVMX_MGMT_PORT_NUM_TX_BUFFERS; i++) {
+			state->tx_ring[i].s.len = CVMX_MGMT_PORT_TX_BUFFER_SIZE;
+			state->tx_ring[i].s.addr =
+			    cvmx_ptr_to_phys(state->tx_buffers[i]);
+		}
+
+		/* Tell the HW where the TX ring is */
+		oring1.u64 = 0;
+		oring1.s.obase = cvmx_ptr_to_phys(state->tx_ring) >> 3;
+		oring1.s.osize = CVMX_MGMT_PORT_NUM_TX_BUFFERS;
+		CVMX_SYNCWS;
+		cvmx_write_csr(CVMX_MIXX_ORING1(port), oring1.u64);
+
+		/* Setup the RX ring */
+		for (i = 0; i < CVMX_MGMT_PORT_NUM_RX_BUFFERS; i++) {
+			/* This size is -8 due to an errata for CN56XX pass 1 */
+			state->rx_ring[i].s.len =
+			    CVMX_MGMT_PORT_RX_BUFFER_SIZE - 8;
+			state->rx_ring[i].s.addr =
+			    cvmx_ptr_to_phys(state->rx_buffers[i]);
+		}
+
+		/* Tell the HW where the RX ring is */
+		iring1.u64 = 0;
+		iring1.s.ibase = cvmx_ptr_to_phys(state->rx_ring) >> 3;
+		iring1.s.isize = CVMX_MGMT_PORT_NUM_RX_BUFFERS;
+		CVMX_SYNCWS;
+		cvmx_write_csr(CVMX_MIXX_IRING1(port), iring1.u64);
+		cvmx_write_csr(CVMX_MIXX_IRING2(port),
+			       CVMX_MGMT_PORT_NUM_RX_BUFFERS);
+
+		/* Disable the external input/output */
+		cvmx_mgmt_port_disable(port);
+
+		/* Set the MAC address filtering up */
+		cvmx_mgmt_port_set_mac(port, state->mac);
+
+		/*
+		 * Set the default max size to an MTU of 1500 with L2
+		 * and VLAN.
+		 */
+		cvmx_mgmt_port_set_max_packet_size(port, 1518);
+
+		/*
+		 * Enable the port HW. Packets are not allowed until
+		 * cvmx_mgmt_port_enable() is called.
+		 */
+		mix_ctl.u64 = 0;
+		/* Strip the ending CRC */
+		mix_ctl.s.crc_strip = 1;
+		/* Enable the port */
+		mix_ctl.s.en = 1;
+		/* Arbitration mode */
+		mix_ctl.s.nbtarb = 0;
+		/* MII CB-request FIFO programmable high watermark */
+		mix_ctl.s.mrq_hwm = 1;
+		cvmx_write_csr(CVMX_MIXX_CTL(port), mix_ctl.u64);
+
+		if (OCTEON_IS_MODEL(OCTEON_CN56XX_PASS1_X)
+		    || OCTEON_IS_MODEL(OCTEON_CN52XX_PASS1_X)) {
+			/*
+			 * Force compensation values, as they are not
+			 * determined properly by HW.
+			 */
+			union cvmx_agl_gmx_drv_ctl drv_ctl;
+
+			drv_ctl.u64 = cvmx_read_csr(CVMX_AGL_GMX_DRV_CTL);
+			if (port) {
+				drv_ctl.s.byp_en1 = 1;
+				drv_ctl.s.nctl1 = 6;
+				drv_ctl.s.pctl1 = 6;
+			} else {
+				drv_ctl.s.byp_en = 1;
+				drv_ctl.s.nctl = 6;
+				drv_ctl.s.pctl = 6;
+			}
+			cvmx_write_csr(CVMX_AGL_GMX_DRV_CTL, drv_ctl.u64);
+		}
+	}
+	return CVMX_MGMT_PORT_SUCCESS;
+}
+
+/**
+ * Shutdown a management port. This currently disables packet IO
+ * but leaves all hardware and buffers. Another application can then
+ * call initialize() without redoing the hardware setup.
+ *
+ * @port:   Management port
+ *
+ * Returns CVMX_MGMT_PORT_SUCCESS or an error code
+ */
+enum cvmx_mgmt_port_result cvmx_mgmt_port_shutdown(int port)
+{
+	if ((port < 0) || (port >= __cvmx_mgmt_port_num_ports()))
+		return CVMX_MGMT_PORT_INVALID_PARAM;
+
+	/* Stop packets from comming in */
+	cvmx_mgmt_port_disable(port);
+
+	/*
+	 * We don't free any memory so the next intialize can reuse
+	 * the HW setup.
+	 */
+	return CVMX_MGMT_PORT_SUCCESS;
+}
+
+/**
+ * Enable packet IO on a management port
+ *
+ * @port:   Management port
+ *
+ * Returns CVMX_MGMT_PORT_SUCCESS or an error code
+ */
+enum cvmx_mgmt_port_result cvmx_mgmt_port_enable(int port)
+{
+	struct cvmx_mgmt_port_state *state;
+	union cvmx_agl_gmx_prtx_cfg agl_gmx_prtx;
+	union cvmx_agl_gmx_inf_mode agl_gmx_inf_mode;
+	union cvmx_agl_gmx_rxx_frm_ctl rxx_frm_ctl;
+
+	if ((port < 0) || (port >= __cvmx_mgmt_port_num_ports()))
+		return CVMX_MGMT_PORT_INVALID_PARAM;
+
+	state = cvmx_mgmt_port_state_ptr + port;
+
+	cvmx_spinlock_lock(&state->lock);
+
+	rxx_frm_ctl.u64 = 0;
+	rxx_frm_ctl.s.pre_align = 1;
+	/*
+	 * When set, disables the length check for non-min sized pkts
+	 * with padding in the client data.
+	 */
+	rxx_frm_ctl.s.pad_len = 1;
+	/* When set, disables the length check for VLAN pkts */
+	rxx_frm_ctl.s.vlan_len = 1;
+	/* When set, PREAMBLE checking is  less strict */
+	rxx_frm_ctl.s.pre_free = 1;
+	/* Control Pause Frames can match station SMAC */
+	rxx_frm_ctl.s.ctl_smac = 0;
+	/* Control Pause Frames can match globally assign Multicast address */
+	rxx_frm_ctl.s.ctl_mcst = 1;
+	/* Forward pause information to TX block */
+	rxx_frm_ctl.s.ctl_bck = 1;
+	/* Drop Control Pause Frames */
+	rxx_frm_ctl.s.ctl_drp = 1;
+	/* Strip off the preamble */
+	rxx_frm_ctl.s.pre_strp = 1;
+	/*
+	 * This port is configured to send PREAMBLE+SFD to begin every
+	 * frame.  GMX checks that the PREAMBLE is sent correctly.
+	 */
+	rxx_frm_ctl.s.pre_chk = 1;
+	cvmx_write_csr(CVMX_AGL_GMX_RXX_FRM_CTL(port), rxx_frm_ctl.u64);
+
+	/* Enable the AGL block */
+	agl_gmx_inf_mode.u64 = 0;
+	agl_gmx_inf_mode.s.en = 1;
+	cvmx_write_csr(CVMX_AGL_GMX_INF_MODE, agl_gmx_inf_mode.u64);
+
+	/* Configure the port duplex and enables */
+	agl_gmx_prtx.u64 = cvmx_read_csr(CVMX_AGL_GMX_PRTX_CFG(port));
+	agl_gmx_prtx.s.tx_en = 1;
+	agl_gmx_prtx.s.rx_en = 1;
+	if (cvmx_mgmt_port_get_link(port) < 0)
+		agl_gmx_prtx.s.duplex = 0;
+	else
+		agl_gmx_prtx.s.duplex = 1;
+	agl_gmx_prtx.s.en = 1;
+	cvmx_write_csr(CVMX_AGL_GMX_PRTX_CFG(port), agl_gmx_prtx.u64);
+
+	cvmx_spinlock_unlock(&state->lock);
+	return CVMX_MGMT_PORT_SUCCESS;
+}
+
+/**
+ * Disable packet IO on a management port
+ *
+ * @port:   Management port
+ *
+ * Returns CVMX_MGMT_PORT_SUCCESS or an error code
+ */
+enum cvmx_mgmt_port_result cvmx_mgmt_port_disable(int port)
+{
+	struct cvmx_mgmt_port_state *state;
+	union cvmx_agl_gmx_prtx_cfg agl_gmx_prtx;
+
+	if ((port < 0) || (port >= __cvmx_mgmt_port_num_ports()))
+		return CVMX_MGMT_PORT_INVALID_PARAM;
+
+	state = cvmx_mgmt_port_state_ptr + port;
+
+	cvmx_spinlock_lock(&state->lock);
+
+	agl_gmx_prtx.u64 = cvmx_read_csr(CVMX_AGL_GMX_PRTX_CFG(port));
+	agl_gmx_prtx.s.en = 0;
+	cvmx_write_csr(CVMX_AGL_GMX_PRTX_CFG(port), agl_gmx_prtx.u64);
+
+	cvmx_spinlock_unlock(&state->lock);
+	return CVMX_MGMT_PORT_SUCCESS;
+}
+
+/**
+ * Send a packet out the management port. The packet is copied so
+ * the input buffer isn't used after this call.
+ *
+ * @port:       Management port
+ * @packet_len: Length of the packet to send. It does not include the final CRC
+ * @buffer:     Packet data
+ *
+ * Returns CVMX_MGMT_PORT_SUCCESS or an error code
+ */
+enum cvmx_mgmt_port_result cvmx_mgmt_port_send(int port, int packet_len,
+					       void *buffer)
+{
+	struct cvmx_mgmt_port_state *state;
+	union cvmx_mixx_oring2 mix_oring2;
+
+	if ((port < 0) || (port >= __cvmx_mgmt_port_num_ports()))
+		return CVMX_MGMT_PORT_INVALID_PARAM;
+
+	/* Max sure the packet size is valid */
+	if ((packet_len < 1) || (packet_len > CVMX_MGMT_PORT_TX_BUFFER_SIZE))
+		return CVMX_MGMT_PORT_INVALID_PARAM;
+
+	if (buffer == NULL)
+		return CVMX_MGMT_PORT_INVALID_PARAM;
+
+	state = cvmx_mgmt_port_state_ptr + port;
+
+	cvmx_spinlock_lock(&state->lock);
+
+	mix_oring2.u64 = cvmx_read_csr(CVMX_MIXX_ORING2(port));
+	if (mix_oring2.s.odbell >= CVMX_MGMT_PORT_NUM_TX_BUFFERS - 1) {
+		/* No room for another packet */
+		cvmx_spinlock_unlock(&state->lock);
+		return CVMX_MGMT_PORT_NO_MEMORY;
+	} else {
+		/* Copy the packet into the output buffer */
+		memcpy(state->tx_buffers[state->tx_write_index], buffer,
+		       packet_len);
+		/* Insert the source MAC */
+		memcpy(state->tx_buffers[state->tx_write_index] + 6,
+		       ((char *)&state->mac) + 2, 6);
+		/* Update the TX ring buffer entry size */
+		state->tx_ring[state->tx_write_index].s.len = packet_len;
+		/* Increment our TX index */
+		state->tx_write_index =
+		    (state->tx_write_index + 1) % CVMX_MGMT_PORT_NUM_TX_BUFFERS;
+		/* Ring the doorbell, send ing the packet */
+		CVMX_SYNCWS;
+		cvmx_write_csr(CVMX_MIXX_ORING2(port), 1);
+		if (cvmx_read_csr(CVMX_MIXX_ORCNT(port)))
+			cvmx_write_csr(CVMX_MIXX_ORCNT(port),
+				       cvmx_read_csr(CVMX_MIXX_ORCNT(port)));
+
+		cvmx_spinlock_unlock(&state->lock);
+		return CVMX_MGMT_PORT_SUCCESS;
+	}
+}
+
+/**
+ * Receive a packet from the management port.
+ *
+ * @port:       Management port
+ * @buffer_len: Size of the buffer to receive the packet into
+ * @buffer:     Buffer to receive the packet into
+ *
+ * Returns The size of the packet, or a negative erorr code on failure. Zero
+ *         means that no packets were available.
+ */
+int cvmx_mgmt_port_receive(int port, int buffer_len, void *buffer)
+{
+	union cvmx_mixx_ircnt mix_ircnt;
+	struct cvmx_mgmt_port_state *state;
+	int result;
+
+	if ((port < 0) || (port >= __cvmx_mgmt_port_num_ports()))
+		return CVMX_MGMT_PORT_INVALID_PARAM;
+
+	/* Max sure the buffer size is valid */
+	if (buffer_len < 1)
+		return CVMX_MGMT_PORT_INVALID_PARAM;
+
+	if (buffer == NULL)
+		return CVMX_MGMT_PORT_INVALID_PARAM;
+
+	state = cvmx_mgmt_port_state_ptr + port;
+
+	cvmx_spinlock_lock(&state->lock);
+
+	/* Find out how many RX packets are pending */
+	mix_ircnt.u64 = cvmx_read_csr(CVMX_MIXX_IRCNT(port));
+	if (mix_ircnt.s.ircnt) {
+		void *source = state->rx_buffers[state->rx_read_index];
+		uint64_t *zero_check = source;
+		/*
+		 * CN56XX pass 1 has an errata where packets might
+		 * start 8 bytes into the buffer instead of at their
+		 * correct location. If the first 8 bytes is zero we
+		 * assume this has happened.
+		 */
+		if (OCTEON_IS_MODEL(OCTEON_CN56XX_PASS1_X)
+		    && (*zero_check == 0))
+			source += 8;
+		/* Start off with zero bytes received */
+		result = 0;
+		/*
+		 * While the completion code signals more data, copy
+		 * the buffers into the user's data.
+		 */
+		while (state->rx_ring[state->rx_read_index].s.code == 16) {
+			/* Only copy what will fit in the user's buffer */
+			int length = state->rx_ring[state->rx_read_index].s.len;
+			if (length > buffer_len)
+				length = buffer_len;
+			memcpy(buffer, source, length);
+			/*
+			 * Reduce the size of the buffer to the
+			 * remaining space. If we run out we will
+			 * signal an error when the code 15 buffer
+			 * doesn't fit.
+			 */
+			buffer += length;
+			buffer_len -= length;
+			result += length;
+			/*
+			 * Update this buffer for reuse in future
+			 * receives. This size is -8 due to an errata
+			 * for CN56XX pass 1.
+			 */
+			state->rx_ring[state->rx_read_index].s.code = 0;
+			state->rx_ring[state->rx_read_index].s.len =
+			    CVMX_MGMT_PORT_RX_BUFFER_SIZE - 8;
+			state->rx_read_index =
+			    (state->rx_read_index +
+			     1) % CVMX_MGMT_PORT_NUM_RX_BUFFERS;
+			/*
+			 * Zero the beginning of the buffer for use by
+			 * the errata check.
+			 */
+			*zero_check = 0;
+			CVMX_SYNCWS;
+			/* Increment the number of RX buffers */
+			cvmx_write_csr(CVMX_MIXX_IRING2(port), 1);
+			source = state->rx_buffers[state->rx_read_index];
+			zero_check = source;
+		}
+
+		/* Check for the final good completion code */
+		if (state->rx_ring[state->rx_read_index].s.code == 15) {
+			if (buffer_len >=
+			    state->rx_ring[state->rx_read_index].s.len) {
+				int length =
+				    state->rx_ring[state->rx_read_index].s.len;
+				memcpy(buffer, source, length);
+				result += length;
+			} else {
+				/* Not enough room for the packet */
+				cvmx_dprintf("ERROR: cvmx_mgmt_port_receive: "
+					"Packet (%d) larger than "
+					"supplied buffer (%d)\n",
+					state->rx_ring[state->rx_read_index].s.len,
+					     buffer_len);
+				result = CVMX_MGMT_PORT_NO_MEMORY;
+			}
+		} else {
+			union cvmx_agl_gmx_prtx_cfg agl_gmx_prtx;
+			cvmx_dprintf("ERROR: cvmx_mgmt_port_receive: Receive "
+				"error code %d. Packet dropped(Len %d)\n",
+				state->rx_ring[state->rx_read_index].s.code,
+				state->rx_ring[state->rx_read_index].s.len +
+				result);
+			result = -state->rx_ring[state->rx_read_index].s.code;
+
+			/* Check to see if we need to change the duplex. */
+			agl_gmx_prtx.u64 =
+			    cvmx_read_csr(CVMX_AGL_GMX_PRTX_CFG(port));
+			if (cvmx_mgmt_port_get_link(port) < 0)
+				agl_gmx_prtx.s.duplex = 0;
+			else
+				agl_gmx_prtx.s.duplex = 1;
+			cvmx_write_csr(CVMX_AGL_GMX_PRTX_CFG(port),
+				       agl_gmx_prtx.u64);
+		}
+
+		/*
+		 * Clean out the ring buffer entry. This size is -8
+		 * due to an errata for CN56XX pass 1.
+		 */
+		state->rx_ring[state->rx_read_index].s.code = 0;
+		state->rx_ring[state->rx_read_index].s.len =
+		    CVMX_MGMT_PORT_RX_BUFFER_SIZE - 8;
+		state->rx_read_index =
+		    (state->rx_read_index + 1) % CVMX_MGMT_PORT_NUM_RX_BUFFERS;
+		/*
+		 * Zero the beginning of the buffer for use by the
+		 * errata check.
+		 */
+		*zero_check = 0;
+		CVMX_SYNCWS;
+		/* Increment the number of RX buffers */
+		cvmx_write_csr(CVMX_MIXX_IRING2(port), 1);
+		/* Decrement the pending RX count */
+		cvmx_write_csr(CVMX_MIXX_IRCNT(port), 1);
+	} else {
+		/* No packets available */
+		result = 0;
+	}
+	cvmx_spinlock_unlock(&state->lock);
+	return result;
+}
+
+/**
+ * Get the management port link status:
+ * 100 = 100Mbps, full duplex
+ * 10 = 10Mbps, full duplex
+ * 0 = Link down
+ * -10 = 10Mpbs, half duplex
+ * -100 = 100Mbps, half duplex
+ *
+ * @port:   Management port
+ *
+ * Returns
+ */
+int cvmx_mgmt_port_get_link(int port)
+{
+	struct cvmx_mgmt_port_state *state;
+	int phy_status;
+	int duplex;
+
+	if ((port < 0) || (port >= __cvmx_mgmt_port_num_ports()))
+		return CVMX_MGMT_PORT_INVALID_PARAM;
+
+	state = cvmx_mgmt_port_state_ptr + port;
+
+	/* Assume 100Mbps if we don't know the PHY address */
+	if (state->phy_id == -1)
+		return 100;
+
+	/* Read the PHY state */
+	phy_status =
+	    cvmx_mdio_read(state->phy_id >> 8, state->phy_id & 0xff, 17);
+
+	/* Only return a link if the PHY has finished auto negotiation
+	   and set the resolved bit (bit 11) */
+	if (!(phy_status & (1 << 11)))
+		return 0;
+
+	/* Create multiple factor to represent duplex */
+	if ((phy_status >> 13) & 1)
+		duplex = 1;
+	else
+		duplex = -1;
+
+	/* Speed is encoded on bits 15-14 */
+	switch ((phy_status >> 14) & 3) {
+	case 0:		/* 10 Mbps */
+		return 10 * duplex;
+	case 1:		/* 100 Mbps */
+		return 100 * duplex;
+	default:
+		return 0;
+	}
+}
+
+/**
+ * Set the MAC address for a management port
+ *
+ * @port:   Management port
+ * @mac:    New MAC address. The lower 6 bytes are used.
+ *
+ * Returns CVMX_MGMT_PORT_SUCCESS or an error code
+ */
+enum cvmx_mgmt_port_result cvmx_mgmt_port_set_mac(int port, uint64_t mac)
+{
+	struct cvmx_mgmt_port_state *state;
+	union cvmx_agl_gmx_rxx_adr_ctl agl_gmx_rxx_adr_ctl;
+
+	if ((port < 0) || (port >= __cvmx_mgmt_port_num_ports()))
+		return CVMX_MGMT_PORT_INVALID_PARAM;
+
+	state = cvmx_mgmt_port_state_ptr + port;
+
+	cvmx_spinlock_lock(&state->lock);
+
+	agl_gmx_rxx_adr_ctl.u64 = 0;
+	/* Only accept matching MAC addresses */
+	agl_gmx_rxx_adr_ctl.s.cam_mode = 1;
+	/* Drop multicast */
+	agl_gmx_rxx_adr_ctl.s.mcst = 0;
+	/* Allow broadcast */
+	agl_gmx_rxx_adr_ctl.s.bcst = 1;
+	cvmx_write_csr(CVMX_AGL_GMX_RXX_ADR_CTL(port), agl_gmx_rxx_adr_ctl.u64);
+
+	/* Only using one of the CAMs */
+	cvmx_write_csr(CVMX_AGL_GMX_RXX_ADR_CAM0(port), (mac >> 40) & 0xff);
+	cvmx_write_csr(CVMX_AGL_GMX_RXX_ADR_CAM1(port), (mac >> 32) & 0xff);
+	cvmx_write_csr(CVMX_AGL_GMX_RXX_ADR_CAM2(port), (mac >> 24) & 0xff);
+	cvmx_write_csr(CVMX_AGL_GMX_RXX_ADR_CAM3(port), (mac >> 16) & 0xff);
+	cvmx_write_csr(CVMX_AGL_GMX_RXX_ADR_CAM4(port), (mac >> 8) & 0xff);
+	cvmx_write_csr(CVMX_AGL_GMX_RXX_ADR_CAM5(port), (mac >> 0) & 0xff);
+	cvmx_write_csr(CVMX_AGL_GMX_RXX_ADR_CAM_EN(port), 1);
+	state->mac = mac;
+
+	cvmx_spinlock_unlock(&state->lock);
+	return CVMX_MGMT_PORT_SUCCESS;
+}
+
+/**
+ * Get the MAC address for a management port
+ *
+ * @port:   Management port
+ *
+ * Returns MAC address
+ */
+uint64_t cvmx_mgmt_port_get_mac(int port)
+{
+	if ((port < 0) || (port >= __cvmx_mgmt_port_num_ports()))
+		return CVMX_MGMT_PORT_INVALID_PARAM;
+
+	return cvmx_mgmt_port_state_ptr[port].mac;
+}
+
+/**
+ * Set the multicast list.
+ *
+ * @port:   Management port
+ * @flags:  Interface flags
+ *
+ * Returns
+ */
+void cvmx_mgmt_port_set_multicast_list(int port, int flags)
+{
+	struct cvmx_mgmt_port_state *state;
+	union cvmx_agl_gmx_rxx_adr_ctl agl_gmx_rxx_adr_ctl;
+
+	if ((port < 0) || (port >= __cvmx_mgmt_port_num_ports()))
+		return;
+
+	state = cvmx_mgmt_port_state_ptr + port;
+
+	cvmx_spinlock_lock(&state->lock);
+
+	agl_gmx_rxx_adr_ctl.u64 = cvmx_read_csr(CVMX_AGL_GMX_RXX_ADR_CTL(port));
+
+	/* Allow broadcast MAC addresses */
+	if (!agl_gmx_rxx_adr_ctl.s.bcst)
+		agl_gmx_rxx_adr_ctl.s.bcst = 1;
+
+	if ((flags & CVMX_IFF_ALLMULTI) || (flags & CVMX_IFF_PROMISC))
+		/* Force accept multicast packets */
+		agl_gmx_rxx_adr_ctl.s.mcst = 2;
+	else
+		/* Force reject multicast packets */
+		agl_gmx_rxx_adr_ctl.s.mcst = 1;
+
+	if (flags & CVMX_IFF_PROMISC)
+		/*
+		 * Reject matches if promisc. Since CAM is shut off,
+		 * should accept everything.
+		 */
+		agl_gmx_rxx_adr_ctl.s.cam_mode = 0;
+	else
+		/* Filter packets based on the CAM */
+		agl_gmx_rxx_adr_ctl.s.cam_mode = 1;
+
+	cvmx_write_csr(CVMX_AGL_GMX_RXX_ADR_CTL(port), agl_gmx_rxx_adr_ctl.u64);
+
+	if (flags & CVMX_IFF_PROMISC)
+		cvmx_write_csr(CVMX_AGL_GMX_RXX_ADR_CAM_EN(port), 0);
+	else
+		cvmx_write_csr(CVMX_AGL_GMX_RXX_ADR_CAM_EN(port), 1);
+
+	cvmx_spinlock_unlock(&state->lock);
+}
+
+/**
+ * Set the maximum packet allowed in. Size is specified
+ * including L2 but without FCS. A normal MTU would corespond
+ * to 1514 assuming the standard 14 byte L2 header.
+ *
+ * @port:   Management port
+ * @size_without_fcs:
+ *               Size in bytes without FCS
+ */
+void cvmx_mgmt_port_set_max_packet_size(int port, int size_without_fcs)
+{
+	struct cvmx_mgmt_port_state *state;
+
+	if ((port < 0) || (port >= __cvmx_mgmt_port_num_ports()))
+		return;
+
+	state = cvmx_mgmt_port_state_ptr + port;
+
+	cvmx_spinlock_lock(&state->lock);
+	cvmx_write_csr(CVMX_AGL_GMX_RXX_FRM_MAX(port), size_without_fcs);
+	cvmx_write_csr(CVMX_AGL_GMX_RXX_JABBER(port),
+		       (size_without_fcs + 7) & 0xfff8);
+	cvmx_spinlock_unlock(&state->lock);
+}
diff --git a/drivers/net/octeon/cvmx-mgmt-port.h b/drivers/net/octeon/cvmx-mgmt-port.h
new file mode 100644
index 0000000..622168c
--- /dev/null
+++ b/drivers/net/octeon/cvmx-mgmt-port.h
@@ -0,0 +1,168 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/**
+ *
+ * Support functions for managing the MII management port
+ *
+ */
+
+#ifndef __CVMX_MGMT_PORT_H__
+#define __CVMX_MGMT_PORT_H__
+
+enum cvmx_mgmt_port_result {
+	CVMX_MGMT_PORT_SUCCESS = 0,
+	CVMX_MGMT_PORT_NO_MEMORY = -1,
+	CVMX_MGMT_PORT_INVALID_PARAM = -2,
+};
+
+/* Enumeration of Net Device interface flags. */
+enum cvmx_mgmt_port_netdevice_flags {
+	CVMX_IFF_PROMISC = 0x100,	/* receive all packets           */
+	CVMX_IFF_ALLMULTI = 0x200,	/* receive all multicast packets */
+};
+
+/**
+ * Called to initialize a management port for use. Multiple calls
+ * to this function accross applications is safe.
+ *
+ * @port:   Port to initialize
+ *
+ * Returns CVMX_MGMT_PORT_SUCCESS or an error code
+ */
+extern enum cvmx_mgmt_port_result cvmx_mgmt_port_initialize(int port);
+
+/**
+ * Shutdown a management port. This currently disables packet IO
+ * but leaves all hardware and buffers. Another application can then
+ * call initialize() without redoing the hardware setup.
+ *
+ * @port:   Management port
+ *
+ * Returns CVMX_MGMT_PORT_SUCCESS or an error code
+ */
+extern enum cvmx_mgmt_port_result cvmx_mgmt_port_shutdown(int port);
+
+/**
+ * Enable packet IO on a management port
+ *
+ * @port:   Management port
+ *
+ * Returns CVMX_MGMT_PORT_SUCCESS or an error code
+ */
+extern enum cvmx_mgmt_port_result cvmx_mgmt_port_enable(int port);
+
+/**
+ * Disable packet IO on a management port
+ *
+ * @port:   Management port
+ *
+ * Returns CVMX_MGMT_PORT_SUCCESS or an error code
+ */
+extern enum cvmx_mgmt_port_result cvmx_mgmt_port_disable(int port);
+
+/**
+ * Send a packet out the management port. The packet is copied so
+ * the input buffer isn't used after this call.
+ *
+ * @port:       Management port
+ * @packet_len: Length of the packet to send. It does not include the final CRC
+ * @buffer:     Packet data
+ *
+ * Returns CVMX_MGMT_PORT_SUCCESS or an error code
+ */
+extern enum cvmx_mgmt_port_result cvmx_mgmt_port_send(int port, int packet_len,
+						      void *buffer);
+
+/**
+ * Receive a packet from the management port.
+ *
+ * @port:       Management port
+ * @buffer_len: Size of the buffer to receive the packet into
+ * @buffer:     Buffer to receive the packet into
+ *
+ * Returns The size of the packet, or a negative erorr code on failure. Zero
+ *         means that no packets were available.
+ */
+extern int cvmx_mgmt_port_receive(int port, int buffer_len, void *buffer);
+
+/**
+ * Get the management port link status:
+ * 100 = 100Mbps, full duplex
+ * 10 = 10Mbps, full duplex
+ * 0 = Link down
+ * -10 = 10Mpbs, half duplex
+ * -100 = 100Mbps, half duplex
+ *
+ * @port:   Management port
+ *
+ * Returns
+ */
+extern int cvmx_mgmt_port_get_link(int port);
+
+/**
+ * Set the MAC address for a management port
+ *
+ * @port:   Management port
+ * @mac:    New MAC address. The lower 6 bytes are used.
+ *
+ * Returns CVMX_MGMT_PORT_SUCCESS or an error code
+ */
+extern enum cvmx_mgmt_port_result cvmx_mgmt_port_set_mac(int port,
+							 uint64_t mac);
+
+/**
+ * Get the MAC address for a management port
+ *
+ * @port:   Management port
+ *
+ * Returns MAC address
+ */
+extern uint64_t cvmx_mgmt_port_get_mac(int port);
+
+/**
+ * Set the multicast list.
+ *
+ * @port:   Management port
+ * @flags:  Interface flags
+ *
+ * Returns
+ */
+extern void cvmx_mgmt_port_set_multicast_list(int port, int flags);
+
+/**
+ * Set the maximum packet allowed in. Size is specified
+ * including L2 but without FCS. A normal MTU would corespond
+ * to 1514 assuming the standard 14 byte L2 header.
+ *
+ * @port:   Management port
+ * @size_without_crc:
+ *               Size in bytes without FCS
+ */
+extern void cvmx_mgmt_port_set_max_packet_size(int port, int size_without_fcs);
+
+#endif /* __CVMX_MGMT_PORT_H__ */
diff --git a/drivers/net/octeon/octeon-mgmt-port.c b/drivers/net/octeon/octeon-mgmt-port.c
new file mode 100644
index 0000000..9cffbb5
--- /dev/null
+++ b/drivers/net/octeon/octeon-mgmt-port.c
@@ -0,0 +1,389 @@
+/*
+ *   Octeon Management Port Ethernet Driver
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2007, 2008 Cavium Networks
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/ip.h>
+#include <linux/string.h>
+#include <linux/delay.h>
+
+#include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-mixx-defs.h>
+#include <asm/octeon/cvmx-agl-defs.h>
+
+#include "cvmx-mgmt-port.h"
+
+static struct net_device *global_dev[2] = { NULL, NULL };
+
+#define DEBUGPRINT(format, ...) do {if (printk_ratelimit())		\
+					printk(format, ##__VA_ARGS__);	\
+				} while (0)
+
+/**
+ * This is the definition of the Ethernet driver's private
+ * driver state stored in dev->priv.
+ */
+struct device_private {
+	int port;
+	struct net_device_stats stats;	/* Device statistics */
+};
+
+
+/**
+ * Packet transmit
+ *
+ * @param skb    Packet to send
+ * @param dev    Device info structure
+ * @return Always returns zero
+ */
+static int packet_transmit(struct sk_buff *skb, struct net_device *dev)
+{
+	uint64_t flags;
+	struct device_private *priv = (struct device_private *) dev->priv;
+	enum cvmx_mgmt_port_result result;
+	local_irq_save(flags);
+	result = cvmx_mgmt_port_send(priv->port, skb->len, skb->data);
+	local_irq_restore(flags);
+	if (result == CVMX_MGMT_PORT_SUCCESS) {
+		priv->stats.tx_packets++;
+		priv->stats.tx_bytes += skb->len;
+	} else {
+		/* DEBUGPRINT("ERROR: cvmx_mgmt_port_send() failed with %d\n",
+				result);
+		*/
+		priv->stats.tx_dropped++;
+	}
+	dev_kfree_skb(skb);
+	return 0;
+}
+
+
+/**
+ * Interrupt handler. The interrupt occurs whenever the POW
+ * transitions from 0->1 packets in our group.
+ *
+ * @param cpl
+ * @param dev_id
+ * @param regs
+ * @return
+ */
+static irqreturn_t do_interrupt(int cpl, void *dev_id)
+{
+	uint64_t flags;
+	struct sk_buff *skb;
+	int result;
+	char packet[2048];
+	struct net_device *dev = (struct net_device *) dev_id;
+	struct device_private *priv = (struct device_private *) dev->priv;
+
+	do {
+		local_irq_save(flags);
+		result = cvmx_mgmt_port_receive(priv->port, sizeof(packet),
+						packet);
+		local_irq_restore(flags);
+
+		/* Silently drop packets if we aren't up */
+		if ((dev->flags & IFF_UP) == 0)
+			continue;
+
+		if (result > 0) {
+			skb = dev_alloc_skb(result);
+			if (skb) {
+				memcpy(skb_put(skb, result), packet, result);
+				skb->protocol = eth_type_trans(skb, dev);
+				skb->dev = dev;
+				skb->ip_summed = CHECKSUM_NONE;
+				priv->stats.rx_bytes += skb->len;
+				priv->stats.rx_packets++;
+				netif_rx(skb);
+			} else {
+				DEBUGPRINT("%s: Failed to allocate skbuff, "
+					   "packet dropped\n",
+					   dev->name);
+				priv->stats.rx_dropped++;
+			}
+		} else if (result < 0) {
+			DEBUGPRINT("%s: Receive error code %d, packet "
+				   "dropped\n",
+				   dev->name, result);
+			priv->stats.rx_errors++;
+		}
+	} while (result != 0);
+
+	/* Clear any pending interrupts */
+	cvmx_write_csr(CVMX_MIXX_ISR(priv->port),
+		       cvmx_read_csr(CVMX_MIXX_ISR(priv->port)));
+	cvmx_read_csr(CVMX_MIXX_ISR(priv->port));
+
+	return IRQ_HANDLED;
+}
+
+
+#ifdef CONFIG_NET_POLL_CONTROLLER
+/**
+ * This is called when the kernel needs to manually poll the
+ * device. For Octeon, this is simply calling the interrupt
+ * handler. We actually poll all the devices, not just the
+ * one supplied.
+ *
+ * @param dev    Device to poll. Unused
+ */
+static void device_poll_controller(struct net_device *dev)
+{
+	do_interrupt(0, dev);
+}
+#endif
+
+
+/**
+ * Open a device for use. Device should be able to send and
+ * receive packets after this is called.
+ *
+ * @param dev    Device to bring up
+ * @return Zero on success
+ */
+static int device_open(struct net_device *dev)
+{
+	/* Clear the statistics whenever the interface is brought up */
+	struct device_private *priv = (struct device_private *) dev->priv;
+	memset(&priv->stats, 0, sizeof(priv->stats));
+	cvmx_mgmt_port_enable(priv->port);
+	return 0;
+}
+
+
+/**
+ * Stop an ethernet device. No more packets should be
+ * received from this device.
+ *
+ * @param dev    Device to bring down
+ * @return Zero on success
+ */
+static int device_close(struct net_device *dev)
+{
+	struct device_private *priv = (struct device_private *) dev->priv;
+	cvmx_mgmt_port_disable(priv->port);
+	return 0;
+}
+
+
+/**
+ * Get the low level ethernet statistics
+ *
+ * @param dev    Device to get the statistics from
+ * @return Pointer to the statistics
+ */
+static struct net_device_stats *device_get_stats(struct net_device *dev)
+{
+	struct device_private *priv = (struct device_private *) dev->priv;
+	return &priv->stats;
+}
+
+/**
+ * Set the multicast list. Currently unimplemented.
+ *
+ * @param dev    Device to work on
+ */
+static void ethernet_mgmt_port_set_multicast_list(struct net_device *dev)
+{
+	struct device_private *priv = (struct device_private *)dev->priv;
+	int port = priv->port;
+	int num_ports;
+	if (OCTEON_IS_MODEL(OCTEON_CN52XX))
+		num_ports = 2;
+	else
+		num_ports = 1;
+	if (port < num_ports)
+		cvmx_mgmt_port_set_multicast_list(port, dev->flags);
+}
+
+/**
+ * Set the hardware MAC address for a management port device
+ *
+ * @param dev    Device to change the MAC address for
+ * @param addr   Address structure to change it too. MAC address is addr + 2.
+ * @return Zero on success
+ */
+static int ethernet_mgmt_port_set_mac_address(struct net_device *dev,
+					      void *addr)
+{
+	struct device_private *priv = (struct device_private *) dev->priv;
+	union cvmx_agl_gmx_prtx_cfg agl_gmx_cfg;
+	int port = priv->port;
+	int num_ports;
+
+	if (OCTEON_IS_MODEL(OCTEON_CN52XX))
+		num_ports = 2;
+	else
+		num_ports = 1;
+
+	memcpy(dev->dev_addr, addr + 2, 6);
+
+	if (port < num_ports) {
+		int i;
+		uint8_t *ptr = addr;
+		uint64_t mac = 0;
+		for (i = 0; i < 6; i++)
+			mac = (mac<<8) | (uint64_t)(ptr[i+2]);
+
+		agl_gmx_cfg.u64 = cvmx_read_csr(CVMX_AGL_GMX_PRTX_CFG(port));
+		cvmx_mgmt_port_set_mac(port, mac);
+		ethernet_mgmt_port_set_multicast_list(dev);
+		cvmx_write_csr(CVMX_AGL_GMX_PRTX_CFG(port), agl_gmx_cfg.u64);
+	}
+	return 0;
+}
+
+/**
+ * Per network device initialization
+ *
+ * @param dev    Device to initialize
+ * @return Zero on success
+ */
+static int device_init(struct net_device *dev)
+{
+	struct device_private *priv = (struct device_private *) dev->priv;
+	uint64_t mac = cvmx_mgmt_port_get_mac(priv->port);
+
+	dev->hard_start_xmit = packet_transmit;
+	dev->get_stats = device_get_stats;
+	dev->open = device_open;
+	dev->stop = device_close;
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	dev->poll_controller = device_poll_controller;
+#endif
+	dev->dev_addr[0] = (mac >> 40) & 0xff;
+	dev->dev_addr[1] = (mac >> 32) & 0xff;
+	dev->dev_addr[2] = (mac >> 24) & 0xff;
+	dev->dev_addr[3] = (mac >> 16) & 0xff;
+	dev->dev_addr[4] = (mac >> 8) & 0xff;
+	dev->dev_addr[5] = (mac >> 0) & 0xff;
+	return 0;
+}
+
+
+/**
+ * Module/ driver initialization. Creates the linux network
+ * devices.
+ *
+ * @return Zero on success
+ */
+static int __init ethernet_mgmt_port_init(void)
+{
+	struct net_device *dev;
+	struct device_private *priv;
+	union cvmx_mixx_irhwm mix_irhwm;
+	union cvmx_mixx_intena mix_intena;
+	int num_ports;
+	int port;
+
+	if (!OCTEON_IS_MODEL(OCTEON_CN56XX) && !OCTEON_IS_MODEL(OCTEON_CN52XX))
+		return 0;
+
+	if (OCTEON_IS_MODEL(OCTEON_CN52XX))
+		num_ports = 2;
+	else
+		num_ports = 1;
+
+	printk("Octeon management port ethernet driver\n");
+
+	for (port = 0; port < num_ports; port++) {
+		if (cvmx_mgmt_port_initialize(port) != CVMX_MGMT_PORT_SUCCESS) {
+			pr_err("ERROR: cvmx_mgmt_port_initialize(%d) "
+			       "failed\n", port);
+			return -1;
+		}
+
+		/* Setup is complete, create the virtual ethernet devices */
+		dev = alloc_etherdev(sizeof(struct device_private));
+		if (dev == NULL) {
+			pr_err("ERROR: Failed to allocate ethernet device\n");
+			return -1;
+		}
+
+		dev->init = device_init;
+		strcpy(dev->name, "mgmt%d");
+
+		/* Initialize the device private structure. */
+		priv = (struct device_private *) dev->priv;
+		memset(priv, 0, sizeof(struct device_private));
+		priv->port = port;
+
+		if (register_netdev(dev) < 0) {
+			pr_err("ERROR: Failed to register ethernet device\n");
+			kfree(dev);
+			return -1;
+		}
+
+		/* Clear any pending interrupts */
+		cvmx_write_csr(CVMX_MIXX_ISR(priv->port),
+			       cvmx_read_csr(CVMX_MIXX_ISR(priv->port)));
+
+		/* Register an IRQ hander for to receive interrupts */
+		dev->irq =
+			(priv->port == 0) ? OCTEON_IRQ_MII0 : OCTEON_IRQ_MII1;
+		if (request_irq(dev->irq, do_interrupt, IRQF_SHARED, dev->name,
+			    dev))
+			pr_err("ethernet-mgmt: Failed to assign "
+			       "interrupt %d\n", dev->irq);
+
+		/* Interrupt every single RX packet */
+		mix_irhwm.u64 = 0;
+		mix_irhwm.s.irhwm = 0;
+		cvmx_write_csr(CVMX_MIXX_IRHWM(priv->port), mix_irhwm.u64);
+
+		/* Enable receive interrupts */
+		mix_intena.u64 = 0;
+		mix_intena.s.ithena = 1;
+		cvmx_write_csr(CVMX_MIXX_INTENA(priv->port), mix_intena.u64);
+
+		global_dev[priv->port] = dev;
+
+		dev->set_mac_address = ethernet_mgmt_port_set_mac_address;
+		dev->set_multicast_list = ethernet_mgmt_port_set_multicast_list;
+	}
+	return 0;
+}
+
+
+/**
+ * Module / driver shutdown
+ *
+ * @return Zero on success
+ */
+static void __exit ethernet_mgmt_port_cleanup(void)
+{
+	int port;
+	for (port = 0; port < 2; port++) {
+		if (global_dev[port]) {
+			struct device_private *priv =
+				(struct device_private *) global_dev[port]->priv;
+			/* Disable interrupt */
+			cvmx_write_csr(CVMX_MIXX_IRHWM(priv->port), 0);
+			cvmx_write_csr(CVMX_MIXX_INTENA(priv->port), 0);
+			cvmx_mgmt_port_shutdown(priv->port);
+
+			/* Free the interrupt handler */
+			free_irq(global_dev[port]->irq, global_dev[port]);
+
+			/* Free the ethernet devices */
+			unregister_netdev(global_dev[port]);
+			kfree(global_dev[port]);
+			global_dev[port] = NULL;
+		}
+	}
+}
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Cavium Networks <support@caviumnetworks.com>");
+MODULE_DESCRIPTION("Cavium Networks Octeon management port ethernet driver.");
+module_init(ethernet_mgmt_port_init);
+module_exit(ethernet_mgmt_port_cleanup);
-- 
1.5.6.5
