Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2014 10:42:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24432 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817540AbaGQImHoPKhA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jul 2014 10:42:07 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C07CBF70F9CDF;
        Thu, 17 Jul 2014 09:41:58 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 17 Jul 2014 09:42:01 +0100
Received: from [192.168.154.89] (192.168.154.89) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 17 Jul
 2014 09:42:00 +0100
Message-ID: <53C78C4D.5090308@imgtec.com>
Date:   Thu, 17 Jul 2014 09:41:49 +0100
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        <mina86@mina86.com>, Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/4] mips: Add cma support to mips
References: <1405525892-60383-1-git-send-email-Zubair.Kakakhel@imgtec.com> <CAOLZvyEs_+R+urf-rhvpfZ+ieqhgg6zXuOtLLPUqKSaeNTzpNg@mail.gmail.com> <CAOLZvyFjkuCzUkbb3SpJ25gKQoZ-Ken9Ri1YEckxdM6ETNyuSg@mail.gmail.com>
In-Reply-To: <CAOLZvyFjkuCzUkbb3SpJ25gKQoZ-Ken9Ri1YEckxdM6ETNyuSg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.89]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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



On 17/07/14 09:38, Manuel Lauss wrote:
> On Wed, Jul 16, 2014 at 6:18 PM, Manuel Lauss <manuel.lauss@gmail.com> wrote:
>> Hi,
>>
>> On Wed, Jul 16, 2014 at 5:51 PM, Zubair Lutfullah Kakakhel
>> <Zubair.Kakakhel@imgtec.com> wrote:
>>> Here we have 4 patches that add cma support to mips.
>>>
>>> Patch 1 adds dma-contiguous.h to asm-generic
>>> Patch 2 and 3 make arm64 and x86 use dma-contiguous from asm-generic
>>> Patch 4 adds cma to mips.
>>
>> I've given this a try on mips32, I haven't dug into this error yet, maybe
>> you have an idea:
> [ oops snipped ]
> 
> Nevermind.   Did a full recompile, the oops is gone.  Works fine now,
> framebuffer driver and others are very happy.
> 
> Thanks!
>         Manuel
> 

Good to know. :)

Thanks for testing it on your platform.

ZubairLK
