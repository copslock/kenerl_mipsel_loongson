Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2007 08:31:35 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:9477 "EHLO sorrow.cyrius.com")
	by ftp.linux-mips.org with ESMTP id S20023670AbXJ3Ib1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 30 Oct 2007 08:31:27 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 178CCD8D1; Tue, 30 Oct 2007 08:31:21 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 2E8C554501; Tue, 30 Oct 2007 09:31:07 +0100 (CET)
Date:	Tue, 30 Oct 2007 09:31:07 +0100
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.4.24-rc1 does not boot on SGI
Message-ID: <20071030083106.GA16763@deprecation.cyrius.com>
References: <1193468825.7474.6.camel@scarafaggio>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1193468825.7474.6.camel@scarafaggio>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org> [2007-10-27 09:07]:
> The new kernel once again does not boot on SGI O2. What happens is that
> arcboot write its messages and nothing more is displayed on the screen.
> The last message is "Starting ELF64 kernel". The previous running kernel
> were 2.6.23 from linux-mips.org and 2.6.23.1 from kernel.org.

I can confirm that currnt git doesn't boot (no message on the serial
console at all).  However, I'm curious to know whether 2.6.23 is
working properly for you (and, if so, can you send me your .config).
For me, it stops after printing

Freeing unused kernel memory: 268k freed

but then I can still hear it doing something and after a minute or so
I see:

Adding 131064k swap on /dev/sda2.  Priority:-1 extents:1 across:131064k
EXT3 FS on sda1, internal journal

and later:

gbefb: wait for vpixen_off timed out

and then I gave up and went to bed. ;-)
-- 
Martin Michlmayr
http://www.cyrius.com/
