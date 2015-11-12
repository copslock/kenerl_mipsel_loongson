Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Nov 2015 16:12:47 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31915 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012303AbbKLPMpUC8Et (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Nov 2015 16:12:45 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 3847180191D9B;
        Thu, 12 Nov 2015 15:12:36 +0000 (GMT)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.235.1; Thu, 12 Nov
 2015 15:12:39 +0000
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Thu, 12 Nov 2015 15:12:38 +0000
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 12 Nov
 2015 15:12:38 +0000
Subject: Re: [PATCH 10/14] irqchip/mips-gic: Add a IPI hierarchy domain
To:     Thomas Gleixner <tglx@linutronix.de>
References: <1446549181-31788-1-git-send-email-qais.yousef@imgtec.com>
 <1446549181-31788-11-git-send-email-qais.yousef@imgtec.com>
 <alpine.DEB.2.11.1511071323471.4032@nanos>
CC:     <linux-kernel@vger.kernel.org>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
From:   Qais Yousef <qais.yousef@imgtec.com>
Message-ID: <5644AC66.2070508@imgtec.com>
Date:   Thu, 12 Nov 2015 15:12:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1511071323471.4032@nanos>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49898
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

Hi Thomas,

On 11/07/2015 02:51 PM, Thomas Gleixner wrote:
> On Tue, 3 Nov 2015, Qais Yousef wrote:
>
>> Add a new ipi domain on top of the normal domain.
>>
>> MIPS GIC now supports dynamic allocation of an IPI.
> I don't think you make use of the power of hierarchical irq
> domains. You just whacked the current code into submission.
>

This time I'm having problems digesting your suggestion. I can't see how 
it would make things simpler to be honest.

Issues I'm seeing:

     - Device domain would be identical to GIC domain and it would defer 
everything to the parent domain except for the extra level of 
indirection. No?

     - The race condition I mentioned in my earlier email where we must 
be told what hwirqs are available because we can't guarantee there's no 
real device connected to it which could interfere with the operation. We 
have always to work on a pre reserved set defined by the system. 
Currently GIC hard codes this set, but I'll be making it a DT property 
in the future.

     - If we remove the mapping, how can a coprocessor drivers find out 
the reverse mapping to pass the hwirq to the firmware so that it can 
send and listen on the correct hwirqs? I have to say my current patches 
missed dealing with this problem. Now I have something to test my rproc 
driver on I came to realise I haven't added the function to do the 
reverse mapping.

In summary. I can't see how adding the device domain would help in 
making things simpler and without having generic explicit cpu mapping I 
don't know how I can implement a generic reverse mapping function to get 
the hwirq to pass to the coprocessor firmware.

If I misunderstood your suggestion, mind rephrasing it please?

I can see though if I use irq_*_alloc_parent() I can probably get rid 
off the below since I'd be able to use gic_irq_domain all the time to do 
the revmap.

+		if (test_bit(intr, ipi_intrs)) {
+			virq = irq_linear_revmap(gic_ipi_domain,
+					GIC_SHARED_TO_HWIRQ(intr));
+		} else {
+			virq = irq_linear_revmap(gic_irq_domain,
+					GIC_SHARED_TO_HWIRQ(intr));
+		}
+



Thanks,
Qais
