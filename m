Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Dec 2004 16:55:59 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:12271 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225247AbULGQzz>; Tue, 7 Dec 2004 16:55:55 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 42D40186D7; Tue,  7 Dec 2004 08:55:53 -0800 (PST)
Message-ID: <41B5E098.3070107@mvista.com>
Date: Tue, 07 Dec 2004 08:55:52 -0800
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Stickel <michael.stickel@4g-systems.biz>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Ocelot-3 memory configuration patch
References: <20041207003553.GA22456@prometheus.mvista.com> <200412071106.14064.michael.stickel@4g-systems.biz>
In-Reply-To: <200412071106.14064.michael.stickel@4g-systems.biz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6585
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Michael Stickel wrote:
> What if the "memsize" PMON variable is not defined?
> Can that happen. Then the memory size is either 0L,
> or an undefined value.
> Shouldn't it be initialized to 128 by default?
> 
> On Tuesday 07 December 2004 01:35, you wrote:
> 
>>Hi Ralf,
>>
>>Based on your suggestion, I have now modified the Ocelot-3 code
>>to probe for memory that has been configured by PMON. Please review ...
>>
>>Thanks
>>Manish Lachwani
> 
> 
memsize is always defined by PMON

Thanks
Manish Lachwani
