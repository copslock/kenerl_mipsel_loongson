Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 May 2006 14:50:57 +0200 (CEST)
Received: from nevyn.them.org ([66.93.172.17]:14796 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8133520AbWEJMut (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 May 2006 14:50:49 +0200
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1Fdo9L-0000hz-0e; Wed, 10 May 2006 08:50:43 -0400
Date:	Wed, 10 May 2006 08:50:42 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] use generic DWARF_DEBUG
Message-ID: <20060510125042.GA2666@nevyn.them.org>
References: <20060510.153604.82350680.nemoto@toshiba-tops.co.jp> <20060510071937.GA7813@networkno.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060510071937.GA7813@networkno.de>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Wed, May 10, 2006 at 08:19:37AM +0100, Thiemo Seufer wrote:
> Atsushi Nemoto wrote:
> > When debugging a kernel compiled by gcc 4.1 with gdb 6.4, gdb could
> > not show filename, linenumber, etc.  It seems fixed if I used generic
> > DWARF_DEBUG macro.  Although gcc 3.x seems work without this change,
> > it would be better to use the generic macro unless there were
> > something MIPS specific.
> 
> There was something MIPS specific for n64 (DWARF64) uuntil very
> recently. GCC HEAD switched n64 Linux to DWARF32 some days ago.

Shouldn't affect this.  What Atsushi is deleting are sections for DWARF
_1_, not DWARF _2_; that's ancient history.  I don't know why they need
to be listed at all, though; I've never had a problem, and orphan
placement ought to take care of it.

-- 
Daniel Jacobowitz
CodeSourcery
