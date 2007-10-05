Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Oct 2007 11:52:15 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:18821 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027168AbXJEKwN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 5 Oct 2007 11:52:13 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l95AqBdP002216;
	Fri, 5 Oct 2007 11:52:11 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l95Aq9Uk002215;
	Fri, 5 Oct 2007 11:52:09 +0100
Date:	Fri, 5 Oct 2007 11:52:09 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andi Kleen <andi@firstfloor.org>
Cc:	"Steven J. Hill" <sjhill@realitydiluted.com>,
	veerasena reddy <veerasena_b@yahoo.co.in>,
	linux-mips <linux-mips@linux-mips.org>,
	"linux-kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: unresoved symbol _gp_disp
Message-ID: <20071005105209.GB1404@linux-mips.org>
References: <230962.51223.qm@web8408.mail.in.yahoo.com> <20071004173928.GA32033@real.realitydiluted.com> <p73k5q268d4.fsf@bingen.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73k5q268d4.fsf@bingen.suse.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16865
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 04, 2007 at 08:29:59PM +0200, Andi Kleen wrote:
> From: Andi Kleen <andi@firstfloor.org>
> Date: 04 Oct 2007 20:29:59 +0200
> To: "Steven J. Hill" <sjhill@realitydiluted.com>
> Cc: veerasena reddy <veerasena_b@yahoo.co.in>,
> 	linux-mips <linux-mips@linux-mips.org>,
> 	"linux-kernel.org" <linux-kernel@vger.kernel.org>
> Subject: Re: unresoved symbol _gp_disp
> Content-Type: text/plain; charset=us-ascii
> 
> "Steven J. Hill" <sjhill@realitydiluted.com> writes:
> 
> > > I have written a loadble module ( which gets complied
> > > along with kernel) which does some floating point
> > > operation.
> > >  
> > NO FLOATING POINT in the kernel PERIOD. Either use integer
> > operations, or redo your software architecture and do the
> > floating point in userspace.
> 
> You can use floating point; you just have to make sure to 
> save the FP context explicitely and disable preemption. Details
> on how to do this vary by architecture.
> 
> The problem is that FP code typically takes often a lot of CPU time
> and it is quite antisocial to disable preemption for a long time
> because that impacts real time latency for everybody.
> 
> Besides many uses can be relatively easily rewritten to fixed
> point.

He said he was using software floating point which from a kernel perspective
really just is integer stuff anyway.

Hardware floating point in a MIPS kernel would be require solving a few
interesting problems; the kernel floating point assist software is only
designed to support userspace.  Or alternativle well written FP code
that avoids all the corner cases which would normally be handled by the
kernel fp software.

The biggest argument against floating point use in the kernel is that most
of the time it's an indicator for poor division of work between kernel
and userspace.

  Ralf
