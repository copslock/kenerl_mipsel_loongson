Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2015 21:04:01 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49477 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012589AbbEOTD766g0s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2015 21:03:59 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2A7639DD8817D;
        Fri, 15 May 2015 20:03:53 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 15 May
 2015 20:03:56 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Fri, 15 May
 2015 20:03:55 +0100
Received: from [10.20.3.79] (10.20.3.79) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 15 May
 2015 12:03:53 -0700
Message-ID: <55564319.7020502@imgtec.com>
Date:   Fri, 15 May 2015 12:03:53 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     "aleksey.makarov@auriga.com" <aleksey.makarov@auriga.com>,
        James Hogan <James.Hogan@imgtec.com>,
        Paul Burton <Paul.Burton@imgtec.com>,
        "david.daney@cavium.com" <david.daney@cavium.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "davidlohr@hp.com" <davidlohr@hp.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>
Subject: Re: [PATCH v2] MIPS64: Support of at least 48 bits of SEGBITS
References: <20150515013351.7450.12130.stgit@ubuntu-yegoshin> <55561EB6.4020009@gmail.com>
In-Reply-To: <55561EB6.4020009@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.79]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47414
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

On 05/15/2015 09:28 AM, David Daney wrote:
> On 05/14/2015 06:34 PM, Leonid Yegoshin wrote:
>> SEGBITS default is 40 bits or less, depending from CPU type.
>> This patch introduces 48bits of application virtual address (SEGBITS) support.
>> It is defined only for 16K and 64K pages and is optional (configurable).
>>
>> Penalty - a small number of additional pages for generic (small) applications.
>> But for 64K pages it adds 3rd level of PTE structure, which has a little
>> impact during software TLB refill.
>>
>> This patch is needed because MIPS I6XXX and P6XXX cores have 48 bit of
>> virtual address in each segment (SEGBITS).
>>
> I'm concerned that the change log doesn't convey the true reason for the
> patch.
>
> Many processors support larger VA space than is utilized by the kernel.
>    A choice was made to reduce the size of the VA space in order to
> reduce TLB handling overhead.
>
> If the true reason for the patch is to enable larger VA space, say that.
>    But is it really required by those processors you mention?  I doubt it.
>
> David Daney
>
>

Well, I was not aware about many processors capability, I can't find 
this kind of note anywhere.

And I assumed that statement "If unsure, say N" and the fact that it is 
configurable leads to conclusion that it is completely optional. I have 
a request from management to support 48bit VA but I understand that 
somebody may not like even small penalty.

In other side, this patch was required to test HW capability, GLIBC and 
application compatibility (I tested on buildroot FS).

So, if you still have concern, please propose a description statement.

- Leonid.
