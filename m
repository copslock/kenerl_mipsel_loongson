Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2003 21:12:15 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:48116 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225208AbTDXUMO>;
	Thu, 24 Apr 2003 21:12:14 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id NAA31796;
	Thu, 24 Apr 2003 13:12:09 -0700
Subject: Re: Au1500 PCI autoconfig issues with multiple PCI devices?
From: Pete Popov <ppopov@mvista.com>
To: baitisj@evolution.com
Cc: Jun Sun <jsun@mvista.com>,
	Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <20030424130459.P10148@luca.pas.lab>
References: <20030424114832.O10148@luca.pas.lab>
	 <20030424121140.G28275@mvista.com>  <20030424130459.P10148@luca.pas.lab>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1051215131.511.659.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 24 Apr 2003 13:12:11 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips


> Here's another question:

> What are the goals of the AU1500 PCI auto config? Is it supposed to be a full
> implementation, or just enough to work with a PCI card? The reason I ask is
> that the DBAu1500 has only one PCI slot, so a simple implementation would
> normally suffice.
> 
> Restated: I don't know if the PCI auto config code was designed to work with
> all sorts of wacky PCI devices. I don't know if the intention of the code is to
> support the single PCI slot present on the DbAu1500 development board, or if it
> is supposed to be more flexible (and complicated). 

The MIPS pci auto should work fine with a single PCI bus and it _should_
be a full implementation. The code was ported from PPC some time ago,
but sub busses were not tested.  Also, if I remember correctly, we
simplified a bit the more complex PPC implementation and maybe you're
seeing the result of that :)

Pete
