Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 20:59:54 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:13565 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225198AbTBTU7x>;
	Thu, 20 Feb 2003 20:59:53 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id MAA04950;
	Thu, 20 Feb 2003 12:53:55 -0800
Subject: Re: Ramdisk image on flash.
From: Pete Popov <ppopov@mvista.com>
To: Jun Sun <jsun@mvista.com>
Cc: Dan Malek <dan@embeddededge.com>,
	Tibor Polgar <tpolgar@freehandsystems.com>,
	Mark Salter <msalter@redhat.com>, krishnakumar@naturesoft.net,
	linux-mips@linux-mips.org
In-Reply-To: <20030220124456.G7466@mvista.com>
References: <200302201135.09154.krishnakumar@naturesoft.net>
	 <1045765647.30379.262.camel@zeus.mvista.com>
	 <3E552CDF.ECD08EEF@freehandsystems.com>
	 <20030220194115.2A21378A6D@deneb.localdomain>
	 <3E55342D.6E1D36FF@freehandsystems.com> <3E553C03.10207@embeddededge.com>
	 <20030220124456.G7466@mvista.com>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1045774664.16543.307.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 20 Feb 2003 12:57:44 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, 2003-02-20 at 12:44, Jun Sun wrote:
> On Thu, Feb 20, 2003 at 03:35:15PM -0500, Dan Malek wrote:
> > Tibor Polgar wrote:
> > 
> > > The original poster wanted a setup where the initrd was NOT part of the
> > > kernel, which begs the question of how/where it would be put into flash so
> > > something could load/uncompress it. 
> > 
> > I regularly do this with compressed kernels (zImage) on PowerPC, ARM, and
> > Alchemy MIPS processors.  I attach the compressed ramdisk to the zImage,
> > usually with "cat" and some shell scripts.  The zImage uncompressor code
> > will relocate the ramdisk (and potentially ask for additional kernel
> > command line parameters) and will tell the kernel where the ramdisk is
> > located.  I don't have to recompile the kernel to do this, and best of
> > all it doesn't require any special boot rom knowledge of the image.  It
> > works with all boot roms that can load a binary image into a memory location
> > (not everyone uses RedBoot) :-)  Another advantage is exactly the same
> > image that you repeatedly test by loading over tftp or with a debugger
> > can be written into flash memory without modification.  It removes the
> > need to actually have to write to flash to test the image that will be
> > eventually written to flash.  You just jump to the start of the image to
> > uncompress/relocate/initialize/jump to kernel regardless of where it
> > is located.
> >
> 
> Looks like you have the solution that I called for. :-)
>  
> > 
> > There are a couple of things keeping me from making a patch for the MIPS
> > kernel.  This method is in conflict with the "compiled in" ramdisk method,
> > and reserving the "bootmem" pages to ensure the kernel doesn't allocate the
> > compressed ramdisk pages before they are freed doesn't work well compared
> > to other architectures.  I'm still running on luck with this latter problem,
> > but I think I can fix it.  I don't know yet what to do about the conflicts
> > and assumptions made about the compiled-in ramdisk.
> >
> 
> The compiled-in one uses a configure option.  Perhaps you can rely on that
> to differentiate?  Once the new method get stable, I am in favor to 
> covert all embedded ramdisk to the new one.

Me too. Keep in mind too that there is no "standard" zImage support in
mips right now.  I'm not sure what Dan is using for the zImage support,
that but that's another patch that needs to make its way in the source
tree.  I added zImage support in the form of an arch/mips/zboot
directory and supporting files, but that never made it in linux-mips.org
because it added yet another copy of zlib (my argument was, so what, all
the other arches do it).

Pete
