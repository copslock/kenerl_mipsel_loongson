Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Aug 2015 17:11:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51700 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007257AbbHXPLKwuFr9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Aug 2015 17:11:10 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 60B8874D0361C;
        Mon, 24 Aug 2015 16:11:02 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 24 Aug 2015 16:11:04 +0100
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 24 Aug
 2015 16:11:04 +0100
Message-ID: <55DB3408.7080502@imgtec.com>
Date:   Mon, 24 Aug 2015 16:11:04 +0100
From:   Qais Yousef <qais.yousef@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.8.0
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <alsa-devel@alsa-project.org>, Jason Cooper <jason@lakedaemon.net>,
        "Marc Zyngier" <marc.zyngier@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export gic_send_ipi
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com> <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com> <alpine.DEB.2.11.1508241447100.3873@nanos> <55DB15EB.3090109@imgtec.com> <alpine.DEB.2.11.1508241653200.3873@nanos>
In-Reply-To: <alpine.DEB.2.11.1508241653200.3873@nanos>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49006
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

On 08/24/2015 03:55 PM, Thomas Gleixner wrote:
> On Mon, 24 Aug 2015, Qais Yousef wrote:
>> On 08/24/2015 01:49 PM, Thomas Gleixner wrote:
>>> On Mon, 24 Aug 2015, Qais Yousef wrote:
>>>
>>>> Some drivers might require to send ipi to other cores. So export it.
>>> Which IPIs do you need to send from a driver which are not exposed by
>>> the SMP functions already?
>> It's not an SMP IPI. We use GIC to exchange interrupts between AXD and the
>> host system since AXD is another MIPS core in the cluster.
> So that should have been in the changelog to begin with.
>   

OK sorry for the confusion. I'll amend the changelog and be more careful 
in the future.

Thanks,
Qais

>>>> This will be used later by AXD driver.
>>> That smells fishy and it wants a proper explanation WHY and not just a
>>> sloppy statement that it will be used later. I can figure that out
>>> myself as exporting a function without using it does not make any sense.
>> Sorry for the terse explanation. As pointed above AXD uses GIC to send and
>> receive interrupts to the host core. Without this change I can't compile the
>> driver as a driver module because the symbol is not exported.
> Really? Exporting it solves that problem then. That's interesting news
> for me.
>
> Thanks,
>
> 	tglx
