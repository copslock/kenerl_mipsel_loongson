Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2009 19:27:40 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:38282 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492798AbZHGR1d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Aug 2009 19:27:33 +0200
Received: by ewy12 with SMTP id 12so2120801ewy.0
        for <linux-mips@linux-mips.org>; Fri, 07 Aug 2009 10:27:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=xRMqy0ieTMAw+aXx3furpwhWYdtl5D1vfgnpZHTXdfc=;
        b=DlSPFh7Rhzw4RojSDW7cq1ZShSN2IXxnz3MptVTUM3GJ1cFjzdpu61FGfe0fIvulBp
         OnL8iZ4/6qHLYzk3tQagfF3U04ueob834IWGuH5oq2wmgXqO3Eun2N1bxWMauDdd2rqb
         UmGK3qGh5l81X5kLbt2lvqF/Dr6naX02aCLek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Zbw3uSHkkk8dNQ1GK7Xj6FGyvzOKwsqpSSj5svLCYr0ayoXxSDoVkv0JujW5TJGvSI
         MbLDXiI4MCaTbmATeOD0cZDmj2UtZtTfhAVp6q4+PimobaTHPvWibix9jYW8oHBXlfQO
         rKJkv8QXYmGVCqVRlmq8OgXBwY2SXAwdxlhRo=
Received: by 10.210.131.6 with SMTP id e6mr1680454ebd.63.1249666048120;
        Fri, 07 Aug 2009 10:27:28 -0700 (PDT)
Received: from ?192.168.254.2? (florian.mimichou.net [82.241.112.26])
        by mx.google.com with ESMTPS id 7sm3609271eyg.5.2009.08.07.10.27.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Aug 2009 10:27:24 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Alexander Clouter <alex@digriz.org.uk>
Subject: Re: [PATCH] ar7: register watchdog driver only if enabled in hardware configuration
Date:	Fri, 7 Aug 2009 19:27:19 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org
References: <200908042309.36721.florian@openwrt.org> <3qqnk6-j07.ln1@chipmunk.wormnet.eu>
In-Reply-To: <3qqnk6-j07.ln1@chipmunk.wormnet.eu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200908071927.19714.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23851
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hey Alexander,

Le Wednesday 05 August 2009 10:00:35 Alexander Clouter, vous avez écrit :
> Florian Fainelli <florian@openwrt.org> wrote:
> > This patch checks if the watchdog enable bit is set in the DCL
> > register meaning that the hardware watchdog actually works and
> > if so, register the ar7_wdt platform_device.
> >
> > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> > ---
> > diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
> > index e2278c0..835f3f0 100644
> > --- a/arch/mips/ar7/platform.c
> > +++ b/arch/mips/ar7/platform.c
> > @@ -503,6 +503,7 @@ static int __init ar7_register_devices(void)
> > {
> >        u16 chip_id;
> >        int res;
> > +       u32 *bootcr, val;
> > #ifdef CONFIG_SERIAL_8250
> >        static struct uart_port uart_port[2];
> >
> > @@ -595,7 +596,13 @@ static int __init ar7_register_devices(void)
> >
> >        ar7_wdt_res.end = ar7_wdt_res.start + 0x20;
> >
> > -       res = platform_device_register(&ar7_wdt);
> > +       bootcr = (u32 *)ioremap_nocache(AR7_REGS_DCL, 4);
> > +       val = *bootcr;
> > +       iounmap(bootcr);
> > +
> > +       /* Register watchdog only if enabled in hardware */
> > +       if (val & AR7_WDT_HW_ENA)
> > +               res = platform_device_register(&ar7_wdt);
> >
> >        return res;
> > }
>
> 'res' can now return NULL[1].  Solved if you do:
> ----
> int res = -ENODEV;
> ----
>
> I'm guessing this is the most apprioate?

I prefer letting this as-is, since if the watchdog was not enabled in 
hardware, we will not register the watchdog driver, and return the last 
platform_device_register call.

>
> Cheers
>
> [1] I cannot see the full file annoyingly, it's not in my linux-mips
> 	git tree.

Not sure which tree you checked out, but it is in linux-queue: 
http://www.linux-mips.org/git?p=linux-queue.git;a=tree;f=arch/mips/ar7;h=40ee7382dfabf05ee6c967016e42f94992655c20;hb=HEAD
-- 
Best regards, Florian Fainelli
Email: florian@openwrt.org
Web: http://openwrt.org
IRC: [florian] on irc.freenode.net
-------------------------------
