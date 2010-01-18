Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jan 2010 19:08:41 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19612 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492706Ab0ARSIi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jan 2010 19:08:38 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b54a3a60000>; Mon, 18 Jan 2010 10:08:38 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 18 Jan 2010 10:08:32 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 18 Jan 2010 10:08:32 -0800
Message-ID: <4B54A3A0.5080101@caviumnetworks.com>
Date:   Mon, 18 Jan 2010 10:08:32 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     wuzhangjin@gmail.com
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Sergei Shtylyov <sshtylyov@ru.mvista.com>,
        David Daney <david.s.daney@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH v6] MIPS: Add a high resolution sched_clock() via cnt32_to_63().
References: <1259319110-16107-1-git-send-email-wuzhangjin@gmail.com> <1263801284.11671.50.camel@falcon>
In-Reply-To: <1263801284.11671.50.camel@falcon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Jan 2010 18:08:32.0367 (UTC) FILETIME=[3EA80FF0:01CA9869]
X-archive-position: 25604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 11977

Wu Zhangjin wrote:
> If the processor support dynamic cpu frequency and the support is
> enabled in kernel, this sched_clock() implementation will be broken(and
> If the frequency of the MIPS CP0 counter is related to the cpu's
> frequency).
> 
> So, some extra resitrictions should be added to it.
> 
> arch/mips/Kconfig
> 
> config CPU_HAS_FIXED_CP0_COUNTER
> 	bool
> 
> config SYS_SUPPORTS_HRES_SCHED_CLOCK
> 	bool
> 	depends on CPU_HAS_FIXED_CP0_COUNTER || !CPU_FREQ
> 
> arch/mips/kernel/csrc-r4k.c
> 
> #ifdef SYS_SUPPORTS_HRES_SCHED_CLOCK
> 
> /* The high resolution version of sched_clock() */
> 
> #endif
> 
> And I'm not sure whether the cavium octeon support dynamic cpu
> frequency,

Not currently...

> if yes, it's high resolution version of sched_clock() also
> should be wrapped with the above macro to ensure it is not broken:
> 
> arch/mips/cavium-octeon/csrc-octeon.c
> 

... So this is not applicable.


> Regards,
> 	Wu Zhangjin
> 
