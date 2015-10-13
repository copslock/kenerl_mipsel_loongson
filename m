Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2015 16:49:03 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10699 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009454AbbJMOtCBtZ96 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2015 16:49:02 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C1D4D52DFA078;
        Tue, 13 Oct 2015 15:48:53 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 13 Oct 2015 15:48:56 +0100
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 13 Oct
 2015 15:48:55 +0100
Subject: Re: [RFC v2 PATCH 00/14] Implement generic IPI support mechanism
To:     Thomas Gleixner <tglx@linutronix.de>
References: <1444731382-19313-1-git-send-email-qais.yousef@imgtec.com>
 <alpine.DEB.2.11.1510131550020.25029@nanos>
CC:     <linux-kernel@vger.kernel.org>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
From:   Qais Yousef <qais.yousef@imgtec.com>
Message-ID: <561D19D7.4060004@imgtec.com>
Date:   Tue, 13 Oct 2015 15:48:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1510131550020.25029@nanos>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49531
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

On 10/13/2015 02:53 PM, Thomas Gleixner wrote:
> On Tue, 13 Oct 2015, Qais Yousef wrote:
>
>> This series is based on Linus tree. I couldn't compile test it
>> because MIPS compilation was broken due to other reasons. I expect
>> some brokeness because of the introduction of struct irq_common_data
>> which is not present on the 4.1 tree I was testing my code on before
>> porting it to Linus tip. I will fix these issues and introduce
>> proper accessors for accessing struct ipi_mask given that the
>> concept is approved.
> Please base it on 4.1-rc5 + irq/core.
>   
>>    irq: add new IRQ_DOMAIN_FLAGS_IPI
> The proper prefix for the core parts is 'genirq:'. Please start the
> sentence after the prefix with an uppercase letter
>
>>    irq: add GENERIC_IRQ_IPI Kconfig symbol
>>    irq: add new struct ipi_mask
>>    irq: add a new irq_send_ipi() to irq_chip
>>    irq: add struct ipi_mask to irq_data
>>    irq: add struct ipi_mapping and its helper functions
>>    irq: add a new generic IPI reservation code to irq core
>>    irq: implement irq_send_ipi
>>    MIPS: add support for generic SMP IPI support
>>    MIPS: make smp CMP, CPS and MT use the new generic IPI functions
>>    MIPS: delete smp-gic.c
>>    irqchip: mips-gic: add a IPI hierarchy domain
> Please make that
>
> irqchip/mips-gic: Add ....
>
>


Will do. Thanks a lot for the review and all the pointers. I need to 
revive the DT binding discussion now, in the proper list this time.

Thanks,
Qais
