Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Oct 2004 09:44:37 +0100 (BST)
Received: from vanessarodrigues.com ([IPv6:::ffff:192.139.46.150]:34019 "EHLO
	jaguar.mkp.net") by linux-mips.org with ESMTP id <S8224791AbUJRIob>;
	Mon, 18 Oct 2004 09:44:31 +0100
Received: by jaguar.mkp.net (Postfix, from userid 1655)
	id 72605286D1B; Mon, 18 Oct 2004 04:44:17 -0400 (EDT)
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
From: Jes Sorensen <jes@wildopensource.com>
Date: 18 Oct 2004 04:44:17 -0400
In-Reply-To: <Pine.LNX.4.58L.0410150311370.25607@blysk.ds.pg.gda.pl>
Message-ID: <yq0zn2ks9em.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <jes@trained-monkey.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jes@wildopensource.com
Precedence: bulk
X-list: linux-mips

>>>>> "Maciej" == Maciej W Rozycki <macro@linux-mips.org> writes:

Maciej> On Fri, 15 Oct 2004, Ralf Baechle wrote:
>> Sure, go ahead.  This btw should match with the pci_controller
>> definition which is looking fishy also.

Maciej>  Tough.  Both the PCI memory and the PCI I/O spaces are mapped
Maciej> in several areas, depending on the byte lane swapping policy
Maciej> needed and whether 64-bit addressing is feasible or not.  We'd
Maciej> need two areas for I/O and four for memory (plus another one
Maciej> for the 40-bit HT address space).

Dual address cycles, ie. 64 bit addressing is fscked on the 1250 from
what I remember. Correct way to work around this is to stick all
physical memory outside the 32 bit space into ZONE_HIGHMEM - had a
patch for 2.4, but I lost it ages ago ;-(

One can just hope Broadcom will learn how to make chips some day ;-(

Regards,
Jes
