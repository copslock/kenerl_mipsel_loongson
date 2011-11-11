Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 02:12:08 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:63155 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904255Ab1KKBLk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Nov 2011 02:11:40 +0100
Received: by gyf1 with SMTP id 1so2833127gyf.36
        for <multiple recipients>; Thu, 10 Nov 2011 17:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=cC+S2tB83+okE4QSfpRL9f8XdGvcnugl80lpgqxijSg=;
        b=Z5OQgypghBXHumMuFFrCavVi/G5foP7/7ZrAN9wsCgN26p0wOBoLDwJkK78KwbnHG4
         rTzMjXBR24ky8kJ4mErM8/PUkln/6fSRzYpcZOOl6weOnjoe60d0ZRnmNrgi1pAyu2sp
         c/YPdiog+TMQmQgSvhxWPs1HFsUw9mi7K9B9E=
Received: by 10.100.237.19 with SMTP id k19mr4293139anh.163.1320973894890;
        Thu, 10 Nov 2011 17:11:34 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id l19sm28978494anc.14.2011.11.10.17.11.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Nov 2011 17:11:34 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pAB1BW5K030122;
        Thu, 10 Nov 2011 17:11:32 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pAB1BWsi030121;
        Thu, 10 Nov 2011 17:11:32 -0800
From:   ddaney.cavm@gmail.com
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 2/2] of: Make of_find_node_by_path() traverse /aliases for relative paths.
Date:   Thu, 10 Nov 2011 17:11:29 -0800
Message-Id: <1320973889-30079-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1320973889-30079-1-git-send-email-ddaney.cavm@gmail.com>
References: <1320973889-30079-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 31522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9904

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
index 9b6588e..cf765c7 100644
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
