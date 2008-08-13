Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Aug 2008 21:58:52 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:50092 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28595333AbYHMU6u (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 13 Aug 2008 21:58:50 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KTNQe-0002qa-00; Wed, 13 Aug 2008 22:58:48 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 5F8D6C3163; Wed, 13 Aug 2008 22:58:36 +0200 (CEST)
Date:	Wed, 13 Aug 2008 22:58:36 +0200
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: "indy_volume_button" [sound/oss/hal2.ko] undefined
Message-ID: <20080813205836.GA10796@alpha.franken.de>
References: <20080813125954.GA3203@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080813125954.GA3203@deprecation.cyrius.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20207
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Wed, Aug 13, 2008 at 03:59:55PM +0300, Martin Michlmayr wrote:
> sound/oss/hal2.ko fails to build because indy_volume_button was
> removed from the IP22 code.  Is sound/oss/hal2o going to be removed
> before 2.6.27 is out?

The OSS hal driver is still marked experimental and the only IP22 sound
driver I'll care (and take care) is the alsa one. So if nobody objects
I'll send a remove patch.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
