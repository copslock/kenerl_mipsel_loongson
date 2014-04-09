Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Apr 2014 10:54:54 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:56876 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6821191AbaDIIyw40-YO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Apr 2014 10:54:52 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id BBD0845D25C91;
        Wed,  9 Apr 2014 09:54:43 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Wed, 9 Apr
 2014 09:54:45 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 9 Apr 2014 09:54:45 +0100
Received: from [192.168.154.89] (192.168.154.89) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 9 Apr
 2014 09:54:44 +0100
Message-ID: <53450AE7.802@imgtec.com>
Date:   Wed, 9 Apr 2014 09:55:03 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 00/14] Initial BPF-JIT support for MIPS
References: <1396957635-27071-1-git-send-email-markos.chandras@imgtec.com> <CAGVrzcZXUWmWO3iuDGPPtKaT1O5qr50LpeSPPHxFCqovkQXzag@mail.gmail.com>
In-Reply-To: <CAGVrzcZXUWmWO3iuDGPPtKaT1O5qr50LpeSPPHxFCqovkQXzag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.89]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

Hi Florian,

On 04/08/2014 07:38 PM, Florian Fainelli wrote:
> Hi,
>
> 2014-04-08 4:47 GMT-07:00 Markos Chandras <markos.chandras@imgtec.com>:
>> Hi,
>>
>> This adds support for BPF-JIT for MIPS. Tested on mips32 LE/BE and mips64 BE
>> with a few networking tools such as tcpdump and dhcp but not all opcodes have
>> been tested as far as I can tell. There are a few optimizations left to be made
>> (fastpath for load operations instead of calling the helper functions) but
>> these can be added later on. If someone has complex network setups in place and
>> would like to give it a try, that would be much appreciated.
>>
>> This patchset is for the upstream-sfr/mips-for-linux-next tree
>
> You should have probably CC'd netdev@vger.kernel.org to get their
> review on the specific JIT implementation.
>
> BPF_JIT is made conditional to MIPS32/64R2 processors, I could not
> spot easily in the implementation whether this is because you are
> using r2-only instructions, or this is just the targets you tested. Is
> there any chance to make that work on MIPS32r1 CPUs for instance?
> Those are used in low-end devices which could benefit from such a
> performance boost.
>
> Thanks!
>
>>

I used in fact only R2 devices. I also use R2 specific instructions such 
as "ins" and "wsbh". I haven't really considered supporting older ISAs 
for a couple of reasons. R2 has been around for a long time so a ~7y old 
device is probably R2 capable. Furthermore, I was not sure whether 
mips32/64R1 devices are likely to run the latest kernel (and/or use 
BPF-JIT at all). But I could easily be wrong.
Having said that, it's possible to support R1 devices but I'd like to 
avoid the overhead so a few #ifdefs are needed in the code. My personal 
preference is to support R2 in the initial patch, and add R1 support 
later on (along with the optimizations I have in mind).

-- 
markos
