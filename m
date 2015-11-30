Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 12:59:25 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7426 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007140AbbK3L7WoG23P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 12:59:22 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 7F1413DAB3C40;
        Mon, 30 Nov 2015 11:59:14 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Mon, 30 Nov 2015 11:59:16 +0000
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 30 Nov
 2015 11:59:16 +0000
Subject: Re: [PATCH v2 09/19] genirq: Add a new function to get IPI reverse
 mapping
To:     Thomas Gleixner <tglx@linutronix.de>
References: <1448453217-3874-1-git-send-email-qais.yousef@imgtec.com>
 <1448453217-3874-10-git-send-email-qais.yousef@imgtec.com>
 <5658429D.3000105@imgtec.com> <alpine.DEB.2.11.1511301139500.3572@nanos>
 <565C2ABD.5030409@imgtec.com> <alpine.DEB.2.11.1511301220380.3572@nanos>
CC:     <linux-kernel@vger.kernel.org>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
From:   Qais Yousef <qais.yousef@imgtec.com>
Message-ID: <565C3A14.10401@imgtec.com>
Date:   Mon, 30 Nov 2015 11:59:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1511301220380.3572@nanos>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50167
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

On 11/30/2015 11:22 AM, Thomas Gleixner wrote:
> On Mon, 30 Nov 2015, Qais Yousef wrote:
>> On 11/30/2015 10:40 AM, Thomas Gleixner wrote:
>>> On Fri, 27 Nov 2015, Qais Yousef wrote:
>>>> While trying to get my remoteproc driver work with this I uncovered a
>>>> problem
>>>> with this approach.
>>>>
>>>> mips-gic doesn't store the actual hwirq in the irq_data. It uses
>>>> GIC_SHARED_TO_HWIRQ() and GIC_HWIRQ_TO_SHARED() to add and remove an
>>>> offset.
>>> Why can't MIPS store the real hwirq number in irq_data?
>>
>> I'm wary of ending up in inconsistency hell where some functions need to deal
>> with raw hwirq and others with translated ones.
>>
>> I will give this a go first and see if it gets really ugly.
> Well, the question is why can't those functions not all use the raw
> hardware irq. We have it in irq_data exactly to avoid calculations in
> the hot path functions.
>


I'll see what I can do as part of this series. I think I can fix the new 
IPI and device domains, but can't promise about the root gic domain. It 
might be too big of a change for this series.

Thanks,
Qais
