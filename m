Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 19:38:22 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:58873 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225262AbTBTTiV>;
	Thu, 20 Feb 2003 19:38:21 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id LAA01265;
	Thu, 20 Feb 2003 11:37:36 -0800
Subject: Re: Ramdisk image on flash.
From: Pete Popov <ppopov@mvista.com>
To: Tibor Polgar <tpolgar@freehandsystems.com>
Cc: krishnakumar@naturesoft.net, linux-mips@linux-mips.org
In-Reply-To: <3E552CDF.ECD08EEF@freehandsystems.com>
References: <200302201135.09154.krishnakumar@naturesoft.net>
	 <1045765647.30379.262.camel@zeus.mvista.com>
	 <3E552CDF.ECD08EEF@freehandsystems.com>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1045770085.30379.294.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 20 Feb 2003 11:41:25 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, 2003-02-20 at 11:30, Tibor Polgar wrote:
> Pete Popov wrote:
> > 
> > On Wed, 2003-02-19 at 22:05, Krishnakumar. R wrote:
> > > Hi,
> > >
> > > Is there any way that I can keep
> > > a ramdisk image (containing the root filesystem)
> > > in a flash device and boot to it.
> > 
> > Yes, and other architectures have support for passing arguments to the
> > kernel that tell it where the ramdisk is. I don't know that we've done
> > that for MIPS, yet.  It wouldn't be too hard to do and maybe someone on
> > this list is already working on it (I think someone actually is working
> > on it and was preparing a patch for Ralf).
> 
> For having separate initrd and kernel load we also need an aware bootloader
> that knows where to find the ramdisk.   RedBoot, from what i read, seems to be
> i386 specific.    The Yamon i've patched "COULD" be made to do it.   

I haven't looked at how initrd support is really done in other arches. But I
think the kernel copies the initrd image from its original location to a
new location, so I don't see why the original location couldn't be in
flash.  You could just pass the physical address to the kernel, and have
the kernel load it from flash to ram. 
 
Pete
