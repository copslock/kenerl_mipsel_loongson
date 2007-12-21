Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Dec 2007 01:24:39 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:24968 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28584306AbXLUBYh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Dec 2007 01:24:37 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lBL1BOlt015515;
	Fri, 21 Dec 2007 02:11:49 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lBL1BMuf015514;
	Fri, 21 Dec 2007 02:11:22 +0100
Date:	Fri, 21 Dec 2007 02:11:22 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	Pavel Kiryukhin <vksavl@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] fix user_cpus_allowed assignment
Message-ID: <20071221011122.GB14926@linux-mips.org>
References: <73cd086a0712170517i146a452exea775f3942c1d5da@mail.gmail.com> <017c01c840cb$7a5049c0$10eca8c0@grendel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <017c01c840cb$7a5049c0$10eca8c0@grendel>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 17, 2007 at 05:40:03PM +0100, Kevin D. Kissell wrote:

> This looks to be a correct fix.  Long term, we really do need to convince
> the scheduler maintainer to provide hooks that will allow hardware-driven
> affinity to be integrated with application-driven affinity in a sensible way,
> without requiring replication (and replicated maintenence) of the system
> call code in private copies like this.  I asked for such hooks in sched.c
> when it first became apparent that dynamic FPU affinity was desirable,
> but was blown off at that time, so, with regret, I perpetrated the local copy
> hack.  But it's silly, and MIPS can't possibly be the only architecture where 
> Linux is used in systems with assymmetric resources where adaptive affinity 
> is useful.

I dare to speculate that the new job of a certain Mike Uhler may increase
the need for such a scheduler feature :-)

  Ralf
