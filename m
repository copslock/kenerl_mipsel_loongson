Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Apr 2005 09:10:00 +0100 (BST)
Received: from no-dns-yet.demon.co.uk ([IPv6:::ffff:83.104.11.251]:18896 "EHLO
	exterity.co.uk") by linux-mips.org with ESMTP id <S8225248AbVDEIJp> convert rfc822-to-8bit;
	Tue, 5 Apr 2005 09:09:45 +0100
Content-class: urn:content-classes:message
Subject: RE: No PCI memory response
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date:	Tue, 5 Apr 2005 09:11:24 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <CEA5455795C8AA44AA1E18EF32379B2105CF5E@exterity-serv1.Exterity.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: No PCI memory response
thread-index: AcU5JwDTMZSDHp4oTCW7UNSAOaWfyQAkJsqg
From:	"Gill Robles-Thome" <gill.robles@exterity.co.uk>
To:	<linux-mips@linux-mips.org>
Return-Path: <gill.robles@exterity.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7593
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gill.robles@exterity.co.uk
Precedence: bulk
X-list: linux-mips

Hi -

I'm certainly seeing what looks like random reads...however, is the
static bus controller actually implicated in PCI bus operations?  The
product brief for the Au1100 doesn't mention PCI, so I'm not sure that
we're looking at the same problem.

Thanks,
Gill

-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Ulrich Eckhardt
Sent: 04 April 2005 15:53
To: linux-mips@linux-mips.org
Subject: Re: No PCI memory response


Gill wrote:
> Can anyone help?  We're trying to talk to a RealTek RTL8139 device 
> across the PCI bus, and, although linux can access configuration 
> registers on the device, it does not access memory space correctly, 
> and we are unable to read back any sensible values from the RTL8139 
> registers.
>
> We are using the latest 2.6 linux on an Alchemy DB1550 board.

Random reads, discarded data after writing? I had the same problem and
solved 
it by simply configuring the static bus controller of my Au1100 properly
(of 
which before I didn't even know it existed...).

hth

Uli
