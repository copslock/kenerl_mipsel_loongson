Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Apr 2009 13:38:22 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:4287 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20031292AbZDRMiS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 18 Apr 2009 13:38:18 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n3ICcGZm021342;
	Sat, 18 Apr 2009 14:38:16 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n3ICcFmC021340;
	Sat, 18 Apr 2009 14:38:15 +0200
Date:	Sat, 18 Apr 2009 14:38:15 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Joseph S. Myers" <joseph@codesourcery.com>
Cc:	"Maciej W. Rozycki" <macro@codesourcery.com>,
	linux-mips@linux-mips.org, libc-ports@sourceware.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
Message-ID: <20090418123815.GA21240@linux-mips.org>
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk> <Pine.LNX.4.64.0904152018070.3560@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0904152018070.3560@digraph.polyomino.org.uk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 15, 2009 at 08:19:33PM +0000, Joseph S. Myers wrote:

> >  Here is code to implement the getcontext API for MIPS.  This glibc patch 
> > is sent to the linux-mips mailing list, because it makes use of an 
> > internal syscall which has not been designated as a part of the public 
> > ABI.  I am writing to request this syscall to become fixed as a part of 
> > the ABI or to seek for an alternative.  See below for the rationale.
> 
> Was there any conclusion about whether the assumptions this patch makes 
> about the kernel are OK (and so it can go in) or not?

I've probably not spelled it out clearly enough in an earlier email on
this topic but yes, I think it's ok.  In all reality the stackframe has
de facto become a part of the ABI that needs to be kept stable.

  Ralf
