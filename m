Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Jul 2018 21:14:57 +0200 (CEST)
Received: from mx1.mailbox.org ([80.241.60.212]:50480 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993874AbeGUTOhVYtgY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 21 Jul 2018 21:14:37 +0200
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id BF0684757D;
        Sat, 21 Jul 2018 21:14:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id vC32wpsMn1wY; Sat, 21 Jul 2018 21:14:30 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/4] net: dsa: Add Lantiq / Intel GSWIP tag support
Date:   Sat, 21 Jul 2018 21:13:56 +0200
Message-Id: <20180721191358.13952-3-hauke@hauke-m.de>
In-Reply-To: <20180721191358.13952-1-hauke@hauke-m.de>
References: <20180721191358.13952-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

This handles the tag added by the PMAC on the VRX200 SoC line.

The GSWIP uses internally a GSWIP special tag which is located after the
Ethernet header. The PMAC which connects the GSWIP to the CPU converts
this special tag used by the GSWIP into the PMAC special tag which is
added in front of the Ethernet header.

This was tested with GSWIP 2.0 found in the VRX200 SoCs, other GSWIP
versions use slightly different PMAC special tags

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 MAINTAINERS         |   6 +++
 include/net/dsa.h   |   1 +
 net/dsa/Kconfig     |   3 ++
 net/dsa/Makefile    |   1 +
 net/dsa/dsa.c       |   3 ++
 net/dsa/dsa_priv.h  |   3 ++
 net/dsa/tag_gswip.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 127 insertions(+)
 create mode 100644 net/dsa/tag_gswip.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 192d7f73fd01..741718ff9b79 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8009,6 +8009,12 @@ S:	Maintained
 F:	net/l3mdev
 F:	include/net/l3mdev.h
 
+LANTIQ / INTEL Ethernet drivers
+M:	Hauke Mehrtens <hauke@hauke-m.de>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	net/dsa/tag_gswip.c
+
 LANTIQ MIPS ARCHITECTURE
 M:	John Crispin <john@phrozen.org>
 L:	linux-mips@linux-mips.org
diff --git a/include/net/dsa.h b/include/net/dsa.h
index fdbd6082945d..60bc8952e29b 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -35,6 +35,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_BRCM_PREPEND,
 	DSA_TAG_PROTO_DSA,
 	DSA_TAG_PROTO_EDSA,
+	DSA_TAG_PROTO_GSWIP,
 	DSA_TAG_PROTO_KSZ,
 	DSA_TAG_PROTO_LAN9303,
 	DSA_TAG_PROTO_MTK,
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 4183e4ba27a5..48c41918fb35 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -38,6 +38,9 @@ config NET_DSA_TAG_DSA
 config NET_DSA_TAG_EDSA
 	bool
 
+config NET_DSA_TAG_GSWIP
+	bool
+
 config NET_DSA_TAG_KSZ
 	bool
 
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index 9e4d3536f977..6e721f7a2947 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -9,6 +9,7 @@ dsa_core-$(CONFIG_NET_DSA_TAG_BRCM) += tag_brcm.o
 dsa_core-$(CONFIG_NET_DSA_TAG_BRCM_PREPEND) += tag_brcm.o
 dsa_core-$(CONFIG_NET_DSA_TAG_DSA) += tag_dsa.o
 dsa_core-$(CONFIG_NET_DSA_TAG_EDSA) += tag_edsa.o
