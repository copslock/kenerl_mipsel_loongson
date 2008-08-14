Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Aug 2008 06:42:13 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:35334 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20026163AbYHNFmH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Aug 2008 06:42:07 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id A0999D8DB; Thu, 14 Aug 2008 05:42:04 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 8C40A15065F; Thu, 14 Aug 2008 08:41:53 +0300 (IDT)
Date:	Thu, 14 Aug 2008 08:41:53 +0300
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: "indy_volume_button" [sound/oss/hal2.ko] undefined
Message-ID: <20080814054153.GA2546@deprecation.cyrius.com>
References: <20080813125954.GA3203@deprecation.cyrius.com> <20080813205836.GA10796@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080813205836.GA10796@alpha.franken.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Thomas Bogendoerfer <tsbogend@alpha.franken.de> [2008-08-13 22:58]:
> > sound/oss/hal2.ko fails to build because indy_volume_button was
> > removed from the IP22 code.  Is sound/oss/hal2o going to be removed
> > before 2.6.27 is out?
> 
> The OSS hal driver is still marked experimental and the only IP22 sound
> driver I'll care (and take care) is the alsa one. So if nobody objects
> I'll send a remove patch.

Well, it got broken by your ALSA related changes.  Anyway, I'm all for
removing it, but it should happen before 2.6.27 is out so there's no
regression.

-- 
Martin Michlmayr
http://www.cyrius.com/
