Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2007 08:19:05 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:50057 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20026053AbXKTIS4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Nov 2007 08:18:56 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IuOJo-00069F-00; Tue, 20 Nov 2007 09:18:52 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 47953C2DE7; Tue, 20 Nov 2007 09:18:35 +0100 (CET)
Date:	Tue, 20 Nov 2007 09:18:35 +0100
To:	Markus Gothe <markus.gothe@27m.se>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Florian Lohoff <flo@rfc822.org>, linux-mips@linux-mips.org
Subject: Re: [SPAM] Re: IP22 64Bit arcboot - current git crashes on 3 machines at different points
Message-ID: <20071120081834.GA8627@alpha.franken.de>
References: <20071119160954.GA12244@paradigm.rfc822.org> <20071119193137.GA27317@linux-mips.org> <775F4404-2D0A-4E65-9401-E2193B96DBDC@27m.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <775F4404-2D0A-4E65-9401-E2193B96DBDC@27m.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Tue, Nov 20, 2007 at 03:49:07AM +0100, Markus Gothe wrote:
> Afaik R4x00 is just semi-64bit in contrast to the R5K, which derives  
> from the R10K.

how about reading documents ? Early R4k have ugly bugs in 64bit mode,
but starting with rev5 they run 64bit code pretty well. And R5k does
in no way derive from R10k.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
