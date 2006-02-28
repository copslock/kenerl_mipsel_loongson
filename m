Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2006 22:41:02 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:60164 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133642AbWB1Wkw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Feb 2006 22:40:52 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id DE03364D3D; Tue, 28 Feb 2006 22:48:32 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 6FCC781F5; Tue, 28 Feb 2006 23:48:25 +0100 (CET)
Date:	Tue, 28 Feb 2006 22:48:25 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: Re: MIPS kernel status as of 2.6.16-rc5
Message-ID: <20060228224825.GA27332@deprecation.cyrius.com>
References: <20060228214144.GA6615@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060228214144.GA6615@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Martin Michlmayr <tbm@cyrius.com> [2006-02-28 21:41]:
>  - bcm1x80: while 4 CPUs are found, Bogomips are never displayed.  So
>    maybe something with the recent SMP change is still not 100% right.
>    [Actually, it seems this is not reported in non-SMP either]

Actually, what happens is that the "Calibrating delay loop..." message
_is_ there, but it's shown at such a priority that you don't see it
during boot.  It's there when you type "dmesg" though.
-- 
Martin Michlmayr
http://www.cyrius.com/
