Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2007 17:46:39 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:29359 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037570AbXJQQqh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Oct 2007 17:46:37 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9HGka7J006762;
	Wed, 17 Oct 2007 17:46:36 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9HGkaYR006761;
	Wed, 17 Oct 2007 17:46:36 +0100
Date:	Wed, 17 Oct 2007 17:46:36 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Probe for usability of cp0 compare interrupt.
Message-ID: <20071017164636.GC5491@linux-mips.org>
References: <S20022491AbXJQLKE/20071017111004Z+82239@ftp.linux-mips.org> <20071018.011033.115643462.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071018.011033.115643462.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 18, 2007 at 01:10:33AM +0900, Atsushi Nemoto wrote:

> > Some processors offer the option of using the interrupt on which
> > normally the count / compare interrupt would be signaled as a normal
> > interupt pin.  Previously this required some ugly hackery for each
> > system which is much easier done by a quick and simple probe.
> 
> It seems write_c0_compare(0) will not work as expected if c0_count was
> near 0xffffffff.  How about write_c0_compare(read_c0_compare()) (or
> c0_timer_ack()) ?

The two things are a know lose end.  There is a bug in some old MIPS
processors where reading one of the compare or count registers in exactly
the moment when both have identical values in the interrupt getting lost.

Will have to dig up the details on that one again before I can implement
a proper workaround ...

> Also something calculated from mips_hpt_frequency would be better than
> the magic number 0x300000.

Well, we just don't care how long it really takes - but it has to be
slow enough to work even for stuff like qemu.  Then busy wait for a
number of cycles long enough to ensure the timer will have expired to
avoid the interrupt bug.

  Ralf
