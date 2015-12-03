Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2015 10:52:09 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23806 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007572AbbLCJwIGx5aZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Dec 2015 10:52:08 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 8F3CD7262DD40;
        Thu,  3 Dec 2015 09:52:00 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Thu, 3 Dec 2015 09:52:02 +0000
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 3 Dec
 2015 09:52:01 +0000
Subject: Re: [PATCH v3 14/19] irqchip/mips-gic: Use gic_vpes instead of
 NR_CPUS
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        <linux-kernel@vger.kernel.org>
References: <1449058920-21011-1-git-send-email-qais.yousef@imgtec.com>
 <1449058920-21011-15-git-send-email-qais.yousef@imgtec.com>
 <565F3869.4020603@cogentembedded.com>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
From:   Qais Yousef <qais.yousef@imgtec.com>
Message-ID: <566010C1.1000506@imgtec.com>
Date:   Thu, 3 Dec 2015 09:52:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <565F3869.4020603@cogentembedded.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50304
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

On 12/02/2015 06:28 PM, Sergei Shtylyov wrote:
>
>> @@ -1084,7 +1084,7 @@ static void __init __gic_init(unsigned long 
>> gic_base_addr,
>>       gic_ipi_domain->bus_token = DOMAIN_BUS_IPI;
>>
>>       /* Make the last 2 * NR_CPUS available for IPIs */
>
>    Looks like you forgot to also change this comment...

This code changes again in a later patch with the correct comment on. 
I'll fix it in the next series.

Thanks,
Qais
