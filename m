Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Mar 2004 16:51:31 +0000 (GMT)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:32138 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225384AbUCEQva>; Fri, 5 Mar 2004 16:51:30 +0000
Received: from localhost ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.36 #1 (Debian))
	id 1AzIWu-0005tK-00; Fri, 05 Mar 2004 10:50:32 -0600
Message-ID: <4048AF9E.2060401@realitydiluted.com>
Date: Fri, 05 Mar 2004 11:49:34 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: linux-mips@linux-mips.org
Subject: Re: gcc 3.2.0 bug causes kernel failure
References: <20040305152206.GA21264@linux-mips.org>
In-Reply-To: <20040305152206.GA21264@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> Me and Steven have tracked down a LTP failure in the capget tests to a
> bug in gcc 3.2.0.  Reducing optimization to just -O seems to solve the
> problem.  To this point we've found the capget LTP problem with 2.4
> kernel built with 3.2.0; 2.6.3 built with 2.95.4 seems to be ok.  We've
> also only tested 32-bit kernels.  We'de be interested in test results
> from other configurations, in particular 2.4 kernels built by later 3.2.x
> compiler revisions would be of interest.
> 
Further investigation of GCC 3.2.0 compiler optimizations shows that the
'-fschedule-insns' is to blame for incorrect code generation. By adding
the option '-fno-schedule-insns' correct code will be generated. This
was verified with the following instruction schedulings:

    -mcpu=r4300 -mips2
    -mcpu=r4600 -mips2
    -mcpu=r5000 -mips2

All of these exhibit the same failure. They also exhibit the same success
when the above compiler option is used. Thanks again to Ralf for giving
me more ideas to try and verify this. I have not verified that newer
gcc-3.2.x or gcc-3.3 versions fix this problem. Comments and more testing
are welcome. Thanks.

-Steve
