Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Feb 2009 14:07:55 +0000 (GMT)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:51369 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20808781AbZB0OHw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 27 Feb 2009 14:07:52 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n1RE7nrs028498;
	Fri, 27 Feb 2009 14:07:49 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n1RE7mZ1028496;
	Fri, 27 Feb 2009 14:07:48 GMT
Date:	Fri, 27 Feb 2009 14:07:48 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 06/14] MIPS: print irq handler description
Message-ID: <20090227140748.GA28473@linux-mips.org>
References: <caebb02f97491d8e5830438e1a746b0e02fa2c7c.1229846411.git.mano@roarinelk.homelinux.net> <80cf5c7a0db39a7230bae7766264acbfc68d200e.1229846412.git.mano@roarinelk.homelinux.net> <e6862a9acc480a4f00d0b7ae738e8a355a7e4810.1229846412.git.mano@roarinelk.homelinux.net> <ac2064c64b746420a21008fa4e9e7c4ecf048d7a.1229846413.git.mano@roarinelk.homelinux.net> <dc79b2a4d9da426f867de084c75940109eff1287.1229846413.git.mano@roarinelk.homelinux.net> <535458cb8c8f570089b2712a1e73ca7314d5b7c7.1229846413.git.mano@roarinelk.homelinux.net> <496F90AA.7070407@caviumnetworks.com> <20090115194921.GB8656@roarinelk.homelinux.net> <496F9579.7050300@caviumnetworks.com> <20090115202210.GC8656@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090115202210.GC8656@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 15, 2009 at 09:22:10PM +0100, Manuel Lauss wrote:

> On Thu, Jan 15, 2009 at 11:58:49AM -0800, David Daney wrote:
> > Manuel Lauss wrote:
> > [...]
> >> Or how about this?
> > [...]  		seq_printf(p, " %14s", irq_desc[i].chip->name);
> >> -		seq_printf(p, "-%-8s", irq_desc[i].name);
> >> +		if (irq_desc[i].name)
> >> +			seq_printf(p, "-%-8s", irq_desc[i].name);
> >>  		seq_printf(p, "  %s", action->name);
> >
> > I will let you and Ralf decide.  However it would be nice if action->name 
> > lined up with a mixture of NULL and non-NULL irq_desc[i].name.  It is not 
> > clear to me if this is the case with your patch.
> 
> Good point, no it's not the case unfortunately; the gap between
> the controller and irq names becomes unaesthetically wide.
> 
> So please revert the patch.

Done.

  Ralf
