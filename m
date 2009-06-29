Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jun 2009 14:30:55 +0200 (CEST)
Received: from mailout02.rmx.de ([217.111.120.10]:52470 "EHLO mailout02.rmx.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492662AbZF2Mas (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Jun 2009 14:30:48 +0200
Received: from [172.19.17.48] (HELO kdin01.retarus.de)
  by mailout02.rmx.de (CommuniGate Pro SMTP 5.2.13 _community_)
  with ESMTP id 40919574 for linux-mips@linux-mips.org; Mon, 29 Jun 2009 14:25:52 +0200
Received: from bzvsmg91.dmzext.sys.sphairon.com (mail01.pmns.de [195.243.125.132])
	by kdin01.retarus.de (8.14.2/8.14.2/retarus.custom) with SMTP id n5TCPpPu013407
	for <linux-mips@linux-mips.org>; Mon, 29 Jun 2009 14:25:51 +0200
Received: from BZSVEX02.sas.sys.sphairon.com (bzsvex02.sas.sys.sphairon.com [10.158.5.105])
	by bzvsmg91.dmzext.sys.sphairon.com (Postfix) with ESMTP id CDB1460609
	for <linux-mips@linux-mips.org>; Mon, 29 Jun 2009 14:24:36 +0200 (CEST)
Received: from [10.158.7.50] (10.158.7.50) by bzsvex02.sas.sys.sphairon.com
 (10.158.5.105) with Microsoft SMTP Server (TLS) id 8.1.358.0; Mon, 29 Jun
 2009 14:25:50 +0200
Message-ID: <4A48B2CC.6060508@sphairon.com>
Date:	Mon, 29 Jun 2009 14:25:48 +0200
From:	Frank Seidel <Frank.Seidel@sphairon.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
MIME-Version: 1.0
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:	"Seidel, Frank" <Frank.Seidel@sphairon.com>
Subject: [PATCH] linux-2.4: br2684: allocation out of atomic context
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-RMX-ID: 20090629-142551-n5TCPpPu013407-0@kdin01
X-RMX-TRACE: 2009-06-29 14:25:52 RmxMSO@kdin01/mailcc10 [0.1s] 20090629-142551-n5TCPpPu013407-0@kdin01 0:00:01
X-RMX-TRACE: 2009-06-29 14:25:52 KdIn@kdin01/mailcc04 [0.5s] 20090629-142551-n5TCPpPu013407-0@kdin01 0:00:00
Return-Path: <Frank.Seidel@sphairon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Frank.Seidel@sphairon.com
Precedence: bulk
X-list: linux-mips

Author: Arne Redlich <redlicha@sphairon.com>

Moved GFP_Kernel allocation out of atomic context

Signed-off-by: Arne Redlich <redlicha@sphairon.com>
Signed-off-by: Frank Seidel <Frank.Seidel@sphairon.com>
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
