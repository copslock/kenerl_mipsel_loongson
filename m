Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Feb 2005 12:30:04 +0000 (GMT)
Received: from p3EE07C05.dip.t-dialin.net ([IPv6:::ffff:62.224.124.5]:39794
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225003AbVBCM3u>; Thu, 3 Feb 2005 12:29:50 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j13CTmxN008642;
	Thu, 3 Feb 2005 13:29:48 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id j13CThwR008641;
	Thu, 3 Feb 2005 13:29:44 +0100
Date:	Thu, 3 Feb 2005 13:29:43 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Nori, Soma Sekhar" <nsekhar@ti.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Dealing with RAM not starting at 0x00000000
Message-ID: <20050203122943.GA8509@linux-mips.org>
References: <F6B01C6242515443BB6E5DDD63AE935F04682B@dbde2k01.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F6B01C6242515443BB6E5DDD63AE935F04682B@dbde2k01.itg.ti.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 01, 2005 at 03:06:29PM +0530, Nori, Soma Sekhar wrote:

> I am working towards porting 2.6.10 kernel on a mips 4kec based board
> which has physical memory starting at 0x14000000.
> What is the best way to overcome the "hole" from 0x00000000 to
> 0x14000000 without incuring a huge memory overhead.
> (For exception handling there is 4k of RAM kept at 0x00000000 also - but
> I guess linux paging need need not be aware of this small RAM)

You can set PAGE_OFFSET to 0x94000000.  If you do this you're probably
going to run into a few bugs where PAGE_OFFSET is assumed to be KSEG0,
that is 0x80000000.  Nothing dramatic though.

  Ralf
