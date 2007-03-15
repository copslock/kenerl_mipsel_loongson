Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Mar 2007 20:01:18 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.175]:48179 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022512AbXCOUBQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Mar 2007 20:01:16 +0000
Received: by ug-out-1314.google.com with SMTP id 40so523740uga
        for <linux-mips@linux-mips.org>; Thu, 15 Mar 2007 13:00:15 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Q8DBf8xstI6AfS2HeCX/ucph+iW0RpfpJ2kAMmGNjlpzBze8VnAiB29uWt1Eb06ccVRVhD6AXlA9/Lx0ygmr9U7Ci1ql7T6z65fQw8P55o2HBOczO2gAuBEQHdaAsi5DplknDtXTwjA4HTPGjlebP6gofjlRHFVJ7bqXtP19DYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZMX6GFgcgp2g2dkFNmrl73ORyWg2rEhc6gblvoZdQIGQgtXg5s+NVf1U64PSmQgClfmabDQ1ql6kgrjyrvB6EcohEvngyMu94KcGCIecz8wzrQWpqHl93agLN97/lxtTHRcWazkbowi7udlIQhbieTAToomM3yXv+MloO7WvgGA=
Received: by 10.66.216.20 with SMTP id o20mr3286847ugg.1173988815288;
        Thu, 15 Mar 2007 13:00:15 -0700 (PDT)
Received: from ?192.168.123.7? ( [89.78.229.67])
        by mx.google.com with ESMTP id 13sm1914330ugb.2007.03.15.13.00.13;
        Thu, 15 Mar 2007 13:00:14 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] IDE/DMA for au1xxx
Date:	Thu, 15 Mar 2007 21:07:26 +0100
User-Agent: KMail/1.9.6
Cc:	Daniel Mack <daniel@caiaq.de>, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org
References: <20070315122012.GA8612@ipxXXXXX> <45F9520A.2000804@ru.mvista.com>
In-Reply-To: <45F9520A.2000804@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200703152107.26545.bzolnier@gmail.com>
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips


Hi,

On Thursday 15 March 2007, Sergei Shtylyov wrote:
> Daniel Mack wrote:
> > Hi,
> 
> > this makes the DMA part of Au1xxx's IDE interface compile again.
> 
> > Signed-of-by: Daniel Mack <daniel@caiaq.de>
> 
> > ------------------------------------------------------------------------
> 
> > diff --git a/drivers/ide/mips/au1xxx-ide.c b/drivers/ide/mips/au1xxx-ide.c
> > index b2dc028..806b6d1 100644
> > --- a/drivers/ide/mips/au1xxx-ide.c
> > +++ b/drivers/ide/mips/au1xxx-ide.c
> > @@ -443,7 +443,6 @@ static void auide_dma_host_on(ide_drive_t *drive)
> >  static int auide_dma_on(ide_drive_t *drive)
> >  {
> >  	drive->using_dma = 1;
> > -
> >  	return 0;
> >  }
> >  
> > @@ -638,6 +637,7 @@ static int au_ide_probe(struct device *dev)
> >  	struct platform_device *pdev = to_platform_device(dev);
> >  	_auide_hwif *ahwif = &auide_hwif;
> >  	ide_hwif_t *hwif;
> > +	hw_regs_t *hw;
> >  	struct resource *res;
> >  	int ret = 0;
> >  
> > @@ -681,7 +681,7 @@ static int au_ide_probe(struct device *dev)
> >  	/* FIXME:  This might possibly break PCMCIA IDE devices */
> >  
> >  	hwif                            = &ide_hwifs[pdev->id];
> > -	hw_regs_t *hw 			= &hwif->hw;
> > +	hw 				= &hwif->hw;
> >  	hwif->irq = hw->irq             = ahwif->irq;
> >  	hwif->chipset                   = ide_au1xxx;
> 
>     The patch consisting of these 2 hunks has been already posted to linux-ide 
> by Ralf... Your patch looks more complete though.

I applied Ralf's one and I would merge this one but I'm not on linux-mips ML.

Daniel, please resend the original patch to linux-ide ML.

> > diff --git a/include/asm-mips/mach-au1x00/au1xxx_ide.h b/include/asm-mips/mach-au1x00/au1xxx_ide.h
> > index e9fa252..e747814 100644
> > --- a/include/asm-mips/mach-au1x00/au1xxx_ide.h
> > +++ b/include/asm-mips/mach-au1x00/au1xxx_ide.h
> > @@ -166,13 +166,13 @@ int __init auide_probe(void);
> >          static int auide_dma_setup(ide_drive_t *drive);
> >          static int auide_dma_check(ide_drive_t *drive);
> >          static int auide_dma_test_irq(ide_drive_t *drive);
> > -        static int auide_dma_host_off(ide_drive_t *drive);
> > -        static int auide_dma_host_on(ide_drive_t *drive);
> > +        static void auide_dma_host_off(ide_drive_t *drive);
> > +        static void auide_dma_host_on(ide_drive_t *drive);
> >          static int auide_dma_lostirq(ide_drive_t *drive);
> >          static int auide_dma_on(ide_drive_t *drive);
> >          static void auide_ddma_tx_callback(int irq, void *param);
> >          static void auide_ddma_rx_callback(int irq, void *param);
> > -        static int auide_dma_off_quietly(ide_drive_t *drive);
> > +        static void auide_dma_off_quietly(ide_drive_t *drive);
> >  #endif /* end CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA */
> 
>     WTF these protos are doing in include/asm-mips/ -- being purely IDE 
> subsystem specific?! :-O
>     Could you move them into the driver (if they are indeed necessary)?

seconded, this is a good idea

Thanks,
Bart
