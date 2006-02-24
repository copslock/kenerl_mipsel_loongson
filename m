Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2006 01:24:19 +0000 (GMT)
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:34728 "EHLO
	rwcrmhc12.comcast.net") by ftp.linux-mips.org with ESMTP
	id S8133748AbWBXBX4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Feb 2006 01:23:56 +0000
Received: from [192.168.1.4] (unknown[69.140.185.48])
          by comcast.net (rwcrmhc12) with ESMTP
          id <20060224013028m12001gumle>; Fri, 24 Feb 2006 01:30:28 +0000
Message-ID: <43FE61AD.1010802@gentoo.org>
Date:	Thu, 23 Feb 2006 20:30:21 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	jblache@debian.org
Subject: Re: IP22 doesn't shutdown properly
References: <20060217225824.GE20785@deprecation.cyrius.com> <20060223221350.GA5239@deprecation.cyrius.com> <20060223224346.GA7536@flint.arm.linux.org.uk> <20060224003947.GJ9704@deprecation.cyrius.com>
In-Reply-To: <20060224003947.GJ9704@deprecation.cyrius.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10633
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Martin Michlmayr wrote:
> * Russell King <rmk@arm.linux.org.uk> [2006-02-23 22:43]:
>> Looking at the ip22 driver, it seems that if shutdown() is called for
>> the console port, the driver does _nothing_.
> 
> sunzilog.c does the same, and it's based on a comment by you (quoted
> right before shutdown()).  Anyway, I don't quite understand the
> comment but maybe Ralf (or you) can write a patch.

iirc, ip22zilog was based heavily off of sunzilog in the early days of the 2.6.x 
port.  So I wouldn't be surprised if both contain similar sets of bugs. 
Probably be interesting to see if the Sparc people found any more and fixed that 
might still exist in ip22zilog.


--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
