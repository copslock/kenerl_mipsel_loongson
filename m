Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Aug 2003 11:04:27 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:43529 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225334AbTHDKEQ>;
	Mon, 4 Aug 2003 11:04:16 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 19jcDK-0001ct-00; Mon, 04 Aug 2003 11:05:14 +0100
Received: from gladsmuir.algor.co.uk ([172.20.192.66] helo=gladsmuir.mips.com)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 19jayF-0003wJ-00; Mon, 04 Aug 2003 09:45:35 +0100
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16174.7469.845997.741559@gladsmuir.mips.com>
Date: Mon, 4 Aug 2003 09:45:33 +0100
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Dominic Sweetman <dom@mips.com>,
	Adam Kiepul <Adam_Kiepul@pmc-sierra.com>,
	Fuxin Zhang <fxzhang@ict.ac.cn>, linux-mips@linux-mips.org
Subject: Re: RM7k cache_flush_sigtramp
In-Reply-To: <20030801092649.GA17624@linux-mips.org>
References: <9DFF23E1E33391449FDC324526D1F259017DF087@SJC1EXM02>
	<16170.7179.635988.268987@doms-laptop.algor.co.uk>
	<20030801092649.GA17624@linux-mips.org>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-0.8, required 4, AWL,
	QUOTED_EMAIL_TEXT, REFERENCES)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Ralf,

> Linux supports the traditional MIPS UNIX cacheflush(2) syscall through
> a libc interface.  Since I've not seen any other use for the call than
> I/D-cache synchronization.  I'd just make cacheflush(3) use SYNCI where
> available...

SYNCI just does what's required to execute code you just wrote: that's
a D-cache writeback and an I-cache invalidate.  It doesn't invalidate
the D-cache afterwards, which is required by the definition of
cacheflush(3).

I think it would be better to provide cache manipulation calls defined
top-down (by their purpose); but so long as we are stuck with calls
which are defined as performing particular low-level actions, it's
surely dangerous to guess that we know what they are used for so we
can trim the functions accordingly...

--
Dominic Sweetman
MIPS Technologies
