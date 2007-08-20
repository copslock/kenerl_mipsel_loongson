Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Aug 2007 17:30:20 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:63715 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021739AbXHTQaR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Aug 2007 17:30:17 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l7KGSfZt015268;
	Mon, 20 Aug 2007 17:28:42 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l7KGSer2015267;
	Mon, 20 Aug 2007 17:28:40 +0100
Date:	Mon, 20 Aug 2007 17:28:40 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Nicolas Schichan <nschichan@freebox.fr>
Cc:	Andrew Sharp <andy.sharp@onstor.com>, linux-mips@linux-mips.org
Subject: Re: kexec - not happening on mipsel?
Message-ID: <20070820162840.GA11771@linux-mips.org>
References: <20070808170846.7d395891@ripper.onstor.net> <200708101857.15567.nschichan@freebox.fr> <20070814094738.GC16958@linux-mips.org> <200708201557.38810.nschichan@freebox.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200708201557.38810.nschichan@freebox.fr>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 20, 2007 at 03:57:38PM +0200, Nicolas Schichan wrote:

> The updated patch only uses __flush_cache_all().

Applied, thanks.

> > There is a hazard barrier missing here.
> 
> Just for my culture, could you please specify which kind of barrier macro 
> should I use here ? should it be a back_to_back_c0_hazard() ?

According to the MIPS architecture, a mfc0 instruction that is immediately
following a mtc0 instruction where both are accessing the same cp0
register, has undefined operation.  Not all processors have this hazard and
for those those which have it the resolution before version 2 of the
architecture did differ between MIPS implementation.
back_to_back_c0_hazard() will solve this problem.  For example:

	write_c0_status(read_c0_status() & ~ ST0_BEV);
	write_c0_status(read_c0_status() | ST0_IE);

could possibly be compiled into such a mtc0 mfc0 sequence.  Throwing in a
back_to_back_c0_hazard() line will fix that.

	write_c0_status(read_c0_status() & ~ ST0_BEV);
	back_to_back_c0_hazard();
	write_c0_status(read_c0_status() | ST0_IE);

On a modern processor back_to_back_c0_hazard() will expand into a EHB,
on an antique to whatever serves the equivalent job.

Changing Config.K0 also creates an "instruction hazard".  Even when the
mtc0 has been graduated in the pipeline it needs to be ensured that no
instructions are being fetched and executed based on the old value.

My description is somewhat to short to be accurate, I suggest you read
up on it in the MIPS R2 architecture specification, See MIPS Run and of
course in the manual for your specific processor.

> Hoewever I so feel a bit unsafe now because D-Cache is not wrote-back and 
> I-Cache is not invalidated in relocate_kernel.S, before jumping to the new 
> kernel. This happens to work on my board, but I think that it is mostly 
> because of luck. Maybe using KSEG1 or XKPHYS (not sure about this one, I am 
> not familiar with 64bit mips) when fixing the indirection list addresses 
> should be safer.

KSEG1 would have the same issues as KSEG0 configured to uncached.

But really, why making things more complicated than required.  A flush
should do the trick.

Another open end in your patch would be SMP; normally Linux expects that
on bootup all processors are under firmware control but that is not the
case when a new kernel is initializing after being kexeced.

  Ralf
