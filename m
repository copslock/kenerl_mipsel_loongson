Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Aug 2008 08:01:28 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:20747 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20025401AbYHNHBV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Aug 2008 08:01:21 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id BA1BFD8DB; Thu, 14 Aug 2008 07:01:18 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id C811B15065F; Thu, 14 Aug 2008 10:01:12 +0300 (IDT)
Date:	Thu, 14 Aug 2008 10:01:12 +0300
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: "indy_volume_button" [sound/oss/hal2.ko] undefined
Message-ID: <20080814070112.GA2549@deprecation.cyrius.com>
References: <20080813125954.GA3203@deprecation.cyrius.com> <20080813205836.GA10796@alpha.franken.de> <20080814054153.GA2546@deprecation.cyrius.com> <20080814063751.GA5572@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080814063751.GA5572@alpha.franken.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Thomas Bogendoerfer <tsbogend@alpha.franken.de> [2008-08-14 08:37]:
> > Anyway, I'm all for removing it, but it should happen before 2.6.27 is
> > out so there's no regression.
> 
> I'll send a remove path later. The second option would be to just
> remove the indy_volume_button code from the OSS driver.

I'd just get rid of the whole driver.

Thanks for writing the new one, btw.
-- 
Martin Michlmayr
http://www.cyrius.com/
