Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 May 2006 17:12:31 +0200 (CEST)
Received: from sorrow.cyrius.com ([65.19.161.204]:2053 "HELO sorrow.cyrius.com")
	by ftp.linux-mips.org with SMTP id S8126581AbWELPMV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 12 May 2006 17:12:21 +0200
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id C9A1564D54; Fri, 12 May 2006 15:12:13 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id A2BA866F5B; Fri, 12 May 2006 17:12:01 +0200 (CEST)
Date:	Fri, 12 May 2006 17:12:01 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Karel van Houten <Karel@vhouten.xs4all.nl>,
	debian-mips@lists.debian.org, linux-mips@linux-mips.org
Subject: Re: 2.6 for DECstation, d-i
Message-ID: <20060512151201.GJ7863@deprecation.cyrius.com>
References: <44635C0D.7040901@vhouten.xs4all.nl> <20060511173350.GM7827@deprecation.cyrius.com> <Pine.LNX.4.64N.0605111853500.20004@blysk.ds.pg.gda.pl> <20060511185446.GB7234@deprecation.cyrius.com> <Pine.LNX.4.64N.0605121142240.14216@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0605121142240.14216@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.11+cvs20060330
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Maciej W. Rozycki <macro@linux-mips.org> [2006-05-12 11:57]:
> > Yeah, but the problem is that ZS is not a config option anymore.  I
> > hacked up something to see if the driver works but I guess there's a
> > nicer solution.
>  Of course there is.  Just enable SERIAL_NONSTANDARD, SERIAL_DEC, 
> SERIAL_DEC_CONSOLE and ZS.  They are all in drivers/char/Kconfig and it's 
> not a coincidence the options are the same as in 2.4.

Hmm, okay, they are in the linux-mips tree, but not in mainline. :/
-- 
Martin Michlmayr
http://www.cyrius.com/
