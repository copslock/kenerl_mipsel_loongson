Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Sep 2015 16:08:38 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11961 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009069AbbI3OIhjhTPK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Sep 2015 16:08:37 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id EFCBAB60636AC;
        Wed, 30 Sep 2015 15:08:27 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 30 Sep 2015 15:08:30 +0100
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 30 Sep
 2015 15:08:30 +0100
Subject: Re: [PATCH 0/6] Implement generic IPI support mechanism
To:     Thomas Gleixner <tglx@linutronix.de>
References: <1443019758-20620-1-git-send-email-qais.yousef@imgtec.com>
 <5602D958.6000003@linux.intel.com> <5603B6CA.7050601@imgtec.com>
 <alpine.DEB.2.11.1509292101420.4500@nanos> <560BE4F3.7060607@imgtec.com>
 <alpine.DEB.2.11.1509301602160.4500@nanos>
CC:     Jiang Liu <jiang.liu@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <marc.zyngier@arm.com>,
        <jason@lakedaemon.net>, <linux-mips@linux-mips.org>
From:   Qais Yousef <qais.yousef@imgtec.com>
Message-ID: <560BECDE.7090405@imgtec.com>
Date:   Wed, 30 Sep 2015 15:08:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1509301602160.4500@nanos>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49407
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

On 09/30/2015 03:03 PM, Thomas Gleixner wrote:
> On Wed, 30 Sep 2015, Qais Yousef wrote:
>
>> On 09/29/2015 09:48 PM, Thomas Gleixner wrote:
>>> 	 Now how these hwirqs are allocated is a domain/architecture
>>> 	 specific issue.
>>>
>>> 	 x86 will just find a vector which is available on all target
>>> 	 cpus and mark it as used. That's a single hw irq number.
>>>
>>> 	 mips and others, which implement IPIs as regular hw interrupt
>>> 	 numbers, will allocate a these (consecutive) hw interrupt
>>> 	 numbers either from a reserved region or just from the
>>> 	 regular space. That's a bunch of hw irq numbers and we need
>>> 	 to come up with a proper storage format in the irqdata for
>>> 	 that. That might be
>>>
>>> 	       struct ipi_mapping {
>>> 		      unsigned int	nr_hwirqs;
>>> 		      unsigned int	cpumap[NR_CPUS];
>>> 	       };
>> Can we use NR_CPUS here? If we run in UP configuration for instance, this will
>> be one. The coprocessor could be outside the NR_CPUS range in general, no?
>>
>> How about
>>
>>                          struct ipi_mapping {
>>                                  unsigned int        nr_hwirqs;
>>                                  unsigned int        nr_cpus;
>>                                  unsigned int        *cpumap;
>>                          }
>>
>> where cpumap is dynamically allocated by the controller which has better
>> knowledge about the supported cpu range it can talk to?
> Sure. As I said: 'That might be' ....
>   
>


OK thanks. I just wanted to make sure I didn't misunderstand anything.

Will try to send an updated version with all the changes soon.

Thanks,
Qais
