Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 12:48:10 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47257 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006763AbbK3LsIPIcHP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 12:48:08 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id AC552A8CA92FA;
        Mon, 30 Nov 2015 11:48:00 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Mon, 30 Nov 2015 11:48:02 +0000
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 30 Nov
 2015 11:48:01 +0000
Subject: Re: [PATCH v2 04/19] genirq: Add new struct ipi_mask and helper
 functions
To:     Thomas Gleixner <tglx@linutronix.de>
References: <1448453217-3874-1-git-send-email-qais.yousef@imgtec.com>
 <1448453217-3874-5-git-send-email-qais.yousef@imgtec.com>
 <alpine.DEB.2.11.1511301158100.3572@nanos>
CC:     <linux-kernel@vger.kernel.org>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
From:   Qais Yousef <qais.yousef@imgtec.com>
Message-ID: <565C3771.7040202@imgtec.com>
Date:   Mon, 30 Nov 2015 11:48:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1511301158100.3572@nanos>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50166
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

On 11/30/2015 11:20 AM, Thomas Gleixner wrote:
> On Wed, 25 Nov 2015, Qais Yousef wrote:
>> cpumask is limited to NR_CPUS. Introduce ipi_mask which allows us to address
>> cpu range that is higher than NR_CPUS which is required for drivers to send
>> IPIs for coprocessor that are outside Linux CPU range.
> I have second thoughts on this.
>
> cpumask is indeed limited to NR_CPUS or in case of CPUMASK_ON_STACK
> limited to nr_cpu_ids.
>
> But, that's not an issue for that coprocessor case. Let's assume you
> have 16 Linux CPUs and 4 coprocessors. So you set the number of
> possible cpus (NR_CPUS) to 20. That makes the cpumask sizeof 20.
>
> The boot-process sets the number of available cpus to 16. So the
> Linux side will never try to access anything beyond cpu15.
>
> But you can spare that extra mask magic and simply use cpumask. Sorry
> that I did not think about that earlier.
>
>


Yes it would be much better to reuse it but wouldn't the runtime checks 
against nr_cpu_ids create problems especially when CPUMASK_ON_STACK is 
defined?

Thanks,
Qais
