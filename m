Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 May 2007 08:24:38 +0100 (BST)
Received: from out001.atlarge.net ([129.41.63.69]:24612 "EHLO
	out001.atlarge.net") by ftp.linux-mips.org with ESMTP
	id S20023624AbXERHYg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 18 May 2007 08:24:36 +0100
Received: from hpmailfe-01.atlarge.net ([10.100.60.156]) by out001.atlarge.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 18 May 2007 02:21:22 -0500
Received: from localhost ([213.250.36.225]) by hpmailfe-01.atlarge.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 18 May 2007 02:21:21 -0500
Date:	Fri, 18 May 2007 09:24:27 +0200
From:	Domen Puncer <domen.puncer@telargo.com>
To:	Jean Delvare <khali@linux-fr.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>, i2c@lm-sensors.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] i2c-au1550: convert to platform driver
Message-ID: <20070518072427.GC20713@moe.telargo.com>
References: <20070516053439.GB12986@roarinelk.homelinux.net> <20070517123853.4ae91d25@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070517123853.4ae91d25@hyperion.delvare>
User-Agent: Mutt/1.5.12-2006-07-14
X-OriginalArrivalTime: 18 May 2007 07:21:21.0659 (UTC) FILETIME=[22943CB0:01C7991D]
Return-Path: <domen.puncer@telargo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@telargo.com
Precedence: bulk
X-list: linux-mips

On 17/05/07 12:38 +0200, Jean Delvare wrote:
> Hi Manuel,
> 
> On Wed, 16 May 2007 07:34:40 +0200, Manuel Lauss wrote:
> > Convert the i2c-au1550 driver to platform_driver.
> > 
> > * Convert the core i2c-au1550 driver to platform_driver, get rid of
> >   the i2c-au1550.h file, and remove the unused pb1550_wm_codec_write().

The "unused" pb1550_wm_codec_write, is used by out-of-tree cim driver,
which never really worked for me. I guess it (or a nicer solution)
can be a part of cim driver.

> > * register the platform device for Alchemy boards which previously
> >   defined the i2c psc base address in their headers.
> > * update au1x psc header for the new driver style.

It's much easier to review split patches (patch per logical change).

...
> > diff -Naurp linux-2.6.21-a/drivers/i2c/busses/i2c-au1550.c linux-2.6.21-au/drivers/i2c/busses/i2c-au1550.c
> > --- linux-2.6.21-a/drivers/i2c/busses/i2c-au1550.c	2007-05-15 20:32:44.000000000 +0200
> > +++ linux-2.6.21-au/drivers/i2c/busses/i2c-au1550.c	2007-05-15 21:39:34.000000000 +0200
...
> > @@ -110,24 +103,18 @@ wait_master_done(struct i2c_au1550_data 
> >  static int
> >  do_address(struct i2c_au1550_data *adap, unsigned int addr, int rd)
> >  {
> > -	volatile psc_smb_t	*sp;
> > -	u32			stat;
> > -
> > -	sp = (volatile psc_smb_t *)(adap->psc_base);
> > +	u32 stat, base = adap->psc_base;
> >  
> >  	/* Reset the FIFOs, clear events.
> >  	*/
> > -	stat = sp->psc_smbstat;
> > -	sp->psc_smbevnt = PSC_SMBEVNT_ALLCLR;
> > +	stat = au_readl(base + PSC_SMBSTAT);
> > +	au_writel(PSC_SMBEVNT_ALLCLR, base + PSC_SMBEVNT);
> >  	au_sync();
> > -
> >  	if (!(stat & PSC_SMBSTAT_TE) || !(stat & PSC_SMBSTAT_RE)) {
> > -		sp->psc_smbpcr = PSC_SMBPCR_DC;
> > +		au_writel(PSC_SMBPCR_DC, base + PSC_SMBPCR);
> >  		au_sync();
> > -		do {
> > -			stat = sp->psc_smbpcr;
> > -			au_sync();
> > -		} while ((stat & PSC_SMBPCR_DC) != 0);
> > +		while (au_readl(base + PSC_SMBPCR) & PSC_SMBPCR_DC)
> > +			msleep(0);
> 
> You are changing the behavior here, while this patch is supposed to
> only convert the driver to the new device driver model.

Well... since msleep(0) is nothing, it's the same, but it does
look weird.


...
> >  	/* Now, set up the PSC for SMBus PIO mode.
> >  	*/
> > -	sp = (volatile psc_smb_t *)(adap->psc_base);
> > -	sp->psc_ctrl = PSC_CTRL_DISABLE;
> > +	au_writel(PSC_CTRL_DISABLE, base + PSC_CTRL_OFFSET);
> >  	au_sync();
> > -	sp->psc_sel = PSC_SEL_PS_SMBUSMODE;
> > -	sp->psc_smbcfg = 0;
> > +	au_writel(PSC_SEL_PS_SMBUSMODE, base + PSC_SEL_OFFSET);

au_sync();?


...	
> > +	while (!(au_readl(base + PSC_SMBSTAT) & PSC_SMBSTAT_DR))
> >  		au_sync();
> > -	} while ((stat & PSC_SMBSTAT_DR) == 0);
> >  
> > -	return i2c_add_adapter(i2c_adap);
> > -}
> > +	ret = i2c_add_adapter(&priv->adap);
> > +	if (ret == 0) {
> > +		platform_set_drvdata(pdev, priv);
> > +		return 0;
> > +	}
> >  
> > +	au_writel(0, base + PSC_SMBCFG);

au_sync();?

> > +	au_writel(PSC_CTRL_DISABLE, base + PSC_CTRL_OFFSET);
> > +	au_sync();
> >  
> > -int
> > -i2c_au1550_del_bus(struct i2c_adapter *adap)
> > -{
> > -	return i2c_del_adapter(adap);
> > +	kfree(priv);
> > +out:	return ret;
> 
> Label should be on its own line.
> 
> >  }
> >  
> >  static int
> > -pb1550_reg(struct i2c_client *client)
> > +i2c_au1550_remove(struct platform_device *pdev)
> >  {
> > -	return 0;
> > +	struct i2c_au1550_data *priv = platform_get_drvdata(pdev);
> > +	u32 base;
> > +
> > +	if (priv) {
> 
> This test doesn't seem needed, there's no way this function can be
> called if i2c_au1550_probe() didn't succeed, so the driver data must
> have been set.
> 
> > +		platform_set_drvdata(pdev, NULL);
> > +		base = priv->psc_base;
> > +		i2c_del_adapter(&priv->adap);
> > +		au_writel(0, base + PSC_SMBCFG);

au_sync();?

> > +		au_writel(PSC_CTRL_DISABLE, base + PSC_CTRL_OFFSET);
> > +		au_sync();
> > +		kfree(priv);
> > +	}
> > +	return 0;	
> >  }
> >  
> >  static int
> > -pb1550_unreg(struct i2c_client *client)
> > +i2c_au1550_suspend(struct platform_device *pdev, pm_message_t state)
> >  {
> > +	struct i2c_au1550_data *priv = platform_get_drvdata(pdev);
> > +	u32 base = priv->psc_base;
> > +
> > +	au_writel(PSC_CTRL_SUSPEND, base + PSC_CTRL_OFFSET);
> > +	au_sync();
> >  	return 0;
> >  }

I don't think this will work for "hibernate".
Clocks and other settings should be saved and restored on resume, but
maybe board code already does that.


...
> Other than these minor comments, the patch looks really good. Thanks
> for your work. Domen, feel free to add you own comments.

Unfortunately I don't have au1200 based board set-up anymore, so I can't
test this.
It looks OK to me.


	Domen
