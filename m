Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2003 04:21:41 +0100 (BST)
Received: from p508B56D0.dip.t-dialin.net ([IPv6:::ffff:80.139.86.208]:43162
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225211AbTGRDVj>; Fri, 18 Jul 2003 04:21:39 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h6I3LKDB007038;
	Fri, 18 Jul 2003 05:21:20 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h6I3LJff007037;
	Fri, 18 Jul 2003 05:21:19 +0200
Date: Fri, 18 Jul 2003 05:21:19 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Johannes Stezenbach <js@convergence.de>, linux-mips@linux-mips.org
Subject: Re: 2.4: typo in system.h / __save_and_sti
Message-ID: <20030718032119.GA6974@linux-mips.org>
References: <20030717120322.GA6113@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030717120322.GA6113@convergence.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 17, 2003 at 02:03:22PM +0200, Johannes Stezenbach wrote:

> I noticed a typo in the (apparently unused) __save_and_sti() macro:

Thanks for noticing this one.  Yes, __save_and_sti() seems unused
except by local_irq_set() which itself is unused.  The operation it
performs seems to be of little use but anyway, as a pointless exercise
appropriate for 5:20am hacking I fixed it in CVS.

  Ralf
