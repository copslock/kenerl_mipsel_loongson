Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2007 23:40:30 +0000 (GMT)
Received: from xyzzy.farnsworth.org ([65.39.95.219]:11787 "HELO farnsworth.org")
	by ftp.linux-mips.org with SMTP id S20039332AbXB1Xk0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Feb 2007 23:40:26 +0000
Received: (qmail 15752 invoked by uid 1000); 28 Feb 2007 16:40:23 -0700
From:	"Dale Farnsworth" <dale@farnsworth.org>
Date:	Wed, 28 Feb 2007 16:40:23 -0700
To:	Stephen Hemminger <shemminger@linux-foundation.org>
Cc:	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/2] mv643xx_eth: move mac_addr inside of mv643xx_eth_platform_data
Message-ID: <20070228234023.GA15081@xyzzy.farnsworth.org>
References: <20070228224031.GA8233@xyzzy.farnsworth.org> <20070228151103.0c5a320d@freekitty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070228151103.0c5a320d@freekitty>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <dale@farnsworth.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dale@farnsworth.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 28, 2007 at 03:11:03PM -0800, Stephen Hemminger wrote:
> On Wed, 28 Feb 2007 15:40:31 -0700
> "Dale Farnsworth" <dale@farnsworth.org> wrote:
> 
> > The information contained within platform_data should be self-contained.
> > Replace the pointer to a MAC address with the actual MAC address in
> > struct mv643xx_eth_platform_data.
> > 
> > Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
> > 
> > Index: b/drivers/net/mv643xx_eth.c
> > ===================================================================
> > --- a/drivers/net/mv643xx_eth.c
> > +++ b/drivers/net/mv643xx_eth.c
> > @@ -1380,7 +1380,9 @@ static int mv643xx_eth_probe(struct plat
> >  
> >  	pd = pdev->dev.platform_data;
> >  	if (pd) {
> > -		if (pd->mac_addr)
> > +		static u8 zero_mac_addr[6] = { 0 };
> > +
> > +		if (memcmp(pd->mac_addr, zero_mac_addr, 6) != 0)
> >  			memcpy(dev->dev_addr, pd->mac_addr, 6);
> 
> 
> is_zero_ether_addr() is faster/cleaner for this

Thanks.  I follow up with a modified patch in a day or two.

-Dale
