Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jun 2009 17:48:39 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:51261 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493027AbZF2Psc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Jun 2009 17:48:32 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5TFhRYN018885;
	Mon, 29 Jun 2009 16:43:27 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5TFhRr3018883;
	Mon, 29 Jun 2009 16:43:27 +0100
Date:	Mon, 29 Jun 2009 16:43:27 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Willy Tarreau <w@1wt.eu>
Cc:	Frank Seidel <Frank.Seidel@sphairon.com>,
	linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: [PATCH] linux-2.4: vlan: Slab memleak fix
Message-ID: <20090629154325.GB18570@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

From: Arne Redlich <readlicha@sphairon.com>

Fix slab memleak on wan service restart

Signed-off-by: Arne Redlich <redlicha@sphairon.com>
Signed-off-by: Frank Seidel <Frank.Seidel@sphairon.com>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---
 net/8021q/vlan_dev.c |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -548,6 +548,22 @@ int vlan_dev_set_ingress_priority(char *
 	return -EINVAL;
 }
 
+/* Remove all egress_priority_map hash table entries. --redlicha */
+static void vlan_dev_destroy_egress_priority_map(struct net_device *dev)
+{
+	struct vlan_dev_info *info = VLAN_DEV_INFO(dev);
+	struct vlan_priority_tci_mapping *m;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(info->egress_priority_map); i++) {
+		while ((m = info->egress_priority_map[i])) {
+			info->egress_priority_map[i] =
+				info->egress_priority_map[i]->next;
+			kfree(m);
+		}
+	}
+}
+
 int vlan_dev_set_egress_priority(char *dev_name, __u32 skb_prio, short vlan_prio)
 {
 	struct net_device *dev = dev_get_by_name(dev_name);
@@ -826,7 +842,11 @@ void vlan_dev_destruct(struct net_device
 		if (dev->priv) {
 			if (VLAN_DEV_INFO(dev)->dent)
 				BUG();
-
+			/*
+			 * Don't leak the hash table entries in
+			 * VLAN_DEV_INFO(dev)->egress_priority_map! --redlicha
+			 */
+			vlan_dev_destroy_egress_priority_map(dev);
 			kfree(dev->priv);
 			dev->priv = NULL;
 		}
