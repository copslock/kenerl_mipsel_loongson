Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jun 2009 17:54:17 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:58849 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493036AbZF2PyK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Jun 2009 17:54:10 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5TFn5tm019039;
	Mon, 29 Jun 2009 16:49:05 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5TFn5qT019037;
	Mon, 29 Jun 2009 16:49:05 +0100
Date:	Mon, 29 Jun 2009 16:49:05 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Willy Tarreau <w@1wt.eu>
Cc:	Frank Seidel <Frank.Seidel@sphairon.com>,
	linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: [PATCH] linux-2.4: br2684: allocation out of atomic context
Message-ID: <20090629154905.GD18570@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

From: Arne Redlich <redlicha@sphairon.com>

Moved GFP_Kernel allocation out of atomic context

Signed-off-by: Arne Redlich <redlicha@sphairon.com>
Signed-off-by: Frank Seidel <Frank.Seidel@sphairon.com>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---
 net/atm/br2684.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/net/atm/br2684.c
+++ b/net/atm/br2684.c
@@ -509,6 +509,10 @@ Note: we do not have explicit unassign,
 		MOD_DEC_USE_COUNT;
 		return -EFAULT;
 	}
+	brvcc = kmalloc(sizeof(struct br2684_vcc), GFP_KERNEL);
+	if (!brvcc)
+		return -ENOMEM;
+	memset(brvcc, 0, sizeof(struct br2684_vcc));
 	write_lock_irq(&devs_lock);
 	brdev = br2684_find_dev(&be.ifspec);
 	if (brdev == NULL) {
@@ -532,11 +536,6 @@ Note: we do not have explicit unassign,
 		err = -EINVAL;
 		goto error;
 	}
-	brvcc = kmalloc(sizeof(struct br2684_vcc), GFP_KERNEL);
-	if (!brvcc) {
-		err = -ENOMEM;
-		goto error;
-	}
 	memset(brvcc, 0, sizeof(struct br2684_vcc));
 	DPRINTK("br2684_regvcc vcc=%p, encaps=%d, brvcc=%p\n", atmvcc, be.encaps,
 		brvcc);
@@ -567,6 +566,7 @@ Note: we do not have explicit unassign,
 	return 0;
     error:
 	write_unlock_irq(&devs_lock);
+	kfree(brvcc);
 	MOD_DEC_USE_COUNT;
 	return err;
 }
