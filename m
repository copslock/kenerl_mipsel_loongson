Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jan 2005 21:08:48 +0000 (GMT)
Received: from alg138.algor.co.uk ([IPv6:::ffff:62.254.210.138]:20661 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225388AbVAXVId>; Mon, 24 Jan 2005 21:08:33 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j0OL5aQK003874;
	Mon, 24 Jan 2005 21:05:36 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j0OL5ZT5003873;
	Mon, 24 Jan 2005 21:05:35 GMT
Date:	Mon, 24 Jan 2005 21:05:35 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Fix some (maybe) missing syncs in bitops.h
Message-ID: <20050124210535.GA2797@linux-mips.org>
References: <20050121010403.GA10371@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121010403.GA10371@nevyn.them.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 20, 2005 at 08:04:03PM -0500, Daniel Jacobowitz wrote:

> If I'm reading the broadcom documentation right, the semantics of set_bit
> and test_and_set_bit require a sync at the end on this architecture.

Linux semantics of the bit functions are less than obvious.  The functions
set_bit, change_bit and clear_bit may be atomic but they don't have memory
barrier semantics, that is memory accesses before the function call may be
reordered to be executed after the function has been completed or vice
versa.  The test_and_{set,clear,change}_bit functions however have memory
barrier semantics.  The intended use is something like:

	if (!test_and_set_bit(bitnr, bitmap)) {
		/* we got the bit */

		... do something ...

		smp_mb__before_clear_bit();
		clear_bit(bitnr, bitmap);
		smp_mb__after_clear_bit();
	} else
		printk("Bit was already set by somebody else\n");

> I've been trying to track down a nasty signal delivery bug that I thought
> was a TIF_SIGPENDING not being visible on the other CPU early enough.  Turns
> out that wasn't the problem, but I still think the syncs are correct, so I'm
> posting the patch.

And the code indeed seems to be ok as it is.

  Ralf
