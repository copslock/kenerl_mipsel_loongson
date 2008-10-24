Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 22:41:09 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:21183 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22318548AbYJXVlB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Oct 2008 22:41:01 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9OLexmJ000674;
	Fri, 24 Oct 2008 22:40:59 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9OLewEL000673;
	Fri, 24 Oct 2008 22:40:58 +0100
Date:	Fri, 24 Oct 2008 22:40:58 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	linux-mips@linux-mips.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] TXx9: Add TX4938 ATA support (v2)
Message-ID: <20081024214057.GJ25297@linux-mips.org>
References: <20081023.011646.51867355.anemo@mba.ocn.ne.jp> <200810232206.50973.bzolnier@gmail.com> <4900F8DE.4070203@ru.mvista.com> <200810242252.25327.bzolnier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200810242252.25327.bzolnier@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 24, 2008 at 10:52:25PM +0200, Bartlomiej Zolnierkiewicz wrote:

> > > applied
> > >   
> > 
> >    Hm, I thought that one was for Ralf...
> 
> Ralf ACK-ed the change and was fine with it going through ide tree.
> 
> Anyway it really doesn't matter through whose tree such patches are
> going in as long as people are fine with them.
> 

To explain why - there were no ordering constraints but it's always nice
if all bits make it to kernel.org in one pull.  The arch part was rather
minor compared to the IDE part so this should preferably go through the
IDE tree.

> No need to add some more rigid kernel bureaucracy...

Wildy-acked-by: Ralf Baechle <ralf@linux-mips.org> :-)

  Ralf
