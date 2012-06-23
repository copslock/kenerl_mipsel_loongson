Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jun 2012 02:25:42 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:51864 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903721Ab2FWAYa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jun 2012 02:24:30 +0200
Received: by dadm1 with SMTP id m1so3181024dad.36
        for <linux-mips@linux-mips.org>; Fri, 22 Jun 2012 17:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2/EpnNLts4LDDnpZA/cIfCBDOV5pHmHXN4YwxZYlapc=;
        b=NsbsyDU13PYLbyEPpqi46+BOVJAJD/R5Q1WNiiRHy05/yef9545t15hnyfqgvtsJpD
         x8A5qnUyiXoUclXCPIkioVoS9qUnORumJPLy6HaYNq1Aotpte2HdJ3501/hH1pTgdWD6
         LsgdJ4ATrr5XMuLuojB3lSBaBZ/r+mXLwC+hrllsV/BgUZ9wdIw1fDdEBsphzsSlQLK3
         GOixYaJlh79IvhHSMfdrIDYiNe/d/gOBzUwx0TYbMSZ5sY6rK/NRX2ikTPPmlhfgjy33
         J5RRPRFHB/xBexJ4MijQff8k1nQGDTFhw5uJ0nhnPp3O+uAQEznIWyXidl5kx2hdQBV3
         TN2g==
Received: by 10.68.190.102 with SMTP id gp6mr15804709pbc.5.1340411064451;
        Fri, 22 Jun 2012 17:24:24 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ru4sm603355pbc.66.2012.06.22.17.24.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Jun 2012 17:24:22 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q5N0OKR5019029;
        Fri, 22 Jun 2012 17:24:20 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q5N0OKGd019028;
        Fri, 22 Jun 2012 17:24:20 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        devicetree-discuss@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        afleming@gmail.com, David Daney <david.daney@cavium.com>
Subject: [PATCH 1/4] netdev/phy: Handle IEEE802.3 clause 45 Ethernet PHYs
Date:   Fri, 22 Jun 2012 17:24:13 -0700
Message-Id: <1340411056-18988-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1340411056-18988-1-git-send-email-ddaney.cavm@gmail.com>
References: <1340411056-18988-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

The IEEE802.3 clause 45 MDIO bus protocol allows for directly
addressing PHY registers using a 21 bit address, and is used by many
10G Ethernet PHYS.  Already existing is the ability of MDIO bus
drivers to use clause 45, with the MII_ADDR_C45 flag.  Here we add
struct phy_c45_device_ids to hold the device identifier registers
present in clause 45. struct phy_device gets a couple of new fields:
c45_ids to hold the identifiers and is_c45 to signal that it is clause
45.

Normally the MII_ADDR_C45 flag is ORed with the register address to
indicate a clause 45 transaction.  Here we also use this flag in the
*device* address passed to get_phy_device() to indicate that probing
should be done with clause 45 transactions.

