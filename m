Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Aug 2017 12:49:34 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:42464 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993877AbdH3Kt0sL5KP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Aug 2017 12:49:26 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 3E675888AB550;
        Wed, 30 Aug 2017 11:49:16 +0100 (IST)
Received: from [10.150.130.83] (10.150.130.83) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 30 Aug
 2017 11:49:18 +0100
Subject: Re: Maintenance of Linux/MIPS?
To:     David Daney <ddaney@caviumnetworks.com>,
        Paul Burton <paul.burton@imgtec.com>,
        <linux-mips@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>, <ralf@linux-mips.org>
CC:     <john@phrozen.org>, <david.daney@cavium.com>,
        James Hogan <james.hogan@imgtec.com>
References: <c96eaa42-ab7f-d902-746c-c6cff242c596@gmail.com>
 <1539189.Q9sWsqvfCA@np-p-burton>
 <5e78f983-04fd-0357-c580-1438cdf1bc27@caviumnetworks.com>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <33db77a2-32e4-6b2c-d463-9d116ba55623@imgtec.com>
Date:   Wed, 30 Aug 2017 11:49:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <5e78f983-04fd-0357-c580-1438cdf1bc27@caviumnetworks.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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



On 26/08/17 00:14, David Daney wrote:
> On 08/25/2017 04:07 PM, Paul Burton wrote:
>> Hello,
>>
>> On Friday, 25 August 2017 14:21:33 PDT Florian Fainelli wrote:
>>> Hi,
>>>
>>> There are a lot of patches at
>>> https://patchwork.linux-mips.org/project/linux-mips/list/ that 
>>> appear to
>>> be under the "New" state and have not had a chance to be reviewed yet.
>>>
>>> What can we do to help speed up the review process, do we need more
>>> reviewers? It seems like most patches affecting Linux/MIPS are still
>>> core MIPS kernel changes, but would it help if say, people were queuing
>>> SoC/board specific patches in trees and submit pull requests? Would 
>>> that
>>> help lower the amount of patches to review?
>>>
>>> Any other suggestion?
>>>
>>> Thanks!
>>
>> Personally I think it'd probably be good if Ralf were willing to 
>> formally
>> share maintainership duties with someone else or a group of people. I 
>> think
>> James for example would be a great choice, and already dons a 
>> maintainer hat.
>
> FWIW, I agree.  James has a lot of experience here and has served as 
> maintainer when Ralf was away in the past.  Making him a permanent 
> co-maintainer, or similar, with the explicit mandate of getting 
> patches upstream to Linus, would be beneficial to all who rely on the 
> MIPS Linux kernel.
>
> David.

I'd add my vote to having James as a co-maintainer, which should help 
lower the burden on Ralf and hopefully lead to a faster 
time-to-upstream, as currently quite a few series have required 
respinning simply because the kernel has moved on while they wait and 
the patches have bitrotted.

Matt

>
>
>
>>
>> As-is Ralf ends up being a bottleneck a lot of the time, and the 
>> backlog in
>> patchwork is pretty good evidence of that. There are a whole lot of 
>> patches
>> that ought to be going into v4.14, and that ought to be sat in 
>> linux-next
>> right now in preparation for that. Sadly not many of them are, and 
>> usually
>> that remains the case until very close to the merge window. Sharing 
>> the load
>> could only help with this.
>>
>> Thanks,
>>      Paul
>>
>
>
