Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2009 06:03:44 +0100 (BST)
Received: from mail-ew0-f171.google.com ([209.85.219.171]:58903 "EHLO
	mail-ew0-f171.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20021528AbZEVFDi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 22 May 2009 06:03:38 +0100
Received: by ewy19 with SMTP id 19so1780753ewy.0
        for <multiple recipients>; Thu, 21 May 2009 22:03:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=PBtKn+6SQNqYhd4zIPogk/mNNvcT2dxTOJyd8Dg1zaE=;
        b=Xl3daGEiLblMmQ0lJW8eev6ZSXQ/Laeg2q0EoLy5SvQ4yDRXnmMJRaOk3noqwVb4O9
         y4iHdZSP+gE/J4b2IU5Xobfv4x1HdciFeXJwYXnUDGyOiEWnoL9FUBiAg9IBYZykUaEu
         6Q+MjEgvpDldi0WyEG8nBMHiudR9wEyicEZh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=oP0xe+QLPbWasGzcMRtF8WLLdEJwbv3vbf+mQEWnf4cx12yvGryBCUp8cAqGSFzqlY
         CAUK42/vBoKLpa+uvvQJQxMERhDvyk9L3Fm0lBe+OmNTiXVmKF/QP58h77dg9ZSKO+/D
         h2isH9h0lqaGLcoXY7SRYA1Z6Saz7g+rsWTPg=
Received: by 10.210.20.6 with SMTP id 6mr303474ebt.72.1242968612916;
        Thu, 21 May 2009 22:03:32 -0700 (PDT)
Received: from ?192.168.1.22? (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 7sm1100484eyg.57.2009.05.21.22.03.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 May 2009 22:03:32 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] rb532: check irq number when handling GPIO interrupts
Date:	Fri, 22 May 2009 07:03:28 +0200
User-Agent: KMail/1.9.9
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <200905211949.47486.florian@openwrt.org> <4A15A2DD.2000203@ru.mvista.com>
In-Reply-To: <4A15A2DD.2000203@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200905220703.28939.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Thursday 21 May 2009 20:52:13 Sergei Shtylyov, vous avez écrit :
> Hello.
>
> Florian Fainelli wrote:
> > This patch makes sure that we are not going to clear
> > or change the interrupt status of a GPIO interrupt
> > superior to 13 as this is the maximum number of GPIO
> > interrupt source (p.232 of the RC32434 reference manual).
> >
> > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> > ---
> > diff --git a/arch/mips/rb532/irq.c b/arch/mips/rb532/irq.c
> > index 53eeb5e..afdcafc 100644
> > --- a/arch/mips/rb532/irq.c
> > +++ b/arch/mips/rb532/irq.c
> > @@ -151,7 +151,8 @@ static void rb532_disable_irq(unsigned int irq_nr)
> >  		mask |= intr_bit;
> >  		WRITE_MASK(addr, mask);
> >
> > -		if (group == GPIO_MAPPED_IRQ_GROUP)
> > +		/* There is a maximum of 13 GPIO interrupts */
> > +		if (group == GPIO_MAPPED_IRQ_GROUP && irq_nr <= (GROUP4_IRQ_BASE +
> > 13))
>
>     So, 13 or 14? The code seem to allow 14. Probably it should be <, not
> <= here...

That's actually 14, numbering starting from 0, I should learn how to count. 
Ralf, do you want me to resubmit that one with the proper message / 
descriptions ?

>
> >  			rb532_gpio_set_istat(0, irq_nr - GPIO_MAPPED_IRQ_BASE);
> >
> >  		/*
> > @@ -174,7 +175,7 @@ static int rb532_set_type(unsigned int irq_nr,
> > unsigned type) int gpio = irq_nr - GPIO_MAPPED_IRQ_BASE;
> >  	int group = irq_to_group(irq_nr);
> >
> > -	if (group != GPIO_MAPPED_IRQ_GROUP)
> > +	if (group != GPIO_MAPPED_IRQ_GROUP || irq_nr > (GROUP4_IRQ_BASE + 13))
>
>     ... and >= here.
>
> >  		return (type == IRQ_TYPE_LEVEL_HIGH) ? 0 : -EINVAL;
> >
> >  	switch (type) {
>
> WBR, Sergei



-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
