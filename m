Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2016 02:02:08 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55546 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991976AbcLIBCBzPaC0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Dec 2016 02:02:01 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 9C6E055FC73C4;
        Fri,  9 Dec 2016 01:01:50 +0000 (GMT)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 9 Dec 2016 01:01:55 +0000
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL-X.hh.imgtec.org
 (10.100.10.113) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 9 Dec
 2016 01:01:54 +0000
Received: from [10.20.2.61] (10.20.2.61) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 8 Dec 2016
 17:01:53 -0800
Message-ID: <584A0281.3040505@imgtec.com>
Date:   Thu, 8 Dec 2016 17:01:53 -0800
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Justin Chen <justinpopo6@gmail.com>
CC:     <linux-mips@linux-mips.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Justin Chen <justin.chen@broadcom.com>
Subject: Re: [RFC] MIPS: Add cacheinfo support
References: <20161208011626.20885-1-justinpopo6@gmail.com> <5849EC43.2070802@imgtec.com> <CAJx26kW0e-HC0VUTObZ5Or+XjFvE9KmtOToKbFvKYvhE--Vw5A@mail.gmail.com>
In-Reply-To: <CAJx26kW0e-HC0VUTObZ5Or+XjFvE9KmtOToKbFvKYvhE--Vw5A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.2.61]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

On 12/08/2016 04:28 PM, Justin Chen wrote:
> Thanks for the comments Leonid.
>
> We should consider the scope of this patch. The information we are
> trying to expose to userspace is limited to the struct cacheinfo
> located at include/linux/cacheinfo.c (of course this can always be
> expanded). So the question is what information would be useful to
> expose to userspace.
> Some justification for exposing the current information in the
> cacheinfo struct could be: (Pulled from another email chain)
> "Agreed. So far I have got requests from GCC, JIT and graphics guys.
> IIUC they need this to support cache flushing for user applications like
> gcc trampolines and JIT compilers. I am also told that having knowledge
> of cache architecture can help optimal code strategies, though I don't
> have much details on that."
> https://patchwork.kernel.org/patch/5867721/
>
> There may be justification for including the points you mentioned
> above, but I believe that is outside the scope of this patch. The
> cache information exposed in this patch is limited, but I do not
> believe it is useless. The points above can be added, but it will
> require a rework of the base cacheinfo driver. driver/base/cacheinfo.c
>
>
Justin,

CACHE instruction is not available in user space, only SYNCI on MIPS R2+ 
for trampoline.
Any operation with CACHE requires a syscall.

As for SYNCI (trampoline from L1D->L1I) the following information in 
user space is needed:

     1. L1 line size (available via RDHWR $x, $1). It is available now 
directly from CPU, but may be better to supply from kernel because some 
cores has no that.

     2. The flag that L1I is NOT coherent with L1D and SYNCI is needed 
and available

The knowledge about L1/L2 sizes is not needed for regular application... 
well, if application wants to get advantage of cache sizes, well, in 
this case it can be supplied.

But it is unreliable because app may be rescheduled into different kind 
of core which has a different L1 size (in heterogeneous system, BTW). It 
can be fixed by setting affinity, of course (not sure - can it be 
reliably done in BIG/LITTLE approach). But that requires in application 
the knowledge and understanding of system CPU structure... well why we 
can allow all that stuff besides information purpose? It corrupts the 
all efforts and optimization in kernel about performance and powersaving.

Regards,
- Leonid.
