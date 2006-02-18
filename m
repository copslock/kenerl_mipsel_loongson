Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Feb 2006 01:20:49 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:48395 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133650AbWBRBUk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 18 Feb 2006 01:20:40 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 6E71C64D59; Sat, 18 Feb 2006 01:27:21 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 506CB8F77; Sat, 18 Feb 2006 01:27:13 +0000 (GMT)
Date:	Sat, 18 Feb 2006 01:27:13 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Kumba <kumba@gentoo.org>
Cc:	linux-mips@linux-mips.org, jblache@debian.org
Subject: Re: IP22 doesn't shutdown properly
Message-ID: <20060218012713.GJ20785@deprecation.cyrius.com>
References: <20060217225824.GE20785@deprecation.cyrius.com> <43F67607.1030703@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F67607.1030703@gentoo.org>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10506
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Kumba <kumba@gentoo.org> [2006-02-17 20:19]:
> >now after init sends the TERM signal; the LED stays green for a few
> >seconds, then turns orange which definitely isn't good."
> 
> Turns red/orange and stays that color, or starts flashing?

Stays the same colour.

By the way, Stephen Becker mentioned on IRC that he sees the same -
but *only* when he uses serial console, not fb (sounds a bit odd to
me, but maybe someone can make sense of this).
-- 
Martin Michlmayr
http://www.cyrius.com/
