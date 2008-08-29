Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Aug 2008 10:16:34 +0100 (BST)
Received: from mgw1.diku.dk ([130.225.96.91]:149 "EHLO mgw1.diku.dk")
	by ftp.linux-mips.org with ESMTP id S20026997AbYH2JQc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 29 Aug 2008 10:16:32 +0100
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 7BD7552C324;
	Fri, 29 Aug 2008 11:16:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2g7FE9JnUioA; Fri, 29 Aug 2008 11:16:29 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 26E3652C309;
	Fri, 29 Aug 2008 11:16:29 +0200 (CEST)
Received: from imap.diku.dk (imap.diku.dk [130.225.96.139])
	by nhugin.diku.dk (Postfix) with ESMTP
	id C625B6DF893; Fri, 29 Aug 2008 11:13:41 +0200 (CEST)
Received: from mobil-140.diku.dk (fw-mobil.diku.dk [130.225.96.28])
	by imap.diku.dk (Postfix) with ESMTP id 0A96161DCD;
	Fri, 29 Aug 2008 11:16:29 +0200 (CEST)
From:	Julien Brunel <brunel@diku.dk>
To:	dedekind@infradead.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] fs/ubifs: Use an IS_ERR test rather than a NULL test
Date:	Fri, 29 Aug 2008 11:08:32 +0200
User-Agent: KMail/1.9.9
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200808291108.32958.brunel@diku.dk>
Return-Path: <brunel@diku.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brunel@diku.dk
Precedence: bulk
X-list: linux-mips

From: Julien Brunel <brunel@diku.dk>

In case of error, the function kthread_create returns an ERR pointer,
but never returns a NULL pointer. So a NULL test that comes before an
IS_ERR test should be deleted.

The semantic match that finds this problem is as follows:
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@match_bad_null_test@
expression x, E;
statement S1,S2;
@@
x = kthread_create(...)
... when != x = E
* if (x == NULL) 
S1 else S2
// </smpl>

Signed-off-by:  Julien Brunel <brunel@diku.dk>
Signed-off-by:  Julia Lawall <julia@diku.dk>

---
 fs/ubifs/super.c |    4 ----
 1 file changed, 4 deletions(-)

diff -u -p a/fs/ubifs/super.c b/fs/ubifs/super.c
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -1027,8 +1027,6 @@ static int mount_ubifs(struct ubifs_info
 		sprintf(c->bgt_name, BGT_NAME_PATTERN, c->vi.ubi_num,
 			c->vi.vol_id);
 		c->bgt = kthread_create(ubifs_bg_thread, c, c->bgt_name);
-		if (!c->bgt)
-			c->bgt = ERR_PTR(-EINVAL);
 		if (IS_ERR(c->bgt)) {
 			err = PTR_ERR(c->bgt);
 			c->bgt = NULL;
@@ -1340,8 +1338,6 @@ static int ubifs_remount_rw(struct ubifs
 
 	/* Create background thread */
 	c->bgt = kthread_create(ubifs_bg_thread, c, c->bgt_name);
-	if (!c->bgt)
-		c->bgt = ERR_PTR(-EINVAL);
 	if (IS_ERR(c->bgt)) {
 		err = PTR_ERR(c->bgt);
 		c->bgt = NULL;
