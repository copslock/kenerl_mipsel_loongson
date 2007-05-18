Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 May 2007 13:38:56 +0100 (BST)
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:9491 "EHLO
	kraid.nerim.net") by ftp.linux-mips.org with ESMTP
	id S20023726AbXERMiy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 18 May 2007 13:38:54 +0100
Received: from hyperion.delvare (jdelvare.pck.nerim.net [62.212.121.182])
	by kraid.nerim.net (Postfix) with ESMTP id B22C8410B6;
	Fri, 18 May 2007 14:38:20 +0200 (CEST)
Date:	Fri, 18 May 2007 14:38:39 +0200
From:	Jean Delvare <khali@linux-fr.org>
To:	Domen Puncer <domen.puncer@telargo.com>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>, i2c@lm-sensors.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] i2c-au1550: convert to platform driver
Message-ID: <20070518143839.41117729@hyperion.delvare>
In-Reply-To: <20070518072427.GC20713@moe.telargo.com>
References: <20070516053439.GB12986@roarinelk.homelinux.net>
	<20070517123853.4ae91d25@hyperion.delvare>
	<20070518072427.GC20713@moe.telargo.com>
X-Mailer: Sylpheed-Claws 2.5.5 (GTK+ 2.10.6; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <khali@linux-fr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips

Hi Domen,

On Fri, 18 May 2007 09:24:27 +0200, Domen Puncer wrote:
> On 17/05/07 12:38 +0200, Jean Delvare wrote:
> > On Wed, 16 May 2007 07:34:40 +0200, Manuel Lauss wrote:
> > >  	if (!(stat & PSC_SMBSTAT_TE) || !(stat & PSC_SMBSTAT_RE)) {
> > > -		sp->psc_smbpcr = PSC_SMBPCR_DC;
> > > +		au_writel(PSC_SMBPCR_DC, base + PSC_SMBPCR);
> > >  		au_sync();
> > > -		do {
> > > -			stat = sp->psc_smbpcr;
> > > -			au_sync();
> > > -		} while ((stat & PSC_SMBPCR_DC) != 0);
> > > +		while (au_readl(base + PSC_SMBPCR) & PSC_SMBPCR_DC)
> > > +			msleep(0);
> > 
> > You are changing the behavior here, while this patch is supposed to
> > only convert the driver to the new device driver model.
> 
> Well... since msleep(0) is nothing, it's the same, but it does
> look weird.

msleep(0) isn't nothing. It sleeps until the next tick.

-- 
Jean Delvare
