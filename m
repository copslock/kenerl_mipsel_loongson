Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2004 20:47:40 +0100 (BST)
Received: from 67-121-164-6.ded.pacbell.net ([IPv6:::ffff:67.121.164.6]:54797
	"EHLO mailserver.sunrisetelecom.com") by linux-mips.org with ESMTP
	id <S8225275AbUJNTre>; Thu, 14 Oct 2004 20:47:34 +0100
Received: from sunrisetelecom.com ([192.168.50.222]) by mailserver.sunrisetelecom.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 14 Oct 2004 12:47:22 -0700
Message-ID: <416ED763.2090501@sunrisetelecom.com>
Date: Thu, 14 Oct 2004 15:45:39 -0400
From: Karl Lessard <klessard@sunrisetelecom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: linux-mips <linux-mips@linux-mips.org>
Subject: Duplicated allocation in AU1xxx OHCI driver
Content-Type: multipart/mixed;
 boundary="------------070702060606050605090108"
X-OriginalArrivalTime: 14 Oct 2004 19:47:22.0488 (UTC) FILETIME=[9F553780:01C4B226]
Return-Path: <klessard@sunrisetelecom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6047
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: klessard@sunrisetelecom.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------070702060606050605090108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I was looking at the code of the new ohci-au1xxx, and I've figured out 
that operationnal regiters resource
is allocated two times: once when registering the OHCI platform device 
(check in drivers/base/platform.c),
and once in OHCI driver probe.
Is that ok?? I'm kind of surprised that the second allocation doesn't 
failed. Removing it seems to works
well for me.

Thanks,
Karl

--------------070702060606050605090108
Content-Type: text/plain;
 name="ohci-au1xxx.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ohci-au1xxx.patch"

--- linux-mips/drivers/usb/host/ohci-au1xxx.c	Sun Oct 10 13:56:25 2004
+++ linux/drivers/usb/host/ohci-au1xxx.c	Thu Oct 14 15:39:11 2004
@@ -91,13 +91,6 @@ int usb_hcd_au1xxx_probe (const struct h
 	struct usb_hcd *hcd = 0;
 
 	unsigned int *addr = NULL;
-
-	if (!request_mem_region(dev->resource[0].start,
-				dev->resource[0].end
-				- dev->resource[0].start + 1, hcd_name)) {
-		pr_debug("request_mem_region failed");
-		return -EBUSY;
-	}
 	
 	au1xxx_start_hc(dev);
 	
@@ -173,9 +166,6 @@ int usb_hcd_au1xxx_probe (const struct h
 		driver->hcd_free(hcd);
  err1:
 	au1xxx_stop_hc(dev);
-	release_mem_region(dev->resource[0].start,
-				dev->resource[0].end
-			   - dev->resource[0].start + 1);
 	return retval;
 }
 
@@ -219,9 +209,6 @@ void usb_hcd_au1xxx_remove (struct usb_h
 	hcd->driver->hcd_free (hcd);
 
 	au1xxx_stop_hc(dev);
-	release_mem_region(dev->resource[0].start,
-			   dev->resource[0].end
-			   - dev->resource[0].start + 1);
 }
 
 /*-------------------------------------------------------------------------*/

--------------070702060606050605090108--
