Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 03:36:45 +0100 (CET)
Received: from forward.webhostbox.net ([204.11.59.73]:48384 "EHLO
        forward.webhostbox.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013674AbcCQCgoEVBB4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 03:36:44 +0100
Received: from bh-25.webhostbox.net (unknown [172.16.210.69])
        by forward.webhostbox.net (Postfix) with ESMTP id 9142B19D4D;
        Thu, 17 Mar 2016 02:36:42 +0000 (GMT)
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:36446 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.86_1)
        (envelope-from <linux@roeck-us.net>)
        id 1agNnm-004NLp-8K; Thu, 17 Mar 2016 02:36:42 +0000
Subject: Re: linux-next: Tree for Mar 14 (mips qemu failure bisected)
To:     Qais Yousef <qsyousef@gmail.com>
References: <20160314174037.0097df55@canb.auug.org.au>
 <20160314143729.GA31845@roeck-us.net> <20160315052659.GA9320@roeck-us.net>
 <56E884BA.5050103@gmail.com> <20160316001713.GA4412@roeck-us.net>
 <20160316132210.GA21918@roeck-us.net> <56E9C1CA.7050208@gmail.com>
 <56E9DB85.9090405@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <56EA1839.8010807@roeck-us.net>
Date:   Wed, 16 Mar 2016 19:36:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <56E9DB85.9090405@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.1 cv=MpLykzue c=1 sm=1 tr=0
        a=9TTQYYGGY7a1eFc7Vblcuw==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
        a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
        a=7OsogOcEt9IA:10 a=eGuZYyiZVCMyFN132DIA:9 a=QEXdDO2ut3YA:10
Return-Path: <SRS0+9h8u=PN=roeck-us.net=linux@forward.webhostbox.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 03/16/2016 03:17 PM, Qais Yousef wrote:
> On 16/03/2016 20:27, Qais Yousef wrote:
>>
>>
>> On 16/03/2016 13:22, Guenter Roeck wrote:
>>> On Tue, Mar 15, 2016 at 05:17:13PM -0700, Guenter Roeck wrote:
>>>> On Tue, Mar 15, 2016 at 09:55:06PM +0000, Qais Yousef wrote:
>>>>> Hi Guenter,
>>>>>
>>> [ ... ]
>>>>>>> Qemu test results:
>>>>>>>     total: 96 pass: 69 fail: 27
>>>>>>> Failed tests:
>>>>>> [ ... ]
>>>>>>>     mips:mips_malta_smp_defconfig
>>>>>> I bisected this failure to commit bb11cff327e54 ("MIPS: Make smp CMP, CPS and MT
>>>>>> use the new generic IPI functions". Bisect log is attached.
>>>>> Thanks for bisecting this. I tested this on a real Malta system but not
>>>>> qemu. I'll try to reproduce.
>>>>>
>>>> I run the tests with only a single CPU core enabled. Maybe that causes
>>>> problems with your code ?
>>>>
>>> I ran another qemu test (this time on mainline) with "-smp 2", but the only
>>> difference is that the image now gets stuck even earlier.
>>>
>>> Also, I ran another set of bisects, this time with both mips and mips64
>>> on mainline (after your patch landed), with the same results.
>>>
>>> Guenter
>>>
>>
>> OK thanks for the info. The offending commit just enables using quite a few of the newly added code before that. So the problem could be in any of the newly added code.
>>
>> Unfortunately I can only look at this during my limited time in the evening and I have to setup my system to compile and run this, so I won't be able to get to the bottom of this as fast as I'd like to.
>>
>> Qais
>
> OK I was up and running faster than I thought I would be. Can you confirm that you're hitting a BUG_ON() in mips_smp_ipi_init()?
>
> What I see is that BUG_ON() is hit because we couldn't find an ipidomain to allocate the ipis from. The reason of whih is that the qemu malta machine doesn't have a GIC though the config is compiled with GIC on. Also if I remember correctly qemu malta doesn't really support SMP. I think that was the reason I never ran this on qemu.

Turns out MIPS_GIC is auto-selected by MIPS_MALTA, so I can not just unconfigure it.
Too bad. That means if your patch isn't accepted, I'll have to drop the mips
SMP build runtime tests, unless you have a better idea.

Thanks,
Guenter
