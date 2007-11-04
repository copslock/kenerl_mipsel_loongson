Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Nov 2007 00:33:48 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:24229 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28577301AbXKDAdq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 4 Nov 2007 00:33:46 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lA40Xc8t001518;
	Sun, 4 Nov 2007 00:33:38 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lA40XcS5001517;
	Sun, 4 Nov 2007 00:33:38 GMT
Date:	Sun, 4 Nov 2007 00:33:38 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] JAZZ: disable PIT; cleanup R4030 clockevent
Message-ID: <20071104003338.GB28717@linux-mips.org>
References: <20071101125236.GA16577@alpha.franken.de> <20071101150741.GA8570@linux-mips.org> <20071101160210.GA20366@linux-mips.org> <20071102101713.GA9110@alpha.franken.de> <20071102122001.GC22829@linux-mips.org> <20071102220819.GA20792@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071102220819.GA20792@alpha.franken.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 02, 2007 at 11:08:19PM +0100, Thomas Bogendoerfer wrote:

> On Fri, Nov 02, 2007 at 12:20:01PM +0000, Ralf Baechle wrote:
> > One thing I'm still wondering about, does the kernel actually go tickless
> > for you?
> 
> a kernel with CONFIG_NO_HZ boots and acts normal. But it looks like
> the PIT is still ticking at the selected 100HZ...

I think this happens because the R4030 clockevent device has a rather
high rating of 300 while the PIT because of an omission or intension
doesn't set it's rating at all so has rating of 0.  So Linux prefers the
R4030.  You can see which clockevent device is actually getting used
by Linux in /proc/timer_list.

  Ralf
