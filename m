Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Feb 2011 10:55:52 +0100 (CET)
Received: from mail-yi0-f49.google.com ([209.85.218.49]:59810 "EHLO
        mail-yi0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491038Ab1BXJzt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Feb 2011 10:55:49 +0100
Received: by yic15 with SMTP id 15so204376yic.36
        for <multiple recipients>; Thu, 24 Feb 2011 01:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=wvOhzmcT8ujMAdPZ2fdVgpLUbrUxZmQOHI/73FQZSPY=;
        b=a4e57ob70hRnsOrUtrcRrIajPCWyfFvJImsFKrbZkr5If9aipULxlKKlNWiP++SX3A
         YG5FKPSMQJAppI6G9wkYSXTPXznZHXHmhczZyimjPf0/rrqJgY/9PdtYPnZmG4Na8eAo
         e9N4Z1qNhccR+i1Z6HQuFafJ+dFc7zsRTU0MQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Pc+UVJ3tfkHWWK0jwgBrLaS/8l9KExMon4wW5a0fOaAdccAWJBVmlN624gEAu4t+5c
         hcJBUD08+EIPezpQYWVD+e96wUk69S/Nlg61z2qLW0FzerO2u+Bq5sLxfIpcZwPuHnR5
         58AeacXorPGAw0F+bm9pF7AvfwQxKKCppMnB4=
Received: by 10.151.39.19 with SMTP id r19mr1688401ybj.11.1298541343039;
        Thu, 24 Feb 2011 01:55:43 -0800 (PST)
Received: from [172.16.48.51] ([59.160.135.215])
        by mx.google.com with ESMTPS id r41sm5491834yba.4.2011.02.24.01.55.35
        (version=SSLv3 cipher=OTHER);
        Thu, 24 Feb 2011 01:55:41 -0800 (PST)
Subject: Re: [PATCH v5] EHCI bus glue for on-chip PMC MSP USB controller
From:   Anoop P A <anoop.pa@gmail.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     "gregkh @ suse . de" <gregkh@suse.de>,
        "dbrownell @ users . sourceforge . net" 
        <dbrownell@users.sourceforge.net>,
        "stern @ rowland . harvard . edu" <stern@rowland.harvard.edu>,
        "pkondeti @ codeaurora . org" <pkondeti@codeaurora.org>,
        "jacob . jun . pan @ intel . com" <jacob.jun.pan@intel.com>,
        "linux-usb @ vger . kernel . org" <linux-usb@vger.kernel.org>,
        "alek . du @ intel . com" <alek.du@intel.com>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>,
        "gadiyar @ ti . com" <gadiyar@ti.com>,
        "ralf @ linux-mips . org" <ralf@linux-mips.org>,
        "linux-mips @ linux-mips . org" <linux-mips@linux-mips.org>,
        Greg KH <greg@kroah.com>
In-Reply-To: <20110223170205.GE19898@bicker>
References: <4D5ABB65.3090101@parrot.com>
         <1298388933-13707-1-git-send-email-anoop.pa@gmail.com>
         <20110222200427.GB1966@bicker> <1298467343.9950.119.camel@paanoop1-desktop>
         <20110223170205.GE19898@bicker>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 24 Feb 2011 15:49:15 +0530
Message-ID: <1298542755.9950.277.camel@paanoop1-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2011-02-23 at 20:02 +0300, Dan Carpenter wrote:
> > > It doesn't compile so I can't test this, but I think that this will
> > > cause a sparse warning.  "base" should have an __iomem tag.  Please
> > > run sparse on this driver.
> > Looks like mips platform build has been broken on linux-next ( unable to
> > configure) . However I have tested code with linux-queue tree ( mips)
> > and didn't see any such warnings
> 
> Sparse is an external tool.  You have to install it and build with
> make C=1 drivers/usb/file.o
Ok. I found there was some issue in arch/mips/Makefile CHECKFLAGS
> 
> > > > +	temp = HCS_N_CC(ehci->hcs_params) * HCS_N_PCC(ehci->hcs_params);
> > > > +	temp &= 0x0f;
> > > 
> > > companion HCs * ports per CC & 0xf?
> > > 
> > > What's the &= 0x0f for?  It's left out of the printk.
> > Code got carried forward from ehci-pci.c . Is that says ehci-pci.c is
> > uptodate? .  
> 
> My guess is that ehci-pci.c is buggy.  Anyway this is just a work around
> to handle buggy hardware.  Since the code here just prints some debug
> output and doesn't do the work arounds we might as well remove the whole
> thing?  It seems unlikely that your mips hardware will have the same
> bug.
Ok I will remove the code block

> 
> > > > +static int ehci_msp_suspend(struct device *dev)
> > > > +{
> > > > +	struct usb_hcd *hcd = dev_get_drvdata(dev);
> > > > +	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
> > > > +	unsigned long flags;
> > > > +	int rc;
> > > > +
> > > > +	return 0;
> > > > +	rc = 0;
> > > > +
> > > > +	if (time_before(jiffies, ehci->next_statechange))
> > > > +		usleep(10000);
> > > 
> > > Is there still a usleep() function?  Either way, can you send us
> > > something that compiles on linux-next?
> > Again code got carried from ehci-pci.c .(changed msleep to usleep as
> > checkpatch complained about it). I am unable to compile mips targets in
> > linux-next tree . However this patch is tested with both linux-stable
> > and linux-queue tree of l-m-o
> 
> checkpatch.pl complains because msleep() is not accurate for tiny
> amounts of time.  There is no usleep() function because trying to be
> that accurate is a lot of work and causes a lot of interrupts.  There
> is a usleep_range() function instead which lets the scheduler group
> wakeups together.  This is documented in
> Documentation/timers/timers-howto.txt
> 
> Also this is dead code.  No one will complain, if you just delete it.
You mean entire ehci_msp_suspend() ??

> 
> regards,
> dan carpenter
