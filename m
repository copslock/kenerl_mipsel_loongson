Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Nov 2006 01:06:45 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:63642 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037528AbWK3BGn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Nov 2006 01:06:43 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kAU15JF8022010;
	Thu, 30 Nov 2006 01:05:19 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kAU15GRO022009;
	Thu, 30 Nov 2006 01:05:16 GMT
Date:	Thu, 30 Nov 2006 01:05:16 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	m.kozlowski@tuxland.pl, linux-mips@linux-mips.org
Subject: Re: [PATCH] mips tx4927 missing brace fix
Message-ID: <20061130010516.GA17608@linux-mips.org>
References: <200611292030.36170.m.kozlowski@tuxland.pl> <20061129194346.GA20892@linux-mips.org> <20061130.095643.74752511.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130.095643.74752511.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13274
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 30, 2006 at 09:56:43AM +0900, Atsushi Nemoto wrote:

> > Thanks Mariusz!  Applied,
> 
> Oh, that was my fault.  Thank you.  I see the fix was folded into
> linux-queue tree.  Thanks.

Yes, that's what I usually do with fixes that reach me before the
patches have actually been applied to the tree.  There was another
thing which broke the Malta build and I'm building a few more kernels.

And for those who still haven't noticed, 2.6.19 is out, so the race for
2.6.20 has begun.  Send patches!

  Ralf
