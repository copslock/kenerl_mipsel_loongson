Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jun 2009 14:26:50 +0200 (CEST)
Received: from mailout02.rmx.de ([217.111.120.10]:55517 "EHLO mailout02.rmx.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492653AbZF2M0m (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Jun 2009 14:26:42 +0200
Received: from [172.19.17.48] (HELO kdin01.retarus.de)
  by mailout02.rmx.de (CommuniGate Pro SMTP 5.2.13 _community_)
  with ESMTP id 40918528 for linux-mips@linux-mips.org; Mon, 29 Jun 2009 14:21:46 +0200
Received: from bzvsmg91.dmzext.sys.sphairon.com (mail01.pmns.de [195.243.125.132])
	by kdin01.retarus.de (8.14.2/8.14.2/retarus.custom) with SMTP id n5TCLjKV009000
	for <linux-mips@linux-mips.org>; Mon, 29 Jun 2009 14:21:45 +0200
Received: from BZSVEX02.sas.sys.sphairon.com (bzsvex02.sas.sys.sphairon.com [10.158.5.105])
	by bzvsmg91.dmzext.sys.sphairon.com (Postfix) with ESMTP id E795160609
	for <linux-mips@linux-mips.org>; Mon, 29 Jun 2009 14:20:30 +0200 (CEST)
Received: from [10.158.7.50] (10.158.7.50) by bzsvex02.sas.sys.sphairon.com
 (10.158.5.105) with Microsoft SMTP Server (TLS) id 8.1.358.0; Mon, 29 Jun
 2009 14:21:44 +0200
Message-ID: <4A48B1D5.5020003@sphairon.com>
Date:	Mon, 29 Jun 2009 14:21:41 +0200
From:	Frank Seidel <Frank.Seidel@sphairon.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
MIME-Version: 1.0
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:	"Seidel, Frank" <Frank.Seidel@sphairon.com>
Subject: [PATCH] linux-2.4: vlan: Slab memleak fix
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-RMX-ID: 20090629-142145-n5TCLjKV009000-0@kdin01
X-RMX-TRACE: 2009-06-29 14:21:46 RmxMSO@kdin01/mailcc06 [0.1s] 20090629-142145-n5TCLjKV009000-0@kdin01 0:00:01
X-RMX-TRACE: 2009-06-29 14:21:46 KdIn@kdin01/mailcc09 [0.5s] 20090629-142145-n5TCLjKV009000-0@kdin01 0:00:00
Return-Path: <Frank.Seidel@sphairon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23530
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Frank.Seidel@sphairon.com
Precedence: bulk
X-list: linux-mips

Author: Arne Redlich <readlicha@sphairon.com>

Fix slab memleak on wan service restart

Signed-off-by: Arne Redlich <redlicha@sphairon.com>
Signed-off-by: Frank Seidel <Frank.Seidel@sphairon.com>
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
