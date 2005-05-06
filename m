Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2005 10:19:10 +0100 (BST)
Received: from adsl-72-19.38-151.net24.it ([IPv6:::ffff:151.38.19.72]:29159
	"EHLO zaigor.enneenne.com") by linux-mips.org with ESMTP
	id <S8225344AbVEFJSx>; Fri, 6 May 2005 10:18:53 +0100
Received: from giometti by zaigor.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1DTyyr-0005Q0-00; Fri, 06 May 2005 11:18:45 +0200
Date:	Fri, 6 May 2005 11:18:45 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Pete Popov <ppopov@embeddedalley.com>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: USB hangs on AU1100
Message-ID: <20050506091845.GB1987@enneenne.com>
References: <20050505155435.GA28227@enneenne.com> <1115311361.1614.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
In-Reply-To: <1115311361.1614.6.camel@localhost.localdomain>
Organization: Programmi e soluzioni GNU/Linux
X-PGP-Key: gpg --keyserver keyserver.penguin.de --recv-keys D25A5633
User-Agent: Mutt/1.5.6+20040722i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 05, 2005 at 09:42:41AM -0700, Pete Popov wrote:
> It sounds like this is a custom Au1100 based board? What boot code are

Yes, but is very close to the DB1100.

> you running?  I'm guessing the SOC isn't setup correctly or you have a
> HW problem.

I selected the code for the DB1100... I'm very puzzled about this
problem!

However let me suggest you this little patch in order to advice the
user about this problem and to avoid system locks.

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@linux.it
Linux Device Driver                             giometti@enneenne.com
Embedded Systems                     home page: giometti.enneenne.com
UNIX programming                     phone:     +39 349 2432127

--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

Index: ohci-au1xxx.c
===================================================================
RCS file: /home/cvs/linux/drivers/usb/host/ohci-au1xxx.c,v
retrieving revision 1.5
diff -u -r1.5 ohci-au1xxx.c
--- ohci-au1xxx.c	3 Apr 2005 20:39:19 -0000	1.5
+++ ohci-au1xxx.c	6 May 2005 09:14:35 -0000
@@ -38,8 +38,10 @@
 
 /*-------------------------------------------------------------------------*/
 
-static void au1xxx_start_hc(struct platform_device *dev)
+static int au1xxx_start_hc(struct platform_device *dev)
 {
+	int count = 3000;
+
 	printk(KERN_DEBUG __FILE__
 		": starting Au1xxx OHCI USB Controller\n");
 
@@ -51,11 +53,19 @@
 
 	/* wait for reset complete (read register twice; see au1500 errata) */
 	while (au_readl(USB_HOST_CONFIG),
-		!(au_readl(USB_HOST_CONFIG) & USBH_ENABLE_RD)) 
+		!(au_readl(USB_HOST_CONFIG) & USBH_ENABLE_RD)) {
 		udelay(1000);
+		if (--count == 0) {
+			printk(KERN_ERR __FILE__
+			": unable to reset USB host\n");
+			return -EBUSY;
+		}
+	}
 
 	printk(KERN_DEBUG __FILE__
 	": Clock to USB host has been enabled \n");
+
+	return 0;
 }
 
 static void au1xxx_stop_hc(struct platform_device *dev)
@@ -113,7 +123,11 @@
 		goto err2;
 	}
 
-	au1xxx_start_hc(dev);
+	retval = au1xxx_start_hc(dev);
+	if (retval < 0) {
+		pr_debug("au1xxx start failed");
+		goto err3;
+	}
 	ohci_hcd_init(hcd_to_ohci(hcd));
 
 	retval = usb_add_hcd(hcd, dev->resource[1].start, SA_INTERRUPT);
@@ -121,6 +135,7 @@
 		return retval;
 
 	au1xxx_stop_hc(dev);
+ err3:
 	iounmap(hcd->regs);
  err2:
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);

--SkvwRMAIpAhPCcCJ--
