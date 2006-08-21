Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Aug 2006 15:45:51 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:9154 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S20037547AbWHUOpt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 21 Aug 2006 15:45:49 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.7/8.13.4) with ESMTP id k7LEk637019160;
	Mon, 21 Aug 2006 15:46:06 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k7LEk6Up019159;
	Mon, 21 Aug 2006 15:46:06 +0100
Date:	Mon, 21 Aug 2006 15:46:06 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	macro@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] qemu does not have dcache aliases
Message-ID: <20060821144605.GA19032@linux-mips.org>
References: <20060820.003338.25478178.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64N.0608211340120.17504@blysk.ds.pg.gda.pl> <20060821.225910.108307053.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821.225910.108307053.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 21, 2006 at 10:59:10PM +0900, Atsushi Nemoto wrote:

> On Mon, 21 Aug 2006 13:45:03 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> >  Hmm, it looks like a bug in QEMU -- we should definitely implement them!
> 
> Well, the QEMU cpu has 2-way 2kB dcache... does not have aliasing
> anyway. :-)
> 
> Or we can just remove cpu_has_dc_aliases from the file and use generic
> definition.

The CPU emulated by Qemu might change eventually so I think this is
preferable.

  Ralf
