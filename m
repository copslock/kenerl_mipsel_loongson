Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2008 15:07:42 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:2768 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28577393AbYGNOHk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 14 Jul 2008 15:07:40 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KIOiJ-0007NP-00; Mon, 14 Jul 2008 16:07:39 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id E96BADE7B3; Mon, 14 Jul 2008 16:05:39 +0200 (CEST)
Date:	Mon, 14 Jul 2008 16:05:39 +0200
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Remove mips_machtype from ARC based machines
Message-ID: <20080714140539.GA28056@alpha.franken.de>
References: <20080714131140.6B5E0DE7BA@solo.franken.de> <20080714133447.GA5963@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080714133447.GA5963@linux-mips.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19827
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Mon, Jul 14, 2008 at 02:34:47PM +0100, Ralf Baechle wrote:
> It may be a little academic at this stage but the Acer PICA has no EISA
> but just ISA slots.

I knew there one JAZZ maschine with ISA only, but I believe it doesn't
make much difference without a register EISA root bus. So we could
also kill it completly and I'll add it, if the EISA bits are sorted.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
