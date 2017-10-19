Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2017 15:23:10 +0200 (CEST)
Received: from 20pmail.ess.barracuda.com ([64.235.150.246]:34803 "EHLO
        20pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992540AbdJSNXDEzo7f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Oct 2017 15:23:03 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx30.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 19 Oct 2017 13:22:52 +0000
Received: from [10.150.130.83] (10.150.130.83) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 19 Oct
 2017 06:21:25 -0700
Subject: Re: [PATCH 1/3] clockevents: Retry programming min delta up to 10
 times
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        James Hogan <james.hogan@mips.com>,
        <linux-mips@linux-mips.org>, James Hogan <jhogan@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        <linux-kernel@vger.kernel.org>
References: <1508414135-29123-1-git-send-email-matt.redfearn@mips.com>
 <alpine.DEB.2.20.1710191435280.1971@nanos>
From:   Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <5b782526-b130-77f2-6d9a-15839e12e065@mips.com>
Date:   Thu, 19 Oct 2017 14:21:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1710191435280.1971@nanos>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1508419365-637140-11545-577074-8
X-BESS-VER: 2017.12-r1710102214
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186116
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips



On 19/10/17 13:43, Thomas Gleixner wrote:
> On Thu, 19 Oct 2017, Matt Redfearn wrote:
>>   	unsigned long long clc;
>>   	int64_t delta;
>> +	int i;
>>   
>> -	delta = dev->min_delta_ns;
>> -	dev->next_event = ktime_add_ns(ktime_get(), delta);
>> +	for (i = 0;;) {
> Bah. What's wrong with
>
> 	for (i = 0; i < 10; i++) {
>
> 	    	....
> 		if (!(dev->set_next_event((unsigned long) clc, dev))
> 			return 0;
> 	}
> 	return -ETIME;
>
> Hmm?

Sure, can make it like that.

>> +		delta = dev->min_delta_ns;
>> +		dev->next_event = ktime_add_ns(ktime_get(), delta);
>>   
>> -	if (clockevent_state_shutdown(dev))
>> -		return 0;
>> +		if (clockevent_state_shutdown(dev))
>> +			return 0;
>>   
>> -	dev->retries++;
>> -	clc = ((unsigned long long) delta * dev->mult) >> dev->shift;
>> -	return dev->set_next_event((unsigned long) clc, dev);
>> +		dev->retries++;
>> +		clc = ((unsigned long long) delta * dev->mult) >> dev->shift;
> I'd rather make that:
>
> 	delta = 0;
> 	for (i = 0; i < 10; i++) {
> 		delta += dev->min_delta_ns;
> 		dev->next_event = ktime_add_ns(ktime_get(), delta);
> 		clc = .....
> 	   	.....
>
> That makes it more likely to succeed fast. Hmm?

That will set the target time to increasing multiples of min_delta_ns in 
the future, right? Sure, it should make it succeed faster - I'll make it 
like that. Are you OK with the arbitrarily chosen 10 retries?

Thanks,
Matt

>
> Thanks,
>
> 	tglx
