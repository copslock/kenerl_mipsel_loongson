Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 17:05:44 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:56978 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022909AbXJYQFm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Oct 2007 17:05:42 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9PG5Uah024677;
	Thu, 25 Oct 2007 17:05:30 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9PG5TRh024676;
	Thu, 25 Oct 2007 17:05:29 +0100
Date:	Thu, 25 Oct 2007 17:05:29 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Sam Ravnborg <sam@ravnborg.org>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [IDE] Fix build bug
Message-ID: <20071025160529.GB24621@linux-mips.org>
References: <20071025135334.GA23272@linux-mips.org> <20071025141305.GA11698@uranus.ravnborg.org> <Pine.LNX.4.64N.0710251545300.24086@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0710251545300.24086@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 25, 2007 at 03:47:16PM +0100, Maciej W. Rozycki wrote:

> > So we can avoid this if we invent a __constinitdata tag that uses
> > a new section?
> 
>  That would do.
> 
> > I ask mainly to understand this error - not that I am that found
> > of the idea.
> 
>  Somebody wants to mix up read-only and read/write data in the same 
> section and GCC quite legitimately complains about it.  You cannot have 
> both at a time.

My interpretation is that it would be perfectly ok for a C compiler to
do minimal handling of const by only throwing errors for attempted
assignments to const objects but otherwise treating them as if they
were non-const, that is for example putting them into an r/w section.

  Ralf
