Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Feb 2005 15:41:35 +0000 (GMT)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:8401 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8224934AbVBNPlU>; Mon, 14 Feb 2005 15:41:20 +0000
Received: from sjhill by real.realitydiluted.com with local (Exim 4.44 #1 (Debian))
	id 1D0iLd-0006JN-Le; Mon, 14 Feb 2005 09:41:17 -0600
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <20050214153435.GD806@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Date:	Mon, 14 Feb 2005 09:41:17 -0600 (CST)
CC:	linux-mips@linux-mips.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E1D0iLd-0006JN-Le@real.realitydiluted.com>
From:	sjhill@realitydiluted.com
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7250
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

> Bulletproofing 2.4 against newer tools is something that only makes limited
> sense, especially wrt. to gcc 3.4 and newer.  Chances for any such changes
> to be accepted upstream are slim - and the kernel has traditionally been
> easily affected by overoptimization, so I recommend against gcc 3.4.  The
> recommended compiler for 2.4 is still gcc 2.95.3 but except gcc 3.0 upto
> gcc 3.3 is reasonable and can be considered well tested.
> 
gcc 3.2 has problems with certain optimizations as well. 3.2 should be
used with caution.

-Steve
