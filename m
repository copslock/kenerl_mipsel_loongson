Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jun 2009 18:16:58 +0200 (CEST)
Received: from mail-ew0-f224.google.com ([209.85.219.224]:48325 "EHLO
	mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491998AbZFKQQx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Jun 2009 18:16:53 +0200
Received: by ewy24 with SMTP id 24so1770414ewy.0
        for <linux-mips@linux-mips.org>; Thu, 11 Jun 2009 09:16:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=H3nLzPIgcHyg9SsAxwochDqHl6bwFNXkHk2wnLOuRX4=;
        b=va/2g+VquehCnfPq7VlDc6d/4r3WHX5u5ZQ0O4t7L5s+jBKrTPQeoZKhjXuj/kSZBX
         WZFXVhdLcBDpDgvFrbhxBHa47Jvfz3hl82+m/EIwbg9Qz9tGvZZgRUyosGT0GEoHH+1i
         t7P35zAJWZ4z8Q0RFD13whUC8Y4NgQsdJcQLY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Py7otqhlpoGfwSak6CLphI2NHfkuEuMg7ENmrM16rDzbe6WPHL4fKRXIxu7m7U8TI/
         Rkx2QvR5X26ZhOM7HqbqRl4+hCBrGOtvScyy590D8cYG0m4NmRToJrNkUHsr0tzUSzRz
         SyN+1y9OekvwTEpN3i5OQZOL15F+4Myt0q42k=
Received: by 10.210.137.17 with SMTP id k17mr2312723ebd.52.1244707757994;
        Thu, 11 Jun 2009 01:09:17 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 10sm819764eyd.52.2009.06.11.01.09.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Jun 2009 01:09:17 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	matthieu castet <castet.matthieu@free.fr>
Subject: Re: [PATCH] bc47xx : fix ssb irq setup
Date:	Thu, 11 Jun 2009 10:09:12 +0200
User-Agent: KMail/1.9.9
Cc:	linville@tuxdriver.com, Michael Buesch <mb@bu3sch.de>,
	linux-mips@linux-mips.org, netdev@vger.kernel.org,
	Daniel Mueller <daniel@danm.de>
References: <4A11DBD4.7070706@free.fr> <4A1ADBAE.6070101@free.fr> <200906110959.38132.florian@openwrt.org>
In-Reply-To: <200906110959.38132.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906111009.15080.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Thursday 11 June 2009 09:59:36 Florian Fainelli, vous avez écrit :
> Hi Matthieu, Michael,
>
> Le Monday 25 May 2009 19:55:58 matthieu castet, vous avez écrit :
> > Michael Buesch wrote:
> > > On Tuesday 19 May 2009 00:06:12 matthieu castet wrote:
> > >> Hi,
> > >>
> > >>
> > >> [1] http://www.danm.de/files/src/bcm5365p/REPORTED_DEVICES
> > >>
> > >> Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
> > >
> > > If this works on all devices, I'm OK with this. Please submit to
> > > linville@tuxdriver.com You can add my ack.
> >
> > Well I have only a wl500gd.
> > I have submit it on openwrt project in order to test in more devices.
>
> It makes the IPsec core work on my Netgear WGT634U and I did not see any
> regression on a Linksys WRT54GS.
>
> Tested-by: Florian Fainelli <florian@openwrt.org>

One minor thing, please remove the dump_irqs call, it is convenient for 
debugging to print the IRQ routing, but I find it a little too verbose for 
production. This can be a follow-up patch if you prefer not to respin it.
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
