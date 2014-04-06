Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Apr 2014 04:06:44 +0200 (CEST)
Received: from mail.lemote.com ([222.92.8.138]:55985 "EHLO mail.lemote.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816417AbaDFCGmMa6uM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 6 Apr 2014 04:06:42 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.lemote.com (Postfix) with ESMTP id C8B48228C1;
        Sun,  6 Apr 2014 10:06:31 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from mail.lemote.com ([127.0.0.1])
        by localhost (mail.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6ulwgK6nmT10; Sun,  6 Apr 2014 10:06:16 +0800 (CST)
Received: from mail.lemote.com (localhost [127.0.0.1])
        (Authenticated sender: chenhc@lemote.com)
        by mail.lemote.com (Postfix) with ESMTPA id 84A3F23450;
        Sun,  6 Apr 2014 10:06:15 +0800 (CST)
Received: from 222.92.8.142
        (SquirrelMail authenticated user chenhc)
        by mail.lemote.com with HTTP;
        Sun, 6 Apr 2014 10:06:16 +0800
Message-ID: <2cc0b93d3a84977f4a2929aa0c2bfb4b.squirrel@mail.lemote.com>
In-Reply-To: <CAEdQ38F-WHEUFqACwGGNGsWQFqTjwwk2ZwNis8zbNWff2xT8Vw@mail.gmail.com>
References: <1396599104-24370-1-git-send-email-chenhc@lemote.com>
    <1396599104-24370-9-git-send-email-chenhc@lemote.com>
    <CAEdQ38F-WHEUFqACwGGNGsWQFqTjwwk2ZwNis8zbNWff2xT8Vw@mail.gmail.com>
Date:   Sun, 6 Apr 2014 10:06:16 +0800
Subject: Re: [PATCH 8/9] MIPS: Loongson-3: Enable the COP2 usage
From:   =?gb2312?Q?=22=B3=C2=BB=AA=B2=C5=22?= <chenhc@lemote.com>
To:     "Matt Turner" <mattst88@gmail.com>, chengxiuzhi@loongson.cn
Cc:     "Ralf Baechle" <ralf@linux-mips.org>,
        "John Crispin" <john@phrozen.org>,
        "Steven J. Hill" <steven.hill@imgtec.com>,
        "Aurelien Jarno" <aurelien@aurel32.net>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Fuxin Zhang" <zhangfx@lemote.com>,
        "Zhangjin Wu" <wuzhangjin@gmail.com>
User-Agent: SquirrelMail/1.4.22
MIME-Version: 1.0
Content-Type: text/plain;charset=gb2312
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

To Matt,

At first thank you very much for your pixman work. In my opinion, Loongson-3
has the same MMI/SIMD instructions as Loongson-2. The only difference is
that Loongson-2's MMI/SIMD trigger COP1 exception, and Loongson-3's MMI/SIMD
trigger COP2 exception, so we need this patch to make pixman work fine.

To Xiuzhi,

Do you have an English version of Loongson-3's user mannual? I think that
will be very useful for Matt.

Huacai

> On Fri, Apr 4, 2014 at 1:11 AM, Huacai Chen <chenhc@lemote.com> wrote:
>> Loongson-3 has some specific instructions (MMI/SIMD) in coprocessor 2.
>> COP2 isn't independent because it share COP1 (FPU)'s registers. This
>> patch enable the COP2 usage so user-space programs can use the MMI/SIMD
>> instructions. When COP2 exception happens, we enable both COP1 (FPU)
>> and COP2, only in this way the fp context can be saved and restored
>> correctly.
>
> Is there a Loongson 3 programmers manual somewhere, similar to
> Loongson2FUserGuide.pdf?
>
> I optimized pixman for Loongson 2E/2F using their SIMD instructions.
> I've compiled pixman for Loongson 3A and I see some new instructions
> being used in the disassembly, but I have no Loongson 3 system to test
> on. At minimum, having a manual would be nice.
>
> Thanks,
> Matt
>
