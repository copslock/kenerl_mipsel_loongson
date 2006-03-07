Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Mar 2006 12:11:03 +0000 (GMT)
Received: from wbmler1.mail.xerox.com ([13.13.138.216]:50627 "EHLO
	wbmler1.mail.xerox.com") by ftp.linux-mips.org with ESMTP
	id S8133391AbWCGMKx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 7 Mar 2006 12:10:53 +0000
Received: from wbmlir3.mail.xerox.com (wbmlir3.mail.xerox.com [13.131.8.223])
	by wbmler1.mail.xerox.com (8.13.4/8.13.1) with ESMTP id k27CJ2Mo011893;
	Tue, 7 Mar 2006 07:19:10 -0500
Received: from wbmlir3.mail.xerox.com (localhost [127.0.0.1])
	by wbmlir3.mail.xerox.com (8.13.4/8.13.1) with ESMTP id k27CIriL032333;
	Tue, 7 Mar 2006 07:18:53 -0500
Received: from usa7061gw02.na.xerox.net (usa7061gw02.na.xerox.net [13.151.32.4])
	by wbmlir3.mail.xerox.com (8.13.4/8.13.1) with ESMTP id k27CIaeA032197;
	Tue, 7 Mar 2006 07:18:52 -0500
Received: from usa7061bh01.na.xerox.net ([13.151.33.5]) by usa7061gw02.na.xerox.net with Microsoft SMTPSVC(6.0.3790.211);
	 Tue, 7 Mar 2006 04:18:36 -0800
Received: from gbrmiteubh01.eu.xerox.net ([13.223.7.13]) by usa7061bh01.na.xerox.net with Microsoft SMTPSVC(6.0.3790.211);
	 Tue, 7 Mar 2006 04:18:33 -0800
Received: from gbrwgceumf02.eu.xerox.net ([13.200.0.54]) by gbrmiteubh01.eu.xerox.net with Microsoft SMTPSVC(6.0.3790.211);
	 Tue, 7 Mar 2006 12:18:02 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Buglet in Alchemy OHCI driver
Date:	Tue, 7 Mar 2006 12:17:21 -0000
Message-ID: <DAF42D2FFC65A146BAB240719E4AD214EE459A@gbrwgceumf02.eu.xerox.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Buglet in Alchemy OHCI driver
Thread-Index: AcY9h5dEM4/7bNVSTsOAI1TsrD7H5gEWJ4Sw
From:	"Hamilton, Ian" <Ian.Hamilton@xerox.com>
To:	"Greg KH" <greg@kroah.com>, "Martin Michlmayr" <tbm@cyrius.com>
Cc:	"Jordan Crouse" <jordan.crouse@amd.com>,
	<linux-usb-devel@lists.sourceforge.net>,
	<linux-mips@linux-mips.org>, <gregkh@suse.de>
X-OriginalArrivalTime: 07 Mar 2006 12:18:02.0275 (UTC) FILETIME=[2E0DEF30:01C641E1]
Return-Path: <Ian.Hamilton@xerox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10745
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Ian.Hamilton@xerox.com
Precedence: bulk
X-list: linux-mips

Hi Greg,

I spotted this in the current latest version of ohci-au1xxx.c (accessed
via git web interface):

94
95 		if (dev->resource[1].flags != IORESOURCE_IRQ) {
96 		pr_debug ("resource[1] is not IORESOURCE_IRQ");
97 		retval -ENOMEM;
98 	}
99  

instead this from Martin's patch:

diff --git a/drivers/usb/host/ohci-au1xxx.c
b/drivers/usb/host/ohci-au1xxx.c
index aa4d0cd..d8fb1bb 100644
--- a/drivers/usb/host/ohci-au1xxx.c
+++ b/drivers/usb/host/ohci-au1xxx.c
@@ -94,7 +94,7 @@ int usb_hcd_au1xxx_probe (const struct h
 
        if (dev->resource[1].flags != IORESOURCE_IRQ) {
                pr_debug ("resource[1] is not IORESOURCE_IRQ");
-               retval = -ENOMEM;
+               return -ENOMEM;
        }

Line 97 produces a warning, but doesn't stop the build, so may have been
missed.

Cheers,
Ian Hamilton.

-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Greg KH
Sent: 01 March 2006 23:22
To: Martin Michlmayr
Cc: Jordan Crouse; linux-usb-devel@lists.sourceforge.net;
linux-mips@linux-mips.org; gregkh@suse.de
Subject: Re: [PATCH] Buglet in Alchemy OHCI driver

On Wed, Mar 01, 2006 at 06:37:35PM +0000, Martin Michlmayr wrote:
> * Jordan Crouse <jordan.crouse@amd.com> [2006-03-01 11:30]:
> > Martin Michlmayr spotted this potentially serious bug.  Please
apply.
> 
> Please don't send patches as MIME attachments.  Here it is again (with
> a better summary too):
> 
> 
> [PATCH] Alchemy OCHI: return if right resources cannot be obtained
> 
> From: Jordan Crouse <jordan.crouse@amd.com>
> 
> Failure to get the right resources should immediately return.  Current
> code has the possiblity of running off into the weeds. Spotted by
> Martin Michlmayr.
> 
> Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
> Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

This patch is already in my tree, in the other patch from Jordan, so it
will make it in after 2.6.16-final is out.

thanks,

greg k-h
