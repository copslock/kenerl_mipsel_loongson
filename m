Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Mar 2004 21:19:20 +0000 (GMT)
Received: from p508B7AB1.dip.t-dialin.net ([IPv6:::ffff:80.139.122.177]:41087
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225377AbUCRVTU>; Thu, 18 Mar 2004 21:19:20 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i2ILJDMk030073;
	Thu, 18 Mar 2004 22:19:13 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i2ILJAiZ030072;
	Thu, 18 Mar 2004 22:19:10 +0100
Date: Thu, 18 Mar 2004 22:19:10 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Dominic Sweetman <dom@mips.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Eric Christopher <echristo@redhat.com>,
	Long Li <long21st@yahoo.com>, linux-mips@linux-mips.org,
	David Ung <davidu@mips.com>, Nigel Stephens <nigel@mips.com>
Subject: Re: gcc support of mips32 release 2
Message-ID: <20040318211910.GB25815@linux-mips.org>
References: <20040305075517.42647.qmail@web40404.mail.yahoo.com> <1078478086.4308.14.camel@dzur.sfbay.redhat.com> <16456.21112.570245.1011@arsenal.mips.com> <Pine.LNX.4.55.0403181404210.5750@jurand.ds.pg.gda.pl> <16473.44507.935886.271157@arsenal.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16473.44507.935886.271157@arsenal.mips.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 18, 2004 at 02:10:35PM +0000, Dominic Sweetman wrote:

> Of course, instructions still have to be *useful* to be added.
> Insert/extract make a reasonable case for themselves, but actually
> arrived in MIPS32 release 2 as part of a bunch of other bit-shuffle
> instructions (also includes rotates and various byte-swaps) which -
> together - help quite a bit to manipulate sub-word data in registers.

And in some case where MIPS such as certain crypto algorithms where MIPS
and RISCs used to look rather pale the new instructions will help
significantly.

  Ralf
