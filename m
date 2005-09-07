Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Sep 2005 14:40:44 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:46087 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225250AbVIGNkX>; Wed, 7 Sep 2005 14:40:23 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j87DlJ1O012197;
	Wed, 7 Sep 2005 14:47:19 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j87DlHR7012196;
	Wed, 7 Sep 2005 14:47:17 +0100
Date:	Wed, 7 Sep 2005 14:47:17 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: unkillable process due to setup_frame() failure
Message-ID: <20050907134717.GA3493@linux-mips.org>
References: <20050907.014234.108739386.anemo@mba.ocn.ne.jp> <20050906184118.GC3102@linux-mips.org> <Pine.LNX.4.61L.0509071011560.4591@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0509071011560.4591@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 07, 2005 at 10:14:16AM +0100, Maciej W. Rozycki wrote:

> > > So, the process can not be kill by SIGKILL.  In 2.6.12, 'sigkill
> > > priority fix' was applied to __dequeue_signal(), but it does not help
> > > while the SIGTRAP is queued to tsk->pending but SIGKILL (by kill
> > > command) is queued to tsk->signal->shared_pending.
> > 
> > The behaviour of not advancing the EPC beyond the faulting instruction is
> > part of the problem - but I believe that was the usual behaviour for
> > MIPS UNIXoid operating systems.
> 
>  Well, SIGKILL should always work and frankly I can't see a reason to 
> return back to user space in the affected context in the first place.  
> What's left in EPC shouldn't matter.

I said it's part of the problem - not that it should be changed.  The
behaviour as far as I can say is also standard for MIPS unixoid operating
systems.  That said, I definately prefer the approach of Atushi's suggested
fix #2.  The other question is why we try to continue if delivering a
signal failed and we already know that repeated attempts would fail again.

  Ralf
