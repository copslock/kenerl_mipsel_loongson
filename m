Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2015 17:55:36 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33789 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013023AbbKWQzfNNi1T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Nov 2015 17:55:35 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 6ABF75182A33C;
        Mon, 23 Nov 2015 16:55:26 +0000 (GMT)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.235.1; Mon, 23 Nov
 2015 16:55:28 +0000
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Mon, 23 Nov 2015 16:55:28 +0000
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 23 Nov
 2015 16:55:28 +0000
Subject: Re: [PATCH 10/14] irqchip/mips-gic: Add a IPI hierarchy domaind
To:     Thomas Gleixner <tglx@linutronix.de>
References: <1446549181-31788-1-git-send-email-qais.yousef@imgtec.com>
 <1446549181-31788-11-git-send-email-qais.yousef@imgtec.com>
 <alpine.DEB.2.11.1511071323471.4032@nanos> <56407F3C.4060404@imgtec.com>
 <alpine.DEB.2.11.1511161610070.3761@nanos> <564EFA74.90606@imgtec.com>
 <alpine.DEB.2.11.1511202113010.3931@nanos>
CC:     <linux-kernel@vger.kernel.org>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
From:   Qais Yousef <qais.yousef@imgtec.com>
Message-ID: <565344FF.1090508@imgtec.com>
Date:   Mon, 23 Nov 2015 16:55:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1511202113010.3931@nanos>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50063
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

On 11/20/2015 08:39 PM, Thomas Gleixner wrote:
>> Same applies when doing the reverse mapping.
>>
>> In other words, the ipi_mask won't always necessarily be linear to facilitate
>> the 1:1 mapping that this approach assumes.
>>
>> It is a solvable problem, but I think we're losing the elegance that promoted
>> going into this direction and I think sticking to using struct ipi_mapping
>> (with some enhancements to how it's exposed an integrated by/into generic
>> code) is a better approach.
> The only reason to use the ipi_mapping thing is if we need non
> consecutive masks, i.e. cpu 5 and 9.

That's the case I had in mind.

>
> I really don't want to have it mandatory as it does not make any sense
> for systems where the IPI is a single per_cpu interrupt. For the
> linear consecutive space it is just adding memory and cache footprint
> for no benefit. Think about machines with 4k and more cpus ....

OK. Although so far I think the ovehead is higher without the 
ipi_mapping because of all the extra checkings we have to do when 
sending an IPI. I'll leave this to code review when I have something 
ready though.

I'm debugging more problems and hopefully I'll send something this week.

Thanks,
Qais
