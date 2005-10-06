Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Oct 2005 20:45:58 +0100 (BST)
Received: from eth13.com-link.com ([208.242.241.164]:21389 "EHLO
	real.realitydiluted.com") by ftp.linux-mips.org with ESMTP
	id S8133563AbVJFTpl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Oct 2005 20:45:41 +0100
Received: from sjhill by real.realitydiluted.com with local (Exim 4.52 #1 (Debian))
	id 1ENakd-0005up-Pl; Thu, 06 Oct 2005 13:45:55 -0500
Subject: Re: PREEMPT
In-Reply-To: <43457563.60505@timesys.com>
To:	john cooper <john.cooper@timesys.com>
Date:	Thu, 6 Oct 2005 13:45:55 -0500 (CDT)
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Greg Weeks <greg.weeks@timesys.com>, linux-mips@linux-mips.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E1ENakd-0005up-Pl@real.realitydiluted.com>
From:	sjhill@realitydiluted.com
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

> The code base I'm dealing with is a 2.6.13 derivative
> with PREEMPT_RT support.  Looks like the problem was
> due to PREEMPT_RT confusing fpu_emulator_cop1Handler()
> resulting in a SIGBUS nailing the associated task.
> 
> I have it sort of working for soft FPU but expect it
> requires some attention to safely access a HW FPU where
> emulation assistance is needed.
> 
Um, did no one have a look at Atsushi Nemoto's patch earlier today
that addressed pre-emption and CPU1, or am I missing something?

-Steve
