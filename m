Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 20:01:40 +0000 (GMT)
Received: from bisque.propagation.net ([IPv6:::ffff:66.221.142.1]:485 "EHLO
	bisque.propagation.net") by linux-mips.org with ESMTP
	id <S8225261AbTBTUBj>; Thu, 20 Feb 2003 20:01:39 +0000
Received: from freehandsystems.com (adsl-64-170-127-190.dsl.snfc21.pacbell.net [64.170.127.190])
	by bisque.propagation.net (8.11.6/8.8.5) with ESMTP id h1KK1Rg14489;
	Thu, 20 Feb 2003 14:01:28 -0600
Message-ID: <3E55342D.6E1D36FF@freehandsystems.com>
Date: Thu, 20 Feb 2003 12:01:49 -0800
From: Tibor Polgar <tpolgar@freehandsystems.com>
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Salter <msalter@redhat.com>
CC: krishnakumar@naturesoft.net, linux-mips@linux-mips.org
Subject: Re: Ramdisk image on flash.
References: <200302201135.09154.krishnakumar@naturesoft.net> <1045765647.30379.262.camel@zeus.mvista.com> <3E552CDF.ECD08EEF@freehandsystems.com> <20030220194115.2A21378A6D@deneb.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <tpolgar@freehandsystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tpolgar@freehandsystems.com
Precedence: bulk
X-list: linux-mips

> >> On Wed, 2003-02-19 at 22:05, Krishnakumar. R wrote:
> >> > Hi,
> >> >
> >> > Is there any way that I can keep
> >> > a ramdisk image (containing the root filesystem)
> >> > in a flash device and boot to it.
> >>
> >> Yes, and other architectures have support for passing arguments to the
> >> kernel that tell it where the ramdisk is. I don't know that we've done
> >> that for MIPS, yet.  It wouldn't be too hard to do and maybe someone on
> >> this list is already working on it (I think someone actually is working
> >> on it and was preparing a patch for Ralf).
> 
> > For having separate initrd and kernel load we also need an aware bootloader
> > that knows where to find the ramdisk.   RedBoot, from what i read, seems to be
> > i386 specific.
> 
> Not at all. RedBoot can be used to pass a command line to MIPS kernels. It
> would be simple to add the passing of a ramdisk address. It already supports
> ramdisks from ARM and SH kernels.

The original poster wanted a setup where the initrd was NOT part of the
kernel, which begs the question of how/where it would be put into flash so
something could load/uncompress it.   I'd love to have a way to decouple the
two so i wouldn't have to recompile the kernel when i change the root image,
but still not waste any space in flash.   I guess they could be written one
after the other and the loader is just given a "load map" of where each one
resides.   Would this satisfy Krishnakumar's requirements?

Tibor
