Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 May 2004 16:02:09 +0100 (BST)
Received: from c2ce9fba.adsl.oleane.fr ([IPv6:::ffff:194.206.159.186]:42905
	"EHLO avalon.france.sdesigns.com") by linux-mips.org with ESMTP
	id <S8225576AbUEJPCH>; Mon, 10 May 2004 16:02:07 +0100
Received: from avalon.france.sdesigns.com (localhost.localdomain [127.0.0.1])
	by avalon.france.sdesigns.com (8.12.8/8.12.8) with ESMTP id i4AF251q010161
	for <linux-mips@linux-mips.org>; Mon, 10 May 2004 17:02:05 +0200
Received: (from michon@localhost)
	by avalon.france.sdesigns.com (8.12.8/8.12.8/Submit) id i4AF25BN010159
	for linux-mips@linux-mips.org; Mon, 10 May 2004 17:02:05 +0200
X-Authentication-Warning: avalon.france.sdesigns.com: michon set sender to em@realmagic.fr using -f
Subject: Re: new platform
From: Emmanuel Michon <em@realmagic.fr>
To: linux-mips@linux-mips.org
In-Reply-To: <Pine.GSO.4.10.10405101648140.21907-100000@helios.et.put.poznan.pl>
References: <Pine.GSO.4.10.10405101648140.21907-100000@helios.et.put.poznan.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: REALmagic France SAS
Message-Id: <1084201325.2219.1325.camel@avalon.france.sdesigns.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 10 May 2004 17:02:05 +0200
Return-Path: <em@realmagic.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: em@realmagic.fr
Precedence: bulk
X-list: linux-mips

On Mon, 2004-05-10 at 16:53, Stanislaw Skowronek wrote:
> > Q2- Most hardware platforms have their SDRAM chips mapped at
> > physical address 0x0. Mine does not. Am I going ahead of problems?
> > It seems to be assumed at a lot of places (I have already ported YAMON).
> 
> I have run into very few problems of the sort on the Octane, which has all
> its memory just over CKSEG0. Most, if not all, of them would be gone if
> the Octane had anything at all in CKSEG0, not counting exception vectors
> (that reminds me, how do you handle exceptions? Linux assumes you *DO*
> have some writeable space at CKSEG0, at least a kilobyte - all exception
> handlers are copied there at runtime).

It seems not all MIPS CPUs have the CP0 register EBase but mine does

This one allows to use any value as exception base instead of
0x8000_0000 (that saves me: I will just point it at the base of my RAM).

Sincerely yours,

E.M.

> 
> You will have to change the kernel link address to the beginning of your
> physical RAM (or any other place you like, as long as it is under 512MB).
> It is easily done and I don't think it will cause any problems.
> 
> Stanislaw Skowronek
> 
> 
> 
> 
