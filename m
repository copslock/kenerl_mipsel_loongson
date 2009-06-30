Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jun 2009 10:21:17 +0200 (CEST)
Received: from mailout02.rmx.de ([217.111.120.10]:42263 "EHLO mailout02.rmx.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492172AbZF3IVK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 30 Jun 2009 10:21:10 +0200
Received: from [172.19.17.48] (HELO kdin01.retarus.de)
  by mailout02.rmx.de (CommuniGate Pro SMTP 5.2.13 _community_)
  with ESMTP id 41050363; Tue, 30 Jun 2009 10:15:59 +0200
Received: from bzvsmg91.dmzext.sys.sphairon.com (mail01.pmns.de [195.243.125.132])
	by kdin01.retarus.de (8.14.2/8.14.2/retarus.custom) with SMTP id n5U8Fv36014826;
	Tue, 30 Jun 2009 10:15:58 +0200
Received: from BZSVEX02.sas.sys.sphairon.com (bzsvex02.sas.sys.sphairon.com [10.158.5.105])
	by bzvsmg91.dmzext.sys.sphairon.com (Postfix) with ESMTP id BD79B60566;
	Tue, 30 Jun 2009 10:14:41 +0200 (CEST)
Received: from [10.158.7.50] (10.158.7.50) by bzsvex02.sas.sys.sphairon.com
 (10.158.5.105) with Microsoft SMTP Server (TLS) id 8.1.358.0; Tue, 30 Jun
 2009 10:15:57 +0200
Message-ID: <4A49C9BC.6050908@sphairon.com>
Date:	Tue, 30 Jun 2009 10:15:56 +0200
From:	Frank Seidel <Frank.Seidel@sphairon.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
MIME-Version: 1.0
To:	Willy Tarreau <w@1wt.eu>
CC:	"Seidel, Frank" <Frank.Seidel@sphairon.com>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [PATCH] linux-2.4: br2684: fix double freeing skb
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-RMX-ID: 20090630-101558-n5U8Fv36014826-0@kdin01
X-RMX-TRACE: 2009-06-30 10:15:59 RmxMSO@kdin01/mailcc10 [0.1s] 20090630-101558-n5U8Fv36014826-0@kdin01 0:00:01
X-RMX-TRACE: 2009-06-30 10:15:59 KdIn@kdin01/mailcc03 [0.9s] 20090630-101558-n5U8Fv36014826-0@kdin01 0:00:00
Return-Path: <Frank.Seidel@sphairon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Frank.Seidel@sphairon.com
Precedence: bulk
X-list: linux-mips

Author: Peter Sieber <siep@sphairon.com>

Fix double freeing skb, see net/core/dev.c
dev_queue_xmit().

Signed-off-by: Peter Sieber <siep@sphairon.com>
Signed-off-by: Frank Seidel <Frank.Seidel@sphairon.com>
---
 net/atm/br2684.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/atm/br2684.c
+++ b/net/atm/br2684.c
@@ -221,7 +221,7 @@ static int br2684_start_xmit(struct sk_b
 		/* netif_stop_queue(dev); */
 		dev_kfree_skb(skb);
 		read_unlock(&devs_lock);
-		return -EUNATCH;
+		return 0;
 	}
 	if (!br2684_xmit_vcc(skb, brdev, brvcc)) {
 		/*
