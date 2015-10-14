Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2015 17:46:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41313 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010217AbbJNPqsB5w0w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Oct 2015 17:46:48 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0E5C626E49098;
        Wed, 14 Oct 2015 16:46:39 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 14 Oct 2015 16:46:42 +0100
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 14 Oct
 2015 16:46:41 +0100
Subject: Re: [RFC v2 PATCH 05/14] irq: add struct ipi_mask to irq_data
To:     Davidlohr Bueso <dave@stgolabs.net>
References: <1444731382-19313-1-git-send-email-qais.yousef@imgtec.com>
 <1444731382-19313-6-git-send-email-qais.yousef@imgtec.com>
 <20151014145017.GE3052@linux-uzut.site>
CC:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>,
        <jiang.liu@linux.intel.com>, <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>
From:   Qais Yousef <qais.yousef@imgtec.com>
Message-ID: <561E78E1.2020907@imgtec.com>
Date:   Wed, 14 Oct 2015 16:46:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20151014145017.GE3052@linux-uzut.site>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49549
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

On 10/14/2015 03:50 PM, Davidlohr Bueso wrote:
> On Tue, 13 Oct 2015, Qais Yousef wrote:
>
>> It has a similar role to affinity mask, but tracks the IPI affinity 
>> instead.
>>
>> Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
>> ---
>> include/linux/irq.h | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/irq.h b/include/linux/irq.h
>> index 504133671985..b000b217ea24 100644
>> --- a/include/linux/irq.h
>> +++ b/include/linux/irq.h
>> @@ -157,6 +157,7 @@ struct irq_common_data {
>>     void            *handler_data;
>>     struct msi_desc        *msi_desc;
>>     cpumask_var_t        affinity;
>> +    struct ipi_mask        ipi_mask;
>> };
>
> This should be folded into patch 3, no?

For me they are 2 separate changes, hence the 2 commits. They could be 
folded but I prefer the septation unless there's a strong opinion not to.

Thanks,
Qais
