Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 May 2012 14:57:02 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:54367 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903681Ab2EXM4y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 May 2012 14:56:54 +0200
Date:   Thu, 24 May 2012 13:56:54 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     "Steven J. Hill" <sjhill@mips.com>, linux-mips@linux-mips.org
Subject: Re: [v2,4/5] MIPS: Malta PCI changes for PCI 2.1 compatibility and
 conflicts.
In-Reply-To: <20120524112503.GA2337@linux-mips.org>
Message-ID: <alpine.LFD.2.00.1205241341060.3701@eddie.linux-mips.org>
References: <1333742869-17373-1-git-send-email-sjhill@mips.com> <20120524112503.GA2337@linux-mips.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 33444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, 24 May 2012, Ralf Baechle wrote:

> > diff --git a/arch/mips/mti-malta/malta-pci.c b/arch/mips/mti-malta/malta-pci.c
> > index bf80921..afeb619 100644
> > --- a/arch/mips/mti-malta/malta-pci.c
> > +++ b/arch/mips/mti-malta/malta-pci.c
> > @@ -241,8 +241,9 @@ void __init mips_pcibios_init(void)
> >  		return;
> >  	}
> >  
> > -	if (controller->io_resource->start < 0x00001000UL)	/* FIXME */
> > -		controller->io_resource->start = 0x00001000UL;
> > +	/* Change start address to avoid conflicts with ACPI and SMB devices */
> > +	if (controller->io_resource->start < 0x00002000UL)	/* FIXME */
> > +		controller->io_resource->start = 0x00002000UL;
> 
> I think raising this value to 0x2000 solves the FIXME which is there since
> Maciej's 66d9ad704b25287bfee7e86a5af50b92642b9c72 commit in 2005.  Maciej,
> do you recall you added the FIXME?

 Vaguely.  I reckon the bump was required because PIIX4 ACPI/SMB didn't 
reserve their resources that are not properly set/announced with standard 
PCI BARs in the PCI configuration space.  Chances therefore were something 
else would take this range and I reckon this was of course exactly what 
happened, ruining everything in a weird way.

 And I think it was the other way round -- I think bumping it up yet more 
is the wrong way of "fixing this up" (why is it needed anyway, did the 
assignment change? -- I don't remember if power-on defaults are used on 
Malta or if that is YAMON that initialises these).  I am fairly sure if I 
added that FIXME it was meant as a reminder to fix that properly and not 
do something as trivial as this.  And a proper fix is IMO either of these:

1. If there is a proper PIIX4 ACPI/SMB driver available then it should 
   reserve these resources to avoid the conflict.

2. Otherwise a PCI quirk should do that based on the PCI ID of the device 
   and the resource ranges obtained directly from the device (I reckon 
   they still use BARs, but in the vendor-specific space, they're not 
   fixed assignments), pretty much like some PC/AT legacy resources are 
   reserved (82xx series PIC, PIT, etc).

I don't remember why I didn't do either of these, sorry.

  Maciej
