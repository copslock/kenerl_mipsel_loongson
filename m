Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 12:54:31 +0100 (CET)
Received: from fg-out-1718.google.com ([72.14.220.154]:23109 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492533AbZKKLyY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2009 12:54:24 +0100
Received: by fg-out-1718.google.com with SMTP id d23so349379fga.6
        for <multiple recipients>; Wed, 11 Nov 2009 03:54:21 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:x-uid:x-length
         :reply-to:content-type:content-transfer-encoding:message-id;
        bh=LxttfQos1zkDvLRqOVW4JmAuBx10UOZpf5qK4yvOdUY=;
        b=F7wyoCPekGE2but0z4GGhbZO+y3f7gXJC66jjJ0nfngncQCTX62wMMGEPovSfwmiFQ
         EnAVwMioHUrKbV9Kbpw4nJSGk3ut/Q63h5uKO9Ejb4O6CjLqnvVKuUj0Y0X31mJyIzzU
         E3qnqebLYRA7FXu7jNnCfzAprWmZ0hIsFiRH4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:x-uid:x-length:reply-to:content-type
         :content-transfer-encoding:message-id;
        b=fEN+EIeKoeBD8Zj57Whe5ZEFDu0+Y0sVjGg34wZ4PTpd08h9lJOh+5KmdIEa4RYP53
         gPzRt+T82WHgJncKecO9rKAQ0grGuEy3VVcgRkxAOxcTbBhsSrcQ7673rLNB9FUXVa8Y
         Ral/qvqwP7uei/BieO/pnMjLHzulrlC6n9Hmc=
Received: by 10.86.248.36 with SMTP id v36mr1032984fgh.37.1257940461144;
        Wed, 11 Nov 2009 03:54:21 -0800 (PST)
Received: from lenovo.localnet (florian.mimichou.net [88.178.11.95])
        by mx.google.com with ESMTPS id d6sm10490107fga.0.2009.11.11.03.54.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 03:54:18 -0800 (PST)
From:	Florian Fainelli <florian@openwrt.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH 2/2] au1000-eth: convert to platform_driver model
Date:	Wed, 11 Nov 2009 12:54:15 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.31-14-server; KDE/4.3.2; x86_64; ; )
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	"linux-mips" <linux-mips@linux-mips.org>, netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>
References: <200911100113.38685.florian@openwrt.org> <f861ec6f0911100120j12d86b0cs3ef9c2816019eaf9@mail.gmail.com>
In-Reply-To: <f861ec6f0911100120j12d86b0cs3ef9c2816019eaf9@mail.gmail.com>
MIME-Version: 1.0
X-UID:	142
X-Length: 5404
Reply-To: Florian Fainelli <florian@openwrt.org>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200911111254.16500.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Manuel,

On Tuesday 10 November 2009 10:20:25 Manuel Lauss wrote:
> Hi Florian,
> 
> On Tue, Nov 10, 2009 at 1:13 AM, Florian Fainelli <florian@openwrt.org> 
wrote:
> > This patch converts the au1000-eth driver to become a full
> > platform-driver as it ought to be. We now pass PHY-speficic
> > configurations through platform_data but for compatibility
> > the driver still assumes the default settings (search for PHY1 on
> > MAC0) when no platform_data is passed. Tested on my MTX-1 board.
[snip]
> >
> > -                       phydev = tmp_phydev;
> > -                       break; /* found it */
> > +               if (aup->phy1_search_mac0) {
> > +                       /* try harder to find a PHY */
> > +                       if (!phydev && (aup->mac_id == 1)) {
> > +                               /* no PHY found, maybe we have a dual
> > PHY? */ +                               printk (KERN_INFO DRV_NAME ": no
> > PHY found on MAC1, " +                                       "let's see
> > if it's attached to MAC0...\n"); +
> > +                               /* find the first (lowest address)
> > non-attached PHY on +                                * the MAC0 MII bus
> > */
> > +                               for (phy_addr = 0; phy_addr <
> > PHY_MAX_ADDR; phy_addr++) { +                                       if
> > (aup->mac_id == 1)
> > +                                               break;
> 
> aup->mac_id needs to be 1 for this loop to be executed in the first
> place, and here
> you immediately bail out if it is.

From the reading of the comment, it seems to me like we should not do anything 
in this for loop if we were using MAC1, but I may have misunderstood that, as 
such I have added this break to "comply" with the comment.

> Also, how do you access the phy map of the other controller without use of
>  the au_macs[] structure? (which is unused after this patch and could be
>  removed, along
> with the NUM_ETH_INTERFACES constant)

We access the phy map of the other controller by using the correct mii bus 
identifier, since we have registered a per-interface mdio bus or have I 
overlooked something ?

> 
> > +                                       struct phy_device *const
> > tmp_phydev = +                                                      
> > aup->mii_bus->phy_map[phy_addr];
> 
> My compiler complains about mixed code/declarations.

That declaration was already there and as this patch has no intent to clean 
anything right now, I have left it as-is.
--
Florian
