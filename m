Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 20:37:48 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:45303 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225263AbTBTUhr>;
	Thu, 20 Feb 2003 20:37:47 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h1KKbWq26114;
	Thu, 20 Feb 2003 12:37:32 -0800
Date: Thu, 20 Feb 2003 12:37:32 -0800
From: Jun Sun <jsun@mvista.com>
To: Tibor Polgar <tpolgar@freehandsystems.com>
Cc: Mark Salter <msalter@redhat.com>, krishnakumar@naturesoft.net,
	linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: Ramdisk image on flash.
Message-ID: <20030220123732.F7466@mvista.com>
References: <200302201135.09154.krishnakumar@naturesoft.net> <1045765647.30379.262.camel@zeus.mvista.com> <3E552CDF.ECD08EEF@freehandsystems.com> <20030220194115.2A21378A6D@deneb.localdomain> <3E55342D.6E1D36FF@freehandsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E55342D.6E1D36FF@freehandsystems.com>; from tpolgar@freehandsystems.com on Thu, Feb 20, 2003 at 12:01:49PM -0800
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, Feb 20, 2003 at 12:01:49PM -0800, Tibor Polgar wrote:
> > >> On Wed, 2003-02-19 at 22:05, Krishnakumar. R wrote:
> > >> > Hi,
> > >> >
> > >> > Is there any way that I can keep
> > >> > a ramdisk image (containing the root filesystem)
> > >> > in a flash device and boot to it.
> > >>
> > >> Yes, and other architectures have support for passing arguments to the
> > >> kernel that tell it where the ramdisk is. I don't know that we've done
> > >> that for MIPS, yet.  It wouldn't be too hard to do and maybe someone on
> > >> this list is already working on it (I think someone actually is working
> > >> on it and was preparing a patch for Ralf).
> > 
> > > For having separate initrd and kernel load we also need an aware bootloader
> > > that knows where to find the ramdisk.   RedBoot, from what i read, seems to be
> > > i386 specific.
> > 
> > Not at all. RedBoot can be used to pass a command line to MIPS kernels. It
> > would be simple to add the passing of a ramdisk address. It already supports
> > ramdisks from ARM and SH kernels.
> 
> The original poster wanted a setup where the initrd was NOT part of the
> kernel, which begs the question of how/where it would be put into flash so
> something could load/uncompress it.   I'd love to have a way to decouple the
> two so i wouldn't have to recompile the kernel when i change the root image,
> but still not waste any space in flash.   I guess they could be written one
> after the other and the loader is just given a "load map" of where each one
> resides.   Would this satisfy Krishnakumar's requirements?
>

For the sanity of kernel, I also favor leaving ramfs root outside kernel.
It would be nice if we can do the following :

1) create kernel ELF as normal
2) outside the kernel, create .o file that is ramfs root
3) outside the kernel, we use a separate tool/program that combines
   1) and 2) into a new ELF file.  The entry point of the new ELF file
   would append ramfs parameters (such as "initrd=xxxx") to the args
   and then jump to kernel_entry.

There are some difficulties, but looks very possible.

Jun
