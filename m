Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Nov 2004 10:31:21 +0000 (GMT)
Received: from pD9562C58.dip.t-dialin.net ([IPv6:::ffff:217.86.44.88]:43120
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225297AbUK2KbQ>; Mon, 29 Nov 2004 10:31:16 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iATAVBsc001339;
	Mon, 29 Nov 2004 11:31:11 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iATAV17P001338;
	Mon, 29 Nov 2004 11:31:01 +0100
Date: Mon, 29 Nov 2004 11:31:01 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: linux-mips@linux-mips.org, Manish Lachwani <mlachwani@mvista.com>
Subject: Re: titan_ge etherent driver
Message-ID: <20041129103101.GB32075@linux-mips.org>
References: <200411291105.43441.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411291105.43441.thomas.koeller@baslerweb.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 29, 2004 at 11:05:43AM +0100, Thomas Koeller wrote:

> since I noticed that you are working on the titan_ge driver,
> I think it is time to let you know that I am currently
> reworking that driver in the context of a new platform port.
> The primary goal is to cleanly separate the  titan_ge driver
> from the yosemite platform and to make it usable with other
> RM9000-based platforms as well.
> 
> The work is rather advanced, I did implement all the necessary
> changes and am now debugging through the thing to make it
> work. During the process I found quite a number of issues with
> the old driver that I fixed along the way.
> 
> The main points addressed by my work are these:
> 
> - Do no longer monopolize the message interrupt, so the titan_ge
>   can coexist with other drivers for OCDs.
> 
> - Do not refuse to initialize if the link is down. This
>   would prevent a statically linked kernel from booting if
>   no network cord was attached :-(

Indeed, these messages were looking suspicious and I also meant to eventually
look into them also ...

> - Properly allocate and deallocate any resources used.
> 
> - Introduce a mapping layer, so that the driver can be told to
>   use any ethernet slice for any port number, and even leave
>   alone slices so they can be used for different purposes (GPI).

Networking gives you zero guarantee for an association of the port
numbers (as in ethX) and a particular slice.  Consider the case where a
board is using a PCI network controller and the Titan module is loaded
later - eth0 is already gone.

> - Introduce a general OCD access framework that is designed to be
>   useful for new platform ports.
> 
> I will submit my work work for review once it is completed (since
> I am working on it full time, that should not take too long). Until
> then, I'd like to avoid unnecessary duplication of work, so I am
> announcing this.

Other thing to fix is the driver itself playing with the CIC directly.

Good to know but collisions are likely very limited because the Titan GE
work I did was only small bug fixes.  The one thing which I'm chasing
now is that a recent update from kernel.org import is causing a NFS
hang when booting from NFS.  Interestingly the system will continue after
a few seconds and never hang again.  May be driver related or not.

  Ralf
