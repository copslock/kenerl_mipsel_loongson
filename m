Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2006 18:30:08 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:27148 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133619AbWCAS35 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Mar 2006 18:29:57 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 4C9F464D3D; Wed,  1 Mar 2006 18:37:45 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 775D89025; Wed,  1 Mar 2006 19:37:35 +0100 (CET)
Date:	Wed, 1 Mar 2006 18:37:35 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Jordan Crouse <jordan.crouse@amd.com>
Cc:	linux-usb-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
	gregkh@suse.de
Subject: Re: [PATCH] Buglet in Alchemy OHCI driver
Message-ID: <20060301183735.GA28491@deprecation.cyrius.com>
References: <20060301183026.GL31957@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060301183026.GL31957@cosmic.amd.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Jordan Crouse <jordan.crouse@amd.com> [2006-03-01 11:30]:
> Martin Michlmayr spotted this potentially serious bug.  Please apply.

Please don't send patches as MIME attachments.  Here it is again (with
a better summary too):


[PATCH] Alchemy OCHI: return if right resources cannot be obtained

From: Jordan Crouse <jordan.crouse@amd.com>

Failure to get the right resources should immediately return.  Current
code has the possiblity of running off into the weeds. Spotted by
Martin Michlmayr.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

---

 drivers/usb/host/ohci-au1xxx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/ohci-au1xxx.c b/drivers/usb/host/ohci-au1xxx.c
index aa4d0cd..d8fb1bb 100644
--- a/drivers/usb/host/ohci-au1xxx.c
+++ b/drivers/usb/host/ohci-au1xxx.c
@@ -94,7 +94,7 @@ int usb_hcd_au1xxx_probe (const struct h
 
 	if (dev->resource[1].flags != IORESOURCE_IRQ) {
 		pr_debug ("resource[1] is not IORESOURCE_IRQ");
-		retval = -ENOMEM;
+		return -ENOMEM;
 	}
 
 	hcd = usb_create_hcd(driver, &dev->dev, "Au1xxx");

-- 
Martin Michlmayr
http://www.cyrius.com/
