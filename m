Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jul 2009 12:56:22 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42696 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491955AbZGBK4O (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Jul 2009 12:56:14 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n62AoOIV007722;
	Thu, 2 Jul 2009 11:50:24 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n62AoOLU007720;
	Thu, 2 Jul 2009 11:50:24 +0100
Date:	Thu, 2 Jul 2009 11:50:24 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org,
	Pavel Machek <pavel@ucw.cz>
Subject: Re: [BUG] MIPS: Hibernation in the latest linux-mips:master branch
	not work
Message-ID: <20090702105024.GD14804@linux-mips.org>
References: <1246372868.19049.17.camel@falcon> <20090630144540.GA18212@linux-mips.org> <1246374687.20482.10.camel@falcon> <20090701180715.GA23121@linux-mips.org> <1246496647.9660.46.camel@falcon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1246496647.9660.46.camel@falcon>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 02, 2009 at 09:04:07AM +0800, Wu Zhangjin wrote:

> > > hi, ralf, in the latest master branch of linux-mips git repo, seems
> > > there is a need to select the SYS_SUPPORTS_HOTPLUG_CPU option in every
> > > uni-processor board, otherwise, the suspend/hibernation can not be used,
> > > because you have set:
> > > 
> > > config ARCH_HIBERNATION_POSSIBLE
> > >     def_bool y
> > >     depends on SYS_SUPPORTS_HOTPLUG_CPU
> > > 
> > > config ARCH_SUSPEND_POSSIBLE
> > >     def_bool y
> > >     depends on SYS_SUPPORTS_HOTPLUG_CPU
> > > 
> > > so, the board-specific patch must be pushed by the maintainers of
> > > boards. and if the board support SMP, they must implement the
> > > mips-specific hotplug support, is this right? I have selected
> > > SYS_SUPPORTS_HOTPLUG_CPU in LEMOTE_FULONG and will push a relative patch
> > > later.
> > 
> > I think below patch should take care of this problem.  It simply assumes
> > that all uniprocessor systems support suspend and hibernate.  That's an
> > assumption that I'm not to unhappy with though it may force us to fix a
> > few systems.
> > 
> 
> This patch is better.
> 
> Thanks!
> Wu Zhangjin

Thanks, patch applied.

You're welcome!

  Ralf
