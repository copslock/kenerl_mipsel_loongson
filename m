Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Sep 2008 12:40:17 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:6839
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20166131AbYI1Ljf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 28 Sep 2008 12:39:35 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m8SBdWKA009454;
	Sun, 28 Sep 2008 12:39:32 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m8SBdVDF009451;
	Sun, 28 Sep 2008 12:39:31 +0100
Date:	Sun, 28 Sep 2008 12:39:31 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-ide@vger.kernel.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] IDE: Fix platform device registration in Swarm IDE
	driver
Message-ID: <20080928113931.GA9207@linux-mips.org>
References: <20080922122853.GA15210@linux-mips.org> <48DA1F9D.6000501@ru.mvista.com> <200809271859.55304.bzolnier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200809271859.55304.bzolnier@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Sep 27, 2008 at 06:59:55PM +0200, Bartlomiej Zolnierkiewicz wrote:

> > > -	swarm_ide_resource.start = offset;
> > > -	swarm_ide_resource.end = offset + size - 1;
> > > -	if (request_resource(&iomem_resource, &swarm_ide_resource)) {
> > >   
> > 
> >    Why drop request_resource() completely? Replace it by 
> > request_mem_region().
> 
> Yes, this needs fixing (otherwise everything looks good).

No, platform_device_add which is called by platform_device_register*
will take care of adding the resources - but only if if's told about them
which the old driver didn't.

Also, in case of a resource conflict a device should not be added at all but
exactly that is what the old code did.  A resource conflict would have been
caught by the platform_driver probing code well too late.

> Ralf: I guess that your next step will be dropping swarm-specific platform ide
> driver in favor of generic one (please see drivers/ide/legacy/ide_platform.c)
> as they are _very_ similar now? :)

Good point - I was already wondering if something like that does exist.
What's left over of the swarm driver way too much looks like it can be
squeezed into some sort of template.

  Ralf
