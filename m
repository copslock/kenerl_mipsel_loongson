Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2009 14:12:29 +0100 (BST)
Received: from fg-out-1718.google.com ([72.14.220.152]:50927 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023746AbZD2NMY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 29 Apr 2009 14:12:24 +0100
Received: by fg-out-1718.google.com with SMTP id d23so1215236fga.9
        for <multiple recipients>; Wed, 29 Apr 2009 06:12:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=muPs/x7RabtlHTLRSECMcLWk6dv3LfN9FidOtUww60w=;
        b=sKFv4lo1IOZYA7dCrGoL3J+YIU2Ax/S7gNcXDxJ7RBQzTDj+vMIU2yathM/xJha8fD
         N8PZ1Bto1NQBmZ6abWJUO7AypqNSQVfKyyRfBsUXwOXWdZg+y4SreHsasJV1K6DD6HlH
         A61NL3/D0QbOCzmeCece9/1HFCERBiaO/e59U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=XrKvHyXDLkCMaGeOg0QA4I8id87zHTuMxx1yx0cR/wC7wDBXAwL9/WZ9vtdMLZmSnh
         tQQ0n6I+xdawVbxtHIzvjfSN7TKVFaDLexM4bFknFwg/DzPn2vfriVLw1ZVZy/yJfouj
         kvZg1p4as9ys/6HZEoPCcPDHDI+xJ5I76KzIA=
Received: by 10.86.65.18 with SMTP id n18mr695224fga.25.1241010742758;
        Wed, 29 Apr 2009 06:12:22 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id e11sm8282676fga.21.2009.04.29.06.12.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Apr 2009 06:12:21 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] fix build failures on msp_irq_slp.c
Date:	Wed, 29 Apr 2009 15:12:18 +0200
User-Agent: KMail/1.9.9
Cc:	Shane McDonald <mcdonald.shane@gmail.com>,
	linux-mips@linux-mips.org
References: <200904271659.48357.florian@openwrt.org> <20090429115859.GA1487@linux-mips.org>
In-Reply-To: <20090429115859.GA1487@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200904291512.19297.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Ralf, Shane,

Le Wednesday 29 April 2009 13:58:59 Ralf Baechle, vous avez écrit :
> On Mon, Apr 27, 2009 at 04:59:48PM +0200, Florian Fainelli wrote:
> > Trying to build MSP4200 VoIP defconfig also fails on msp_irq_slp.c
> > with a non-existing reference to mask_slp_irq, which is in turn
> > mask_msp_slp_irq. Passed that, we will also miss a comma when
> > calling set_irq_chip_and_handler. This patch fixes both issues.
> >
> > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> > ---
> > diff --git a/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c
> > b/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c index f5f1b8d..66f6f85
> > 100644
> > --- a/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c
> > +++ b/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c
> > @@ -45,7 +45,7 @@ static inline void mask_msp_slp_irq(unsigned int irq)
> >   */
> >  static inline void ack_msp_slp_irq(unsigned int irq)
> >  {
> > -	mask_slp_irq(irq);
> > +	mask_msp_slp_irq(irq);
> >
> >  	/*
> >  	 * only really necessary for 18, 16-14 and sometimes 3:0 (since
>
> The whole irq chip thing in this file is looking suspect as it treats
> acknowledging and mask an interrupt as the same thing.  Sure that is the
> right thing?

That is a quick and dirty fix which compiles, I assumed that the function 
meant to be called is mask_msp_slp_irq, Shane probably knows more about how 
this should be fixed.

>
> > @@ -79,7 +79,7 @@ void __init msp_slp_irq_init(void)
> >
> >  	/* initialize all the IRQ descriptors */
> >  	for (i = MSP_SLP_INTBASE; i < MSP_PER_INTBASE + 32; i++)
> > -		set_irq_chip_and_handler(i, &msp_slp_irq_controller
> > +		set_irq_chip_and_handler(i, &msp_slp_irq_controller,
> >  					 handle_level_irq);
> >  }
> >
> >
> > diff --git a/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c
> > b/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c index f5f1b8d..66f6f85
> > 100644
>
> Please don't send the patch twice in one email ...

Sorry about that.
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
