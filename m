Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Aug 2008 15:49:39 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:43430 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28577540AbYHQOtc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 17 Aug 2008 15:49:32 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KUjZR-0000uc-00; Sun, 17 Aug 2008 16:49:29 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id C75D8C3F17; Sun, 17 Aug 2008 16:46:51 +0200 (CEST)
Date:	Sun, 17 Aug 2008 16:46:51 +0200
To:	Christoph Hellwig <hch@lst.de>
Cc:	linux-mips@linux-mips.org, linux-parisc@vger.kernel.org
Subject: Re: missing compat_sys_ptrace conversions for mips and parisc
Message-ID: <20080817144651.GA30963@alpha.franken.de>
References: <20080817022924.GA23625@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080817022924.GA23625@lst.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Sun, Aug 17, 2008 at 04:29:24AM +0200, Christoph Hellwig wrote:
> Currently mips and parisc are the only architectures not yet converted

I'll send a patch for mips in a couple of minutes to Ralf.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
