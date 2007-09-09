Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Sep 2007 19:20:18 +0100 (BST)
Received: from ag-out-0708.google.com ([72.14.246.249]:25221 "EHLO
	ag-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20022472AbXIISUJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 9 Sep 2007 19:20:09 +0100
Received: by ag-out-0708.google.com with SMTP id 33so459625agc
        for <linux-mips@linux-mips.org>; Sun, 09 Sep 2007 11:19:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=yu0GIeMpfdgp1EfeLwo0pDWwu3hfQb5Sz5ddMl73ghc=;
        b=iaZm8ZkWautiqSyxytdnB8y09kBKKVo/c1P2ORsKMpVUZyVPObu8+RNjy2ug2+TNztOFk3ulwptg7GGRYPxM/owJKei/YXAtjBCv9XLs1EX2YFN0wF5AxYdWpx/3g03qn0Row5Nq+gxdxXOHFJWXqSpxx+x6s5AC3fkRbkA2ZMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=chdYL//ocLhEXa5JXNkoUuoIAvMNls0+OLxfw65bmM1iMv9lbYoXKnQ9jBaf6eBL129f8WjZnFPV4dx9FEpuYijPZQANycMnac19gSUXXbQqADvoVQa/xVTD8jQuDkAvJAaiB1wF6gvkkdsb4TTDR7TYTglNh6GIVCU9poGv0Hg=
Received: by 10.100.33.14 with SMTP id g14mr3621090ang.1189361990585;
        Sun, 09 Sep 2007 11:19:50 -0700 (PDT)
Received: from raver.cocorico ( [79.18.35.53])
        by mx.google.com with ESMTPS id i36sm6053947wxd.2007.09.09.11.19.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 09 Sep 2007 11:19:48 -0700 (PDT)
From:	Matteo Croce <technoboy85@gmail.com>
To:	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH][MIPS][5/7] AR7: watchdog timer
Date:	Sun, 9 Sep 2007 20:19:43 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070831.706792)
Cc:	linux-mips@linux-mips.org, Nicolas Thill <nico@openwrt.org>,
	Enrik Berkhan <Enrik.Berkhan@akk.org>,
	Christer Weinigel <wingel@nano-system.com>
References: <200708201704.11529.technoboy85@gmail.com> <200709061731.26655.technoboy85@gmail.com> <20070909084752.GB2654@infomag.infomag.iguana.be>
In-Reply-To: <20070909084752.GB2654@infomag.infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200709092019.43471.technoboy85@gmail.com>
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

Il Sunday 09 September 2007 10:47:52 hai scritto:
> Hi Matteo,
> 
> > Driver for the watchdog timer. It worked with 2.4, doesn't does with 2.6.
> > Apart that it doesn't reboots the device it works :)
> 
> Can you please explain this a bit more? Is this driver working under 2.4
> (and also rebooting the device) but not under 2.6?

Exactly.
A guy had it working with the attached patch but it doesn't works for me.

Cheers,
Matteo

Index: target/linux/ar7-2.6/files/drivers/char/watchdog/ar7_wdt.c
===================================================================
--- target/linux/ar7-2.6/files/drivers/char/watchdog/ar7_wdt.c	(revision 8520)
+++ target/linux/ar7-2.6/files/drivers/char/watchdog/ar7_wdt.c	(working copy)
@@ -76,7 +76,6 @@
 // Offset of the WDT registers
 static unsigned long ar7_regs_wdt;
 // Pointer to the remapped WDT IO space
-static ar7_wdt_t *ar7_wdt;
 static void ar7_wdt_get_regs(void)
 {
     u16 chip_id = ar7_chip_id();
@@ -94,6 +93,8 @@
                      
 static void ar7_wdt_kick(u32 value)
 {
+	volatile ar7_wdt_t *ar7_wdt = (ar7_wdt_t *)ioremap(ar7_regs_wdt, sizeof(ar7_wdt_t));
+
 	ar7_wdt->kick_lock = 0x5555;
 	if ((ar7_wdt->kick_lock & 3) == 1) {
 		ar7_wdt->kick_lock = 0xAAAA;
@@ -107,6 +108,8 @@
 
 static void ar7_wdt_prescale(u32 value)
 {
+	volatile ar7_wdt_t *ar7_wdt = (ar7_wdt_t *)ioremap(ar7_regs_wdt, sizeof(ar7_wdt_t));
+
 	ar7_wdt->prescale_lock = 0x5A5A;
 	if ((ar7_wdt->prescale_lock & 3) == 1) {
 		ar7_wdt->prescale_lock = 0xA5A5;
@@ -120,6 +123,8 @@
 
 static void ar7_wdt_change(u32 value)
 {
+	volatile ar7_wdt_t *ar7_wdt = (ar7_wdt_t *)ioremap(ar7_regs_wdt, sizeof(ar7_wdt_t));
+
 	ar7_wdt->change_lock = 0x6666;
 	if ((ar7_wdt->change_lock & 3) == 1) {
 		ar7_wdt->change_lock = 0xBBBB;
@@ -133,6 +138,8 @@
 
 static void ar7_wdt_disable(u32 value)
 {
+	volatile ar7_wdt_t *ar7_wdt = (ar7_wdt_t *)ioremap(ar7_regs_wdt, sizeof(ar7_wdt_t));
+
 	ar7_wdt->disable_lock = 0x7777;
 	if ((ar7_wdt->disable_lock & 3) == 1) {
 		ar7_wdt->disable_lock = 0xCCCC;
@@ -215,9 +222,6 @@
 static ssize_t ar7_wdt_write(struct file *file, const char *data, 
 			     size_t len, loff_t *ppos)
 {
-	if (ppos != &file->f_pos)
-		return -ESPIPE;
-
 	/* check for a magic close character */
 	if (len) {
 		size_t i;
@@ -304,8 +308,6 @@
 		return -EBUSY;
 	}
 
-	ar7_wdt = (ar7_wdt_t *)ioremap(ar7_regs_wdt, sizeof(ar7_wdt_t));
-
 	ar7_wdt_disable_wdt();
 	ar7_wdt_prescale(prescale_value);
 	ar7_wdt_update_margin(margin);
@@ -337,7 +339,6 @@
 {
         unregister_reboot_notifier(&ar7_wdt_notifier);
 	misc_deregister(&ar7_wdt_miscdev);
-    iounmap(ar7_wdt);
 	release_mem_region(ar7_regs_wdt, sizeof(ar7_wdt_t));
 }
 
Index: target/linux/ar7-2.6/config/default
===================================================================
--- target/linux/ar7-2.6/config/default	(revision 8520)
+++ target/linux/ar7-2.6/config/default	(working copy)
@@ -3,7 +3,7 @@
 # CONFIG_64BIT_PHYS_ADDR is not set
 CONFIG_AR7=y
 CONFIG_AR7_GPIO=y
-# CONFIG_AR7_WDT is not set
+CONFIG_AR7_WDT=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
 # CONFIG_ARCH_SUPPORTS_MSI is not set
