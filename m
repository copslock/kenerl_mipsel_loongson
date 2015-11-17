Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Nov 2015 11:08:37 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53747 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011355AbbKQKIfQQfRr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Nov 2015 11:08:35 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id E6EE3C0AEDE7;
        Tue, 17 Nov 2015 10:08:26 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 17 Nov 2015 10:08:29 +0000
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 17 Nov
 2015 10:08:28 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: [PATCH 10/14] irqchip/mips-gic: Add a IPI hierarchy domain
To:     Thomas Gleixner <tglx@linutronix.de>
References: <1446549181-31788-1-git-send-email-qais.yousef@imgtec.com>
 <1446549181-31788-11-git-send-email-qais.yousef@imgtec.com>
 <alpine.DEB.2.11.1511071323471.4032@nanos> <56407F3C.4060404@imgtec.com>
 <alpine.DEB.2.11.1511161610070.3761@nanos>
CC:     <linux-kernel@vger.kernel.org>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Message-ID: <564AFC9A.9080505@imgtec.com>
Date:   Tue, 17 Nov 2015 10:08:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1511161610070.3761@nanos>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49962
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

On 11/16/2015 05:17 PM, Thomas Gleixner wrote:
> On Mon, 9 Nov 2015, Qais Yousef wrote:
>> On 11/07/2015 02:51 PM, Thomas Gleixner wrote:
>> Generally it's hard to know whether a real device is connected to a hwirq or
>> not. I am saving a patch where we get a set of free hwirqs from DT as only the
>> SoC designer knows what hwirq are actually free and safe to use for IPI. I'll
>> send this patch with the DT IPI changes or the rproc driver that I will be
>> send once these changes are merged.
>>
>> The current code assumes that the last 2 * NR_CPUs hwirqs are always free to
>> use for Linux SMP.
> So what you're saying is that you cannot rely on the last X hwirqs
> being available for IPIs. That's insane and to my knowledge there is
> no hardware out there which does not reserve a consecutive IPI space.

If I read the code you were suggesting correctly, you were trying to fit 
the IPIs in any available non allocated area in the GIC space. What I am 
trying to say is that we can only work on a limited subset of this space 
that we are told explicitly it's safe to use for IPIs. Most likely it's 
consecutive, but I don't feel brave enough to make this assumption 
personally - maybe I'm over paranoid.. I'm more keen on anything that 
would simplify this patch series now though.

I'll do my best with the next series but maybe we'd need to iterate this 
more than once till I get it right.

Thanks,
Qais
