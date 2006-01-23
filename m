Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 16:09:41 +0000 (GMT)
Received: from bender.bawue.de ([193.7.176.20]:27090 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S3465592AbWAWQJU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Jan 2006 16:09:20 +0000
Received: from localhost (unknown [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 91F1E460ED; Mon, 23 Jan 2006 17:13:30 +0100 (MET)
Received: from ths by localhost with local (Exim 4.60)
	(envelope-from <ths@networkno.de>)
	id 1F14JZ-0004wz-UM; Mon, 23 Jan 2006 16:13:09 +0000
Date:	Mon, 23 Jan 2006 16:13:09 +0000
To:	"P. Christeas" <p_christ@hol.gr>
Cc:	MIPS Linux List <linux-mips@linux-mips.org>
Subject: Re: Fixes for uaccess.h with gcc >= 4.0.1
Message-ID: <20060123161309.GA13459@networkno.de>
References: <20060123150507.GA18665@linux-mips.org> <200601231718.40581.p_christ@hol.gr> <20060123153715.GC18665@linux-mips.org> <200601231750.55246.p_christ@hol.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601231750.55246.p_christ@hol.gr>
User-Agent: Mutt/1.5.11
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

On Mon, Jan 23, 2006 at 05:50:53PM +0200, P. Christeas wrote:
> On Monday 23 January 2006 5:37 pm, Ralf Baechle wrote:
> > On Mon, Jan 23, 2006 at 05:18:38PM +0200, P. Christeas wrote:
> > > On Monday 23 January 2006 5:05 pm, Ralf Baechle wrote:
> > > > I'd appreciate if somebody with gcc 4.0.1 could test this kernel patch
> > > > below.
> > > >
> > > >   Ralf
> > >
> > > Is that for 2.4?
> >
> > 2.4 is a no go for all architectures with gcc >= 4.0.0 and in case of MIPS
> > even gcc 3.4 is somewhat dubious.
> >
> > > 2.6 doesn't seem to have that problem..
> >
> > It's probably a matter of configuration then.  Basically with our current
> > uaccess.h and gcc >= 4.0.1 the attempt to pass a pointer to a const
> > variable as the pointer argument to get_user or __get_user will blow up.
> > It's always been a bug - but gcc before 4.0.1 were accepting this
> > silently.
> >
> >   Ralf
> 
> I 've been compiling with gcc 4.0.2 (my tree is Linus') and haven't seen any 
> message like that.

The case I saw happened for 32bit compat ioctls in a 64bit kernel.

> It all compiles fine. Is there a point in testing your 
> patch as well?

Well, if you want to be sure it doesn't break your system...


Thiemo
