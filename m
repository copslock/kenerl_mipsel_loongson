Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2006 18:24:53 +0000 (GMT)
Received: from amdext3.amd.com ([139.95.251.6]:41633 "EHLO amdext3.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133618AbWCASYj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Mar 2006 18:24:39 +0000
Received: from SSVLGW01.amd.com (ssvlgw01.amd.com [139.95.250.169])
	by amdext3.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k21IS8Vk022206;
	Wed, 1 Mar 2006 10:32:25 -0800
Received: from 139.95.53.182 by SSVLGW02.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Wed, 01 Mar 2006 10:20:48 -0800
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
Received: from ldcmail.amd.com ([147.5.200.40]) by SSVLEXBH1.amd.com
 with Microsoft SMTPSVC(6.0.3790.0); Wed, 1 Mar 2006 10:20:48 -0800
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id BD5142028; Wed, 1 Mar 2006
 11:20:47 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k21IUQXI020952; Wed, 1 Mar 2006 11:30:26
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k21IUQ1n020951; Wed, 1 Mar 2006 11:30:26 -0700
Date:	Wed, 1 Mar 2006 11:30:26 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	linux-usb-devel@lists.sourceforge.net
cc:	linux-mips@linux-mips.org, gregkh@suse.de, tbm@cyrius.com
Subject: [PATCH] Buglet in Alchemy OHCI driver
Message-ID: <20060301183026.GL31957@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 01 Mar 2006 18:20:48.0528 (UTC)
 FILETIME=[DD461100:01C63D5C]
X-WSS-ID: 681B398A1V04264282-01-01
Content-Type: multipart/mixed;
 boundary=5vNYLRcllDrimb99
Content-Disposition: inline
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips


--5vNYLRcllDrimb99
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Martin Michlmayr spotted this potentially serious bug.  Please apply.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

--5vNYLRcllDrimb99
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=ohci-fix.patch
Content-Transfer-Encoding: 7bit

[PATCH] Buglet in Alchemy OCHI

From: Jordan Crouse <jordan.crouse@amd.com>

Failure to get the right resources should immediately return. 
Current code has the possiblity of running off into the weeds. Spotted by 
Martin Michlmayr.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
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

--5vNYLRcllDrimb99--
