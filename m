Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2008 19:54:39 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:48025 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28578219AbYCUTyh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Mar 2008 19:54:37 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JcnK0-0006Xg-00; Fri, 21 Mar 2008 20:54:36 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 2A884C2DED; Fri, 21 Mar 2008 20:47:37 +0100 (CET)
Date:	Fri, 21 Mar 2008 20:47:37 +0100
To:	peter fuerst <post@pfrst.de>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] IP28: fix MC GIOPAR setting
Message-ID: <20080321194737.GA8398@alpha.franken.de>
References: <Pine.LNX.4.58.0803211535570.423@Indigo2.Peter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0803211535570.423@Indigo2.Peter>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Fri, Mar 21, 2008 at 04:03:16PM +0100, peter fuerst wrote:
> We must not omit the MASTERGFX setting, unless we want Impact DMA to hang ;-)

is there a reason to restrict this to IP28 only ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
