Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jan 2005 20:08:28 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:62473 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225438AbVANUIX>;
	Fri, 14 Jan 2005 20:08:23 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1CpXpk-0002Iq-00; Fri, 14 Jan 2005 20:14:12 +0000
Received: from [192.168.192.200] (helo=perivale.mips.com)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1CpXjg-000326-00; Fri, 14 Jan 2005 20:07:56 +0000
Received: from macro (helo=localhost)
	by perivale.mips.com with local-esmtp (Exim 3.36 #1 (Debian))
	id 1CpXjg-0005sU-00; Fri, 14 Jan 2005 20:07:56 +0000
Date: Fri, 14 Jan 2005 20:07:56 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@mips.com>
To: Herbert Valerio Riedel <hvr@inso.tuwien.ac.at>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] I/O helpers rework
In-Reply-To: <1105368598.21670.7.camel@shswe.inso.tuwien.ac.at>
Message-ID: <Pine.LNX.4.61.0501141959280.21179@perivale.mips.com>
References: <Pine.LNX.4.61.0412151936460.14855@perivale.mips.com> 
 <1105029224.4361.21.camel@xterm.intra>  <Pine.LNX.4.61.0501101249280.18023@perivale.mips.com>
  <1105368380.21670.4.camel@shswe.inso.tuwien.ac.at>
 <1105368598.21670.7.camel@shswe.inso.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.717,
	required 4, AWL, BAYES_00)
Return-Path: <macro@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
Precedence: bulk
X-list: linux-mips

On Mon, 10 Jan 2005, Herbert Valerio Riedel wrote:

> On Mon, 2005-01-10 at 15:46 +0100, Herbert Valerio Riedel wrote:
> > so this means, the mtd subsystem should use them and that the patch
> > below is the way to fix it? (hoping it won't brake on other systems?)
> 
> sorry, wrong patch... the patch below should have s/__raw_/bus_/g
> instead of s/__raw_//g;

 Probably, although <linux/mtd/map.h> seems device-independent and that 
may mean you might want to take the endianness of the bus an MTD is 
connected to, to preserve data consistency when moving the MTD between 
systems of different endiannesses (it may be non-volatile memory of some 
sort).

> anyway, are the bus_# memory accessors defined for all archs at all?

 Not at all, I'm afraid, and fixing that might be a good idea.
Unfortunately most platforms use a single endianness only and therefore
have a biased view on these accessory functions.  Especially little-endian
folks may have troubles understanding what's this all about.

  Maciej
