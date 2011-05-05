Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 May 2011 19:03:43 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:14452 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491052Ab1EERCt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 May 2011 19:02:49 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4dc2d8740002>; Thu, 05 May 2011 10:03:48 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 5 May 2011 10:02:47 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 5 May 2011 10:02:47 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p45H2eKF030512;
        Thu, 5 May 2011 10:02:41 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p45H2ePj030510;
        Thu, 5 May 2011 10:02:40 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [RFC PATCH v3 2/6] of: Make of_find_node_by_path() traverse /aliases for relative paths.
Date:   Thu,  5 May 2011 10:02:25 -0700
Message-Id: <1304614949-30460-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1304614949-30460-1-git-send-email-ddaney@caviumnetworks.com>
References: <1304614949-30460-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 05 May 2011 17:02:47.0194 (UTC) FILETIME=[42206FA0:01CC0B46]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Currently all paths passed to of_find_node_by_path() must begin with a
'/', indicating a full path to the desired node.

Augment the look-up code so that if a path does *not* begin with '/',
the path is used as the name of an /aliases property.  The value of
this alias is then used as the full node path to be found.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/of/base.c |   41 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 632ebae..1a0a83e 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -340,7 +340,10 @@ EXPORT_SYMBOL(of_get_next_child);
 
 /**
  *	of_find_node_by_path - Find a node matching a full OF path
- *	@path:	The full path to match
+ *	@path: Either the full path to match, or if the path does not
+ *	       start with '/', the name of a property of the /aliases
+ *	       node (an alias).  In the case of an alias, the node
+ *	       matching the alias' value will be returned.
  *
  *	Returns a node pointer with refcount incremented, use
  *	of_node_put() on it when done.
@@ -348,14 +351,50 @@ EXPORT_SYMBOL(of_get_next_child);
 struct device_node *of_find_node_by_path(const char *path)
 {
 	struct device_node *np = allnodes;
+	struct device_node *aliases = NULL;
+	char *alias = NULL;
+	char *new_path = NULL;
 
 	read_lock(&devtree_lock);
+
+	if (path[0] != '/') {
+		const char *ps;
+		aliases = of_find_node_by_path("/aliases");
+		if (!aliases)
+			goto out;
+
+		ps = strchr(path, '/');
+		if (ps) {
+			size_t len = ps - path;
+			alias = kmalloc(len + 1, GFP_KERNEL);
+			strncpy(alias, path, len);
+			alias[len] = 0;
+			path = of_get_property(aliases, alias, NULL);
+			if (!path)
+				goto out;
+			len = strlen(path) + strlen(ps) + 1;
+			new_path = kmalloc(len, GFP_KERNEL);
+			strcpy(new_path, path);
+			strcat(new_path, ps);
+			path = new_path;
+		} else {
+			path = of_get_property(aliases, path, NULL);
+		}
+		if (!path)
+			goto out;
+	}
+
 	for (; np; np = np->allnext) {
 		if (np->full_name && (of_node_cmp(np->full_name, path) == 0)
 		    && of_node_get(np))
 			break;
 	}
+out:
+	if (aliases)
+		of_node_put(aliases);
 	read_unlock(&devtree_lock);
+	kfree(alias);
+	kfree(new_path);
 	return np;
 }
 EXPORT_SYMBOL(of_find_node_by_path);
-- 
1.7.2.3