EXPORT phy_device_create() so that the follow-on patch to of_mdio.c
can use it to create phy devices for PHYs, that have non-standard
device identifier registers, based on the device tree bindings.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/net/phy/phy_device.c |  110 +++++++++++++++++++++++++++++++++++++++---
 include/linux/phy.h          |   25 +++++++++-
 2 files changed, 126 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 18ab0da..fa0f558 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -152,8 +152,8 @@ int phy_scan_fixups(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(phy_scan_fixups);
 
-static struct phy_device* phy_device_create(struct mii_bus *bus,
-					    int addr, int phy_id)
+struct phy_device *phy_device_create(struct mii_bus *bus, int addr, int phy_id,
+				     struct phy_c45_device_ids *c45_ids)
 {
 	struct phy_device *dev;
 
@@ -174,8 +174,12 @@ static struct phy_device* phy_device_create(struct mii_bus *bus,
 
 	dev->autoneg = AUTONEG_ENABLE;
 
+	dev->is_c45 = (addr & MII_ADDR_C45) != 0;
+	addr &= ~MII_ADDR_C45;
 	dev->addr = addr;
 	dev->phy_id = phy_id;
+	if (c45_ids)
+		dev->c45_ids = *c45_ids;
 	dev->bus = bus;
 	dev->dev.parent = bus->parent;
 	dev->dev.bus = &mdio_bus_type;
@@ -200,20 +204,104 @@ static struct phy_device* phy_device_create(struct mii_bus *bus,
 
 	return dev;
 }
+EXPORT_SYMBOL(phy_device_create);
+
+/**
+ * get_phy_c45_ids - reads the specified addr for its 802.3-c45 IDs.
+ * @bus: the target MII bus
+ * @addr: PHY address on the MII bus
+ * @phy_id: where to store the ID retrieved.
+ * @c45_ids: where to store the c45 ID information.
+ *
+ *   If the PHY devices-in-package appears to be valid, it and the
+ *   corresponding identifiers are stored in @c45_ids, zero is stored
+ *   in @phy_id.  Otherwise 0xffffffff is stored in @phy_id.  Returns
+ *   zero on success.
+ *
+ */
+static int get_phy_c45_ids(struct mii_bus *bus, int addr, u32 *phy_id,
+			   struct phy_c45_device_ids *c45_ids) {
+	int phy_reg;
+	int i, reg_addr;
+
+	/*
+	 * Find first non-zero Devices In package.  Device
+	 * zero is reserved, so don't probe it.
+	 */
+	for (i = 1;
+	     i < ARRAY_SIZE(c45_ids->device_ids) &&
+		     c45_ids->devices_in_package == 0;
+	     i++) {
+		reg_addr = MII_ADDR_C45 | i << 16 | 6;
+		phy_reg = mdiobus_read(bus, addr, reg_addr);
+		if (phy_reg < 0)
+			return -EIO;
+		c45_ids->devices_in_package = (phy_reg & 0xffff) << 16;
+
+
+		reg_addr = MII_ADDR_C45 | i << 16 | 5;
+		phy_reg = mdiobus_read(bus, addr, reg_addr);
+		if (phy_reg < 0)
+			return -EIO;
+		c45_ids->devices_in_package |= (phy_reg & 0xffff);
+
+		/*
+		 * If mostly Fs, there is no device there,
+		 * let's get out of here.
+		 */
+		if ((c45_ids->devices_in_package & 0x1fffffff) == 0x1fffffff) {
+			*phy_id = 0xffffffff;
+			return 0;
+		}
+	}
+
+	/* Now probe Device Identifiers for each device present. */
+	for (i = 1; i < ARRAY_SIZE(c45_ids->device_ids); i++) {
+		if (!(c45_ids->devices_in_package & (1 << i)))
+			continue;
+
+		reg_addr = MII_ADDR_C45 | i << 16 | MII_PHYSID1;
+		phy_reg = mdiobus_read(bus, addr, reg_addr);
+		if (phy_reg < 0)
+			return -EIO;
+		c45_ids->device_ids[i] = (phy_reg & 0xffff) << 16;
+
+
+		reg_addr = MII_ADDR_C45 | i << 16 | MII_PHYSID2;
+		phy_reg = mdiobus_read(bus, addr, reg_addr);
+		if (phy_reg < 0)
+			return -EIO;
+		c45_ids->device_ids[i] |= (phy_reg & 0xffff);
+	}
+	*phy_id = 0;
+	return 0;
+}
 
 /**
  * get_phy_id - reads the specified addr for its ID.
  * @bus: the target MII bus
  * @addr: PHY address on the MII bus
  * @phy_id: where to store the ID retrieved.
+ * @c45_ids: where to store the c45 ID information.
+ *
+ * Description: In the case of a 802.3-c22 PHY, reads the ID registers
+ *   of the PHY at @addr on the @bus, stores it in @phy_id and returns
+ *   zero on success.
+ *
+ *   In the case of a 802.3-c45 PHY, get_phy_c45_ids() is invoked, and
+ *   its return value is in turn returned.
  *
- * Description: Reads the ID registers of the PHY at @addr on the
- *   @bus, stores it in @phy_id and returns zero on success.
  */
-static int get_phy_id(struct mii_bus *bus, int addr, u32 *phy_id)
+static int get_phy_id(struct mii_bus *bus, int addr, u32 *phy_id,
+		      struct phy_c45_device_ids *c45_ids)
 {
 	int phy_reg;
 
+	if (addr & MII_ADDR_C45) {
+		addr &= ~MII_ADDR_C45;
+
+		return get_phy_c45_ids(bus, addr, phy_id, c45_ids);
+	}
 	/* Grab the bits from PHYIR1, and put them
 	 * in the upper half */
 	phy_reg = mdiobus_read(bus, addr, MII_PHYSID1);
@@ -241,14 +329,17 @@ static int get_phy_id(struct mii_bus *bus, int addr, u32 *phy_id)
  *
  * Description: Reads the ID registers of the PHY at @addr on the
  *   @bus, then allocates and returns the phy_device to represent it.
+ *   If @addr & MII_ADDR_C45 is not zero, the PHY is assumed to be
+ *   802.3-c45.
  */
 struct phy_device * get_phy_device(struct mii_bus *bus, int addr)
 {
 	struct phy_device *dev = NULL;
 	u32 phy_id;
+	struct phy_c45_device_ids c45_ids = {0};
 	int r;
 
-	r = get_phy_id(bus, addr, &phy_id);
+	r = get_phy_id(bus, addr, &phy_id, &c45_ids);
 	if (r)
 		return ERR_PTR(r);
 
@@ -256,7 +347,7 @@ struct phy_device * get_phy_device(struct mii_bus *bus, int addr)
 	if ((phy_id & 0x1fffffff) == 0x1fffffff)
 		return NULL;
 
-	dev = phy_device_create(bus, addr, phy_id);
+	dev = phy_device_create(bus, addr, phy_id, &c45_ids);
 
 	return dev;
 }
@@ -449,6 +540,11 @@ static int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	/* Assume that if there is no driver, that it doesn't
 	 * exist, and we should use the genphy driver. */
 	if (NULL == d->driver) {
+		if (phydev->is_c45) {
+			pr_err("No driver for phy %x\n", phydev->phy_id);
+			return -ENODEV;
+		}
+
 		d->driver = &genphy_driver.driver;
 
 		err = d->driver->probe(d);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index c291cae..92d53ee 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -83,8 +83,12 @@ typedef enum {
  */
 #define MII_BUS_ID_SIZE	(20 - 3)
 
-/* Or MII_ADDR_C45 into regnum for read/write on mii_bus to enable the 21 bit
-   IEEE 802.3ae clause 45 addressing mode used by 10GIGE phy chips. */
+/*
+ * Or MII_ADDR_C45 into regnum for read/write on mii_bus to enable the
+ * 21 bit IEEE 802.3ae clause 45 addressing mode used by 10GIGE phy
+ * chips.  Also may be ORed into the device address in
+ * get_phy_device().
+ */
 #define MII_ADDR_C45 (1<<30)
 
 struct device;
@@ -243,6 +247,16 @@ enum phy_state {
 	PHY_RESUMING
 };
 
+/*
+ * phy_c45_device_ids: 802.3-c45 Device Identifiers
+ *
+ * devices_in_package: Bit vector of devices present.
+ * device_ids: The device identifer for each present device.
+ */
+struct phy_c45_device_ids {
+	u32 devices_in_package;
+	u32 device_ids[8];
+};
 
 /* phy_device: An instance of a PHY
  *
@@ -250,6 +264,8 @@ enum phy_state {
  * bus: Pointer to the bus this PHY is on
  * dev: driver model device structure for this PHY
  * phy_id: UID for this device found during discovery
+ * c45_ids: 802.3-c45 Device Identifers if is_c45.
+ * is_c45:  Set to true if this phy uses clause 45 addressing.
  * state: state of the PHY for management purposes
  * dev_flags: Device-specific flags used by the PHY driver.
  * addr: Bus address of PHY
@@ -285,6 +301,9 @@ struct phy_device {
 
 	u32 phy_id;
 
+	struct phy_c45_device_ids c45_ids;
+	bool is_c45;
+
 	enum phy_state state;
 
 	u32 dev_flags;
@@ -480,6 +499,8 @@ static inline int phy_write(struct phy_device *phydev, u32 regnum, u16 val)
 	return mdiobus_write(phydev->bus, phydev->addr, regnum, val);
 }
 
+struct phy_device *phy_device_create(struct mii_bus *bus, int addr, int phy_id,
+				     struct phy_c45_device_ids *c45_ids);
 struct phy_device* get_phy_device(struct mii_bus *bus, int addr);
 int phy_device_register(struct phy_device *phy);
 int phy_init_hw(struct phy_device *phydev);
-- 
1.7.2.3
