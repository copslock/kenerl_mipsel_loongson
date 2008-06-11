Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2008 12:01:50 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:28863 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20025437AbYFKLBr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jun 2008 12:01:47 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5BB1Q9I014717;
	Wed, 11 Jun 2008 12:01:27 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5BB1Pko014710;
	Wed, 11 Jun 2008 12:01:25 +0100
Date:	Wed, 11 Jun 2008 12:01:25 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Laird <daniel.j.laird@googlemail.com>
Cc:	Florian Fainelli <florian.fainelli@telecomint.eu>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] : Add support for NXP PNX833x (STB222/5) into linux
	kernel
Message-ID: <20080611110125.GA8187@linux-mips.org>
References: <64660ef00806110353p66608c43ta1e1995aef8b8f6f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64660ef00806110353p66608c43ta1e1995aef8b8f6f@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 11, 2008 at 11:53:24AM +0100, Daniel Laird wrote:

> On the second patch I submitted I changed platform.c as requested so
> it registers all resources without the #ifdefs.
> I also found that cpu_relax was not quite what i wanted so left the
> while(1) loop for halt.
> 
> I have left printk kernel messages in as well (can remove if preferred).
> 
> If you require me to re-submit this second patch let me know (either
> as attachment or inline).
> 
> I also split the ip3902, ip0105 and submitted to the i2c, netdev
> mailing list and am awaiting feedback.

I'm replying to things in not quite chronological order, just looking at
your patch in the other window.

  Ralf
