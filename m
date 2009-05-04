Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 May 2009 22:54:40 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:53597 "EHLO elvis.franken.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023514AbZEDVyd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 4 May 2009 22:54:33 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1M167M-0005fm-02; Mon, 04 May 2009 23:54:32 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 77D33C2C47; Mon,  4 May 2009 23:54:22 +0200 (CEST)
Date:	Mon, 4 May 2009 23:54:22 +0200
To:	Jon Fraser <jfraser@broadcom.com>
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: linux-mips on big_sur (broadcom 1480)
Message-ID: <20090504215422.GB16886@alpha.franken.de>
References: <1239227598.14558.39.camel@chaos.ne.broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1239227598.14558.39.camel@chaos.ne.broadcom.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Wed, Apr 08, 2009 at 05:53:18PM -0400, Jon Fraser wrote:
> Can anybody confirm the running any of the sibyte processors on any of
> the latest kernels?

I've sent a fix a couple of seconds ago, which fixes SMP for BCM1480
and SB1250 systems. I could only test on a BigSur, but the breakage for
SB1250 systems is the same.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
