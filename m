Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Jun 2017 21:51:19 +0200 (CEST)
Received: from aserp1040.oracle.com ([141.146.126.69]:27798 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993943AbdFDTvKgWycq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 4 Jun 2017 21:51:10 +0200
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v54JnY9P004701
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 4 Jun 2017 19:49:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v54JnQMe016033
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sun, 4 Jun 2017 19:49:26 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id v54JnJjL004998;
        Sun, 4 Jun 2017 19:49:20 GMT
Received: from yuvallap (/77.138.186.148)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 04 Jun 2017 12:49:19 -0700
Date:   Sun, 4 Jun 2017 22:49:06 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     klassert@mathematik.tu-chemnitz.de, pcnet32@frontier.com,
        hsweeten@visionengravers.com, jeffrey.t.kirsher@intel.com,
        cooldavid@cooldavid.org, mcuos.com@gmail.com, nic_swsd@realtek.com,
        ralf@linux-mips.org, romieu@fr.zoreil.com, nico@fluxnic.net,
        oneukum@suse.com, davem@davemloft.net, tremyfr@gmail.com,
        paul.gortmaker@windriver.com, jarod@redhat.com, green.hu@gmail.com,
        f.fainelli@gmail.com, edumazet@google.com, shchers@gmail.com,
        stephen.boyd@linaro.org, fgao@48lvckh6395k16k5.yundunddos.com,
        tklauser@distanz.ch, jay.vosburgh@canonical.com,
        robert.jarzmik@free.fr, jeremy.linton@arm.com,
        rmk+kernel@armlinux.org.uk, stephen@networkplumber.org,
        arnd@arndb.de, gerg@linux-m68k.org, allan@asix.com.tw,
        chris.roth@usask.ca, hayeswang@realtek.com,
        mario_limonciello@dell.com, netdev@vger.kernel.org,
        linux-parisc@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] net/{mii,smsc}: Make mii_ethtool_get_link_ksettings and
 smc_netdev_get_ecmd return void
Message-ID: <20170604194905.GA7045@yuvallap>
References: <20170604172200.4177-1-yuval.shaia@oracle.com>
 <20170604190133.GB10273@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170604190133.GB10273@lunn.ch>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-Source-IP: userv0022.oracle.com [156.151.31.74]
Return-Path: <yuval.shaia@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuval.shaia@oracle.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Sun, Jun 04, 2017 at 09:01:33PM +0200, Andrew Lunn wrote:
> > diff --git a/drivers/net/cris/eth_v10.c b/drivers/net/cris/eth_v10.c
> > index da02041..017f48c 100644
> > --- a/drivers/net/cris/eth_v10.c
> > +++ b/drivers/net/cris/eth_v10.c
> > @@ -1417,10 +1417,9 @@ static int e100_get_link_ksettings(struct net_device *dev,
> >  {
> >  	struct net_local *np = netdev_priv(dev);
> >  	u32 supported;
> > -	int err;
> >  
> >  	spin_lock_irq(&np->lock);
> > -	err = mii_ethtool_get_link_ksettings(&np->mii_if, cmd);
> > +	mii_ethtool_get_link_ksettings(&np->mii_if, cmd);
> >  	spin_unlock_irq(&np->lock);
> >  
> >  	/* The PHY may support 1000baseT, but the Etrax100 does not.  */
> > @@ -1432,7 +1431,7 @@ static int e100_get_link_ksettings(struct net_device *dev,
> >  	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
> >  						supported);
> >  
> > -	return err;
> > +	return 0;
> >  }
> 
> How far are going planning on going? It seems like
> *_get_link_ksettings() now all return a useless 0. Do you plan to
> change ethtool_ops and make if void all the way up?

It is not always correct, see for example how xgene_get_link_ksettings
returns non-zero value so i assume that ethtool_ops should remain as it is.
Also, looking at ethtool_get_settings it seems that returned value is
checked.

> 
>        Andrew
