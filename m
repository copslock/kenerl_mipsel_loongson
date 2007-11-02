Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Nov 2007 22:12:08 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:31129 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20030693AbXKBWMA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 2 Nov 2007 22:12:00 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1Io4h8-000452-00; Fri, 02 Nov 2007 23:08:50 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 22CECC2191; Fri,  2 Nov 2007 23:08:19 +0100 (CET)
Date:	Fri, 2 Nov 2007 23:08:19 +0100
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] JAZZ: disable PIT; cleanup R4030 clockevent
Message-ID: <20071102220819.GA20792@alpha.franken.de>
References: <20071101125236.GA16577@alpha.franken.de> <20071101150741.GA8570@linux-mips.org> <20071101160210.GA20366@linux-mips.org> <20071102101713.GA9110@alpha.franken.de> <20071102122001.GC22829@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071102122001.GC22829@linux-mips.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Fri, Nov 02, 2007 at 12:20:01PM +0000, Ralf Baechle wrote:
> One thing I'm still wondering about, does the kernel actually go tickless
> for you?

a kernel with CONFIG_NO_HZ boots and acts normal. But it looks like
the PIT is still ticking at the selected 100HZ...

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
