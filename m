Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Mar 2005 18:55:56 +0000 (GMT)
Received: from smtp008.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.170.74]:37537
	"HELO smtp008.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8227131AbVCVSzl>; Tue, 22 Mar 2005 18:55:41 +0000
Received: from unknown (HELO ?192.168.1.101?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp008.bizmail.sc5.yahoo.com with SMTP; 22 Mar 2005 18:55:39 -0000
Message-ID: <42406A2D.6020905@embeddedalley.com>
Date:	Tue, 22 Mar 2005 10:55:41 -0800
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To:  ppopov@embeddedalley.com
Organization: Embedded Alley Solutions, Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Gilad Rom <gilad@romat.com>
CC:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: Au1500 and 1Gbps
References: <42406706.90409@romat.com> <42406826.2040302@embeddedalley.com> <4240693E.3060207@romat.com>
In-Reply-To: <4240693E.3060207@romat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Gilad Rom wrote:
>>>
>>> Any insight? can the Au1500 even try to handle 1000Mbps?
>>
>>
>>
>> Should be easy to get up and running the benchmarked. The Intel 1G 
>> driver (e100?) should run fine on mips with, hopefully, little or no 
>> modifications.
>>
>> Pete
> 
> 
> Do you see any theoretical limitation on the Au1500 which
> would prevent it from utilizing the full 1000Mbps bandwidth?

I haven't done any paper napkin calculations on what it takes to handle the 
smallest packets, worst case, at 1G.  It also depends on what else your CPU is 
doing. If you're just routing packets you'll get a lot better performance then 
you would if you're busy doing something else.

Pete
