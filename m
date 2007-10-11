Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Oct 2007 15:00:30 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:34515 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021626AbXJKOA2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Oct 2007 15:00:28 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9BE0Rvv005913;
	Thu, 11 Oct 2007 15:00:27 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9BE06gE005901;
	Thu, 11 Oct 2007 15:00:06 +0100
Date:	Thu, 11 Oct 2007 15:00:06 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC] Add __initbss section
Message-ID: <20071011140006.GA2828@linux-mips.org>
References: <470DF25E.60009@gmail.com> <20071011124410.GA17202@linux-mips.org> <Pine.LNX.4.64N.0710111420030.16370@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0710111420030.16370@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 11, 2007 at 02:35:20PM +0100, Maciej W. Rozycki wrote:

> > I think gcc should probably put the jump table into a .subsection if
> > a section was explicitly requested, at least for non-PIC code.
> 
>  Has anybody filed a bug report?  The GCC maintainers may well not be 
> aware of the problem and some arcane ways of use exercised by Linux.

Beofore applying the previously mentioned fixes I spoke to them but they
were not very inclined to consider the gcc behaviour a bug.

  Ralf
