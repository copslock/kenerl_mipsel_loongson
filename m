Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2005 17:13:35 +0000 (GMT)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:61725 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225934AbVCDRNU>; Fri, 4 Mar 2005 17:13:20 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j24HCsuP025890;
	Fri, 4 Mar 2005 17:12:54 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j24HCrZV025878;
	Fri, 4 Mar 2005 17:12:53 GMT
Date:	Fri, 4 Mar 2005 17:12:53 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Christophe Jelger <Christophe.Jelger@unibas.ch>
Cc:	linux-mips@linux-mips.org
Subject: Re: Newbie : Cross-compiling module for wrt54g
Message-ID: <20050304171253.GB12169@linux-mips.org>
References: <42272589.7000802@unibas.ch> <1109867344.9625.74.camel@localhost.localdomain> <4228916F.9070600@unibas.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4228916F.9070600@unibas.ch>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 04, 2005 at 05:48:47PM +0100, Christophe Jelger wrote:

> Thanks to people who replied ... I will spend some time trying to build 
> the module and see what happens !
> 
> JP, I don't know if you meant compiling a standard (or a mips ?) 2.4 
> kernel with gcc 3.4.1, but I know it works with gcc 3.3.5 for the 
> standard kernel.

Compiling 2.4 with gcc 3.4 will fail for certain configurations.  Even
where it successfully builds there is always the danger that a more
modern that is aggressive optimizer will do unexpected things to code -
and OS code is very fragile in that aspect.  Thus I recommend to use only
2.95.3 ... 3.3 for Linux 2.4.

For 2.6 anything between 2.95.3 ... 4.0 has been tested - but 4.0 is still
a bit on the daring side while 3.4 has been tested well on many platforms.

Of course you may always be lucky - or have too much time on your hands ;-)

  Ralf
