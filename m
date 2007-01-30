Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jan 2007 15:18:47 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:21130 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038527AbXA3PSq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 30 Jan 2007 15:18:46 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l0UFIhnU032527;
	Tue, 30 Jan 2007 15:18:43 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l0UFIgrC032526;
	Tue, 30 Jan 2007 15:18:42 GMT
Date:	Tue, 30 Jan 2007 15:18:42 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	macro@linux-mips.org, dan@debian.org, vagabon.xyz@gmail.com,
	linux-mips@linux-mips.org
Subject: Re: RFC: Sentosa boot fix
Message-ID: <20070130151841.GA31405@linux-mips.org>
References: <cda58cb80701290806p5d68ba5ck5e3e3b2b3490126f@mail.gmail.com> <20070129161450.GA3384@nevyn.them.org> <Pine.LNX.4.64N.0701291833480.26916@blysk.ds.pg.gda.pl> <20070130.234537.126574565.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070130.234537.126574565.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 30, 2007 at 11:45:37PM +0900, Atsushi Nemoto wrote:

> On Mon, 29 Jan 2007 18:47:12 +0000 (GMT), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> >  I have BUILD_ELF64 enabled for my SWARM configuration and I do not plan 
> > to change it.  If there is a bug in the definition of __pa_page_offset() 
> > for such a setup it should be fixed indeed.
> 
> Though I do not object to remove "&& !defined(CONFIG_BUILD_ELF64)"
> from __pa_page_offset(), are there any point of CONFIG_BUILD_ELF64=y
> if your load address was CKSEG0?

Code in CKSEG0 allows shorter a shorter code sequence for address loads.
Yet some machines such as IP27 require 64-bit ELF for booting.

  Ralf
