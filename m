Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Dec 2007 15:35:43 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:18831 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024672AbXLJPfl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Dec 2007 15:35:41 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lBAFZNpI019476;
	Mon, 10 Dec 2007 15:35:24 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lBAFZNm5019475;
	Mon, 10 Dec 2007 15:35:23 GMT
Date:	Mon, 10 Dec 2007 15:35:23 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Kaz Kylheku <kaz@zeugmasystems.com>, linux-mips@linux-mips.org
Subject: Re: SiByte 1480 & Branch Likely instructions?
Message-ID: <20071210153523.GA19384@linux-mips.org>
References: <DDFD17CC94A9BD49A82147DDF7D545C5590CF0@exchange.ZeugmaSystems.local> <20071209051450.GA18181@linux-mips.org> <Pine.LNX.4.64N.0712101522100.1177@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0712101522100.1177@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 10, 2007 at 03:28:52PM +0000, Maciej W. Rozycki wrote:

> > > Not really a kernel-related question. I've discovered that GCC 4.1.1
> > > (which I'm not using for kernel compiling, but user space) generates
> > > branch likely instructions by default, even though the documentation
> > > says that their use is off by default for MIPS32 and MIPS64, because
> > > they are considered deprecated. They are documented as obsolete for the
> > > Broadcom chips I am working with.
> > 
> > Microarchitecture guys love to hate branch likely.  But the deprecation is
> > a dream.  Binary compatibility will always require those instructions to
> > continue to exist so the genie is out of the bottle and so I feel very
> > certain to predict that a future MIPS 3 specification will contain branch
> > likely.
> 
>  We have been there before -- binary compatibility does not preclude 
> emulation.  And I do not mean keeping the MIPS I toys (as they might be 
> seen these days) running, but serious products deployed commercially, like 
> newer VAX implementations that kept full binary compatibility with their 
> predecessors in the area of the some of the more arcane instructions only 
> by means of emulating them in the OS.

It would devastate the performance of some binaries.

As an intellectual challenge, how far can you strip down a MIPS
implementation and emulate removed instructions in the kernel ;-)

  Ralf
