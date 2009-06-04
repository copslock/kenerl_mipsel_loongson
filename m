Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 10:22:29 +0100 (WEST)
Received: from mail-fx0-f223.google.com ([209.85.220.223]:50658 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022409AbZFDJWX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Jun 2009 10:22:23 +0100
Received: by fxm23 with SMTP id 23so601995fxm.0
        for <multiple recipients>; Thu, 04 Jun 2009 02:22:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=3H04p7mDv0jeDPAGi1Pr5xsMitOHVPUuLZcAI4ldC3M=;
        b=K9Eh5gYNfIag+ZmQS8DGqyICTHT5M9/Q+tyBrj/P15P2tRS1C/ABjp8Lwt2sXdRk9O
         uAPuznzgql0xE74eyOs7Q7XCTk4K1zB4RuOuKSyRdHMQy3fJm6zR6rl2dltKykiDSWJ1
         Ht/OiJL8uoYA7XD69SuaqZdbUkXKYhuwaci5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=fAPaGCsDBJNf0lpdMkB2KKOz+1e/wkyy7cp+efIiKa8H5ct0JwF1jGlEGKW+K54A3j
         1m7ItD/vLgFHo6wAn8JwXnT/1aaBHfolyzTtOvVZueKiYkdL8HXUfUcaB+SQPJC6N7Xo
         fM4ayt/76WDddLGzprMjhTgIGA38YqQ/sG5+8=
Received: by 10.103.52.13 with SMTP id e13mr1198706muk.52.1244107336823;
        Thu, 04 Jun 2009 02:22:16 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id n7sm3973377mue.58.2009.06.04.02.22.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 02:22:16 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 08/10] add TI AR7 support
Date:	Thu, 4 Jun 2009 11:22:13 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, openwrt-devel@lists.openwrt.org
References: <200906011402.05768.florian@openwrt.org> <20090602125159.GC11488@linux-mips.org>
In-Reply-To: <20090602125159.GC11488@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906041122.14063.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hallo Ralf,

Le Tuesday 02 June 2009 14:51:59 Ralf Baechle, vous avez écrit :
[snip]
> > +
> > +	writel(((prediv - 1) << PREDIV_SHIFT) | (postdiv - 1), &clock->ctrl);
> > +	mdelay(1);
> > +	writel(4, &clock->pll);
> > +	while (readl(&clock->pll) & PLL_STATUS)
> > +		;
> > +	writel(((mul - 1) << MUL_SHIFT) | (0xff << 3) | 0x0e, &clock->pll);
> > +	mdelay(75);
>
> These calls to mdelay seem to be done very early before BogoMIPS has been
> calibrated?

Yes, is there a prefered way than using mdelay here ?

>
>
> Can you elaborate?

I do not think there has been AR7 devices having non-8250 compatible UARTs out 
there thus this code is simply useful. What is meant by the comment is that 
the UART will be reported by Linux as  ttyS0 .... is a Xscale. But this 
should not happen since there are only 8250 UARTs.

> If you don't have a MAC address, either use random_ether_addr() or don't
> bring up the network interface at all.  Multiple interfaces with the same
> MAC can cause chaos on a network to better avoid that.

Thanks for spotting this.

>
> > +struct psp_env_chunk {
> > +	u8 num;
> > +	u8 ctrl;
> > +	u16 csum;
> > +	u8 len;
> > +	char data[11];
> > +} __attribute__ ((packed));
>
> Afair historic versions of this code were totally polluted with
> __attribute__((packed)).  Thanks for cleaning that.
>
> Btw - Linux coding style: No space between __attribute__ and ((packed)).
>
> > +#include <asm/reboot.h>
>
> You get a false warning from checkpatch.pl here.  Which probably means
> either we should teach checkpatch.pl to check if <linux/reboot.h> is
> actually including <asm/reboot.h> or rename <asm/reboot.h> to something
> which would also help to avoid confusion.

<linux/reboot.h> is not including <asm/reboot.h> so renaming <asm/reboot.h> 
sounds like a good solution.

>
> > +++ b/arch/mips/include/asm/mach-ar7/spaces.h
>
> You can cut down this header file to something like:
>
> /* Copyright blurb */
> #ifndef _ASM_AR7_SPACES_H
> #define _ASM_AR7_SPACES_H
>
> /*
>  * This handles the memory map.
>  * We handle pages at KSEG0 for kernels with 32 bit address space.
>  */
> #define PAGE_OFFSET		0x94000000UL
> #define PHYS_OFFSET		0x14000000UL
>
> #include <asm/mach-generic/spaces.h>

Fixed, thanks !
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
