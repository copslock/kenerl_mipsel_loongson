Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Sep 2004 21:19:28 +0100 (BST)
Received: from web81408.mail.yahoo.com ([IPv6:::ffff:206.190.37.97]:36030 "HELO
	web81408.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225239AbUIWUTX>; Thu, 23 Sep 2004 21:19:23 +0100
Message-ID: <20040923201916.38891.qmail@web81408.mail.yahoo.com>
Received: from [216.98.102.225] by web81408.mail.yahoo.com via HTTP; Thu, 23 Sep 2004 13:19:16 PDT
X-RocketYMMF: pete_popov
Date: Thu, 23 Sep 2004 13:19:16 -0700 (PDT)
From: Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
Subject: Re: CPU frequency scaling on MIPS (au1000/common/power.c)
To: Dominik Brodowski <linux@dominikbrodowski.de>, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Cc: cpufreq@www.linux.org.uk
In-Reply-To: <20040923194829.GA32270@dominikbrodowski.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


<snip>

> Therefore, I'd suggest that we update
> arch/mips/au1000/common/power.c to
> use the cpufreq infrastructure. 


The current interface was written a few years ago for
2.4, when I couldn't find a general PM interface to
start with.


> Nonetheless I'd be willing to write
> a "suggestion" on how to update
> arch/mips/au1000/common/power.c, and
> somebody with compiler and hardware could test it
> then.

That would help, though I'm not sure when I would get
to it personally. I'm working on 2.6 updates at the
moment with some other developers, but PM is not on
our list for now. If you're dying to work on it and
hardware is the only issue, I might be able to help :)

> Are there other MIPS CPUs which support CPU
> frequency scaling? 

Not that I know of, and not the way the Au1x supports
it.


Pete
