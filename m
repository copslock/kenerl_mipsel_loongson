Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2007 19:31:13 +0100 (BST)
Received: from ns2.suse.de ([195.135.220.15]:29636 "EHLO mx2.suse.de")
	by ftp.linux-mips.org with ESMTP id S20026465AbXJDSbG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2007 19:31:06 +0100
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 3B02622EBC;
	Thu,  4 Oct 2007 20:30:00 +0200 (CEST)
To:	"Steven J. Hill" <sjhill@realitydiluted.com>
Cc:	veerasena reddy <veerasena_b@yahoo.co.in>,
	linux-mips <linux-mips@linux-mips.org>,
	"linux-kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: unresoved symbol _gp_disp
References: <230962.51223.qm@web8408.mail.in.yahoo.com>
	<20071004173928.GA32033@real.realitydiluted.com>
From:	Andi Kleen <andi@firstfloor.org>
Date:	04 Oct 2007 20:29:59 +0200
In-Reply-To: <20071004173928.GA32033@real.realitydiluted.com>
Message-ID: <p73k5q268d4.fsf@bingen.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <ak@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andi@firstfloor.org
Precedence: bulk
X-list: linux-mips

"Steven J. Hill" <sjhill@realitydiluted.com> writes:

> > I have written a loadble module ( which gets complied
> > along with kernel) which does some floating point
> > operation.
> >  
> NO FLOATING POINT in the kernel PERIOD. Either use integer
> operations, or redo your software architecture and do the
> floating point in userspace.

You can use floating point; you just have to make sure to 
save the FP context explicitely and disable preemption. Details
on how to do this vary by architecture.

The problem is that FP code typically takes often a lot of CPU time
and it is quite antisocial to disable preemption for a long time
because that impacts real time latency for everybody.

Besides many uses can be relatively easily rewritten to fixed
point.

-Andi
