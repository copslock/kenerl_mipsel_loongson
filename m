Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Nov 2004 12:59:39 +0000 (GMT)
Received: from [IPv6:::ffff:80.122.96.210] ([IPv6:::ffff:80.122.96.210]:64683
	"EHLO fwswe.inso.tuwien.ac.at") by linux-mips.org with ESMTP
	id <S8224872AbUKKM7f>; Thu, 11 Nov 2004 12:59:35 +0000
Received: from s052.inso.tuwien.ac.at ([128.130.59.52])
	by fwswe.inso.tuwien.ac.at with esmtp (Exim 3.36 #1 (Debian))
	id 1CSEXS-0002FT-00; Thu, 11 Nov 2004 13:58:58 +0100
Subject: Re: ohci-au1xxx.c cleanups and fix for 2.6.10-rc1
From: Herbert Valerio Riedel <hvr@inso.tuwien.ac.at>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: Pete Popov <ppopov@embeddedalley.com>, linux-mips@linux-mips.org
In-Reply-To: <20041105071817.A19291@home.com>
References: <1099642775.9984.16.camel@s052.inso.tuwien.ac.at>
	 <20041105071817.A19291@home.com>
Content-Type: text/plain
Date: Thu, 11 Nov 2004 13:58:55 +0100
Message-Id: <1100177936.17620.32.camel@s052.inso.tuwien.ac.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Return-Path: <hvr@inso.tuwien.ac.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6305
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hvr@inso.tuwien.ac.at
Precedence: bulk
X-list: linux-mips

On Fri, 2004-11-05 at 07:18 -0700, Matt Porter wrote:
> On Fri, Nov 05, 2004 at 09:19:34AM +0100, Herbert Valerio Riedel wrote:
> > 
> > below just a patch to have usb working again for 2.6.10-rc1 and
> > some minor cleanups...
> > (alas usb still doesn't work on big endian...)
> 
> The patches to support BE OHCI operation were posted months ago on
> the USB list.  GregKH recently picked them up and I just saw the
> first of them merged to the mainline tree. You should have better
> luck with BE OHCI soon. :)

I've played w/ the upcoming patches for 2.6.10-rc2 contained in the bk
snapshots, and was able to confirm that better luck is really in sight
for me (wrt to USB/BE)  :-) 

USB worked fine w/ mouse and some usb-storage ram module, I'd be glad to
provide you w/ the required modifications (if necessary) as soon as
2.6.10-rc2 comes out and get merged into linux-mips cvs...

now I just need to find how to fix that subtle pci w/ BE issue I'm
having w/ pci-device subfunctions disappearing in BE mode...

greetings,
-- 
Herbert Valerio Riedel <hvr@inso.tuwien.ac.at>
