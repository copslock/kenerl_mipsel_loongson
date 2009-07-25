Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Jul 2009 21:39:32 +0200 (CEST)
Received: from ogre.sisk.pl ([217.79.144.158]:55220 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492904AbZGYTjZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 25 Jul 2009 21:39:25 +0200
Received: from localhost (localhost.localdomain [127.0.0.1])
	by ogre.sisk.pl (Postfix) with ESMTP id ABDEB144A23;
	Sat, 25 Jul 2009 18:50:47 +0200 (CEST)
Received: from ogre.sisk.pl ([127.0.0.1])
 by localhost (ogre.sisk.pl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 21671-02; Sat, 25 Jul 2009 18:50:28 +0200 (CEST)
Received: from tosh.localnet (220-bem-13.acn.waw.pl [82.210.184.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ogre.sisk.pl (Postfix) with ESMTP id 9C7891441EB;
	Sat, 25 Jul 2009 18:50:28 +0200 (CEST)
From:	"Rafael J. Wysocki" <rjw@sisk.pl>
To:	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH V2] au1xmmc: dev_pm_ops conversion
Date:	Sat, 25 Jul 2009 21:39:30 +0200
User-Agent: KMail/1.11.2 (Linux/2.6.31-rc4-rjw; KDE/4.2.4; x86_64; ; )
Cc:	Manuel Lauss <manuel.lauss@googlemail.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Manuel Lauss <manuel.lauss@gmail.com>
References: <1248275919-3296-1-git-send-email-manuel.lauss@gmail.com> <200907252019.01266.elendil@planet.nl> <20090725191037.GE14062@dtor-d630.eng.vmware.com>
In-Reply-To: <20090725191037.GE14062@dtor-d630.eng.vmware.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200907252139.30674.rjw@sisk.pl>
X-Virus-Scanned: amavisd-new at ogre.sisk.pl using MkS_Vir for Linux
Return-Path: <rjw@sisk.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rjw@sisk.pl
Precedence: bulk
X-list: linux-mips

On Saturday 25 July 2009, Dmitry Torokhov wrote:
> On Sat, Jul 25, 2009 at 08:18:58PM +0200, Frans Pop wrote:
> > On Saturday 25 July 2009, Dmitry Torokhov wrote:
> > > On Wed, Jul 22, 2009 at 05:18:39PM +0200, Manuel Lauss wrote:
> > > > Cc: Frans Pop <elendil@planet.nl>
> > > > Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> > > >
> > > > +
> > > > +static struct dev_pm_ops au1xmmc_pmops = {
> > > > +	.resume		= au1xmmc_resume,
> > > > +	.suspend	= au1xmmc_suspend,
> > > > +};
> > > > +
> > >
> > > Was suspend to disk tested? It requires freeze()/thaw().
> > 
> > Is that a regression introduced by this patch then? If so, many more of 
> > the recent dev_pm_ops conversion patches would need to be revisited.
> 
> Yes, as far as I understand they would. Let's ask Rafael to confirm...

Yes, they would.  In general, you'd probably want to do something like this:

static struct dev_pm_ops au1xmmc_pmops = {
	.resume		= au1xmmc_resume,
	.suspend		= au1xmmc_suspend,
	.freeze		= au1xmmc_resume,
	.thaw		= au1xmmc_suspend,
	.restore		= au1xmmc_resume,
	.poweroff	= au1xmmc_suspend,
};

but in this particular case it's probably better to define separate callbacks
for .freeze() and .thaw() at least.

During hibernation we call .freeze() and .thaw() before and after creating
the image, respectively, and then .poweroff() is called right after the image
has been saved.  During resume .freeze() is called after the image has been
loaded and before the control goes to the image kernel, which then calls
.restore().

HTH

I see I forgot about that myself.  I'll fix up the floppy and hp-wmi patches.

Best,
Rafael
