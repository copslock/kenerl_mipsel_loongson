Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 04:39:45 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:61967 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133350AbWCTEbp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Mar 2006 04:31:45 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 5CF3864D3E; Mon, 20 Mar 2006 04:41:22 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id EF44066ED5; Mon, 20 Mar 2006 04:41:06 +0000 (GMT)
Date:	Mon, 20 Mar 2006 04:41:06 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	akpm@osdl.org
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	greg@kroah.com
Subject: [PATCH 11/12] [USB] Cosmetic changes to bring ohci-au1xxx.c in sync with linux-mips
Message-ID: <20060320044106.GK20416@deprecation.cyrius.com>
References: <20060320043802.GA20389@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320043802.GA20389@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

These are two cosmetic changes which bring ohci-au1xxx.c in sync with
the linux-mips tree.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


--- linux-2.6/drivers/usb/host/ohci-au1xxx.c	2006-03-05 19:35:05.000000000 +0000
+++ mips.git/drivers/usb/host/ohci-au1xxx.c	2006-03-13 18:43:52.000000000 +0000
@@ -92,12 +92,12 @@
 	int retval;
 	struct usb_hcd *hcd;
 
-	if(dev->resource[1].flags != IORESOURCE_IRQ) {
+	if (dev->resource[1].flags != IORESOURCE_IRQ) {
 		pr_debug ("resource[1] is not IORESOURCE_IRQ");
 		return -ENOMEM;
 	}
 
-	hcd = usb_create_hcd(driver, &dev->dev, "au1xxx");
+	hcd = usb_create_hcd(driver, &dev->dev, "Au1xxx");
 	if (!hcd)
 		return -ENOMEM;
 	hcd->rsrc_start = dev->resource[0].start;

-- 
Martin Michlmayr
http://www.cyrius.com/
