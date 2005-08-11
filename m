Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Aug 2005 10:01:46 +0100 (BST)
Received: from smtp.wicomtechnologies.com ([IPv6:::ffff:195.234.214.162]:8149
	"EHLO smtp.wicomtechnologies.com") by linux-mips.org with ESMTP
	id <S8225244AbVHKJBb>; Thu, 11 Aug 2005 10:01:31 +0100
Received: from [192.168.0.24] (wcm-24.wicom.kiev.ua [192.168.0.24] (may be forged))
	by smtp.wicomtechnologies.com (8.12.10/8.12.10) with ESMTP id j7B95TlG033027;
	Thu, 11 Aug 2005 12:05:29 +0300 (EEST)
	(envelope-from jerry@wicomtechnologies.com)
Date:	Thu, 11 Aug 2005 12:05:27 +0300
From:	Jerry <jerry@wicomtechnologies.com>
X-Mailer: The Bat! (v3.51.10) Professional
Reply-To: Jerry <jerry@wicomtechnologies.com>
X-Priority: 3 (Normal)
Message-ID: <1905543925.20050811120527@wicomtechnologies.com>
To:	jaypee@hotpop.com
CC:	linux-mips@linux-mips.org
Subject: Re: Au1xxx ethernet race condition?
In-Reply-To: <1123749337l.30285l.5l@cavan>
References: <1123749337l.30285l.5l@cavan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <jerry@wicomtechnologies.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jerry@wicomtechnologies.com
Precedence: bulk
X-list: linux-mips

>[In reply to "Au1xxx ethernet race condition?" from jaypee@hotpop.com <jaypee@hotpop.com> to linux-mips <linux-mips@linux-mips.org>  11.08.2005 11:35]

> I'm sure this is overkill. Can anyone else confirm?
> a) they see the problem
> b) that there is a better solution

> As an aside, the network stack for the 2.6 kernel is pretty slow, as  
> large 32k udp pckts don't use anywhere near the amount of cycles that
> 1.5k udp pckts do.
> Suggests to me that it is the udp/ip path that is the bottleneck.

We are dealing with au1200 and there are some problems around
at least with udp timeouts and maybe low perfomance. But it
seems to be driver problems (occurs both in 2.4 and 2.6) besides
au1200 does not use au1000_eth.c

Maybe your problem is somewhere else, and maybe it is completely
different.



   ()_()
 -( ^,^ )- -[21398845]- -<The Bat! 3.51.10>- -<11.08.2005 11:47>-
  (") (")
