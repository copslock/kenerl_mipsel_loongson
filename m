Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 18:49:25 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34416 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6837162AbaEUQtXG1a49 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 May 2014 18:49:23 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0819C9E05E684;
        Wed, 21 May 2014 17:49:13 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Wed, 21 May
 2014 17:49:15 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 21 May 2014 17:49:15 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 21 May
 2014 17:49:14 +0100
Message-ID: <537CD84B.7050005@imgtec.com>
Date:   Wed, 21 May 2014 17:46:03 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        <linux-mips@linux-mips.org>, David Daney <ddaney.cavm@gmail.com>,
        "Ralf Baechle" <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 10/15] MIPS: Add code for new system 'paravirt'.
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com> <1400597236-11352-11-git-send-email-andreas.herrmann@caviumnetworks.com> <537CAC74.4030800@imgtec.com> <537CD4C6.5080905@caviumnetworks.com>
In-Reply-To: <537CD4C6.5080905@caviumnetworks.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 21/05/14 17:31, David Daney wrote:
>>> +    paravirt_smp_sp[cpu] = __KSTK_TOS(idle);
>>> +    mb();
>>
>> is this barrier necessary?
> 
> Really it is just make_writes_visible_asap(), but for OCTEON mb() or
> smp_wmb() is the closest that the kernel has.
> 
> It may not be necessary, but it doesn't really harm anything.

Okay, fair enough. I suggest adding a comment to that effect (I think
checkpatch now complains about barriers without comments :) ).

>>> diff --git a/arch/mips/paravirt/serial.c b/arch/mips/paravirt/serial.c
>>> new file mode 100644
>>> index 0000000..e3f98b2
>>> --- /dev/null
>>> +++ b/arch/mips/paravirt/serial.c
>>> @@ -0,0 +1,38 @@
>>> +/*
>>> + * This file is subject to the terms and conditions of the GNU
>>> General Public
>>> + * License.  See the file "COPYING" in the main directory of this
>>> archive
>>> + * for more details.
>>> + *
>>> + * Copyright (C) 2013 Cavium, Inc.
>>> + */
>>> +
>>> +#include <linux/kernel.h>
>>> +#include <linux/virtio_console.h>
>>> +
>>> +#include <asm/mipsregs.h>
>>> +
>>> +/*
>>> + * Emit one character to the boot console.
>>> + */
>>> +int prom_putchar(char c)
>>> +{
>>> +    hypcall3(0 /* Console output */, 0 /*  port 0 */, (unsigned
>>> long)&c, 1 /* len == 1 */);
>>
>> I think the hypcall API needs to be clearly specified and Documented
>> somewhere along with its HYPCALL codes and scope. I.e. is it specific to
>> kvmtool, or attempting to be a standard API across MIPS hypervisors.
>>
> 
> I was intending it to be the later.  (standard API across MIPS
> hypervisors.)
> 
> The idea being that the first argument would be broken up into several
> ranges.
> 
> 0..x : Globally available HYPCALL provided by all hypervisors.
> 
> m..n : MIPS KVM specific.
> 
> y..z : Reserved for the vendor.
> 
> 
> For some values of x, m, n, y and z.
> 
> But perhaps it should just be MIPS KVM specific. If making it global is
> too much trouble.

I don't think making it global should be a problem (sounds ideal if it
works without changes on multiple hypervisors), but it probably makes
sense to ensure that other stakeholders are aware of it (those working
on other hypervisors and semihosting stuff).

Cheers
James
