Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2004 06:57:44 +0100 (BST)
Received: from vanessarodrigues.com ([IPv6:::ffff:192.139.46.150]:50568 "EHLO
	jaguar.mkp.net") by linux-mips.org with ESMTP id <S8225226AbUJTF5i>;
	Wed, 20 Oct 2004 06:57:38 +0100
Received: by jaguar.mkp.net (Postfix, from userid 1655)
	id 3FC16286D44; Wed, 20 Oct 2004 01:57:37 -0400 (EDT)
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Manish Lachwani <mlachwani@mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH]PCI on SWARM
References: <416DE31E.90509@mvista.com>
	<20041014191754.GB30516@linux-mips.org>
	<Pine.LNX.4.58L.0410142305380.25607@blysk.ds.pg.gda.pl>
	<416EFBAB.8050600@mvista.com>
	<Pine.LNX.4.58L.0410142327530.25607@blysk.ds.pg.gda.pl>
	<20041014225553.GA13597@linux-mips.org>
	<Pine.LNX.4.58L.0410150311370.25607@blysk.ds.pg.gda.pl>
	<yq0zn2ks9em.fsf@jaguar.mkp.net>
	<Pine.LNX.4.58L.0410182042010.12159@blysk.ds.pg.gda.pl>
From: Jes Sorensen <jes@wildopensource.com>
Date: 20 Oct 2004 01:57:36 -0400
In-Reply-To: <Pine.LNX.4.58L.0410182042010.12159@blysk.ds.pg.gda.pl>
Message-ID: <yq0lle2rkxb.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <jes@trained-monkey.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jes@wildopensource.com
Precedence: bulk
X-list: linux-mips

>>>>> "Maciej" == Maciej W Rozycki <macro@linux-mips.org> writes:

Maciej> On Mon, 18 Oct 2004, Jes Sorensen wrote: 
>>  Dual address cycles, ie. 64 bit addressing is fscked on the 1250
>> from what I remember. Correct way to work around this is to stick
>> all physical memory outside the 32 bit space into ZONE_HIGHMEM -
>> had a patch for 2.4, but I lost it ages ago ;-(

Maciej>  The BCM1250A's PCI is obviously 32-bit only (the host bridge
Maciej> is explicitly documented not to support DACs), but you need to
Maciej> use 64-bit addressing to access the whole 4GB range -- the bus
Maciej> is decoded starting from 0xf800000000 and 0xf900000000, with a
Maciej> different byte lane swapping policy for each of these areas.
Maciej> For limited access for 32-bit software, you can use alternate
Maciej> mappings at 0x40000000 and 0x60000000, but they provide only
Maciej> 512MB of space each.

Yeah it seems to be documented, it's highly unfortunate that anybody
will release a chip which doesn't support DAC but will support memory
outside the 4GB range. I'd be highly embarrassed if I had done the
chip, but thats just me.

I think you are right about the HT part.

Cheers,
JEs
