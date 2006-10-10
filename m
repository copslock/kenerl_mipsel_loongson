Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Oct 2006 22:53:41 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:5026 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027541AbWJJVxj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Oct 2006 22:53:39 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k9ALpbSv021240;
	Tue, 10 Oct 2006 22:51:59 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k9ALpOwm021239;
	Tue, 10 Oct 2006 22:51:24 +0100
Date:	Tue, 10 Oct 2006 22:51:24 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ths@networkno.de,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] setup.c: introduce __pa_symbol() and get ride of CPHYSADDR()
Message-ID: <20061010215124.GA21012@linux-mips.org>
References: <452BA4E7.30901@innova-card.com> <20061010.231944.42203018.anemo@mba.ocn.ne.jp> <452BB5E1.5090308@innova-card.com> <20061011.002914.76462350.anemo@mba.ocn.ne.jp> <452BC4A5.3080706@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452BC4A5.3080706@innova-card.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 10, 2006 at 06:04:53PM +0200, Franck Bui-Huu wrote:

> ok, and does the trick on KSEG0/XKPHYS really worth ? I mean what is
> the size code gain ?

Gcc / gas generate a 6 instruction sequence to load something from a
64-bit address, basically lui, add, dsll16, add, dsll16, add.  It's
just 2 instructions for 32-bit addresses.  This boils down to space
savings in the hundred of kilobytes for a kernel.

Of course there are more intelligent way to load an address via global
pointer optimization but that's the two choices we got today.

  Ralf
