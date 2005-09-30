Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Sep 2005 17:10:20 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:59409 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465585AbVI3QKB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Sep 2005 17:10:01 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j8UG9rCQ014050;
	Fri, 30 Sep 2005 17:09:53 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j8UG9qfL014049;
	Fri, 30 Sep 2005 17:09:52 +0100
Date:	Fri, 30 Sep 2005 17:09:52 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] minor fix in asm-mips/module.h
Message-ID: <20050930160952.GB13616@linux-mips.org>
References: <cda58cb8050926000665f843dc@mail.gmail.com> <20050926115539.GB3175@linux-mips.org> <cda58cb805092605057f7cad7d@mail.gmail.com> <20050929234542.GB3983@linux-mips.org> <cda58cb80509300536q42e9ddd4q@mail.gmail.com> <20050930130928.GA3083@linux-mips.org> <cda58cb80509300844v5181d6fey@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80509300844v5181d6fey@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 30, 2005 at 05:44:01PM +0200, Franck wrote:

> > > 2005/9/30, Ralf Baechle <ralf@linux-mips.org>:
> > > > There are no CONFIG_CPU_4KSC and CONFIG_CPU_4KSD configuration options.
> > > > Did you really create this patch against the linux module of the CVS
> > > > repository or was it a different tree?
> > > >
> > >
> > > The patch was created against linux-mips CVS repository. I added 4KSC
> > > and 4KSD support in this tree. I thougth seeing reference of 4KSC
> > > somewhere. Anyway, if you don't want to include them in your tree
> > > that's ok.
> >
> > It's just that references to CONFIG_* symbols that are being defined
> > nowhere don't make sense.  If however you want to contribute improved
> > support for these processors, by all means I'm certainly going to appreciate
> > a patch!
> >
> 
> I'm surprised you're interested in added support for 4KSC and 4KSD
> cpu...Anyway I could send a trivial patch to you if so.

Yes, some people do strange things with Linux :-)

  Ralf
