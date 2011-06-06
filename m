Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 21:21:21 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11431 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491874Ab1FFTUK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jun 2011 21:20:10 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ded28a90000>; Mon, 06 Jun 2011 12:21:13 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 6 Jun 2011 12:20:08 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 6 Jun 2011 12:20:08 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p56JJxoU027117;
        Mon, 6 Jun 2011 12:19:59 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p56JJvxb027116;
        Mon, 6 Jun 2011 12:19:57 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [RFC PATCH v5 2/6] of: Make of_find_node_by_path() traverse /aliases for relative paths.
Date:   Mon,  6 Jun 2011 12:19:42 -0700
Message-Id: <1307387986-27069-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1307387986-27069-1-git-send-email-ddaney@caviumnetworks.com>
References: <1307387986-27069-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 06 Jun 2011 19:20:08.0096 (UTC) FILETIME=[BF4E4A00:01CC247E]
X-archive-position: 30261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4748

Currently all paths passed to of_find_node_by_path() must begin with a
'/', indicating a full path to the desired node.

Augment the look-up code so that if a path does *not* begin with '/',
the path is used as the name of an /aliases property.  The value of
this alias is then used as the full node path to be found.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/of/base.c |   65 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 632ebae..4165084 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -340,22 +340,81 @@ EXPORT_SYMBOL(of_get_next_child);
 
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
  */
 struct device_node *of_find_node_by_path(const char *path)
 {
-	struct device_node *np = allnodes;
+	struct device_node *np = NULL;
+	struct device_node *aliases = NULL;
+	char *alias = NULL;
+	char *new_path = NULL;
+	char *ps;
 
 	read_lock(&devtree_lock);
-	for (; np; np = np->allnext) {
+
+	/*
+	 * The following code has three possibilities:
+	 * 1) '/' at start of string; path == ps; (based at root)
+	 * 2) '/' at offset in string; path < ps; (relative to alias)
+	 * 3) '/' not found; ps == NULL; (alias only)
+	 *
+	 * If ps != path, then it is either a pure alias (ps == NULL),
+	 * or an alias with a relative path (path < ps).  Either way,
+	 * look up the path pointed to by the alias.
+	 */
+	ps = strchr(path, '/');
+	if (path != ps) {
+		aliases = of_find_node_by_path("/aliases");
+		if (!aliases)
+			goto out;
+
+		/*
+		 * Duplicate the alias part of the string so it can be
+		 * NULL terminated.
+		 */
+		alias = kstrndup(path,
+				 ps ? (ps - path) : strlen(path), GFP_KERNEL);
+		if (!alias)
+			goto out;
+		path = of_get_property(aliases, alias, NULL);
+		if (!path || path[0] != '/')
+			goto out;
+
+		/* If ps is not NULL, then there is a relative path to append */
+		if (ps) {
+			new_path = kzalloc(strlen(path) + strlen(ps) + 1,
+					   GFP_KERNEL);
+			if (!new_path)
+				goto out;
+
+			sprintf(new_path, "%s%s", path, ps);
+			path = new_path;
+		}
+	}
+
+	/*
+	 * At this point, path now points to the full unaliased path
+	 * to a node, regardless of whether or not it started with an
+	 * alias.
+	 */
+
+	for (np = allnodes; np; np = np->allnext) {
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
