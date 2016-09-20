Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2016 17:32:14 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41442 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992161AbcITPcIJnryo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Sep 2016 17:32:08 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 893204B67ADA0;
        Tue, 20 Sep 2016 16:31:48 +0100 (IST)
Received: from [10.150.130.83] (10.150.130.83) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 20 Sep
 2016 16:31:51 +0100
Subject: Re: [PATCH v2 5/6] remoteproc/MIPS: Add a remoteproc driver for MIPS
To:     Thomas Gleixner <tglx@linutronix.de>
References: <1474361249-31064-1-git-send-email-matt.redfearn@imgtec.com>
 <1474361249-31064-6-git-send-email-matt.redfearn@imgtec.com>
 <alpine.DEB.2.20.1609201141120.6905@nanos>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>, <linux-mips@linux-mips.org>,
        <linux-remoteproc@vger.kernel.org>, <lisa.parratt@imgtec.com>,
        <linux-kernel@vger.kernel.org>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <95f3d60f-5d4d-aa6d-c94c-c21f717872d0@imgtec.com>
Date:   Tue, 20 Sep 2016 16:31:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1609201141120.6905@nanos>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55216
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

Hi Thomas,


On 20/09/16 10:47, Thomas Gleixner wrote:
> On Tue, 20 Sep 2016, Matt Redfearn wrote:
>> +/* Intercept CPU hotplug events for syfs purposes */
>> +static int mips_rproc_callback(struct notifier_block *nfb, unsigned long action,
>> +			       void *hcpu)
>> +{
> Please convert to cpu hotplug state machine.

OK, I've done that for this and the MIPS GIC patch, using the dynamic 
CPUHP_AP_ONLINE_DYN state - I hope that is ok.

>
>> +	unsigned int cpu = (unsigned long)hcpu;
>> +
>> +	switch (action) {
>> +	case CPU_UP_PREPARE:
>> +	case CPU_DOWN_FAILED:
>> +		mips_rproc_device_unregister(cpu);
>> +		break;
>> +	case CPU_DOWN_PREPARE:
>> +		mips_rproc_device_register(cpu);
>> +		break;
>> +	}
> There is no reason why you need to setup the rproc device on
> DOWN_PREPARE. It's sufficient to do that when the CPU is dead, so you can
> use a symetric callback prep/dead.

Sure, the new state machine makes this much nicer registering the 
on/offline callbacks on one state.

>
>> +	/* Dynamically create mips-rproc class devices based on hotplug data */
>> +	get_online_cpus();
>> +	for_each_possible_cpu(cpu)
>> +		if (!cpu_online(cpu))
>> +			mips_rproc_device_register(cpu);
>> +	register_hotcpu_notifier(&mips_rproc_notifier);
>> +	put_online_cpus();
> Perhaps we should add support for "reverse" functionality to the state
> machine core. I'll have a look later how hard that'd be.

Yeah - I've had to work around the framework a little here since we 
require the opposite sense to the callbacks - activate the driver when 
the cpu is offlined and vice versa. In practice the only issue this gave 
me was that by default the framework invokes the teardown callback when 
the state is removed, so I used __cpuhp_remove_state() to avoid creating 
a remote processor device as the driver is being removed.

Thanks,
Matt

>
> Thanks,
>
> 	tglx
