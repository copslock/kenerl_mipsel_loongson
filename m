Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2007 12:25:54 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:38048 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021942AbXJJLZw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Oct 2007 12:25:52 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9ABPpH7005971;
	Wed, 10 Oct 2007 12:25:51 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9ABPpjV005970;
	Wed, 10 Oct 2007 12:25:51 +0100
Date:	Wed, 10 Oct 2007 12:25:51 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:	Andrew Sharp <andy.sharp@onstor.com>, linux-mips@linux-mips.org
Subject: Re: paging problem with ide-cs driver
Message-ID: <20071010112550.GA1780@linux-mips.org>
References: <20071009132657.64ec9158@ripper.onstor.net> <20071009220530.0416792b@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071009220530.0416792b@the-village.bc.nu>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16927
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 09, 2007 at 10:05:30PM +0100, Alan Cox wrote:

> > Before I dive into this, does any of this ring a bell for anyone?
> > I'm using the ide-cs driver, TI yenta cardbus adapter driver, and sibyte
> > everything else.
> 
> That has cache coherency painted all over it in bright flashing letters.

The Sibyte SOCs have hardware cache coherency and physically indeded
D-caches which makes I/O pretty much a nobrainer.

I-cache coherency is the thing that really needs babysitting on Sibyte
and the Sibyte I-caches are of a somewhat rare kind by being VIVT plus
an additional address space tag.  Mostly because of code duplication
the Sibyte cachecode has its nice damp and dark corner where it did
bitrot away for a while.  Thiemo and I recently found the standard
R4000 cache code to work more reliable for Sibyte so we're getting rid
of it for 2.6.24.  The patch is in 06e523e89ec0322c4abcf41533d5380dfcd81f73.
It can easily be backported to older kernels so I suggest trying this
one.

(As collateral damage 06e523e89ec0322c4abcf41533d5380dfcd81f73 breaks
support for pass 1 BCM1250 parts.  But it seems I'm the last one with one
of those ...)

  Ralf
