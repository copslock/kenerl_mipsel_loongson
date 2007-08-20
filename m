Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Aug 2007 15:56:29 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:2283 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021662AbXHTO41 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Aug 2007 15:56:27 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l7KEsokV012675;
	Mon, 20 Aug 2007 15:54:51 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l7KEsnDc012674;
	Mon, 20 Aug 2007 15:54:49 +0100
Date:	Mon, 20 Aug 2007 15:54:49 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	Carl van Schaik <carl@ok-labs.com>, linux-mips@linux-mips.org
Subject: Re: TLS register for NPTL
Message-ID: <20070820145449.GA11766@linux-mips.org>
References: <46C93BB5.9050809@ok-labs.com> <20070820080627.GF4479@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070820080627.GF4479@networkno.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 20, 2007 at 09:06:27AM +0100, Thiemo Seufer wrote:

> > It seems the rdhwr emulation is used/proposed for accessing the thread
> > word in NPTL.
> > I've been reading some of the posts from 2005 about this choice of this
> > and what I have missed is anyone talking about using the "k0" register
> > for TLS. It seems logical that the kernel could always restore k0 on
> > returning to user-land and having k1 only for the last part of returning
> > to user is sufficient. Any reason why this was not looked at?
> 
> The TLB handlers need k0/k1 as well and have no good place to save/restore
> a register.

It can be done but would require several extra instructions in the most
performance sensitive parts of the OS.

Aside, latest MIPS processors support a hardware implementation of rdhwr $29,
so there is no more emulation overhead for this instruction at full binary
compatibility.

  Ralf
