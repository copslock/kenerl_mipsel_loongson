Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2004 12:18:00 +0100 (BST)
Received: from p508B6D7E.dip.t-dialin.net ([IPv6:::ffff:80.139.109.126]:11570
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225228AbUJTLRz>; Wed, 20 Oct 2004 12:17:55 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i9KBHnWt024920;
	Wed, 20 Oct 2004 13:17:49 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i9KBHnZR024919;
	Wed, 20 Oct 2004 13:17:49 +0200
Date: Wed, 20 Oct 2004 13:17:49 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Jes Sorensen <jes@wildopensource.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Manish Lachwani <mlachwani@mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH]PCI on SWARM
Message-ID: <20041020111749.GB24808@linux-mips.org>
References: <416DE31E.90509@mvista.com> <20041014191754.GB30516@linux-mips.org> <Pine.LNX.4.58L.0410142305380.25607@blysk.ds.pg.gda.pl> <416EFBAB.8050600@mvista.com> <Pine.LNX.4.58L.0410142327530.25607@blysk.ds.pg.gda.pl> <20041014225553.GA13597@linux-mips.org> <Pine.LNX.4.58L.0410150311370.25607@blysk.ds.pg.gda.pl> <yq0zn2ks9em.fsf@jaguar.mkp.net> <Pine.LNX.4.58L.0410182042010.12159@blysk.ds.pg.gda.pl> <yq0lle2rkxb.fsf@jaguar.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq0lle2rkxb.fsf@jaguar.mkp.net>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 20, 2004 at 01:57:36AM -0400, Jes Sorensen wrote:

> Yeah it seems to be documented, it's highly unfortunate that anybody
> will release a chip which doesn't support DAC but will support memory
> outside the 4GB range. I'd be highly embarrassed if I had done the
> chip, but thats just me.

The memory map which apparently has been created with a shotgun
aggrevates the problem ...

  Ralf