+dsa_core-$(CONFIG_NET_DSA_TAG_GSWIP) += tag_gswip.o
 dsa_core-$(CONFIG_NET_DSA_TAG_KSZ) += tag_ksz.o
 dsa_core-$(CONFIG_NET_DSA_TAG_LAN9303) += tag_lan9303.o
 dsa_core-$(CONFIG_NET_DSA_TAG_MTK) += tag_mtk.o
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index e63c554e0623..81212109c507 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -54,6 +54,9 @@ const struct dsa_device_ops *dsa_device_ops[DSA_TAG_LAST] = {
 #ifdef CONFIG_NET_DSA_TAG_EDSA
 	[DSA_TAG_PROTO_EDSA] = &edsa_netdev_ops,
 #endif
+#ifdef CONFIG_NET_DSA_TAG_GSWIP
+	[DSA_TAG_PROTO_GSWIP] = &gswip_netdev_ops,
+#endif
 #ifdef CONFIG_NET_DSA_TAG_KSZ
 	[DSA_TAG_PROTO_KSZ] = &ksz_netdev_ops,
 #endif
diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index 3964c6f7a7c0..824ca07a30aa 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -205,6 +205,9 @@ extern const struct dsa_device_ops dsa_netdev_ops;
 /* tag_edsa.c */
 extern const struct dsa_device_ops edsa_netdev_ops;
 
+/* tag_gswip.c */
+extern const struct dsa_device_ops gswip_netdev_ops;
+
 /* tag_ksz.c */
 extern const struct dsa_device_ops ksz_netdev_ops;
 
diff --git a/net/dsa/tag_gswip.c b/net/dsa/tag_gswip.c
new file mode 100644
index 000000000000..cb559768c87f
--- /dev/null
+++ b/net/dsa/tag_gswip.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel / Lantiq GSWIP tag support
+ *
+ * Copyright (C) 2017 - 2018 Hauke Mehrtens <hauke@hauke-m.de>
+ */
+
+#include <linux/bitops.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <net/dsa.h>
+
+#include "dsa_priv.h"
+
+
+#define GSWIP_TX_HEADER_LEN		4
+
+/* special tag in TX path header */
+/* Byte 0 */
+#define GSWIP_TX_DPID_EN		BIT(0)
+#define GSWIP_TX_PORT_MAP_SHIFT		1
+#define GSWIP_TX_PORT_MAP_MASK		GENMASK(6, 1)
+
+/* Byte 1 */
+#define GSWIP_TX_CLASS_SHIFT		0
+#define GSWIP_TX_CLASS_MASK		GENMASK(3, 0)
+#define GSWIP_TX_CLASS_EN		BIT(4)
+#define GSWIP_TX_LRN_DIS		BIT(5)
+#define GSWIP_TX_PORT_MAP_SEL		BIT(6)
+#define GSWIP_TX_PORT_MAP_EN		BIT(7)
+
+/* Byte 2 */
+#define GSWIP_TX_DPID_SHIFT		0	/* destination group ID */
+#define  GSWIP_TX_DPID_ELAN		0
+#define  GSWIP_TX_DPID_EWAN		1
+#define  GSWIP_TX_DPID_CPU		2
+#define  GSWIP_TX_DPID_APP1		3
+#define  GSWIP_TX_DPID_APP2		4
+#define  GSWIP_TX_DPID_APP3		5
+#define  GSWIP_TX_DPID_APP4		6
+#define  GSWIP_TX_DPID_APP5		7
+
+/* Byte 3 */
+#define GSWIP_TX_CRCGEN_DIS		BIT(23)
+#define GSWIP_TX_SLPID_SHIFT		0	/* source port ID */
+#define  GSWIP_TX_SLPID_CPU		2
+#define  GSWIP_TX_SLPID_APP1		3
+#define  GSWIP_TX_SLPID_APP2		4
+#define  GSWIP_TX_SLPID_APP3		5
+#define  GSWIP_TX_SLPID_APP4		6
+#define  GSWIP_TX_SLPID_APP5		7
+
+
+#define GSWIP_RX_HEADER_LEN	8
+
+/* special tag in RX path header */
+/* Byte 7 */
+#define GSWIP_RX_SPPID_SHIFT		4
+#define GSWIP_RX_SPPID_MASK		GENMASK(6, 4)
+
+
+static struct sk_buff *gswip_tag_xmit(struct sk_buff *skb,
+				      struct net_device *dev)
+{
+	struct dsa_port *dp = dsa_slave_to_port(dev);
+	int err;
+	u8 *gswip_tag;
+
+	err = skb_cow_head(skb, GSWIP_TX_HEADER_LEN);
+	if (err)
+		return NULL;
+
+	skb_push(skb, GSWIP_TX_HEADER_LEN);
+
+	gswip_tag = skb->data;
+	gswip_tag[0] = GSWIP_TX_SLPID_CPU;
+	gswip_tag[1] = GSWIP_TX_DPID_ELAN;
+	gswip_tag[2] = GSWIP_TX_PORT_MAP_EN | GSWIP_TX_PORT_MAP_SEL;
+	gswip_tag[3] = BIT(dp->index + GSWIP_TX_PORT_MAP_SHIFT) & GSWIP_TX_PORT_MAP_MASK;
+	gswip_tag[3] |= GSWIP_TX_DPID_EN;
+
+	return skb;
+}
+
+static struct sk_buff *gswip_tag_rcv(struct sk_buff *skb,
+				     struct net_device *dev,
+				     struct packet_type *pt)
+{
+	int port;
+	u8 *gswip_tag;
+
+	if (unlikely(!pskb_may_pull(skb, GSWIP_RX_HEADER_LEN)))
+		return NULL;
+
+	gswip_tag = ((u8 *)skb->data) - ETH_HLEN;
+	skb_pull_rcsum(skb, GSWIP_RX_HEADER_LEN);
+
+	/* Get source port information */
+	port = (gswip_tag[7] & GSWIP_RX_SPPID_MASK) >> GSWIP_RX_SPPID_SHIFT;
+	skb->dev = dsa_master_find_slave(dev, 0, port);
+	if (!skb->dev)
+		return NULL;
+
+	return skb;
+}
+
+const struct dsa_device_ops gswip_netdev_ops = {
+	.xmit = gswip_tag_xmit,
+	.rcv = gswip_tag_rcv,
+};
-- 
2.11.0
