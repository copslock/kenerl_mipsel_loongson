Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 19:30:30 +0000 (GMT)
Received: from bisque.propagation.net ([IPv6:::ffff:66.221.142.1]:33760 "EHLO
	bisque.propagation.net") by linux-mips.org with ESMTP
	id <S8225262AbTBTTa3>; Thu, 20 Feb 2003 19:30:29 +0000
Received: from freehandsystems.com (adsl-64-170-127-190.dsl.snfc21.pacbell.net [64.170.127.190])
	by bisque.propagation.net (8.11.6/8.8.5) with ESMTP id h1KJUG527631;
	Thu, 20 Feb 2003 13:30:16 -0600
Message-ID: <3E552CDF.ECD08EEF@freehandsystems.com>
Date: Thu, 20 Feb 2003 11:30:39 -0800
From: Tibor Polgar <tpolgar@freehandsystems.com>
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Popov <ppopov@mvista.com>
CC: krishnakumar@naturesoft.net, linux-mips@linux-mips.org
Subject: Re: Ramdisk image on flash.
References: <200302201135.09154.krishnakumar@naturesoft.net> <1045765647.30379.262.camel@zeus.mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <tpolgar@freehandsystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1475
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tpolgar@freehandsystems.com
Precedence: bulk
X-list: linux-mips

Pete Popov wrote:
> 
> On Wed, 2003-02-19 at 22:05, Krishnakumar. R wrote:
> > Hi,
> >
> > Is there any way that I can keep
> > a ramdisk image (containing the root filesystem)
> > in a flash device and boot to it.
> 
> Yes, and other architectures have support for passing arguments to the
> kernel that tell it where the ramdisk is. I don't know that we've done
> that for MIPS, yet.  It wouldn't be too hard to do and maybe someone on
> this list is already working on it (I think someone actually is working
> on it and was preparing a patch for Ralf).

For having separate initrd and kernel load we also need an aware bootloader
that knows where to find the ramdisk.   RedBoot, from what i read, seems to be
i386 specific.    The Yamon i've patched "COULD" be made to do it.   

> 
> > The ramdisk should be separate from the kernel image.

How is this currently done in non-mips archs?   I know lilo and Druid can do
this with a configuration file and hard sector addressing into a filesystem,
but i never understood how they avoid/get around file fragmentation issues.

Tibor
