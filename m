Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Oct 2004 20:15:26 +0100 (BST)
Received: from p508B6F76.dip.t-dialin.net ([IPv6:::ffff:80.139.111.118]:23315
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224872AbUJRTPV>; Mon, 18 Oct 2004 20:15:21 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i9IJF9Nl015602;
	Mon, 18 Oct 2004 21:15:09 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i9IJF8A0015601;
	Mon, 18 Oct 2004 21:15:08 +0200
Date: Mon, 18 Oct 2004 21:15:07 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Jes Sorensen <jes@wildopensource.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Manish Lachwani <mlachwani@mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH]PCI on SWARM
Message-ID: <20041018191507.GA14440@linux-mips.org>
References: <416DE31E.90509@mvista.com> <20041014191754.GB30516@linux-mips.org> <Pine.LNX.4.58L.0410142305380.25607@blysk.ds.pg.gda.pl> <416EFBAB.8050600@mvista.com> <Pine.LNX.4.58L.0410142327530.25607@blysk.ds.pg.gda.pl> <20041014225553.GA13597@linux-mips.org> <Pine.LNX.4.58L.0410150311370.25607@blysk.ds.pg.gda.pl> <yq0zn2ks9em.fsf@jaguar.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq0zn2ks9em.fsf@jaguar.mkp.net>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 18, 2004 at 04:44:17AM -0400, Jes Sorensen wrote:

> Dual address cycles, ie. 64 bit addressing is fscked on the 1250 from
> what I remember. Correct way to work around this is to stick all
> physical memory outside the 32 bit space into ZONE_HIGHMEM - had a patch
> for 2.4, but I lost it ages ago ;-(

The Momentum Jaguar suffers from similar problems, so I've implemented
that for Linux 2.6 as CONFIG_LIMITED_DMA.

> One can just hope Broadcom will learn how to make chips some day ;-(

Well, they've just done their homework, also known as the 1450.  Pick
your red pen and give grades ;-)

  Ralf
