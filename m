Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jul 2008 13:37:56 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:26515 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20024964AbYGIMhg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 9 Jul 2008 13:37:36 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m699rQjr030350;
	Wed, 9 Jul 2008 10:58:47 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m699rORd030331;
	Wed, 9 Jul 2008 10:53:24 +0100
Date:	Wed, 9 Jul 2008 10:53:24 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Cc:	Shane McDonald <mcdonald.shane@gmail.com>,
	linux-mips@linux-mips.org
Subject: Re: [MIPS] Fix section mismatches when compiling atlas and
	decstation defconfigs
Message-ID: <20080709095324.GA29844@linux-mips.org>
References: <E1KFH2c-0005iq-80@localhost> <20080708184922.GA27245@linux-mips.org> <487468E2.30402@movial.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <487468E2.30402@movial.fi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 09, 2008 at 10:29:38AM +0300, Dmitri Vorobiev wrote:

> Ralf Baechle wrote:
> > On Sat, Jul 05, 2008 at 05:19:42PM -0600, Shane McDonald wrote:
> > 
> >> From: Shane McDonald <mcdonald.shane@gmail.com>
> >>
> >> Section mismatches are reported when compiling the default
> >> Atlas configuration and the default Decstation configuration.
> >> This patch resolves those mismatches by defining affected
> >> functions with the __cpuinit attribute, rather than __init.
> >>
> >> Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
> > 
> > I already had an earlier version of your patch applied so I have only
> > applied the c-r4k.c part now with an adjusted comment.
> 
> Isn't Atlas doomed to death?

Yes - but there is nothing in this patch that actually makes it Atlas or
DECstation specific.  It's simply fixing bugs in the CPU cache code.

  Ralf
