Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Mar 2004 20:12:01 +0000 (GMT)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:30864 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225226AbUCEUMA>; Fri, 5 Mar 2004 20:12:00 +0000
Received: from localhost ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.36 #1 (Debian))
	id 1AzLew-00067k-00; Fri, 05 Mar 2004 14:11:02 -0600
Message-ID: <4048DE9D.6050002@realitydiluted.com>
Date: Fri, 05 Mar 2004 15:10:05 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Steven J. Hill" <sjhill@realitydiluted.com>
CC: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: gcc 3.2.0 bug causes kernel failure
References: <20040305152206.GA21264@linux-mips.org> <4048AF9E.2060401@realitydiluted.com>
In-Reply-To: <4048AF9E.2060401@realitydiluted.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Steven J. Hill wrote:
> 
> All of these exhibit the same failure. They also exhibit the same success
> when the above compiler option is used. Thanks again to Ralf for giving
> me more ideas to try and verify this. I have not verified that newer
> gcc-3.2.x or gcc-3.3 versions fix this problem. Comments and more testing
> are welcome. Thanks.
>
I have confirmed that the bug for this issue was fixed in GCC 3.2.3. If you
need to use the GCC 3.2.x series, please use the 3.2.3 version. Thanks.

-Steve
