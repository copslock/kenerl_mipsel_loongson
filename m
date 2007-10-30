Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2007 09:09:51 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:26886 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20023749AbXJ3JJn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 30 Oct 2007 09:09:43 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 81931D8C8; Tue, 30 Oct 2007 09:09:36 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 0045054501; Tue, 30 Oct 2007 10:09:04 +0100 (CET)
Date:	Tue, 30 Oct 2007 10:09:04 +0100
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.4.24-rc1 does not boot on SGI
Message-ID: <20071030090904.GA17714@deprecation.cyrius.com>
References: <1193468825.7474.6.camel@scarafaggio> <20071030083106.GA16763@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071030083106.GA16763@deprecation.cyrius.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17306
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Martin Michlmayr <tbm@cyrius.com> [2007-10-30 09:31]:
> Adding 131064k swap on /dev/sda2.  Priority:-1 extents:1 across:131064k
> EXT3 FS on sda1, internal journal
> 
> and later:
> 
> gbefb: wait for vpixen_off timed out
> 
> and then I gave up and went to bed. ;-)

Okay, so I can login via SSH but there's still no "login" prompt on
the serial console.  echo foo > /dev/ttyS0 also doesn't work, but
printk()s are shown on the serial console (e.g. when I load a module).
Any ideas, Ralf?
-- 
Martin Michlmayr
http://www.cyrius.com/
