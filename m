Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2007 18:52:50 +0100 (BST)
Received: from wf1.mips-uk.com ([194.74.144.154]:27580 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027213AbXFGRws (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Jun 2007 18:52:48 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l57HlncP003262;
	Thu, 7 Jun 2007 18:47:49 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l57Hlndu003261;
	Thu, 7 Jun 2007 18:47:49 +0100
Date:	Thu, 7 Jun 2007 18:47:49 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] No I/O ports on the DECstation
Message-ID: <20070607174749.GB1893@linux-mips.org>
References: <Pine.LNX.4.64N.0705291505370.14456@blysk.ds.pg.gda.pl> <20070531121521.GE28936@linux-mips.org> <Pine.LNX.4.64N.0705311359250.7856@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0705311359250.7856@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 31, 2007 at 02:21:11PM +0100, Maciej W. Rozycki wrote:

> > Stale patch?
> 
>  Not at all, it would seem.  It applies just fine and is still required as 
> of 2.6.22-rc3.  These CONFIG_HAS_IOMEM and CONFIG_HAS_IOPORT options are 
> pretty recent anyway -- there is little chance for anything about them to 
> get stale yet.

Git is pickier than patch.  Anything that will still be applied by patch
with a fuzz will be rejected by git-apply.  For good reason, I several
times ended with a corrupt tree thanks to patch happily (miss-)applying
some stale patch with fuzz.  Heck, it hit akpm recently ...

Anyway, this one was trivial and is in my queue tree now.

  Ralf
