Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 01:31:21 +0100 (CET)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34097 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012471AbcBJA372Yp7x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 01:29:59 +0100
Received: by mail-pf0-f194.google.com with SMTP id 71so173747pfv.1
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 16:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fbkCOwHXxus7M4TDvBAc8hkHEwwOr6NKgZysUD1LZ5E=;
        b=rjzti/OxiRSbbiSYu9kvb+jxnsTSbOYygTk86Jn8IkdvLKHG9/8Hbsu2kWGSzfH2dT
         S6K4MZNnZGSQXjyAnDixuxREwX6q+eBU+xYaUPCBePF4TJHJ4IUADj5kKpDh37WlY0bG
         t8EIdurQ2R/tisd6TgsP/TaaQmdkj316dxL4vU1pfV1SrcdV40hO/6zadOF+SyEjm0i2
         y8xRGt+OaeSH+3HT2Xl0SoBgHbMn/5esvI67ZcTYDqScZhbStkW1jf3gHYU648RvLFgX
         UUsD/j0GZQTJSqSg55suYw2O5d9517m7D/qzt6CR/k3zTq7uj+aE0EmaCqNJ7cNBFXwM
         uJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fbkCOwHXxus7M4TDvBAc8hkHEwwOr6NKgZysUD1LZ5E=;
        b=drOjnJwC1OxuGTSys9DJgPqpG+3azdjEVF9ri7Ru1GVOfySTHsKwBwd6BWwbzDuX6+
         eBr/Jo4Mgt4ogjeU33grwtc2zS5qtSIGnxjEK5cjas94UIB7P3D5RpnDAyBC2DKlgvmy
         +IBWIWAYaqx/UDjT3REevS6qdRYxlLoYPZyX0VRf10Jht2PoAUNLdteNZEc0o4PsrKq7
         m2Ih1snKNbvKXIkCinchPbftYspXatNnX1wWS34AW6fzm1uWDonNTc0tXssqaWLu7FTt
         zZWXNR8NCpH7JnGC238KVTC1l2qK+M5tRHJjj7BBq57p/35UcP9m7iOt3obRLmK4wdCw
         iBDw==
X-Gm-Message-State: AG10YOQrULwRObr2XZL770Ap3GYIf55tAEhmppO8PB0nPGsDVpvj8x5IEJOCJLpwD88T+Q==
X-Received: by 10.98.80.135 with SMTP id g7mr54796112pfj.132.1455064193514;
        Tue, 09 Feb 2016 16:29:53 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id s90sm429295pfa.49.2016.02.09.16.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 16:29:52 -0800 (PST)
From:   David Decotigny <ddecotig@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben@decadent.org.uk>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mips@linux-mips.org,
        fcoe-devel@open-fcoe.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Eugenia Emantayev <eugenia@mellanox.co.il>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Ido Shamay <idos@mellanox.com>, Joe Perches <joe@perches.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Govindarajulu Varadarajan <_govind@gmx.com>,
        Venkata Duvvuru <VenkatKumar.Duvvuru@Emulex.Com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Pravin B Shelar <pshelar@nicira.com>,
        Ed Swierk <eswierk@skyportsystems.com>,
        Robert Love <robert.w.love@intel.com>,
        "James E.J. Bottomley" <JBottomley@parallels.com>,
        Yuval Mintz <Yuval.Mintz@qlogic.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Decotigny <decot@googlers.com>
Subject: [PATCH net-next v8 05/19] net: ethtool: add new ETHTOOL_GSETTINGS/SSETTINGS API
Date:   Tue,  9 Feb 2016 16:29:14 -0800
Message-Id: <1455064168-5102-6-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
References: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddecotig@gmail.com
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

From: David Decotigny <decot@googlers.com>

This patch defines a new ETHTOOL_GSETTINGS/SSETTINGS API, handled by
the new get_ksettings/set_ksettings callbacks. This API provides
support for most legacy ethtool_cmd fields, adds support for larger
link mode masks (up to 4064 bits, variable length), and removes
ethtool_cmd deprecated fields (transceiver/maxrxpkt/maxtxpkt).

This API is deprecating the legacy ETHTOOL_GSET/SSET API and provides
the following backward compatibility properties:
 - legacy ethtool with legacy drivers: no change, still using the
   get_settings/set_settings callbacks.
 - legacy ethtool with new get/set_ksettings drivers: the new driver
   callbacks are used, data internally converted to legacy
   ethtool_cmd. ETHTOOL_GSET will return only the 1st 32b of each link
   mode mask. ETHTOOL_SSET will fail if user tries to set the
   ethtool_cmd deprecated fields to non-0
   (transceiver/maxrxpkt/maxtxpkt). A kernel warning is logged if
   driver sets higher bits.
 - future ethtool with legacy drivers: no change, still using the
   get_settings/set_settings callbacks, internally converted to new data
   structure. Deprecated fields (transceiver/maxrxpkt/maxtxpkt) will be
   ignored and seen as 0 from user space. Note that that "future"
   ethtool tool will not allow changes to these deprecated fields.
 - future ethtool with new drivers: direct call to the new callbacks.

By "future" ethtool, what is meant is:
 - query: first try ETHTOOL_GSETTINGS, and revert to ETHTOOL_GSET if fails
 - set: query first and remember which of ETHTOOL_GSETTINGS or
   ETHTOOL_GSET was successful
   - if ETHTOOL_GSETTINGS was successful, then change config with
     ETHTOOL_SSETTINGS. A failure there is final (do not try ETHTOOL_SSET).
   - otherwise ETHTOOL_GSET was successful, change config with
     ETHTOOL_SSET. A failure there is final (do not try ETHTOOL_SSETTINGS).

The interaction user/kernel via the new API requires a small
ETHTOOL_GSETTINGS handshake first to agree on the length of the link
mode bitmaps. If kernel doesn't agree with user, it returns the bitmap
length it is expecting from user as a negative length (and cmd field
is 0). When kernel and user agree, kernel returns valid info in all
fields (ie. link mode length > 0 and cmd is ETHTOOL_GSETTINGS).

Data structure crossing user/kernel boundary is 32/64-bit
agnostic. Converted internally to a legal kernel bitmap.

The internal __ethtool_get_settings kernel helper will gradually be
replaced by __ethtool_get_ksettings by the time the first ksettings
drivers start to appear. So this patch doesn't change it, it will be
removed before it needs to be changed.

Signed-off-by: David Decotigny <decot@googlers.com>
---
 include/linux/ethtool.h      |  88 ++++++++-
 include/uapi/linux/ethtool.h | 320 ++++++++++++++++++++++++++-------
 net/core/ethtool.c           | 420 ++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 748 insertions(+), 80 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 653dc9c..6077cbb 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -12,6 +12,7 @@
 #ifndef _LINUX_ETHTOOL_H
 #define _LINUX_ETHTOOL_H
 
+#include <linux/bitmap.h>
 #include <linux/compat.h>
 #include <uapi/linux/ethtool.h>
 
