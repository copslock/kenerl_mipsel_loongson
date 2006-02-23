Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2006 21:07:54 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:26896 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133474AbWBWVHp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Feb 2006 21:07:45 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 5A66764D3D; Thu, 23 Feb 2006 21:14:21 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 65B668DC5; Thu, 23 Feb 2006 21:14:05 +0000 (GMT)
Date:	Thu, 23 Feb 2006 21:14:05 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: IP22 doesn't shutdown properly
Message-ID: <20060223211405.GB28456@deprecation.cyrius.com>
References: <20060217225824.GE20785@deprecation.cyrius.com> <20060219165245.GD21416@linux-mips.org> <20060220181227.GA17439@deprecation.cyrius.com> <20060221135901.GA30024@networkno.de> <43FB2252.8030204@gentoo.org> <20060221143107.GB30024@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060221143107.GB30024@networkno.de>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Thiemo Seufer <ths@networkno.de> [2006-02-21 14:31]:
> ISTR I tried both R4400 with newport and R4600 with serial.

Interestingly enough, it powers down properly with your package, even
when I recompile it.  But when I apply your patches again 2.6.12 git,
it still doesn't work.  There's still a large chunk of differences
between the Debian tree and git (2.6.12) and I don't have time right
now to look more closely.  Going to FOSDEM tomorrow.
-- 
Martin Michlmayr
http://www.cyrius.com/
