Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Nov 2009 10:20:39 +0100 (CET)
Received: from mail-bw0-f221.google.com ([209.85.218.221]:44131 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492061AbZKJJUd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Nov 2009 10:20:33 +0100
Received: by bwz21 with SMTP id 21so4224391bwz.24
        for <multiple recipients>; Tue, 10 Nov 2009 01:20:25 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=b4xfMhYgSotIAryFQ4jbPkOecC13odR5Ua+MXXEY+PM=;
        b=Y9E79UrXdgeklyEfQzVJVChCWV+AaSy5bgtDVWaV/kimHLOC1O59sQQzGI2O9tYyMj
         A5fm7WA3H3cTwucyv6kbCMYl0b/ch7ehg/cb6RB5M+kqx53UedxFakB0BcqLddXSpIi7
         pHgmeV3hvPkkcc70sKwaDjQDFImqHlb+WHJ7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Qokn/t5VuSlYmApPb3wOmFt7sXx7txVJ6/bya5Ss+zKsb63IGPOEZyjF6YFO+NSy12
         eYcoYHLmwAXCb9H/MjNs2OMxLwCBrNqX+gyZ4HpVssPI1kCXHRl1Fqzbd5x6CXK/Kb/I
         yx9SkDMoixgvarf0MlyWgHlJToD5f0B9aOP/Y=
MIME-Version: 1.0
Received: by 10.103.126.9 with SMTP id d9mr3496519mun.103.1257844825401; Tue, 
	10 Nov 2009 01:20:25 -0800 (PST)
In-Reply-To: <200911100113.38685.florian@openwrt.org>
References: <200911100113.38685.florian@openwrt.org>
Date:	Tue, 10 Nov 2009 10:20:25 +0100
Message-ID: <f861ec6f0911100120j12d86b0cs3ef9c2816019eaf9@mail.gmail.com>
Subject: Re: [PATCH 2/2] au1000-eth: convert to platform_driver model
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>, netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi Florian,

On Tue, Nov 10, 2009 at 1:13 AM, Florian Fainelli <florian@openwrt.org> wrote:
> This patch converts the au1000-eth driver to become a full
> platform-driver as it ought to be. We now pass PHY-speficic
> configurations through platform_data but for compatibility
> the driver still assumes the default settings (search for PHY1 on
> MAC0) when no platform_data is passed. Tested on my MTX-1 board.
>
> Acked-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/drivers/net/au1000_eth.c b/drivers/net/au1000_eth.c
> index ce6f1ac..6d5a2cb 100644
> --- a/drivers/net/au1000_eth.c
> +++ b/drivers/net/au1000_eth.c

> -# if defined(AU1XXX_PHY1_SEARCH_ON_MAC0)
> -       /* try harder to find a PHY */
> -       if (!phydev && (aup->mac_id == 1)) {
> -               /* no PHY found, maybe we have a dual PHY? */
> -               printk (KERN_INFO DRV_NAME ": no PHY found on MAC1, "
> -                       "let's see if it's attached to MAC0...\n");
> -
> -               BUG_ON(!au_macs[0]);


> -               /* find the first (lowest address) non-attached PHY on
> -                * the MAC0 MII bus */
> -               for (phy_addr = 0; phy_addr < PHY_MAX_ADDR; phy_addr++) {
> -                       struct phy_device *const tmp_phydev =
> -                               au_macs[0]->mii_bus->phy_map[phy_addr];
> -
> -                       if (!tmp_phydev)
> -                               continue; /* no PHY here... */
> -
> -                       if (tmp_phydev->attached_dev)
> -                               continue; /* already claimed by MAC0 */
> +       } else {
> +               int phy_addr;
> +
> +               /* find the first (lowest address) PHY on the current MAC's MII bus */
> +               for (phy_addr = 0; phy_addr < PHY_MAX_ADDR; phy_addr++)
> +                       if (aup->mii_bus->phy_map[phy_addr]) {
> +                               phydev = aup->mii_bus->phy_map[phy_addr];
> +                               if (!aup->phy_search_highest_addr)
> +                                       break; /* break out with first one found */
> +                       }
>
> -                       phydev = tmp_phydev;
> -                       break; /* found it */
> +               if (aup->phy1_search_mac0) {
> +                       /* try harder to find a PHY */
> +                       if (!phydev && (aup->mac_id == 1)) {
> +                               /* no PHY found, maybe we have a dual PHY? */
> +                               printk (KERN_INFO DRV_NAME ": no PHY found on MAC1, "
> +                                       "let's see if it's attached to MAC0...\n");
> +
> +                               /* find the first (lowest address) non-attached PHY on
> +                                * the MAC0 MII bus */
> +                               for (phy_addr = 0; phy_addr < PHY_MAX_ADDR; phy_addr++) {
> +                                       if (aup->mac_id == 1)
> +                                               break;

aup->mac_id needs to be 1 for this loop to be executed in the first
place, and here
you immediately bail out if it is.
Also, how do you access the phy map of the other controller without use of the
au_macs[] structure? (which is unused after this patch and could be
removed, along
with the NUM_ETH_INTERFACES constant)


> +                                       struct phy_device *const tmp_phydev =
> +                                                       aup->mii_bus->phy_map[phy_addr];

My compiler complains about mixed code/declarations.


Thanks!
      Manuel Lauss
