Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Apr 2014 12:56:28 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:53332 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6834664AbaDIK4URIYnI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Apr 2014 12:56:20 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 98EDE660F371F
        for <linux-mips@linux-mips.org>; Wed,  9 Apr 2014 11:56:10 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Wed, 9 Apr
 2014 11:56:12 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 9 Apr 2014 11:56:12 +0100
Received: from [192.168.154.89] (192.168.154.89) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 9 Apr
 2014 11:56:12 +0100
Message-ID: <5345275E.5040703@imgtec.com>
Date:   Wed, 9 Apr 2014 11:56:30 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH 00/14] Initial BPF-JIT support for MIPS
References: <1396957635-27071-1-git-send-email-markos.chandras@imgtec.com> <CAGVrzcZXUWmWO3iuDGPPtKaT1O5qr50LpeSPPHxFCqovkQXzag@mail.gmail.com> <53450AE7.802@imgtec.com> <CAOiHx=nVZ8M12ggf6s1dvQik4rQP9fM3Hr0FGia34tBggVxjQA@mail.gmail.com>
In-Reply-To: <CAOiHx=nVZ8M12ggf6s1dvQik4rQP9fM3Hr0FGia34tBggVxjQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.89]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39744
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

Hi Jonas,

On 04/09/2014 11:11 AM, Jonas Gorski wrote:
> On Wed, Apr 9, 2014 at 10:55 AM, Markos Chandras
> <Markos.Chandras@imgtec.com> wrote:
>> I used in fact only R2 devices. I also use R2 specific instructions such as
>> "ins" and "wsbh". I haven't really considered supporting older ISAs for a
>> couple of reasons. R2 has been around for a long time so a ~7y old device is
>> probably R2 capable. Furthermore, I was not sure whether mips32/64R1 devices
>> are likely to run the latest kernel (and/or use BPF-JIT at all). But I could
>> easily be wrong.
>> Having said that, it's possible to support R1 devices but I'd like to avoid
>> the overhead so a few #ifdefs are needed in the code. My personal preference
>> is to support R2 in the initial patch, and add R1 support later on (along
>> with the optimizations I have in mind).
>
> As far as I can tell on a first glance, you are only using "wsbh", and
> only if the device is running little endian. There is code to emit
> "ins", but it isn't evoked from anywhere.

You are right. Seems like a leftover while I was playing with different 
implementations. I will drop it. Regarding the wsbh, I assume a few ORs 
and shifts will emulate the wsbh instruction for R1. I will have a look 
and provide a v2 soon.

-- 
markos
