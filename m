Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Dec 2007 05:15:02 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:5586 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022104AbXLIFPA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 9 Dec 2007 05:15:00 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lB95EpPi027048;
	Sun, 9 Dec 2007 05:14:52 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lB95EoBt027047;
	Sun, 9 Dec 2007 05:14:51 GMT
Date:	Sun, 9 Dec 2007 05:14:50 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kaz Kylheku <kaz@zeugmasystems.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: SiByte 1480 & Branch Likely instructions?
Message-ID: <20071209051450.GA18181@linux-mips.org>
References: <DDFD17CC94A9BD49A82147DDF7D545C5590CF0@exchange.ZeugmaSystems.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDFD17CC94A9BD49A82147DDF7D545C5590CF0@exchange.ZeugmaSystems.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Dec 07, 2007 at 01:54:30PM -0800, Kaz Kylheku wrote:

> Not really a kernel-related question. I've discovered that GCC 4.1.1
> (which I'm not using for kernel compiling, but user space) generates
> branch likely instructions by default, even though the documentation
> says that their use is off by default for MIPS32 and MIPS64, because
> they are considered deprecated. They are documented as obsolete for the
> Broadcom chips I am working with.

Microarchitecture guys love to hate branch likely.  But the deprecation is
a dream.  Binary compatibility will always require those instructions to
continue to exist so the genie is out of the bottle and so I feel very
certain to predict that a future MIPS 3 specification will contain branch
likely.

Afair the SB1 core has a full blown implementation of branch likely -
unlike the R10000 for example where implementors were lazy that is the
branch predictor predicts branch likely instructions as always taken.
So on the R10000 branch likely is only good as loop closure instruction
while on SB1 it should actually do a decent job wherever it can be
scheduled apropriately.

> I'm investigating a software anomaly which looks like might be caused by
> failure to annul the delay slot of a branch-likely in the fall-through
> case. 
> 
> In parallel with writing some tests, I thought I would ask whether
> anyone happens know whether or not these instructions are known to
> actually work correctly on the SB1480 silicon (and perhaps any
> additional details, like what revisions, etc)?

I have no indications of the contrary.

  Ralf
