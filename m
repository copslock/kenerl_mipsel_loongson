Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Sep 2007 19:28:10 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:50102 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023886AbXISS2H (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 19 Sep 2007 19:28:07 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8JIS5lA018045;
	Wed, 19 Sep 2007 19:28:06 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8JIS4Ik018044;
	Wed, 19 Sep 2007 19:28:04 +0100
Date:	Wed, 19 Sep 2007 19:28:04 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	David Daney <ddaney@avtrex.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Richard Sandiford <rsandifo@nildram.co.uk>,
	GCC Mailing List <gcc@gcc.gnu.org>, linux-mips@linux-mips.org
Subject: Re: MIPS atomic memory operations (A.K.A PR 33479).
Message-ID: <20070919182804.GB14767@linux-mips.org>
References: <46F06980.4080500@avtrex.com> <20070919165809.GA14767@linux-mips.org> <Pine.LNX.4.64N.0709191759361.24627@blysk.ds.pg.gda.pl> <46F15BB3.50107@avtrex.com> <Pine.LNX.4.64N.0709191836140.24627@blysk.ds.pg.gda.pl> <46F16142.1090600@avtrex.com> <20070919181233.GR9972@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070919181233.GR9972@networkno.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 19, 2007 at 07:12:33PM +0100, Thiemo Seufer wrote:

> >>  Another option is to depend on the setting of -mbranch-likely.  By 
> >> default it is on only for the processors which implement it and do not 
> >> discourage it, i.e. these of the MIPS II, MIPS III and MIPS IV ISAs.

All MIPS implementations that have branch likely also support it with
good performance.  So the deprecation is atm really something that has
happened on paper.

The approach for LL/SC loops (where it's used for correctness) and the rest
of the code where we care about code size and performance is not necessarily
the same.

> > This seems to be the most sensible option.
> >
> > I will try to work up the GCC patch tonight.
> 
> This means generic MIPS code (MIPS I) wil have broken atomic
> intrinsics when run on modern MIPS machines.

Oh and if it takes adding new emulations for SYNC (some pseudo MIPS II
implementations lack SYNC afair) or branch likely to the kernel I will
certainly support that.

  Ralf
