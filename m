Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Mar 2003 06:12:37 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:55539 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225194AbTCAGMg>;
	Sat, 1 Mar 2003 06:12:36 +0000
Received: from localhost (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id WAA26641;
	Fri, 28 Feb 2003 22:12:29 -0800
Subject: Re: CardBus on DBAu1500
From: Pete Popov <ppopov@mvista.com>
To: baitisj@evolution.com
Cc: linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20030228194820.Z20129@luca.pas.lab>
References: <20030228194820.Z20129@luca.pas.lab>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1046499358.12356.2.camel@adsl.pacbell.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 28 Feb 2003 22:15:58 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, 2003-02-28 at 19:48, Jeff Baitis wrote:
> Hey Pete and others!
> 
> I'm finally working on CardBus support on the DBAu1500. Just got acquainted
> with PCI today. :)
> 
> I decided that the first step is to plug in a PCI->PCI bridge, and try to see
> if it would work, which it did not. After winding around inside of the kernel,
> I finally arrived in arch/mips/au1000/db1x00/pci_ops.c:
> 
> Inside of config_access(unsigned char access_type, struct pci_dev *dev,
> unsigned char where, u32 * data), on line 97, a little surprise:
> 
>     if (bus != 0) {
>         *data = 0xffffffff;
>         return -1;
>     }
> 
> At this point, I concluded that I cannot traverse a PCI-PCI or CardBus bridge,
> since any devices behind the bridge will require Type 1 Configuration Cycles,
> and it seems that only Type 0 is currently supported.
> 
> I assume that I should add code to handle the case where I need to generate
> Type 1 Configuration Cycles inside of config_access. Pete, since you authored
> this code, I thought I'd quickly run this by you to make sure that I'm on
> track.
> 
> Thanks for your suggestions!

Take a look at arch/mips/au1000/pb1500/pci_ops.c for type 1 config
access. The patch was courtesy of David Gathright and apparently I
missed adding it in the db1500. Actually, we need to combine that code
because it's the same. Let me get through my eternal struggle of getting
the 36 bit patch applied (with Ralf's help I think a modified patch
should be ready this weekend) and then I'll worry about clean ups :)

Pete
