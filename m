Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2007 23:02:00 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:29928 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28573796AbXKZXBv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Nov 2007 23:01:51 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1Iwmxa-0002vt-00
	for linux-mips@linux-mips.org; Tue, 27 Nov 2007 00:01:50 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 43C88C2B28; Tue, 27 Nov 2007 00:01:27 +0100 (CET)
Date:	Tue, 27 Nov 2007 00:01:27 +0100
To:	linux-mips@linux-mips.org
Subject: Re: SGI IP28 support
Message-ID: <20071126230127.GA21970@alpha.franken.de>
References: <20071126223814.GA21339@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071126223814.GA21339@alpha.franken.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Mon, Nov 26, 2007 at 11:38:14PM +0100, Thomas Bogendoerfer wrote:
> [..]

There is one thing I forgot: You need a special gcc, which will generate
cache barriers to avoid speculative stores done by the R10k. Peter
had some patches submitted to the gcc maintainers, which I used to
build my own gcc 4.2.1 cross compiler. Does anybody know, if Peter's
paches are already intergrated in newer gcc versions ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
