Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Dec 2004 03:09:09 +0000 (GMT)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:7326 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225361AbULPDJE>; Thu, 16 Dec 2004 03:09:04 +0000
Received: from localhost ([127.0.0.1])
	by real.realitydiluted.com with esmtp (Exim 4.34 #1 (Debian))
	id 1Cem0b-00048C-BQ; Wed, 15 Dec 2004 21:08:53 -0600
Message-ID: <41C0FD66.6060206@realitydiluted.com>
Date: Wed, 15 Dec 2004 21:13:42 -0600
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
References: <20041216030425Z8225321-1751+3720@linux-mips.org>
In-Reply-To: <20041216030425Z8225321-1751+3720@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

sjhill@linux-mips.org wrote:
> 
> Log message:
> 	Remove obsolete MAX1617 driver code. The 'adm1021' driver handles both
> 	the 1617 and 1617a with a minor modification. This chip now works properly
> 	on SiByte Swarm boards.

Ralf,

A lot of the I2C code, specifically the headers files in 'include/linux' need
to be pushed back to the I2C maintainers. Would you like me to make the patches
and do that, or do you have time?

-Steve
