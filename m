Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Sep 2015 10:12:55 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7192 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007433AbbIXIMx2ct6F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Sep 2015 10:12:53 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B2B6A6FC15943;
        Thu, 24 Sep 2015 09:12:44 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 24 Sep 2015 09:12:46 +0100
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 24 Sep
 2015 09:12:46 +0100
Subject: Re: [PATCH 2/6] irqdomain: add a new send_ipi() to irq_domain_ops
To:     Jiang Liu <jiang.liu@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>
References: <1443019758-20620-1-git-send-email-qais.yousef@imgtec.com>
 <1443019758-20620-3-git-send-email-qais.yousef@imgtec.com>
 <5602D6F3.7030709@linux.intel.com>
CC:     <marc.zyngier@arm.com>, <jason@lakedaemon.net>,
        <linux-mips@linux-mips.org>
From:   Qais Yousef <qais.yousef@imgtec.com>
Message-ID: <5603B07D.3020001@imgtec.com>
Date:   Thu, 24 Sep 2015 09:12:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <5602D6F3.7030709@linux.intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49353
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

On 09/23/2015 05:44 PM, Jiang Liu wrote:
> On 2015/9/23 22:49, Qais Yousef wrote:
>> For generic ipi core to use. It takes hwirq as its sole argument.
>> Hopefully this is generic enough? Should we pass something more abstract?
>>
>> Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
>> ---
>>   include/linux/irqdomain.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
>> index 9b3dc6c2a3cc..cef9e6158be0 100644
>> --- a/include/linux/irqdomain.h
>> +++ b/include/linux/irqdomain.h
>> @@ -92,6 +92,7 @@ struct irq_domain_ops {
>>   	void (*activate)(struct irq_domain *d, struct irq_data *irq_data);
>>   	void (*deactivate)(struct irq_domain *d, struct irq_data *irq_data);
>>   #endif
>> +	void (*send_ipi)(irq_hw_number_t hwirq);
> Hi Qais,
> 	Instead of extending the irq_domain_ops, how about extending
> irq_chip instead? If we treat IPI as a sort of irq controller, and
> irq_chip is used to encapsulate all irq controller related operations,
> and irq_domain_ops is mainly used to allocated resources instead of
> operating corresponding hardware.
> Thanks!
> Gerry
>



Yes true. I was too focused on the reservation part so when it came to 
sending the IPI it just felt natural to add it to irqdomain as it was 
simple to implement like this!

Thanks,
Qais
