Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2008 01:45:57 +0100 (BST)
Received: from p549F5155.dip.t-dialin.net ([84.159.81.85]:32962 "EHLO
	p549F5155.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S28592219AbYE1XlT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 May 2008 00:41:19 +0100
Received: from sorrow.cyrius.com ([65.19.161.204]:23050 "EHLO
	sorrow.cyrius.com") by lappi.linux-mips.net with ESMTP
	id S1105922AbYE1PL7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 May 2008 17:11:59 +0200
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id D735AD8D3; Wed, 28 May 2008 15:11:43 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 817AF150F7D; Wed, 28 May 2008 11:10:25 -0400 (EDT)
Date:	Wed, 28 May 2008 17:10:25 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>,
	linux-mips@linux-mips.org
Subject: Re: Malta build errors with 2.6.26-rc1
Message-ID: <20080528151025.GA15325@deprecation.cyrius.com>
References: <20080512163107.GA19052@deprecation.cyrius.com> <90edad820805121246o328d1cdaide88594ce9d328b7@mail.gmail.com> <20080528071240.GB10393@deprecation.cyrius.com> <20080528085033.GA6250@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080528085033.GA6250@alpha.franken.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Thomas Bogendoerfer <tsbogend@alpha.franken.de> [2008-05-28 10:50]:
> I didn't fix the problems above. The change to traps.c only fixes
> traps.c for 64bit builds and it's a totally different issue. Looking
> at the warning/errors someone needs to fix some data types and use
> CKSEG0ADDR(). I don't have the hardware, so I could only provide an
> untested patch, if no one else steps forward...

QEMU emulates Malta, so I (or someone else here) should be able to
test the patch.
-- 
Martin Michlmayr
http://www.cyrius.com/
