Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Apr 2009 21:20:20 +0100 (BST)
Received: from pfepb.post.tele.dk ([195.41.46.236]:36534 "EHLO
	pfepb.post.tele.dk") by ftp.linux-mips.org with ESMTP
	id S20021879AbZDYUUM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 25 Apr 2009 21:20:12 +0100
Received: from ravnborg.org (x1-6-00-1e-2a-84-ae-3e.k225.webspeed.dk [80.163.61.94])
	by pfepb.post.tele.dk (Postfix) with ESMTP id B267EF8402F;
	Sat, 25 Apr 2009 22:20:11 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 500)
	id 5D0C0580D0; Sat, 25 Apr 2009 22:22:21 +0200 (CEST)
Date:	Sat, 25 Apr 2009 22:22:21 +0200
From:	Sam Ravnborg <sam@ravnborg.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [RFC PATCH] MIPS: move out Alchemy stuff to separate Makefile
Message-ID: <20090425202221.GB1104@uranus.ravnborg.org>
References: <20090424054128.GA7093@roarinelk.homelinux.net> <20090424060015.GA24625@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090424060015.GA24625@linux-mips.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 24, 2009 at 08:00:15AM +0200, Ralf Baechle wrote:
> On Fri, Apr 24, 2009 at 07:41:28AM +0200, Manuel Lauss wrote:
> 
> > Move Makefile information on all Alchemy boards to a separate file
> > in the arch subdir.
> > 
> > Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> > ---
> > Applies on top of my Alchemy-gpio patches;  builds and runs fine on a few
> > different alchemy systems.  It seems nicer to not have to modify the main
> > mips makefile when adding new alchemy boards. What do you all think?
> > 
> >  arch/mips/Makefile         |  104 +------------------------------------------
> >  arch/mips/alchemy/Makefile |  106 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 108 insertions(+), 102 deletions(-)
> >  create mode 100644 arch/mips/alchemy/Makefile
> 
> I think Sam Ravnbord has written something like the grand plan for the
> cleanup a few days ago; I append his mail below.

If Manuel or anyone else is willing to try it out then I will be happy to
help to get this working.
At least cc: me on the core patches.

PS - not subscribed to any mips releated list so I will not see the patches
unless they are sent to me, linux-kbuild or linux-kernel.

Thanks,
	Sam
