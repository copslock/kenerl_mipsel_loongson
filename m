Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Oct 2015 21:46:38 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30647 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010042AbbJ0UqgoRB9J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Oct 2015 21:46:36 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A38885705046B;
        Tue, 27 Oct 2015 20:46:27 +0000 (GMT)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 27 Oct
 2015 20:46:30 +0000
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.235.1; Tue, 27 Oct
 2015 20:46:30 +0000
Received: from [10.20.3.92] (10.20.3.92) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 27 Oct
 2015 13:46:28 -0700
Message-ID: <562FE29C.8040106@imgtec.com>
Date:   Tue, 27 Oct 2015 13:46:20 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <linux-mips@linux-mips.org>, Alex Smith <alex.smith@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [v3, 3/3] MIPS: VDSO: Add implementations of gettimeofday() and
 clock_gettime()
References: <1445417864-31453-1-git-send-email-markos.chandras@imgtec.com> <5629904A.2070400@imgtec.com> <20151027144748.GA23785@linux-mips.org>
In-Reply-To: <20151027144748.GA23785@linux-mips.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.92]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49723
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

On 10/27/2015 07:47 AM, Ralf Baechle wrote:
> On Thu, Oct 22, 2015 at 06:41:30PM -0700, Leonid Yegoshin wrote:
>
>> You can not use R4K CP0_count in SMP (multicore) without core-specific
>> adjustment.
>> After first power-saving with core clock off or core down the values in
>> CP0_count
>> in different cores are absolutely different.
>>
>> Until you include in system a patch like
>> http://patchwork.linux-mips.org/patch/10871/
>>
>>      "MIPS: Setup an instruction emulation in VDSO protected page instead of
>> user stack"
>>
>> which creates a per-thread memory and put into that memory an adjustment
>> value
>> (which can be changed during re-schedule to another core), the use of R4K
>> counter is incorrect
>> in SMP environment.
>>
>> Note: It is also possible to setup and maintain a per-core page with that
>> value too as
>> an alternative variant for adjustment.
> The CPU hot plugging code is supposed to resychronize the counters when
> a CPU is coming online again so that case should be handled.  Beyond that
> the r4k timer code in the kernel also doesn't support clock scaling
> so I'm ok if the VDSO series doesn't support this properly.
>
>    Ralf

I doesn't work in this way - a standard CP0_counter synchronization code 
takes up to hundred milliseconds to complete with running some loop 
cycles on two CPUs. It is clearly seen in Malta FPGA board.

Non-standard (one way sync, write CP0_counter value to memory in CPU0 
before CPU1 wakeup) is not precise because it can't predict how much 
time the CPU1 can spent in wakeup. Just because of HW, for exam, and SW 
next.

I believe, until this issue is fixed the R4K only CPU should be excluded 
from VDSO timing acceleration.

And finally. clock scaling - what we would do if there are two CPUs with 
different clock ratios in system? It seems like common kernel timing 
subsystem can handle that.

- Leonid.
