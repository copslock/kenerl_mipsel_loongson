Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2008 09:52:43 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:8402 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20022091AbYHEIwd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 5 Aug 2008 09:52:33 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KQIHO-00074E-00; Tue, 05 Aug 2008 10:52:30 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 2ED7CC3160; Tue,  5 Aug 2008 10:52:23 +0200 (CEST)
Date:	Tue, 5 Aug 2008 10:52:23 +0200
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH v2] IP27: Switch over to RTC class driver
Message-ID: <20080805085222.GA6808@alpha.franken.de>
References: <20080804170021.AAE18C2EAA@solo.franken.de> <20080805.093305.233543912.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080805.093305.233543912.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Tue, Aug 05, 2008 at 09:33:05AM +0900, Atsushi Nemoto wrote:
> On Mon,  4 Aug 2008 19:00:21 +0200 (CEST), Thomas Bogendoerfer <tsbogend@alpha.franken.de> wrote:
> > +	res.start = XPHYSADDR(KL_CONFIG_CH_CONS_INFO(master_nasid)->memory_base +
> > +			      IOC3_BYTEBUS_DEV0);
> > +	res.end = res.start + 32768;
> 
> res.end should be res.start + 32767 ?

correct, I'll fix that.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
