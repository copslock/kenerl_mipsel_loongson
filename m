Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 May 2006 19:31:49 +0200 (CEST)
Received: from sorrow.cyrius.com ([65.19.161.204]:17676 "HELO
	sorrow.cyrius.com") by ftp.linux-mips.org with SMTP
	id S8133647AbWEKRbk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 May 2006 19:31:40 +0200
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 2F65864D54; Thu, 11 May 2006 17:30:48 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 7146266F5C; Thu, 11 May 2006 19:30:25 +0200 (CEST)
Date:	Thu, 11 May 2006 19:30:25 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: DECstation R3000 boot error
Message-ID: <20060511173025.GA28209@deprecation.cyrius.com>
References: <20060124122700.GA8527@deprecation.cyrius.com> <Pine.LNX.4.64N.0601241227290.11021@blysk.ds.pg.gda.pl> <20060124232117.GA4165@codecarver> <Pine.LNX.4.64N.0601251103020.7675@blysk.ds.pg.gda.pl> <20060203150232.GA25701@deprecation.cyrius.com> <Pine.LNX.4.64N.0602061021110.32080@blysk.ds.pg.gda.pl> <Pine.LNX.4.64N.0602130911260.17051@blysk.ds.pg.gda.pl> <20060213225927.GB4226@deprecation.cyrius.com> <20060213232329.GA8286@deprecation.cyrius.com> <Pine.LNX.4.64N.0602140950200.14255@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0602140950200.14255@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.11+cvs20060330
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Maciej W. Rozycki <macro@linux-mips.org> [2006-02-14 10:01]:
> The driver has been ported by JBG (thanks!) -- it's the zs.c driver
> that needs to be ported to the new serial infrastructure.  But
> that's tough if to be done properly (DMA and synchronous modes are
> not handled well by the serial core), so not at the moment, sorry.
> I'll think about minimal functionality to keep it going though and
> perhaps lk201.c could be changed to work with current zs.c as is
> (dz.c has already been ported -- I have no way of testing it, so I
> somewhat lack incentive to go through it and verify if it's at least
> as good as the old driver in 2.4.)...

Do you think you'll have time to port zs.c soon?  I'd like to move
away from 2.4 in Debian and DECstation is currently the only platform
that isn't supported in 2.6 (or at least not fully).
-- 
Martin Michlmayr
http://www.cyrius.com/
