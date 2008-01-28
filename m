Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jan 2008 21:04:52 +0000 (GMT)
Received: from bsdimp.com ([199.45.160.85]:41408 "EHLO harmony.bsdimp.com")
	by ftp.linux-mips.org with ESMTP id S28584617AbYA1VEi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 28 Jan 2008 21:04:38 +0000
Received: from localhost (localhost [127.0.0.1])
	by harmony.bsdimp.com (8.14.2/8.14.1) with ESMTP id m0SL2UwE043172;
	Mon, 28 Jan 2008 14:02:30 -0700 (MST)
	(envelope-from imp@bsdimp.com)
Date:	Mon, 28 Jan 2008 14:02:45 -0700 (MST)
Message-Id: <20080128.140245.-108809632.imp@bsdimp.com>
To:	ralf@linux-mips.org
Cc:	cfriesen@nortel.com, linux-mips@linux-mips.org
Subject: Re: quick question on 64-bit values with 32-bit inline assembly
From:	"M. Warner Losh" <imp@bsdimp.com>
In-Reply-To: <20080122200751.GA2672@linux-mips.org>
References: <20080122175734.GA31013@linux-mips.org>
	<47963C31.2000403@nortel.com>
	<20080122200751.GA2672@linux-mips.org>
X-Mailer: Mew version 5.2 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <imp@bsdimp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imp@bsdimp.com
Precedence: bulk
X-list: linux-mips

In message: <20080122200751.GA2672@linux-mips.org>
            Ralf Baechle <ralf@linux-mips.org> writes:
: On Tue, Jan 22, 2008 at 12:55:45PM -0600, Chris Friesen wrote:
: 
: >>> gethrtime(void)
: >>> {
: >>>   unsigned long long result;
: >>>
: >>>   asm volatile ("rdhwr %0,$31" : "=r" (result));
: >
: >> Ah, Cavium.
: >
: > Yes indeed.  Any peculiarities that we should be watching out for? Previous 
: > mailing list threads would be great.
: 
: Cavium so far received little coverage on this list - but seems you're
: about to start this.  The reason why I was able to identify Cavium is that
: afaics only Cavium is the only 64-bit CPU to implement a 64-bit timer in
: hardware register $31.
: 
: The definition of rdhwr is generic and I think if anybody has considered
: this specific interaction of ABI and processor architecture then it was
: probably found not to implement such a special read because it is messy
: in more than one way.

When 64-bit operations are enabled, you get all 64-bits.  When they
aren't, only the lower 32-bits of the counter are provided (with sign
extension).  So when operating in 32-bit mode, saving the upper 32
bits are not necessary (or even possible).

Warner
