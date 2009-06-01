Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 15:51:16 +0100 (BST)
Received: from mail-ew0-f219.google.com ([209.85.219.219]:35679 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025360AbZFAOvK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Jun 2009 15:51:10 +0100
Received: by ewy19 with SMTP id 19so8156403ewy.0
        for <multiple recipients>; Mon, 01 Jun 2009 07:51:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=MFeAdzCKk2qaNt4TOz7p0XGtjhw0aPHCqzdnWwgHk+o=;
        b=ME6Iv7Pra85Pzh8kq5QXNjACiF0kOR+lANjAipK6czsXza2gvHnFYxZH1IRGbvlTTa
         pyYu85at+F1uBizSw7K2XAVhIGYKdcACAssV4ABuo2QKEcTYi1lAajCqqNzOkUE2NYVg
         grmgJwZcxyXQ75tcganxIWAIdrAW1u/eQ3h+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=I6ajgHp74XwuEBss5IB1mFo1u1S/U1UZ30S1KE+Tx8bZybKtelR04JH+ayNEzxbQQC
         naq1LEUvY5VvqOHSBFbMOqpBrnBf62JnGJ7yqnzEv14bI3G1O0wAGxtX8Oj0p0e4zDoD
         INq/+k8sYlwumaBHlfwGEEc6dTVOqqkyunb9U=
Received: by 10.210.16.11 with SMTP id 11mr1067375ebp.83.1243867864227;
        Mon, 01 Jun 2009 07:51:04 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 10sm282775eyd.22.2009.06.01.07.51.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Jun 2009 07:51:03 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 07/10] bcm63xx: fix typo when printing CPU frequency
Date:	Mon, 1 Jun 2009 16:50:58 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>
References: <200905312029.50326.florian@openwrt.org> <20090601144618.GF6604@linux-mips.org>
In-Reply-To: <20090601144618.GF6604@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906011650.59851.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Monday 01 June 2009 16:46:18 Ralf Baechle, vous avez écrit :
> On Sun, May 31, 2009 at 08:29:49PM +0200, Florian Fainelli wrote:
> > This patch corrects the comment about the CPU
> > frequency which is actually printed in Hz and not MHz.
> >
> > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> > ---
> > diff --git a/arch/mips/bcm63xx/cpu.c b/arch/mips/bcm63xx/cpu.c
> > index 0a403dd..410c788 100644
> > --- a/arch/mips/bcm63xx/cpu.c
> > +++ b/arch/mips/bcm63xx/cpu.c
> > @@ -238,7 +238,7 @@ void __init bcm63xx_cpu_init(void)
> >
> >  	printk(KERN_INFO "Detected Broadcom 0x%04x CPU revision %02x\n",
> >  	       bcm63xx_cpu_id, bcm63xx_cpu_rev);
> > -	printk(KERN_INFO "CPU frequency is %u MHz\n",
> > +	printk(KERN_INFO "CPU frequency is %u Hz\n",
>
> While technically ok I would suggest to print the number in MHz.  Acuracy
> probably doesn't matter so even rounding to whole MHz would be ok.
>
> Want me to apply anyway?

No that is a one-liner I will respin a new one which prints the frequency in 
Mhz directly.
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
