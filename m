Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2017 07:17:27 +0100 (CET)
Received: from smtp.gentoo.org ([140.211.166.183]:34058 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992214AbdBGGORZwSCr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Feb 2017 07:14:17 +0100
Received: from helcaraxe.arda (c-73-201-78-97.hsd1.md.comcast.net [73.201.78.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kumba)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 39ABE3416A7;
        Tue,  7 Feb 2017 06:14:09 +0000 (UTC)
From:   Joshua Kinard <kumba@gentoo.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>
Subject: [PATCH 08/12] MIPS: BRIDGE: Update ops-bridge.c
Date:   Tue,  7 Feb 2017 01:13:52 -0500
Message-Id: <20170207061356.8270-9-kumba@gentoo.org>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170207061356.8270-1-kumba@gentoo.org>
References: <20170207061356.8270-1-kumba@gentoo.org>
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

From: Joshua Kinard <kumba@gentoo.org>

Update arch/mips/pci/ops-bridge.c to use the new access structs added
to bridge.h in the BRIDGE overhaul patch.  Additional changes include
various fixes to comments, whitespace, and marking the 'bridge_pci_ops'
struct as __read_mostly.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/pci/ops-bridge.c | 125 ++++++++++++++++++-----------------
 1 file changed, 65 insertions(+), 60 deletions(-)

diff --git a/arch/mips/pci/ops-bridge.c b/arch/mips/pci/ops-bridge.c
index 57e1463fcd02..6793a72edec2 100644
--- a/arch/mips/pci/ops-bridge.c
+++ b/arch/mips/pci/ops-bridge.c
@@ -8,16 +8,20 @@
  */
 #include <linux/pci.h>
 #include <asm/paccess.h>
+
+#if defined(CONFIG_SGI_IP27)
 #include <asm/pci/bridge.h>
 #include <asm/sn/arch.h>
 #include <asm/sn/intr.h>
 #include <asm/sn/sn0/hub.h>
+#endif
 
 /*
  * Most of the IOC3 PCI config register aren't present
  * we emulate what is needed for a normal PCI enumeration
  */
-static u32 emulate_ioc3_cfg(int where, int size)
+static inline u32
+emulate_ioc3_cfg(int where, int size)
 {
 	if (size == 1 && where == 0x3d)
 		return 0x01;
@@ -40,29 +44,29 @@ static u32 emulate_ioc3_cfg(int where, int size)
  * accesses and does only decode parts of it's address space.
  */
 
-static int pci_conf0_read_config(struct pci_bus *bus, unsigned int devfn,
-				 int where, int size, u32 * value)
+static int
+pci_conf0_read_config(struct pci_bus *bus, u32 devfn, int where, int size,
+		      u32 *value)
 {
 	struct bridge_controller *bc = BRIDGE_CONTROLLER(bus);
-	bridge_t *bridge = bc->base;
 	int slot = PCI_SLOT(devfn);
 	int fn = PCI_FUNC(devfn);
 	volatile void *addr;
 	u32 cf, shift, mask;
 	int res;
 
-	addr = &bridge->b_type0_cfg_dev[slot].f[fn].c[PCI_VENDOR_ID];
+	addr = &bc->bridge->pci_t0[slot].func[fn].b[PCI_VENDOR_ID];
 	if (get_dbe(cf, (u32 *) addr))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
-	 * generic PCI code a chance to look at it for real ...
+	 * IOC3 is fucking fucked beyond belief.  Don't even give the
+	 * generic PCI code a chance to look at it for real.
 	 */
 	if (cf == (PCI_VENDOR_ID_SGI | (PCI_DEVICE_ID_SGI_IOC3 << 16)))
 		goto oh_my_gawd;
 
-	addr = &bridge->b_type0_cfg_dev[slot].f[fn].c[where ^ (4 - size)];
+	addr = &bc->bridge->pci_t0[slot].func[fn].b[where ^ (4 - size)];
 
 	if (size == 1)
 		res = get_dbe(*value, (u8 *) addr);
@@ -74,9 +78,8 @@ static int pci_conf0_read_config(struct pci_bus *bus, unsigned int devfn,
 	return res ? PCIBIOS_DEVICE_NOT_FOUND : PCIBIOS_SUCCESSFUL;
 
 oh_my_gawd:
-
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
+	 * IOC3 is fucking fucked beyond belief.  Don't even give the
 	 * generic PCI code a chance to look at the wrong register.
 	 */
 	if ((where >= 0x14 && where < 0x40) || (where >= 0x48)) {
@@ -85,10 +88,10 @@ static int pci_conf0_read_config(struct pci_bus *bus, unsigned int devfn,
 	}
 
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't try to access
-	 * anything but 32-bit words ...
+	 * IOC3 is fucking fucked beyond belief.  Don't try to access
+	 * anything but 32-bit words.
 	 */
-	addr = &bridge->b_type0_cfg_dev[slot].f[fn].l[where >> 2];
+	addr = &bc->bridge->pci_t0[slot].func[fn].l[where >> 2];
 
 	if (get_dbe(cf, (u32 *) addr))
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -100,11 +103,11 @@ static int pci_conf0_read_config(struct pci_bus *bus, unsigned int devfn,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int pci_conf1_read_config(struct pci_bus *bus, unsigned int devfn,
-				 int where, int size, u32 * value)
+static int
+pci_conf1_read_config(struct pci_bus *bus, u32 devfn, int where, int size,
+		      u32 *value)
 {
 	struct bridge_controller *bc = BRIDGE_CONTROLLER(bus);
-	bridge_t *bridge = bc->base;
 	int busno = bus->number;
 	int slot = PCI_SLOT(devfn);
 	int fn = PCI_FUNC(devfn);
@@ -112,20 +115,20 @@ static int pci_conf1_read_config(struct pci_bus *bus, unsigned int devfn,
 	u32 cf, shift, mask;
 	int res;
 
-	bridge->b_pci_cfg = (busno << 16) | (slot << 11);
-	addr = &bridge->b_type1_cfg.c[(fn << 8) | PCI_VENDOR_ID];
+	bridge_write_reg(((busno << 16) | (slot << 11)), bc, b_pci_type1_cfg);
+	addr = &bc->bridge->pci_t1.b[(fn << 8) | PCI_VENDOR_ID];
 	if (get_dbe(cf, (u32 *) addr))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
-	 * generic PCI code a chance to look at it for real ...
+	 * IOC3 is fucking fucked beyond belief.  Don't even give the
+	 * generic PCI code a chance to look at it for real.
 	 */
 	if (cf == (PCI_VENDOR_ID_SGI | (PCI_DEVICE_ID_SGI_IOC3 << 16)))
 		goto oh_my_gawd;
 
-	bridge->b_pci_cfg = (busno << 16) | (slot << 11);
-	addr = &bridge->b_type1_cfg.c[(fn << 8) | (where ^ (4 - size))];
+	bridge_write_reg(((busno << 16) | (slot << 11)), bc, b_pci_type1_cfg);
+	addr = &bc->bridge->pci_t1.b[(fn << 8) | (where ^ (4 - size))];
 
 	if (size == 1)
 		res = get_dbe(*value, (u8 *) addr);
@@ -137,9 +140,8 @@ static int pci_conf1_read_config(struct pci_bus *bus, unsigned int devfn,
 	return res ? PCIBIOS_DEVICE_NOT_FOUND : PCIBIOS_SUCCESSFUL;
 
 oh_my_gawd:
-
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
+	 * IOC3 is fucking fucked beyond belief.  Don't even give the
 	 * generic PCI code a chance to look at the wrong register.
 	 */
 	if ((where >= 0x14 && where < 0x40) || (where >= 0x48)) {
@@ -148,11 +150,11 @@ static int pci_conf1_read_config(struct pci_bus *bus, unsigned int devfn,
 	}
 
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't try to access
-	 * anything but 32-bit words ...
+	 * IOC3 is fucking fucked beyond belief.  Don't try to access
+	 * anything but 32-bit words.
 	 */
-	bridge->b_pci_cfg = (busno << 16) | (slot << 11);
-	addr = &bridge->b_type1_cfg.c[(fn << 8) | where];
+	bridge_write_reg(((busno << 16) | (slot << 11)), bc, b_pci_type1_cfg);
+	addr = &bc->bridge->pci_t1.b[(fn << 8) | where];
 
 	if (get_dbe(cf, (u32 *) addr))
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -164,8 +166,9 @@ static int pci_conf1_read_config(struct pci_bus *bus, unsigned int devfn,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int pci_read_config(struct pci_bus *bus, unsigned int devfn,
-			   int where, int size, u32 * value)
+static int
+pci_read_config(struct pci_bus *bus, u32 devfn, int where, int size,
+		u32 *value)
 {
 	if (bus->number > 0)
 		return pci_conf1_read_config(bus, devfn, where, size, value);
@@ -173,29 +176,29 @@ static int pci_read_config(struct pci_bus *bus, unsigned int devfn,
 	return pci_conf0_read_config(bus, devfn, where, size, value);
 }
 
-static int pci_conf0_write_config(struct pci_bus *bus, unsigned int devfn,
-				  int where, int size, u32 value)
+static int
+pci_conf0_write_config(struct pci_bus *bus, u32 devfn, int where, int size,
+		       u32 value)
 {
 	struct bridge_controller *bc = BRIDGE_CONTROLLER(bus);
-	bridge_t *bridge = bc->base;
 	int slot = PCI_SLOT(devfn);
 	int fn = PCI_FUNC(devfn);
 	volatile void *addr;
 	u32 cf, shift, mask, smask;
 	int res;
 
-	addr = &bridge->b_type0_cfg_dev[slot].f[fn].c[PCI_VENDOR_ID];
+	addr = &bc->bridge->pci_t0[slot].func[fn].b[PCI_VENDOR_ID];
 	if (get_dbe(cf, (u32 *) addr))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
-	 * generic PCI code a chance to look at it for real ...
+	 * IOC3 is fucking fucked beyond belief.  Don't even give the
+	 * generic PCI code a chance to look at it for real.
 	 */
 	if (cf == (PCI_VENDOR_ID_SGI | (PCI_DEVICE_ID_SGI_IOC3 << 16)))
 		goto oh_my_gawd;
 
-	addr = &bridge->b_type0_cfg_dev[slot].f[fn].c[where ^ (4 - size)];
+	addr = &bc->bridge->pci_t0[slot].func[fn].b[where ^ (4 - size)];
 
 	if (size == 1) {
 		res = put_dbe(value, (u8 *) addr);
@@ -211,19 +214,18 @@ static int pci_conf0_write_config(struct pci_bus *bus, unsigned int devfn,
 	return PCIBIOS_SUCCESSFUL;
 
 oh_my_gawd:
-
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
-	 * generic PCI code a chance to touch the wrong register.
+	 * IOC3 is fucking fucked beyond belief.  Don't even give the
+	 * generic PCI code a chance to look at the wrong register.
 	 */
 	if ((where >= 0x14 && where < 0x40) || (where >= 0x48))
 		return PCIBIOS_SUCCESSFUL;
 
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't try to access
-	 * anything but 32-bit words ...
+	 * IOC3 is fucking fucked beyond belief.  Don't try to access
+	 * anything but 32-bit words.
 	 */
-	addr = &bridge->b_type0_cfg_dev[slot].f[fn].l[where >> 2];
+	addr = &bc->bridge->pci_t0[slot].func[fn].l[where >> 2];
 
 	if (get_dbe(cf, (u32 *) addr))
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -239,11 +241,11 @@ static int pci_conf0_write_config(struct pci_bus *bus, unsigned int devfn,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int pci_conf1_write_config(struct pci_bus *bus, unsigned int devfn,
-				  int where, int size, u32 value)
+static int
+pci_conf1_write_config(struct pci_bus *bus, u32 devfn, int where, int size,
+		       u32 value)
 {
 	struct bridge_controller *bc = BRIDGE_CONTROLLER(bus);
-	bridge_t *bridge = bc->base;
 	int slot = PCI_SLOT(devfn);
 	int fn = PCI_FUNC(devfn);
 	int busno = bus->number;
@@ -251,19 +253,20 @@ static int pci_conf1_write_config(struct pci_bus *bus, unsigned int devfn,
 	u32 cf, shift, mask, smask;
 	int res;
 
-	bridge->b_pci_cfg = (busno << 16) | (slot << 11);
-	addr = &bridge->b_type1_cfg.c[(fn << 8) | PCI_VENDOR_ID];
+	bridge_write_reg(((busno << 16) | (slot << 11)), bc, b_pci_type1_cfg);
+	addr = &bc->bridge->pci_t1.b[(fn << 8) | PCI_VENDOR_ID];
 	if (get_dbe(cf, (u32 *) addr))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
-	 * generic PCI code a chance to look at it for real ...
+	 * IOC3 is fucking fucked beyond belief.  Don't even give the
+	 * generic PCI code a chance to look at it for real.
 	 */
 	if (cf == (PCI_VENDOR_ID_SGI | (PCI_DEVICE_ID_SGI_IOC3 << 16)))
 		goto oh_my_gawd;
 
-	addr = &bridge->b_type1_cfg.c[(fn << 8) | (where ^ (4 - size))];
+	bridge_write_reg(((busno << 16) | (slot << 11)), bc, b_pci_type1_cfg);
+	addr = &bc->bridge->pci_t1.b[(fn << 8) | (where ^ (4 - size))];
 
 	if (size == 1) {
 		res = put_dbe(value, (u8 *) addr);
@@ -279,19 +282,19 @@ static int pci_conf1_write_config(struct pci_bus *bus, unsigned int devfn,
 	return PCIBIOS_SUCCESSFUL;
 
 oh_my_gawd:
-
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
-	 * generic PCI code a chance to touch the wrong register.
+	 * IOC3 is fucking fucked beyond belief.  Don't even give the
+	 * generic PCI code a chance to look at the wrong register.
 	 */
 	if ((where >= 0x14 && where < 0x40) || (where >= 0x48))
 		return PCIBIOS_SUCCESSFUL;
 
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't try to access
-	 * anything but 32-bit words ...
+	 * IOC3 is fucking fucked beyond belief.  Don't try to access
+	 * anything but 32-bit words.
 	 */
-	addr = &bridge->b_type0_cfg_dev[slot].f[fn].l[where >> 2];
+	bridge_write_reg(((busno << 16) | (slot << 11)), bc, b_pci_type1_cfg);
+	addr = &bc->bridge->pci_t1.b[(fn << 8) | where];
 
 	if (get_dbe(cf, (u32 *) addr))
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -307,8 +310,9 @@ static int pci_conf1_write_config(struct pci_bus *bus, unsigned int devfn,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int pci_write_config(struct pci_bus *bus, unsigned int devfn,
-	int where, int size, u32 value)
+static int
+pci_write_config(struct pci_bus *bus, u32 devfn, int where, int size,
+		 u32 value)
 {
 	if (bus->number > 0)
 		return pci_conf1_write_config(bus, devfn, where, size, value);
@@ -316,7 +320,8 @@ static int pci_write_config(struct pci_bus *bus, unsigned int devfn,
 	return pci_conf0_write_config(bus, devfn, where, size, value);
 }
 
-struct pci_ops bridge_pci_ops = {
+struct pci_ops __read_mostly
+bridge_pci_ops = {
 	.read	= pci_read_config,
 	.write	= pci_write_config,
 };
-- 
2.11.1
