Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 20:45:13 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:22265 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225198AbTBTUpM>;
	Thu, 20 Feb 2003 20:45:12 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h1KKiuM26133;
	Thu, 20 Feb 2003 12:44:56 -0800
Date: Thu, 20 Feb 2003 12:44:56 -0800
From: Jun Sun <jsun@mvista.com>
To: Dan Malek <dan@embeddededge.com>
Cc: Tibor Polgar <tpolgar@freehandsystems.com>,
	Mark Salter <msalter@redhat.com>, krishnakumar@naturesoft.net,
	linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: Ramdisk image on flash.
Message-ID: <20030220124456.G7466@mvista.com>
References: <200302201135.09154.krishnakumar@naturesoft.net> <1045765647.30379.262.camel@zeus.mvista.com> <3E552CDF.ECD08EEF@freehandsystems.com> <20030220194115.2A21378A6D@deneb.localdomain> <3E55342D.6E1D36FF@freehandsystems.com> <3E553C03.10207@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E553C03.10207@embeddededge.com>; from dan@embeddededge.com on Thu, Feb 20, 2003 at 03:35:15PM -0500
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, Feb 20, 2003 at 03:35:15PM -0500, Dan Malek wrote:
> Tibor Polgar wrote:
> 
> > The original poster wanted a setup where the initrd was NOT part of the
> > kernel, which begs the question of how/where it would be put into flash so
> > something could load/uncompress it. 
> 
> I regularly do this with compressed kernels (zImage) on PowerPC, ARM, and
> Alchemy MIPS processors.  I attach the compressed ramdisk to the zImage,
> usually with "cat" and some shell scripts.  The zImage uncompressor code
> will relocate the ramdisk (and potentially ask for additional kernel
> command line parameters) and will tell the kernel where the ramdisk is
> located.  I don't have to recompile the kernel to do this, and best of
> all it doesn't require any special boot rom knowledge of the image.  It
> works with all boot roms that can load a binary image into a memory location
> (not everyone uses RedBoot) :-)  Another advantage is exactly the same
> image that you repeatedly test by loading over tftp or with a debugger
> can be written into flash memory without modification.  It removes the
> need to actually have to write to flash to test the image that will be
> eventually written to flash.  You just jump to the start of the image to
> uncompress/relocate/initialize/jump to kernel regardless of where it
> is located.
>

Looks like you have the solution that I called for. :-)
 
> 
> There are a couple of things keeping me from making a patch for the MIPS
> kernel.  This method is in conflict with the "compiled in" ramdisk method,
> and reserving the "bootmem" pages to ensure the kernel doesn't allocate the
> compressed ramdisk pages before they are freed doesn't work well compared
> to other architectures.  I'm still running on luck with this latter problem,
> but I think I can fix it.  I don't know yet what to do about the conflicts
> and assumptions made about the compiled-in ramdisk.
>

The compiled-in one uses a configure option.  Perhaps you can rely on that
to differentiate?  Once the new method get stable, I am in favor to 
covert all embedded ramdisk to the new one.

Jun
