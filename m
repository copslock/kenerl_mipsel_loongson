Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2015 16:43:26 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34579 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009467AbbJMOnYYTXH6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2015 16:43:24 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id CBFD112A391B6;
        Tue, 13 Oct 2015 15:43:15 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 13 Oct 2015 15:43:18 +0100
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 13 Oct
 2015 15:43:17 +0100
Subject: Re: [RFC v2 PATCH 09/14] MIPS: add support for generic SMP IPI
 support
To:     Thomas Gleixner <tglx@linutronix.de>
References: <1444731382-19313-1-git-send-email-qais.yousef@imgtec.com>
 <1444731382-19313-10-git-send-email-qais.yousef@imgtec.com>
 <alpine.DEB.2.11.1510131543340.25029@nanos>
CC:     <linux-kernel@vger.kernel.org>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
From:   Qais Yousef <qais.yousef@imgtec.com>
Message-ID: <561D1885.9050708@imgtec.com>
Date:   Tue, 13 Oct 2015 15:43:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1510131543340.25029@nanos>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qais.yousef@imgtec.com
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

On 10/13/2015 02:48 PM, Thomas Gleixner wrote:
> On Tue, 13 Oct 2015, Qais Yousef wrote:
>>   
>> +#ifdef CONFIG_GENERIC_IRQ_IPI
>> +void generic_smp_send_ipi_single(int cpu, unsigned int action)
> Please use a mips name space. This suggests that it s completely
> generic, which is not true.
>
>> +{
>> +	generic_smp_send_ipi_mask(cpumask_of(cpu), action);
>> +}
>> +
>> +void generic_smp_send_ipi_mask(const struct cpumask *mask, unsigned int action)
> Ditto.

OK.

>> +{
>> +	unsigned long flags;
>> +	unsigned int core;
>> +	int cpu;
>> +	struct ipi_mask ipi_mask;
>> +
>> +	ipi_mask.cpumask = ((struct cpumask *)mask)->bits;
> We have accessors for that. Hmm, so for this case we must make the
> ipi_mask different:
>
> struct ipi_mask {
> 	unsigned int	nbits;
> 	bool		global;
> 	union {
>         	     struct cpumask *mask;
> 	     unsigned long  cpu_bitmap[];
> 	};
> };
>

Right. This looks cleaner for sure. Not sure why I haven't though about 
this.

Thanks,
Qais
