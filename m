Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Sep 2015 10:52:29 +0200 (CEST)
Received: from mailout1.w1.samsung.com ([210.118.77.11]:15265 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007837AbbIUIw13pqFz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Sep 2015 10:52:27 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NV000H9DRB88K70@mailout1.w1.samsung.com>; Mon,
 21 Sep 2015 09:52:20 +0100 (BST)
X-AuditID: cbfec7f4-f79c56d0000012ee-8c-55ffc5434d3a
Received: from eusync4.samsung.com ( [203.254.199.214])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id 26.BF.04846.345CFF55; Mon,
 21 Sep 2015 09:52:19 +0100 (BST)
Received: from [106.120.53.23] by eusync4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTPA id <0NV000EUTRB74HA0@eusync4.samsung.com>; Mon,
 21 Sep 2015 09:52:19 +0100 (BST)
Message-id: <55FFC542.5090209@samsung.com>
Date:   Mon, 21 Sep 2015 10:52:18 +0200
From:   Jacek Anaszewski <j.anaszewski@samsung.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130804
 Thunderbird/17.0.8
MIME-version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, Bryan Wu <cooloney@gmail.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-leds@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v2] LED/MIPS: Move SEAD3 LED driver to where it belongs.
References: <20150803150401.GD2843@linux-mips.org>
 <55FA7BA0.4080706@samsung.com> <20150918210549.GD16992@NP-P-BURTON>
In-reply-to: <20150918210549.GD16992@NP-P-BURTON>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsVy+t/xa7rOR/+HGnx9ZGpxdOdEJoutb9Yx
        WkyYOond4vPt7awW9/dtZLe4tEfFYveup6wO7B47Z91l9+jZeYbR4+jKtUwee+b/YPX4vEku
        gDWKyyYlNSezLLVI3y6BK+PDie8sBf85Kh6+ncfcwDiVvYuRk0NCwERi3/NZULaYxIV769m6
        GLk4hASWMkosWLkUynnGKPFk0TwWkCpeAS2Ji+8WMncxcnCwCKhKzJgYDRJmEzCU+PniNROI
        LSoQIfHn9D5WiHJBiR+T74G1ighoSExc0MAOMpNZ4AqjxIXnE9lAEsICPhIbPn8HKxISqJBY
        sOktWDMn0NBTi1+CXccsYCbxqGUdM4QtL7F5zVvmCYwCs5DsmIWkbBaSsgWMzKsYRVNLkwuK
        k9JzDfWKE3OLS/PS9ZLzczcxQoL8yw7GxcesDjEKcDAq8fA6CPwPFWJNLCuuzD3EKMHBrCTC
        qzMLKMSbklhZlVqUH19UmpNafIhRmoNFSZx37q73IUIC6YklqdmpqQWpRTBZJg5OqQbGsEaf
        N+cspFzfPGbZJWYVx2hb5HfO6euec58zLbhi9ALTz+uJB367bfdNi5+F1Sz3kv1/PuegTd4P
        y1YIK0zTtl6w9Hz57kP9Oxacy9luvZ57prNRUYvvBeGal8zf+6xmHl5SfvuMz0S1uPpZRqfD
        nGwdp1vOfbxPuMjk3PKOf7+mR9slmoQqsRRnJBpqMRcVJwIAgwn9C24CAAA=
Return-Path: <j.anaszewski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49248
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: j.anaszewski@samsung.com
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

Hi Paul,

On 09/18/2015 11:05 PM, Paul Burton wrote:
> On Thu, Sep 17, 2015 at 10:36:48AM +0200, Jacek Anaszewski wrote:
>> Hi Ralf,
>>
>> This patch got stuck somewhere in my mailbox and just
>> recently showed up to my eyes again, so I applied it to v4.3-rc1, but when
>> tried to compile-test it, I got following errors:
>>
>> arch/mips/kernel/signal.c: In function 'sc_to_extcontext':
>> arch/mips/kernel/signal.c:143:12: error: 'struct ucontext' has no member
>> named 'uc_extcontext'
>>    return &uc->uc_extcontext;
>>              ^
>
> <snip...>
>
>> Compilation succeeds with v4.2-rc8.
>> Is it a known issue?
>
> Hi Jacek,
>
> The patches adding the MSA extended context added a MIPS-specific
> ucontext.h, where we were previously were using the generic one. Kbuild
> doesn't automatically remove the old generated header that includes the
> generic version, so could you try either cleaning your working tree or
> removing arch/mips/include/generated and trying again?

Thanks for the hint. It works.

I've applied the patch to the for-next branch of linux-leds.git

-- 
Best Regards,
Jacek Anaszewski
