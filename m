Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Feb 2012 20:22:13 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:57545 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903789Ab2B2TVa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Feb 2012 20:21:30 +0100
Received: by yhjj52 with SMTP id j52so1600797yhj.36
        for <multiple recipients>; Wed, 29 Feb 2012 11:21:24 -0800 (PST)
Received-SPF: pass (google.com: domain of ddaney.cavm@gmail.com designates 10.236.78.231 as permitted sender) client-ip=10.236.78.231;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of ddaney.cavm@gmail.com designates 10.236.78.231 as permitted sender) smtp.mail=ddaney.cavm@gmail.com; dkim=pass header.i=ddaney.cavm@gmail.com
Received: from mr.google.com ([10.236.78.231])
        by 10.236.78.231 with SMTP id g67mr2353439yhe.117.1330543284707 (num_hops = 1);
        Wed, 29 Feb 2012 11:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0pNykod6JGcL9qNHYRXZ1gFCMe178lKmnEdU0tqxBXo=;
        b=hmTURi5My9YD4SWu5KgD2C/kpRQUE45EL+rULob80iUm9irCm6kp49yNXSP8n0F8Sk
         1913Qo6GxJyeZr+pfcJjCUotYzKCgkXDdkAyyrQZadEu4Kv4M4hOKJ3L4ZwslMXCKgrK
         ztqSfIZ3MC/pPHGre5vT8MZ/jFBUnsq+PTI1A=
Received: by 10.236.78.231 with SMTP id g67mr1872247yhe.117.1330543284658;
        Wed, 29 Feb 2012 11:21:24 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id d66sm58182645yhh.12.2012.02.29.11.21.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 29 Feb 2012 11:21:22 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q1TJLKhI018145;
        Wed, 29 Feb 2012 11:21:20 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q1TJLKfZ018144;
        Wed, 29 Feb 2012 11:21:20 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v6 2/2] of: Make of_find_node_by_path() traverse /aliases for relative paths.
Date:   Wed, 29 Feb 2012 11:21:04 -0800
Message-Id: <1330543264-18103-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1330543264-18103-1-git-send-email-ddaney.cavm@gmail.com>
References: <1330543264-18103-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 32580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

Currently all paths passed to of_find_node_by_path() must begin with a
'/', indicating a full path to the desired node.

Augment the look-up code so that if a path does *not* begin with '/',
the path is used as the name of an /aliases property.  The value of
this alias is then used as the full node path to be found.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/of/base.c |   65 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 5806449..0bbe47c 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -365,22 +365,81 @@ EXPORT_SYMBOL(of_get_next_child);
 
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
