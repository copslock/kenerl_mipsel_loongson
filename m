Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2015 11:05:50 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7655 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013035AbbKIKFsLzuEP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Nov 2015 11:05:48 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 83ADFE0A98D8D;
        Mon,  9 Nov 2015 10:05:40 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Mon, 9 Nov 2015 10:05:41 +0000
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 9 Nov
 2015 10:05:41 +0000
Subject: Re: [PATCH 06/14] genirq: Add struct ipi_mapping and its helper
 functions
To:     Thomas Gleixner <tglx@linutronix.de>
References: <1446549181-31788-1-git-send-email-qais.yousef@imgtec.com>
 <1446549181-31788-7-git-send-email-qais.yousef@imgtec.com>
 <alpine.DEB.2.11.1511071306220.4032@nanos>
CC:     <linux-kernel@vger.kernel.org>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
From:   Qais Yousef <qais.yousef@imgtec.com>
Message-ID: <56406FF5.6030904@imgtec.com>
Date:   Mon, 9 Nov 2015 10:05:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1511071306220.4032@nanos>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49871
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

On 11/07/2015 12:09 PM, Thomas Gleixner wrote:
> On Tue, 3 Nov 2015, Qais Yousef wrote:
>
>> struct ipi_mapping will provide a mechanism for irqchip code to fill out the
>> mapping at reservation and to look it up when sending.
> I'm fine with the code, but can you please move it to w new file,
> i.e. kernel/irq/ipi.c and make the compilation depend on GENERIC_IPI?

I originally had ipi.c then removed it. I'll move all functionality there.

Thanks,
Qais
