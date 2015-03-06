Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Mar 2015 00:23:30 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30168 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007951AbbCFXX2sQ65Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Mar 2015 00:23:28 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0C2A950C29E64;
        Fri,  6 Mar 2015 23:23:19 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 6 Mar
 2015 23:23:22 +0000
Received: from [10.20.2.221] (10.20.2.221) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 6 Mar 2015
 15:23:20 -0800
Message-ID: <54FA36E8.7010501@imgtec.com>
Date:   Fri, 6 Mar 2015 15:23:20 -0800
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Russell King <linux@arm.linux.org.uk>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 04/15] MIPS: Add sched_clock support
References: <1425517137-26463-1-git-send-email-dengcheng.zhu@imgtec.com> <1425517137-26463-5-git-send-email-dengcheng.zhu@imgtec.com> <alpine.LFD.2.11.1503061146430.15786@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1503061146430.15786@eddie.linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.2.221]
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@imgtec.com
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

On 03/06/2015 03:58 AM, Maciej W. Rozycki wrote:
> On Wed, 4 Mar 2015, Deng-Cheng Zhu wrote:
>
>> This will provide sched_clock interface to implement individual
>> read_sched_clock(). Not for CAVIUM_OCTEON_SOC as it defines its own
>> sched_clock() directly (not using the sched_clock_register interface).
>>
>> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
>> ---
>>   arch/mips/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> index 068592a..09405dc 100644
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
>> @@ -43,6 +43,7 @@ config MIPS
>>   	select GENERIC_SMP_IDLE_THREAD
>>   	select BUILDTIME_EXTABLE_SORT
>>   	select GENERIC_CLOCKEVENTS
>> +	select GENERIC_SCHED_CLOCK if !CAVIUM_OCTEON_SOC
>>   	select GENERIC_CMOS_UPDATE
>>   	select HAVE_MOD_ARCH_SPECIFIC
>>   	select VIRT_TO_BUS
>   Why does this change add this question:
>
> ARM Versatile (Express) reference platforms clock source (CLKSRC_VERSATILE) [N/y/?] (NEW) ?

Good catch.

>
> This option enables clock source based on free running
> counter available in the "System Registers" block of
> ARM Versatile, RealView and Versatile Express reference
> platforms.
>
> Symbol: CLKSRC_VERSATILE [=n]
> Type  : boolean
> Prompt: ARM Versatile (Express) reference platforms clock source
>    Location:
>      -> Device Drivers
>        -> Clock Source drivers
>    Defined at drivers/clocksource/Kconfig:216
>    Depends on: GENERIC_SCHED_CLOCK [=y] && !ARCH_USES_GETTIMEOFFSET [=n]
>    Selects: CLKSRC_OF [=n]
>
> to a MIPS configuration?  I find it silly, this appears a platform
> device to me (use reverse dependencies?).

GENERIC_SCHED_CLOCK is generic, by default it uses jiffy_sched_clock_read() 
for read_sched_clock(). Instead of using reverse dependencies, I suggest 
the following:

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 1c2506f..22e0ee1 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -225,7 +225,7 @@ config CLKSRC_QCOM

  config CLKSRC_VERSATILE
         bool "ARM Versatile (Express) reference platforms clock source"
-       depends on GENERIC_SCHED_CLOCK && !ARCH_USES_GETTIMEOFFSET
+       depends on PLAT_VERSATILE && GENERIC_SCHED_CLOCK && 
!ARCH_USES_GETTIMEOFFSET
         select CLKSRC_OF
         default y if MFD_VEXPRESS_SYSREG
         help


Deng-Cheng
