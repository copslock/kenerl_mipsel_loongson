Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2015 19:42:40 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:36831 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010654AbbAISmit2NNE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Jan 2015 19:42:38 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9BECC351470DA
        for <linux-mips@linux-mips.org>; Fri,  9 Jan 2015 18:42:29 +0000 (GMT)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 9 Jan
 2015 18:42:33 +0000
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Fri, 9 Jan
 2015 18:42:32 +0000
Received: from [192.168.65.146] (192.168.65.146) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 9 Jan 2015
 10:42:29 -0800
Message-ID: <54B02115.7090609@imgtec.com>
Date:   Fri, 9 Jan 2015 10:42:29 -0800
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Paul Burton <Paul.Burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Markos Chandras <Markos.Chandras@imgtec.com>
Subject: Re: MIPS,prctl: add PR_[GS]ET_FP_MODE prctl options for MIPS
References: <1420719457-690-1-git-send-email-paul.burton@imgtec.com> <54AF3C2C.7040807@imgtec.com> <6D39441BF12EF246A7ABCE6654B0235320F9B4C3@LEMAIL01.le.imgtec.org>
In-Reply-To: <6D39441BF12EF246A7ABCE6654B0235320F9B4C3@LEMAIL01.le.imgtec.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

On 01/09/2015 12:34 AM, Matthew Fortune wrote:
> Leonid Yegoshin <Leonid.Yegoshin@imgtec.com> writes:
>>
>> This piece of thread walking seems to be not thread safe for newly
>> created thread.
>> Thread creation is not locked between points of copy_thread which copies
>> task thread flags and makeing thread visible to walking via
>> "for_each_thread".
>>
>> So it is possible in environment with two threads - one is creating an
>> another thread, another one switching FPU mode and waiting and race
>> condition may causes a newly thread in old mode but the rest of thread
>> group is in new mode.
>>
>> Besides that, it looks like in kernel with tickless mode a scheduler may
>> no come a long time in idle system, in extreme case - forever.
> Only commenting on the tickless issue... The requirement for the
> PR_SET_FP_MODE call is that all threads in the current thread group switch
> to the new mode prior to it returning. I believe that simply means there
> is no alternative other than for the tickless case to wait as long as it
> has to wait? If the prctl failed in tickless mode (or timed out) then that
> is likely to lead to a program failing to load its libraries and aborting.
There is another design, which doesn't use walk through all thread group 
and any scheduler wait.
It is based on IPI call to kick off threads-from-this-memory-map from 
FPU usage in all CPUs and keeping/updating the real FPU mode flag in 
memory map "context".

I have it and will post it to internal IMG mail list (currently, it 
doesn't use "prctl" but "sysmips" syscall, and is designed around 3.10 
kernel).

- Leonid.
