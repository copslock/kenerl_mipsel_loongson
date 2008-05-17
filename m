Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 May 2008 23:31:45 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:47747 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20035812AbYEQWbn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 17 May 2008 23:31:43 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JxUwI-0002AI-00; Sun, 18 May 2008 00:31:42 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 8FAFAFB377; Sun, 18 May 2008 00:12:52 +0200 (CEST)
Date:	Sun, 18 May 2008 00:12:52 +0200
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] IP27: Fix bootmem memory setup
Message-ID: <20080517221252.GA27051@alpha.franken.de>
References: <20080408214346.ECFF7C2C03@solo.franken.de> <20080409144823.GA3607@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080409144823.GA3607@linux-mips.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19294
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Wed, Apr 09, 2008 at 03:48:23PM +0100, Ralf Baechle wrote:
> On Tue, Apr 08, 2008 at 11:43:46PM +0200, Thomas Bogendoerfer wrote:
> 
> > Changes in the generic bootmem code broke memory setup for IP27. This
> > patch fixes this by replacing lots of special IP27 code with generic
> > bootmon code. This has been tested only on a single node.
> 
> I have a dual-node for testing, will give it a spin later.

my patch is now tested and working on a dual node O200 system.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