@@ -40,9 +41,6 @@ struct compat_ethtool_rxnfc {
 
 #include <linux/rculist.h>
 
-extern int __ethtool_get_settings(struct net_device *dev,
-				  struct ethtool_cmd *cmd);
-
 /**
  * enum ethtool_phys_id_state - indicator state for physical identification
  * @ETHTOOL_ID_INACTIVE: Physical ID indicator should be deactivated
@@ -97,13 +95,72 @@ static inline u32 ethtool_rxfh_indir_default(u32 index, u32 n_rx_rings)
 	return index % n_rx_rings;
 }
 
+/* number of link mode bits/ulongs handled internally by kernel */
+#define __ETHTOOL_LINK_MODE_MASK_NBITS			\
+	(__ETHTOOL_LINK_MODE_LAST + 1)
+
+/* declare a link mode bitmap */
+#define __ETHTOOL_DECLARE_LINK_MODE_MASK(name)		\
+	DECLARE_BITMAP(name, __ETHTOOL_LINK_MODE_MASK_NBITS)
+
+/* drivers must ignore parent.cmd and parent.link_mode_masks_nwords
+ * fields, but they are allowed to overwrite them (will be ignored).
+ */
+struct ethtool_ksettings {
+	struct ethtool_settings parent;
+	struct {
+		__ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
+		__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising);
+		__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising);
+	} link_modes;
+};
+
+/**
+ * ethtool_ksettings_zero_link_mode - clear ksettings link mode mask
+ *   @ptr : pointer to struct ethtool_ksettings
+ *   @name : one of supported/advertising/lp_advertising
+ */
+#define ethtool_ksettings_zero_link_mode(ptr, name)			\
+	bitmap_zero((ptr)->link_modes.name, __ETHTOOL_LINK_MODE_MASK_NBITS)
+
+/**
+ * ethtool_ksettings_add_link_mode - set bit in ksettings link mode mask
+ *   @ptr : pointer to struct ethtool_ksettings
+ *   @name : one of supported/advertising/lp_advertising
+ *   @mode : one of the ETHTOOL_LINK_MODE_*_BIT
+ * (not atomic, no bound checking)
+ */
+#define ethtool_ksettings_add_link_mode(ptr, name, mode)		\
+	__set_bit(ETHTOOL_LINK_MODE_ ## mode ## _BIT, (ptr)->link_modes.name)
+
+/**
+ * ethtool_ksettings_test_link_mode - test bit in ksettings link mode mask
+ *   @ptr : pointer to struct ethtool_ksettings
+ *   @name : one of supported/advertising/lp_advertising
+ *   @mode : one of the ETHTOOL_LINK_MODE_*_BIT
+ * (not atomic, no bound checking)
+ *
+ * Returns true/false.
+ */
+#define ethtool_ksettings_test_link_mode(ptr, name, mode)		\
+	test_bit(ETHTOOL_LINK_MODE_ ## mode ## _BIT, (ptr)->link_modes.name)
+
+extern int __ethtool_get_ksettings(struct net_device *dev,
+				   struct ethtool_ksettings *ksettings);
+
+/* DEPRECATED, use __ethtool_get_ksettings */
+extern int __ethtool_get_settings(struct net_device *dev,
+				  struct ethtool_cmd *cmd);
+
 /**
  * struct ethtool_ops - optional netdev operations
- * @get_settings: Get various device settings including Ethernet link
+ * @get_settings: DEPRECATED, use %get_ksettings/%set_ksettings
+ *	API. Get various device settings including Ethernet link
  *	settings. The @cmd parameter is expected to have been cleared
- *	before get_settings is called. Returns a negative error code or
- *	zero.
- * @set_settings: Set various device settings including Ethernet link
+ *	before get_settings is called. Returns a negative error code
+ *	or zero.
+ * @set_settings: DEPRECATED, use %get_ksettings/%set_ksettings
+ *	API. Set various device settings including Ethernet link
  *	settings.  Returns a negative error code or zero.
  * @get_drvinfo: Report driver/device information.  Should only set the
  *	@driver, @version, @fw_version and @bus_info fields.  If not
@@ -201,6 +258,18 @@ static inline u32 ethtool_rxfh_indir_default(u32 index, u32 n_rx_rings)
  * @get_module_eeprom: Get the eeprom information from the plug-in module
  * @get_eee: Get Energy-Efficient (EEE) supported and status.
  * @set_eee: Set EEE status (enable/disable) as well as LPI timers.
+ * @get_ksettings: When defined, takes precedence over the
+ *	%get_settings method. Get various device settings including Ethernet
+ *	link settings. The %cmd and %link_mode_masks_nwords fields should be
+ *	ignored (use %__ETHTOOL_LINK_MODE_MASK_NBITS instead of the latter),
+ *	any change to them will be overwritten by kernel. Returns a negative
+ *	error code or zero.
+ * @set_ksettings: When defined, takes precedence over the
+ *	%set_settings method. Set various device settings including
+ *	Ethernet link settings. The %cmd and %link_mode_masks_nwords fields
+ *	should be ignored (use %__ETHTOOL_LINK_MODE_MASK_NBITS instead of
+ *	the latter), any change to them will be overwritten by
+ *	kernel. Returns a negative error code or zero.
  *
  * All operations are optional (i.e. the function pointer may be set
  * to %NULL) and callers must take this into account.  Callers must
@@ -280,6 +349,9 @@ struct ethtool_ops {
 	int	(*set_tunable)(struct net_device *,
 			       const struct ethtool_tunable *, const void *);
 
-
+	int	(*get_ksettings)(struct net_device *,
+				 struct ethtool_ksettings *);
+	int	(*set_ksettings)(struct net_device *,
+				 const struct ethtool_ksettings *);
 };
 #endif /* _LINUX_ETHTOOL_H */
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index b2e1801..7f918fd 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -21,7 +21,8 @@
  */
 
 /**
- * struct ethtool_cmd - link control and status
+ * struct ethtool_cmd - DEPRECATED, link control and status
+ * This structure is DEPRECATED, please use struct ethtool_settings.
  * @cmd: Command number = %ETHTOOL_GSET or %ETHTOOL_SSET
  * @supported: Bitmask of %SUPPORTED_* flags for the link modes,
  *	physical connectors and other link features for which the
@@ -1148,8 +1149,12 @@ enum ethtool_sfeatures_retval_bits {
 
 
 /* CMDs currently supported */
-#define ETHTOOL_GSET		0x00000001 /* Get settings. */
-#define ETHTOOL_SSET		0x00000002 /* Set settings. */
+#define ETHTOOL_GSET		0x00000001 /* DEPRECATED, Get settings.
+					    * Please use ETHTOOL_GSETTINGS
+					    */
+#define ETHTOOL_SSET		0x00000002 /* DEPRECATED, Set settings.
+					    * Please use ETHTOOL_SSETTINGS
+					    */
 #define ETHTOOL_GDRVINFO	0x00000003 /* Get driver info. */
 #define ETHTOOL_GREGS		0x00000004 /* Get NIC registers. */
 #define ETHTOOL_GWOL		0x00000005 /* Get wake-on-lan options. */
@@ -1229,73 +1234,139 @@ enum ethtool_sfeatures_retval_bits {
 #define ETHTOOL_STUNABLE	0x00000049 /* Set tunable configuration */
 #define ETHTOOL_GPHYSTATS	0x0000004a /* get PHY-specific statistics */
 
+#define ETHTOOL_GSETTINGS	0x0000004b /* Get ethtool_settings */
+#define ETHTOOL_SSETTINGS	0x0000004c /* Set ethtool_settings */
+
+
 /* compatibility with older code */
 #define SPARC_ETH_GSET		ETHTOOL_GSET
 #define SPARC_ETH_SSET		ETHTOOL_SSET
 
-#define SUPPORTED_10baseT_Half		(1 << 0)
-#define SUPPORTED_10baseT_Full		(1 << 1)
-#define SUPPORTED_100baseT_Half		(1 << 2)
-#define SUPPORTED_100baseT_Full		(1 << 3)
-#define SUPPORTED_1000baseT_Half	(1 << 4)
-#define SUPPORTED_1000baseT_Full	(1 << 5)
-#define SUPPORTED_Autoneg		(1 << 6)
-#define SUPPORTED_TP			(1 << 7)
-#define SUPPORTED_AUI			(1 << 8)
-#define SUPPORTED_MII			(1 << 9)
-#define SUPPORTED_FIBRE			(1 << 10)
-#define SUPPORTED_BNC			(1 << 11)
-#define SUPPORTED_10000baseT_Full	(1 << 12)
-#define SUPPORTED_Pause			(1 << 13)
-#define SUPPORTED_Asym_Pause		(1 << 14)
-#define SUPPORTED_2500baseX_Full	(1 << 15)
-#define SUPPORTED_Backplane		(1 << 16)
-#define SUPPORTED_1000baseKX_Full	(1 << 17)
-#define SUPPORTED_10000baseKX4_Full	(1 << 18)
-#define SUPPORTED_10000baseKR_Full	(1 << 19)
-#define SUPPORTED_10000baseR_FEC	(1 << 20)
-#define SUPPORTED_20000baseMLD2_Full	(1 << 21)
-#define SUPPORTED_20000baseKR2_Full	(1 << 22)
-#define SUPPORTED_40000baseKR4_Full	(1 << 23)
-#define SUPPORTED_40000baseCR4_Full	(1 << 24)
-#define SUPPORTED_40000baseSR4_Full	(1 << 25)
-#define SUPPORTED_40000baseLR4_Full	(1 << 26)
-#define SUPPORTED_56000baseKR4_Full	(1 << 27)
-#define SUPPORTED_56000baseCR4_Full	(1 << 28)
-#define SUPPORTED_56000baseSR4_Full	(1 << 29)
-#define SUPPORTED_56000baseLR4_Full	(1 << 30)
-
-#define ADVERTISED_10baseT_Half		(1 << 0)
-#define ADVERTISED_10baseT_Full		(1 << 1)
-#define ADVERTISED_100baseT_Half	(1 << 2)
-#define ADVERTISED_100baseT_Full	(1 << 3)
-#define ADVERTISED_1000baseT_Half	(1 << 4)
-#define ADVERTISED_1000baseT_Full	(1 << 5)
-#define ADVERTISED_Autoneg		(1 << 6)
-#define ADVERTISED_TP			(1 << 7)
-#define ADVERTISED_AUI			(1 << 8)
-#define ADVERTISED_MII			(1 << 9)
-#define ADVERTISED_FIBRE		(1 << 10)
-#define ADVERTISED_BNC			(1 << 11)
-#define ADVERTISED_10000baseT_Full	(1 << 12)
-#define ADVERTISED_Pause		(1 << 13)
-#define ADVERTISED_Asym_Pause		(1 << 14)
-#define ADVERTISED_2500baseX_Full	(1 << 15)
-#define ADVERTISED_Backplane		(1 << 16)
-#define ADVERTISED_1000baseKX_Full	(1 << 17)
-#define ADVERTISED_10000baseKX4_Full	(1 << 18)
-#define ADVERTISED_10000baseKR_Full	(1 << 19)
-#define ADVERTISED_10000baseR_FEC	(1 << 20)
-#define ADVERTISED_20000baseMLD2_Full	(1 << 21)
-#define ADVERTISED_20000baseKR2_Full	(1 << 22)
-#define ADVERTISED_40000baseKR4_Full	(1 << 23)
-#define ADVERTISED_40000baseCR4_Full	(1 << 24)
-#define ADVERTISED_40000baseSR4_Full	(1 << 25)
-#define ADVERTISED_40000baseLR4_Full	(1 << 26)
-#define ADVERTISED_56000baseKR4_Full	(1 << 27)
-#define ADVERTISED_56000baseCR4_Full	(1 << 28)
-#define ADVERTISED_56000baseSR4_Full	(1 << 29)
-#define ADVERTISED_56000baseLR4_Full	(1 << 30)
+/* Link mode bit indices */
+enum ethtool_link_mode_bit_indices {
+	ETHTOOL_LINK_MODE_10baseT_Half_BIT	= 0,
+	ETHTOOL_LINK_MODE_10baseT_Full_BIT	= 1,
+	ETHTOOL_LINK_MODE_100baseT_Half_BIT	= 2,
+	ETHTOOL_LINK_MODE_100baseT_Full_BIT	= 3,
+	ETHTOOL_LINK_MODE_1000baseT_Half_BIT	= 4,
+	ETHTOOL_LINK_MODE_1000baseT_Full_BIT	= 5,
+	ETHTOOL_LINK_MODE_Autoneg_BIT		= 6,
+	ETHTOOL_LINK_MODE_TP_BIT		= 7,
+	ETHTOOL_LINK_MODE_AUI_BIT		= 8,
+	ETHTOOL_LINK_MODE_MII_BIT		= 9,
+	ETHTOOL_LINK_MODE_FIBRE_BIT		= 10,
+	ETHTOOL_LINK_MODE_BNC_BIT		= 11,
+	ETHTOOL_LINK_MODE_10000baseT_Full_BIT	= 12,
+	ETHTOOL_LINK_MODE_Pause_BIT		= 13,
+	ETHTOOL_LINK_MODE_Asym_Pause_BIT	= 14,
+	ETHTOOL_LINK_MODE_2500baseX_Full_BIT	= 15,
+	ETHTOOL_LINK_MODE_Backplane_BIT		= 16,
+	ETHTOOL_LINK_MODE_1000baseKX_Full_BIT	= 17,
+	ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT	= 18,
+	ETHTOOL_LINK_MODE_10000baseKR_Full_BIT	= 19,
+	ETHTOOL_LINK_MODE_10000baseR_FEC_BIT	= 20,
+	ETHTOOL_LINK_MODE_20000baseMLD2_Full_BIT = 21,
+	ETHTOOL_LINK_MODE_20000baseKR2_Full_BIT	= 22,
+	ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT	= 23,
+	ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT	= 24,
+	ETHTOOL_LINK_MODE_40000baseSR4_Full_BIT	= 25,
+	ETHTOOL_LINK_MODE_40000baseLR4_Full_BIT	= 26,
+	ETHTOOL_LINK_MODE_56000baseKR4_Full_BIT	= 27,
+	ETHTOOL_LINK_MODE_56000baseCR4_Full_BIT	= 28,
+	ETHTOOL_LINK_MODE_56000baseSR4_Full_BIT	= 29,
+	ETHTOOL_LINK_MODE_56000baseLR4_Full_BIT	= 30,
+
+	/* Last allowed bit for __ETHTOOL_LINK_MODE_LEGACY_MASK is bit
+	 * 31. Please do NOT define any SUPPORTED_* or ADVERTISED_*
+	 * macro for bits > 31. The only way to use indices > 31 is to
+	 * use the new ETHTOOL_GSETTINGS/ETHTOOL_SSETTINGS API.
+	 */
+
+	__ETHTOOL_LINK_MODE_LAST
+	  = ETHTOOL_LINK_MODE_56000baseLR4_Full_BIT,
+};
+
+#define __ETHTOOL_LINK_MODE_LEGACY_MASK(base_name)	\
+	(1UL << (ETHTOOL_LINK_MODE_ ## base_name ## _BIT))
+
+/* DEPRECATED macros. Please migrate to
+ * ETHTOOL_GSETTINGS/ETHTOOL_SSETTINGS API. Please do NOT define any new
+ * SUPPORTED_* macro for bits > 31.
+ */
+#define SUPPORTED_10baseT_Half		__ETHTOOL_LINK_MODE_LEGACY_MASK(10baseT_Half)
+#define SUPPORTED_10baseT_Full		__ETHTOOL_LINK_MODE_LEGACY_MASK(10baseT_Full)
+#define SUPPORTED_100baseT_Half		__ETHTOOL_LINK_MODE_LEGACY_MASK(100baseT_Half)
+#define SUPPORTED_100baseT_Full		__ETHTOOL_LINK_MODE_LEGACY_MASK(100baseT_Full)
+#define SUPPORTED_1000baseT_Half	__ETHTOOL_LINK_MODE_LEGACY_MASK(1000baseT_Half)
+#define SUPPORTED_1000baseT_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(1000baseT_Full)
+#define SUPPORTED_Autoneg		__ETHTOOL_LINK_MODE_LEGACY_MASK(Autoneg)
+#define SUPPORTED_TP			__ETHTOOL_LINK_MODE_LEGACY_MASK(TP)
+#define SUPPORTED_AUI			__ETHTOOL_LINK_MODE_LEGACY_MASK(AUI)
+#define SUPPORTED_MII			__ETHTOOL_LINK_MODE_LEGACY_MASK(MII)
+#define SUPPORTED_FIBRE			__ETHTOOL_LINK_MODE_LEGACY_MASK(FIBRE)
+#define SUPPORTED_BNC			__ETHTOOL_LINK_MODE_LEGACY_MASK(BNC)
+#define SUPPORTED_10000baseT_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(10000baseT_Full)
+#define SUPPORTED_Pause			__ETHTOOL_LINK_MODE_LEGACY_MASK(Pause)
+#define SUPPORTED_Asym_Pause		__ETHTOOL_LINK_MODE_LEGACY_MASK(Asym_Pause)
+#define SUPPORTED_2500baseX_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(2500baseX_Full)
+#define SUPPORTED_Backplane		__ETHTOOL_LINK_MODE_LEGACY_MASK(Backplane)
+#define SUPPORTED_1000baseKX_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(1000baseKX_Full)
+#define SUPPORTED_10000baseKX4_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(10000baseKX4_Full)
+#define SUPPORTED_10000baseKR_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(10000baseKR_Full)
+#define SUPPORTED_10000baseR_FEC	__ETHTOOL_LINK_MODE_LEGACY_MASK(10000baseR_FEC)
+#define SUPPORTED_20000baseMLD2_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(20000baseMLD2_Full)
+#define SUPPORTED_20000baseKR2_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(20000baseKR2_Full)
+#define SUPPORTED_40000baseKR4_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(40000baseKR4_Full)
+#define SUPPORTED_40000baseCR4_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(40000baseCR4_Full)
+#define SUPPORTED_40000baseSR4_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(40000baseSR4_Full)
+#define SUPPORTED_40000baseLR4_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(40000baseLR4_Full)
+#define SUPPORTED_56000baseKR4_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(56000baseKR4_Full)
+#define SUPPORTED_56000baseCR4_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(56000baseCR4_Full)
+#define SUPPORTED_56000baseSR4_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(56000baseSR4_Full)
+#define SUPPORTED_56000baseLR4_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(56000baseLR4_Full)
+/* Please do not define any new SUPPORTED_* macro for bits > 31, see
+ * notice above.
+ */
+
+/*
+ * DEPRECATED macros. Please migrate to
+ * ETHTOOL_GSETTINGS/ETHTOOL_SSETTINGS API. Please do NOT define any new
+ * ADERTISE_* macro for bits > 31.
+ */
+#define ADVERTISED_10baseT_Half		__ETHTOOL_LINK_MODE_LEGACY_MASK(10baseT_Half)
+#define ADVERTISED_10baseT_Full		__ETHTOOL_LINK_MODE_LEGACY_MASK(10baseT_Full)
+#define ADVERTISED_100baseT_Half	__ETHTOOL_LINK_MODE_LEGACY_MASK(100baseT_Half)
+#define ADVERTISED_100baseT_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(100baseT_Full)
+#define ADVERTISED_1000baseT_Half	__ETHTOOL_LINK_MODE_LEGACY_MASK(1000baseT_Half)
+#define ADVERTISED_1000baseT_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(1000baseT_Full)
+#define ADVERTISED_Autoneg		__ETHTOOL_LINK_MODE_LEGACY_MASK(Autoneg)
+#define ADVERTISED_TP			__ETHTOOL_LINK_MODE_LEGACY_MASK(TP)
+#define ADVERTISED_AUI			__ETHTOOL_LINK_MODE_LEGACY_MASK(AUI)
+#define ADVERTISED_MII			__ETHTOOL_LINK_MODE_LEGACY_MASK(MII)
+#define ADVERTISED_FIBRE		__ETHTOOL_LINK_MODE_LEGACY_MASK(FIBRE)
+#define ADVERTISED_BNC			__ETHTOOL_LINK_MODE_LEGACY_MASK(BNC)
+#define ADVERTISED_10000baseT_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(10000baseT_Full)
+#define ADVERTISED_Pause		__ETHTOOL_LINK_MODE_LEGACY_MASK(Pause)
+#define ADVERTISED_Asym_Pause		__ETHTOOL_LINK_MODE_LEGACY_MASK(Asym_Pause)
+#define ADVERTISED_2500baseX_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(2500baseX_Full)
+#define ADVERTISED_Backplane		__ETHTOOL_LINK_MODE_LEGACY_MASK(Backplane)
+#define ADVERTISED_1000baseKX_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(1000baseKX_Full)
+#define ADVERTISED_10000baseKX4_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(10000baseKX4_Full)
+#define ADVERTISED_10000baseKR_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(10000baseKR_Full)
+#define ADVERTISED_10000baseR_FEC	__ETHTOOL_LINK_MODE_LEGACY_MASK(10000baseR_FEC)
+#define ADVERTISED_20000baseMLD2_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(20000baseMLD2_Full)
+#define ADVERTISED_20000baseKR2_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(20000baseKR2_Full)
+#define ADVERTISED_40000baseKR4_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(40000baseKR4_Full)
+#define ADVERTISED_40000baseCR4_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(40000baseCR4_Full)
+#define ADVERTISED_40000baseSR4_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(40000baseSR4_Full)
+#define ADVERTISED_40000baseLR4_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(40000baseLR4_Full)
+#define ADVERTISED_56000baseKR4_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(56000baseKR4_Full)
+#define ADVERTISED_56000baseCR4_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(56000baseCR4_Full)
+#define ADVERTISED_56000baseSR4_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(56000baseSR4_Full)
+#define ADVERTISED_56000baseLR4_Full	__ETHTOOL_LINK_MODE_LEGACY_MASK(56000baseLR4_Full)
+/* Please do not define any new ADVERTISED_* macro for bits > 31, see
+ * notice above.
+ */
 
 /* The following are all involved in forcing a particular link
  * mode for the device for setting things.  When getting the
@@ -1475,4 +1546,121 @@ enum ethtool_reset_flags {
 };
 #define ETH_RESET_SHARED_SHIFT	16
 
+
+/**
+ * struct ethtool_settings - link control and status
+ *
+ * IMPORTANT, Backward compatibility notice: When implementing new
+ *	user-space tools, please first try %ETHTOOL_GSETTINGS, and if
+ *	it succeeds use %ETHTOOL_SSETTINGS to change settings; do not
+ *	use %ETHTOOL_SSET if %ETHTOOL_GSETTINGS succeeded: stick to
+ *	%ETHTOOL_GSETTINGS/%SSETTINGS in that case.  Conversely, if
+ *	%ETHTOOL_GSETTINGS fails, use %ETHTOOL_GSET to query and
+ *	%ETHTOOL_SSET to change settings; do not use
+ *	%ETHTOOL_SSETTINGS if %ETHTOOL_GSETTINGS failed: stick to
+ *	%ETHTOOL_GSET/%ETHTOOL_SSET in that case.
+ *
+ * @cmd: Command number = %ETHTOOL_GSETTINGS or %ETHTOOL_SSETTINGS
+ * @speed: Link speed (Mbps)
+ * @duplex: Duplex mode; one of %DUPLEX_*
+ * @port: Physical connector type; one of %PORT_*
+ * @phy_address: MDIO address of PHY (transceiver); 0 or 255 if not
+ *	applicable.  For clause 45 PHYs this is the PRTAD.
+ * @autoneg: Enable/disable autonegotiation and auto-detection;
+ *	either %AUTONEG_DISABLE or %AUTONEG_ENABLE
+ * @mdio_support: Bitmask of %ETH_MDIO_SUPPORTS_* flags for the MDIO
+ *	protocols supported by the interface; 0 if unknown.
+ *	Read-only.
+ * @eth_tp_mdix: Ethernet twisted-pair MDI(-X) status; one of
+ *	%ETH_TP_MDI_*.  If the status is unknown or not applicable, the
+ *	value will be %ETH_TP_MDI_INVALID.  Read-only.
+ * @eth_tp_mdix_ctrl: Ethernet twisted pair MDI(-X) control; one of
+ *	%ETH_TP_MDI_*.  If MDI(-X) control is not implemented, reads
+ *	yield %ETH_TP_MDI_INVALID and writes may be ignored or rejected.
+ *	When written successfully, the link should be renegotiated if
+ *	necessary.
+ * @link_mode_masks_nwords: Number of 32-bit words for each of the
+ *	supported, advertising, lp_advertising link mode bitmaps. For
+ *	%ETHTOOL_GSETTINGS: on entry, number of words passed by user
+ *	(>= 0); on return, if handshake in progress, negative if
+ *	request size unsupported by kernel: absolute value indicates
+ *	kernel recommended size and cmd field is 0, as well as all the
+ *	other fields; otherwise (handshake completed), strictly
+ *	positive to indicate size used by kernel and cmd field is
+ *	%ETHTOOL_GSETTINGS, all other fields populated by driver. For
+ *	%ETHTOOL_SSETTINGS: must be valid on entry, ie. a positive
+ *	value returned previously by %ETHTOOL_GSETTINGS, otherwise
+ *	refused. For drivers: ignore this field (use kernel's
+ *	__ETHTOOL_LINK_MODE_MASK_NBITS instead), any change to it will
+ *	be overwritten by kernel.
+ * @supported: Bitmap with each bit meaning given by
+ *	%ethtool_link_mode_bit_indices for the link modes, physical
+ *	connectors and other link features for which the interface
+ *	supports autonegotiation or auto-detection.  Read-only.
+ * @advertising: Bitmap with each bit meaning given by
+ *	%ethtool_link_mode_bit_indices for the link modes, physical
+ *	connectors and other link features that are advertised through
+ *	autonegotiation or enabled for auto-detection.
+ * @lp_advertising: Bitmap with each bit meaning given by
+ *	%ethtool_link_mode_bit_indices for the link modes, and other
+ *	link features that the link partner advertised through
+ *	autonegotiation; 0 if unknown or not applicable.  Read-only.
+ *
+ * If autonegotiation is disabled, the speed and @duplex represent the
+ * fixed link mode and are writable if the driver supports multiple
+ * link modes.  If it is enabled then they are read-only; if the link
+ * is up they represent the negotiated link mode; if the link is down,
+ * the speed is 0, %SPEED_UNKNOWN or the highest enabled speed and
+ * @duplex is %DUPLEX_UNKNOWN or the best enabled duplex mode.
+ *
+ * Some hardware interfaces may have multiple PHYs and/or physical
+ * connectors fitted or do not allow the driver to detect which are
+ * fitted.  For these interfaces @port and/or @phy_address may be
+ * writable, possibly dependent on @autoneg being %AUTONEG_DISABLE.
+ * Otherwise, attempts to write different values may be ignored or
+ * rejected.
+ *
+ * Deprecated %ethtool_cmd fields transceiver, maxtxpkt and maxrxpkt
+ * are not available in %ethtool_settings. Until all drivers are
+ * converted to ignore them or to the new %ethtool_settings API, for
+ * both queries and changes, users should always try
+ * %ETHTOOL_GSETTINGS first, and if it fails with -ENOTSUPP stick only
+ * to %ETHTOOL_GSET and %ETHTOOL_SSET consistently. If it succeeds,
+ * then users should stick to %ETHTOOL_GSETTINGS and
+ * %ETHTOOL_SSETTINGS (which would support drivers implementing either
+ * %ethtool_cmd or %ethtool_settings).
+ *
+ * Users should assume that all fields not marked read-only are
+ * writable and subject to validation by the driver.  They should use
+ * %ETHTOOL_GSETTINGS to get the current values before making specific
+ * changes and then applying them with %ETHTOOL_SSETTINGS.
+ *
+ * Drivers that implement %get_ksettings and/or %set_ksettings should
+ * ignore the @cmd and @link_mode_masks_nwords fields (any change to
+ * them overwritten by kernel), and rely only on kernel's internal
+ * %__ETHTOOL_LINK_MODE_MASK_NBITS and
+ * %ethtool_link_mode_mask_t. Drivers that implement %set_ksettings()
+ * should validate all fields other than @cmd
+ * and @link_mode_masks_nwords that are not described as read-only or
+ * deprecated, and must ignore all fields described as read-only.
+ */
+struct ethtool_settings {
+	__u32	cmd;
+	__u32	speed;
+	__u8	duplex;
+	__u8	port;
+	__u8	phy_address;
+	__u8	autoneg;
+	__u8	mdio_support;
+	__u8	eth_tp_mdix;
+	__u8	eth_tp_mdix_ctrl;
+	__s8	link_mode_masks_nwords;
+	__u32	reserved[8];
+	__u32	link_mode_masks[0];
+	/* layout of link_mode_masks fields:
+	 * __u32 map_supported[link_mode_masks_nwords];
+	 * __u32 map_advertising[link_mode_masks_nwords];
+	 * __u32 map_lp_advertising[link_mode_masks_nwords];
+	 */
+};
 #endif /* _UAPI_LINUX_ETHTOOL_H */
diff --git a/net/core/ethtool.c b/net/core/ethtool.c
index 453c803..669bd78 100644
--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -386,6 +386,330 @@ static int __ethtool_set_flags(struct net_device *dev, u32 data)
 	return 0;
 }
 
+static void convert_legacy_u32_to_link_mode(unsigned long *dst, u32 legacy_u32)
+{
+	bitmap_zero(dst, __ETHTOOL_LINK_MODE_MASK_NBITS);
+	dst[0] = legacy_u32;
+}
+
+/* return false if src had higher bits set. lower bits always updated. */
+static bool convert_link_mode_to_legacy_u32(u32 *legacy_u32,
+					    const unsigned long *src)
+{
+	bool retval = true;
+
+	/* TODO: following test will soon always be true */
+	if (__ETHTOOL_LINK_MODE_MASK_NBITS > 32) {
+		__ETHTOOL_DECLARE_LINK_MODE_MASK(ext);
+
+		bitmap_zero(ext, __ETHTOOL_LINK_MODE_MASK_NBITS);
+		bitmap_fill(ext, 32);
+		bitmap_complement(ext, ext, __ETHTOOL_LINK_MODE_MASK_NBITS);
+		if (bitmap_intersects(ext, src,
+				      __ETHTOOL_LINK_MODE_MASK_NBITS)) {
+			/* src mask goes beyond bit 31 */
+			retval = false;
+		}
+	}
+	*legacy_u32 = src[0];
+	return retval;
+}
+
+/* return false if legacy contained non-0 deprecated fields
+ * transceiver/maxtxpkt/maxrxpkt. rest of ksettings always updated
+ */
+static bool
+convert_legacy_settings_to_ksettings(struct ethtool_ksettings *ksettings,
+				     const struct ethtool_cmd *legacy_settings)
+{
+	bool retval = true;
+
+	memset(ksettings, 0, sizeof(*ksettings));
+
+	/* This is used to tell users that driver is still using these
+	 * deprecated legacy fields, and they should not use
+	 * %ETHTOOL_GSETTINGS/%ETHTOOL_SSETTINGS
+	 */
+	if (legacy_settings->transceiver ||
+	    legacy_settings->maxtxpkt ||
+	    legacy_settings->maxrxpkt)
+		retval = false;
+
+	convert_legacy_u32_to_link_mode(ksettings->link_modes.supported,
+					legacy_settings->supported);
+	convert_legacy_u32_to_link_mode(ksettings->link_modes.advertising,
+					legacy_settings->advertising);
+	convert_legacy_u32_to_link_mode(ksettings->link_modes.lp_advertising,
+					legacy_settings->lp_advertising);
+	ksettings->parent.speed = ethtool_cmd_speed(legacy_settings);
+	ksettings->parent.duplex = legacy_settings->duplex;
+	ksettings->parent.port = legacy_settings->port;
+	ksettings->parent.phy_address = legacy_settings->phy_address;
+	ksettings->parent.autoneg = legacy_settings->autoneg;
+	ksettings->parent.mdio_support = legacy_settings->mdio_support;
+	ksettings->parent.eth_tp_mdix = legacy_settings->eth_tp_mdix;
+	ksettings->parent.eth_tp_mdix_ctrl = legacy_settings->eth_tp_mdix_ctrl;
+	return retval;
+}
+
+/* return false if ksettings link modes had higher bits
+ * set. legacy_settings always updated (best effort)
+ */
+static bool
+convert_ksettings_to_legacy_settings(struct ethtool_cmd *legacy_settings,
+				     const struct ethtool_ksettings *ksettings)
+{
+	bool retval = true;
+
+	memset(legacy_settings, 0, sizeof(*legacy_settings));
+	/* this also clears the deprecated fields in legacy structure:
+	 * __u8		transceiver;
+	 * __u32	maxtxpkt;
+	 * __u32	maxrxpkt;
+	 */
+
+	retval &= convert_link_mode_to_legacy_u32(
+		&legacy_settings->supported,
+		ksettings->link_modes.supported);
+	retval &= convert_link_mode_to_legacy_u32(
+		&legacy_settings->advertising,
+		ksettings->link_modes.advertising);
+	retval &= convert_link_mode_to_legacy_u32(
+		&legacy_settings->lp_advertising,
+		ksettings->link_modes.lp_advertising);
+	ethtool_cmd_speed_set(legacy_settings, ksettings->parent.speed);
+	legacy_settings->duplex = ksettings->parent.duplex;
+	legacy_settings->port = ksettings->parent.port;
+	legacy_settings->phy_address = ksettings->parent.phy_address;
+	legacy_settings->autoneg = ksettings->parent.autoneg;
+	legacy_settings->mdio_support = ksettings->parent.mdio_support;
+	legacy_settings->eth_tp_mdix = ksettings->parent.eth_tp_mdix;
+	legacy_settings->eth_tp_mdix_ctrl = ksettings->parent.eth_tp_mdix_ctrl;
+	return retval;
+}
+
+/* number of 32-bit words to store the user's link mode bitmaps */
+#define __ETHTOOL_LINK_MODE_MASK_NU32			\
+	DIV_ROUND_UP(__ETHTOOL_LINK_MODE_MASK_NBITS, 32)
+
+/* layout of the struct passed from/to userland */
+struct ethtool_usettings {
+	struct ethtool_settings parent;
+	struct {
+		__u32 supported[__ETHTOOL_LINK_MODE_MASK_NU32];
+		__u32 advertising[__ETHTOOL_LINK_MODE_MASK_NU32];
+		__u32 lp_advertising[__ETHTOOL_LINK_MODE_MASK_NU32];
+	} link_modes;
+};
+
+/* Internal kernel helper to query a device ethtool_settings.
+ *
+ * Backward compatibility note: for compatibility with legacy drivers
+ * that implement only the ethtool_cmd API, this has to work with both
+ * drivers implementing get_ksettings API and drivers implementing
+ * get_settings API. When drivers implement get_settings and report
+ * ethtool_cmd deprecated fields (transceiver/maxrxpkt/maxtxpkt),
+ * these fields are silently ignored because the resulting struct
+ * ethtool_settings does not report them.
+ */
+int __ethtool_get_ksettings(struct net_device *dev,
+			    struct ethtool_ksettings *ksettings)
+{
+	int err;
+	struct ethtool_cmd cmd;
+
+	ASSERT_RTNL();
+
+	if (dev->ethtool_ops->get_ksettings) {
+		memset(ksettings, 0, sizeof(*ksettings));
+		return dev->ethtool_ops->get_ksettings(dev, ksettings);
+	}
+
+	/* driver doesn't support %ethtool_ksettings API. revert to
+	 * legacy %ethtool_cmd API, unless it's not supported either.
+	 * TODO: remove when ethtool_ops::get_settings disappears internally
+	 */
+	err = __ethtool_get_settings(dev, &cmd);
+	if (err < 0)
+		return err;
+
+	/* we ignore deprecated fields transceiver/maxrxpkt/maxtxpkt
+	 */
+	convert_legacy_settings_to_ksettings(ksettings, &cmd);
+	return err;
+}
+EXPORT_SYMBOL(__ethtool_get_ksettings);
+
+/* convert ethtool_usettings in user space to a kernel internal
+ * ethtool_ksettings. return 0 on success, errno on error.
+ */
+static int load_ksettings_from_user(struct ethtool_ksettings *to,
+				    const void __user *from)
+{
+	struct ethtool_usettings usettings;
+
+	if (copy_from_user(&usettings, from, sizeof(usettings)))
+		return -EFAULT;
+
+	memcpy(&to->parent, &usettings.parent, sizeof(to->parent));
+	bitmap_from_u32array(to->link_modes.supported,
+			     __ETHTOOL_LINK_MODE_MASK_NBITS,
+			     usettings.link_modes.supported,
+			     __ETHTOOL_LINK_MODE_MASK_NU32);
+	bitmap_from_u32array(to->link_modes.advertising,
+			     __ETHTOOL_LINK_MODE_MASK_NBITS,
+			     usettings.link_modes.advertising,
+			     __ETHTOOL_LINK_MODE_MASK_NU32);
+	bitmap_from_u32array(to->link_modes.lp_advertising,
+			     __ETHTOOL_LINK_MODE_MASK_NBITS,
+			     usettings.link_modes.lp_advertising,
+			     __ETHTOOL_LINK_MODE_MASK_NU32);
+
+	return 0;
+}
+
+/* convert a kernel internal ethtool_ksettings to ethtool_usettings in
+ * user space. return 0 on success, errno on error.
+ */
+static int store_ksettings_for_user(void __user *to,
+				    const struct ethtool_ksettings *from)
+{
+	struct ethtool_usettings usettings;
+
+	memcpy(&usettings.parent, &from->parent, sizeof(usettings));
+	bitmap_to_u32array(usettings.link_modes.supported,
+			   __ETHTOOL_LINK_MODE_MASK_NU32,
+			   from->link_modes.supported,
+			   __ETHTOOL_LINK_MODE_MASK_NBITS);
+	bitmap_to_u32array(usettings.link_modes.advertising,
+			   __ETHTOOL_LINK_MODE_MASK_NU32,
+			   from->link_modes.advertising,
+			   __ETHTOOL_LINK_MODE_MASK_NBITS);
+	bitmap_to_u32array(usettings.link_modes.lp_advertising,
+			   __ETHTOOL_LINK_MODE_MASK_NU32,
+			   from->link_modes.lp_advertising,
+			   __ETHTOOL_LINK_MODE_MASK_NBITS);
+
+	if (copy_to_user(to, &usettings, sizeof(usettings)))
+		return -EFAULT;
+
+	return 0;
+}
+
+/* Query device for its ethtool_settings.
+ *
+ * Backward compatibility note: this function must fail when driver
+ * does not implement ethtool::get_ksettings, even if legacy
+ * ethtool_ops::get_settings is implemented. This tells new versions
+ * of ethtool that they should use the legacy API %ETHTOOL_GSET for
+ * this driver, so that they can correctly access the ethtool_cmd
+ * deprecated fields (transceiver/maxrxpkt/maxtxpkt), until no driver
+ * implements ethtool_ops::get_settings anymore.
+ */
+static int ethtool_get_ksettings(struct net_device *dev, void __user *useraddr)
+{
+	int err = 0;
+	struct ethtool_ksettings ksettings;
+
+	if (!dev->ethtool_ops->get_ksettings)
+		return -EOPNOTSUPP;
+
+	/* handle bitmap nbits handshake */
+	if (copy_from_user(&ksettings.parent, useraddr,
+			   sizeof(ksettings.parent)))
+		return -EFAULT;
+
+	if (__ETHTOOL_LINK_MODE_MASK_NU32
+	    != ksettings.parent.link_mode_masks_nwords) {
+		/* wrong link mode nbits requested */
+		memset(&ksettings, 0, sizeof(ksettings));
+		/* keep cmd field reset to 0 */
+		/* send back number of words required as negative val */
+		compiletime_assert(__ETHTOOL_LINK_MODE_MASK_NU32 <= S8_MAX,
+				   "need too many bits for link modes!");
+		ksettings.parent.link_mode_masks_nwords
+			= -((s8)__ETHTOOL_LINK_MODE_MASK_NU32);
+
+		/* copy the base fields back to user, not the link
+		 * mode bitmaps
+		 */
+		if (copy_to_user(useraddr, &ksettings.parent,
+				 sizeof(ksettings.parent)))
+			return -EFAULT;
+
+		return 0;
+	}
+
+	/* handshake successful: user/kernel agree on
+	 * link_mode_masks_nwords
+	 */
+
+	memset(&ksettings, 0, sizeof(ksettings));
+	err = dev->ethtool_ops->get_ksettings(dev, &ksettings);
+	if (err < 0)
+		return err;
+
+	/* make sure we tell the right values to user */
+	ksettings.parent.cmd = ETHTOOL_GSETTINGS;
+	ksettings.parent.link_mode_masks_nwords
+		= __ETHTOOL_LINK_MODE_MASK_NU32;
+
+	return store_ksettings_for_user(useraddr, &ksettings);
+}
+
+/* Update device ethtool_settings.
+ *
+ * Backward compatibility note: this function must fail when driver
+ * does not implement ethtool::set_ksettings, even if legacy
+ * ethtool_ops::set_settings is implemented. This tells new versions
+ * of ethtool that they should use the legacy API %ETHTOOL_SSET for
+ * this driver, so that they can correctly update the ethtool_cmd
+ * deprecated fields (transceiver/maxrxpkt/maxtxpkt), until no driver
+ * implements ethtool_ops::get_settings anymore.
+ */
+static int ethtool_set_ksettings(struct net_device *dev, void __user *useraddr)
+{
+	int err;
+	struct ethtool_ksettings ksettings;
+
+	if (!dev->ethtool_ops->set_ksettings)
+		return -EOPNOTSUPP;
+
+	/* make sure nbits field has expected value */
+	if (copy_from_user(&ksettings.parent, useraddr,
+			   sizeof(ksettings.parent)))
+		return -EFAULT;
+
+	if (__ETHTOOL_LINK_MODE_MASK_NU32
+	    != ksettings.parent.link_mode_masks_nwords)
+		return -EINVAL;
+
+	/* copy the whole structure, now that we know it has expected
+	 * format
+	 */
+	err = load_ksettings_from_user(&ksettings, useraddr);
+	if (err)
+		return err;
+
+	/* re-check nwords field, just in case */
+	if (__ETHTOOL_LINK_MODE_MASK_NU32
+	    != ksettings.parent.link_mode_masks_nwords)
+		return -EINVAL;
+
+	return dev->ethtool_ops->set_ksettings(dev, &ksettings);
+}
+
+/* Internal kernel helper to query a device ethtool_cmd settings.
+ *
+ * Note about transition to ethtool_settings API: We do not need (or
+ * want) this function to support "dev" instances that implement the
+ * ethtool_settings API as we will update the drivers calling this
+ * function to call __ethtool_get_ksettings instead, before the first
+ * drivers implement ethtool_ops::get_ksettings.
+ *
+ * TODO 1: at least make this function static when no driver is using it
+ * TODO 2: remove when ethtool_ops::get_settings disappears internally
+ */
 int __ethtool_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 {
 	ASSERT_RTNL();
@@ -399,30 +723,108 @@ int __ethtool_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 }
 EXPORT_SYMBOL(__ethtool_get_settings);
 
+static void
+warn_incomplete_ethtool_legacy_settings_conversion(const char *details)
+{
+	char name[sizeof(current->comm)];
+
+	pr_info_once("warning: `%s' uses legacy ethtool settings API, %s\n",
+		     get_task_comm(name, current), details);
+}
+
+/* Query device for its ethtool_cmd settings.
+ *
+ * Backward compatibility note: for compatibility with legacy ethtool,
+ * this has to work with both drivers implementing get_ksettings API
+ * and drivers implementing get_settings API. When drivers implement
+ * get_ksettings and report higher link mode bits, a kernel warning is
+ * logged once (with name of 1st driver/device) to recommend user to
+ * upgrade ethtool, but the command is successful (only the lower link
+ * mode bits reported back to user).
+ */
 static int ethtool_get_settings(struct net_device *dev, void __user *useraddr)
 {
-	int err;
 	struct ethtool_cmd cmd;
 
-	err = __ethtool_get_settings(dev, &cmd);
-	if (err < 0)
-		return err;
+	ASSERT_RTNL();
+
+	if (dev->ethtool_ops->get_ksettings) {
+		/* First, use ksettings API if it is supported */
+		int err;
+		struct ethtool_ksettings ksettings;
+
+		memset(&ksettings, 0, sizeof(ksettings));
+		err = dev->ethtool_ops->get_ksettings(dev, &ksettings);
+		if (err < 0)
+			return err;
+		if (!convert_ksettings_to_legacy_settings(&cmd, &ksettings))
+			warn_incomplete_ethtool_legacy_settings_conversion(
+				"link modes are only partially reported");
+
+		/* send a sensible cmd tag back to user */
+		cmd.cmd = ETHTOOL_GSET;
+	} else {
+		int err;
+		/* TODO: return -EOPNOTSUPP when
+		 * ethtool_ops::get_settings disappears internally
+		 */
+
+		/* driver doesn't support %ethtool_ksettings
+		 * API. revert to legacy %ethtool_cmd API, unless it's
+		 * not supported either.
+		 */
+		err = __ethtool_get_settings(dev, &cmd);
+		if (err < 0)
+			return err;
+	}
 
 	if (copy_to_user(useraddr, &cmd, sizeof(cmd)))
 		return -EFAULT;
+
 	return 0;
 }
 
+/* Update device settings with given ethtool_cmd.
+ *
+ * Backward compatibility note: for compatibility with legacy ethtool,
+ * this has to work with both drivers implementing set_ksettings API
+ * and drivers implementing set_settings API. When drivers implement
+ * set_ksettings and user's request updates deprecated ethtool_cmd
+ * fields (transceiver/maxrxpkt/maxtxpkt), a kernel warning is logged
+ * once (with name of 1st driver/device) to recommend user to upgrade
+ * ethtool, and the request is rejected.
+ */
 static int ethtool_set_settings(struct net_device *dev, void __user *useraddr)
 {
 	struct ethtool_cmd cmd;
 
-	if (!dev->ethtool_ops->set_settings)
-		return -EOPNOTSUPP;
+	ASSERT_RTNL();
 
 	if (copy_from_user(&cmd, useraddr, sizeof(cmd)))
 		return -EFAULT;
 
+	/* first, try new %ethtool_ksettings API. */
+	if (dev->ethtool_ops->set_ksettings) {
+		struct ethtool_ksettings ksettings;
+
+		if (!convert_legacy_settings_to_ksettings(&ksettings, &cmd))
+			return -EINVAL;
+
+		ksettings.parent.cmd = ETHTOOL_SSETTINGS;
+		ksettings.parent.link_mode_masks_nwords
+			= __ETHTOOL_LINK_MODE_MASK_NU32;
+		return dev->ethtool_ops->set_ksettings(dev, &ksettings);
+	}
+
+	/* legacy %ethtool_cmd API */
+
+	/* TODO: return -EOPNOTSUPP when ethtool_ops::get_settings
+	 * disappears internally
+	 */
+
+	if (!dev->ethtool_ops->set_settings)
+		return -EOPNOTSUPP;
+
 	return dev->ethtool_ops->set_settings(dev, &cmd);
 }
 
@@ -2070,6 +2472,12 @@ int dev_ethtool(struct net *net, struct ifreq *ifr)
 	case ETHTOOL_GPHYSTATS:
 		rc = ethtool_get_phy_stats(dev, useraddr);
 		break;
+	case ETHTOOL_GSETTINGS:
+		rc = ethtool_get_ksettings(dev, useraddr);
+		break;
+	case ETHTOOL_SSETTINGS:
+		rc = ethtool_set_ksettings(dev, useraddr);
+		break;
 	default:
 		rc = -EOPNOTSUPP;
 	}
-- 
2.7.0.rc3.207.g0ac5344
