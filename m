Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Aug 2009 22:47:34 +0200 (CEST)
Received: from mailrelay004.isp.belgacom.be ([195.238.6.170]:54332 "EHLO
	mailrelay004.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493289AbZH0Ur1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 27 Aug 2009 22:47:27 +0200
X-Belgacom-Dynamic: yes
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEALmMlkpR92Cn/2dsb2JhbADYcQmEEAU
Received: from 167.96-247-81.adsl-dyn.isp.belgacom.be (HELO infomag) ([81.247.96.167])
  by relay.skynet.be with ESMTP; 27 Aug 2009 22:47:20 +0200
Received: from wim by infomag with local (Exim 4.69)
	(envelope-from <wim@infomag.iguana.be>)
	id 1MglsN-00021L-Vs; Thu, 27 Aug 2009 22:47:19 +0200
Date:	Thu, 27 Aug 2009 22:47:19 +0200
From:	Wim Van Sebroeck <wim@iguana.be>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] ar7_wdt: convert to become a platform driver
Message-ID: <20090827204719.GM29382@infomag.iguana.be>
References: <200907151210.20294.florian@openwrt.org> <200908111452.28418.florian@openwrt.org> <20090811130133.GH4302@infomag.iguana.be> <200908111517.09726.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="r7U+bLA8boMOj+mD"
Content-Disposition: inline
In-Reply-To: <200908111517.09726.florian@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <wim@iguana.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wim@iguana.be
Precedence: bulk
X-list: linux-mips


--r7U+bLA8boMOj+mD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Florian,

> > > > From: Florian Fainelli <florian@openwrt.org>
> > > > Subject: [PATCH 2/2 v2] ar7_wdt: convert to become a platform driver
> > > >
> > > > This patch converts the ar7_wdt driver to become
> > > > a platform driver. The AR7 SoC specific identification
> > > > and base register calculation is performed by the board
> > > > code, therefore we no longer need to have access to
> > > > ar7_chip_id. We also remove the reboot notifier code to
> > > > use the platform shutdown method as Wim suggested.
> > > >
> > > > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> > > > Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> > >
> > > Any news on this patch ?
> >
> > This one was ok for me. I think we agreed that Ralf would take it up in his
> > tree. I can also take it up in my next tree still.
> 
> Oh, I did not understand that sorry, I thought Ralf would take the first one 
> which is MIPS-specific.

I added the second patch to my tree, but saw that the error handling on probe could be improved.
Can you test attached patch?

Thanks in advance,
Wim.


--r7U+bLA8boMOj+mD
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="ar7_wdt-fix-probe-errors.diff"

diff --git a/drivers/watchdog/ar7_wdt.c b/drivers/watchdog/ar7_wdt.c
index 82855b0..2e94b71 100644
--- a/drivers/watchdog/ar7_wdt.c
+++ b/drivers/watchdog/ar7_wdt.c
@@ -295,7 +295,7 @@ static int __devinit ar7_wdt_probe(struct platform_device *pdev)
 	if (!ar7_wdt) {
 		printk(KERN_ERR DRVNAME ": could not ioremap registers\n");
 		rc = -ENXIO;
-		goto out;
+		goto out_mem_region;
 	}
 
 	ar7_wdt_disable_wdt();
@@ -311,6 +311,7 @@ static int __devinit ar7_wdt_probe(struct platform_device *pdev)
 
 out_alloc:
 	iounmap(ar7_wdt);
+out_mem_region:
 	release_mem_region(ar7_regs_wdt->start, resource_size(ar7_regs_wdt));
 out:
 	return rc;

--r7U+bLA8boMOj+mD--
