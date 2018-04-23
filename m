Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Apr 2018 06:52:14 +0200 (CEST)
Received: from mail-io0-x244.google.com ([IPv6:2607:f8b0:4001:c06::244]:41530
        "EHLO mail-io0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992363AbeDWEwFu8iTx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Apr 2018 06:52:05 +0200
Received: by mail-io0-x244.google.com with SMTP id o7-v6so15110032iob.8;
        Sun, 22 Apr 2018 21:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=m7F/mxLFWZLNeab/gwm+kLOOAryW4hgve+rWdfNrj9Y=;
        b=N9ZcCNxftVAYNvecD3g9Q/2hVuIrmM0Q70STuytvJqQNmomgxbAHzTVK+U9iWmVJ7Z
         fgRDmzZV1zyEowPR2uLt6Fh1zq2p2CJ2cW1y9z04O1N1/sVh0z2+EaXq63aEIkRz/0j7
         7AOjONuWluDZekWxrsaU4dNdo/isN6UBXFDcPolUhPggkB6DdqKTLTYc39yyUEgY97/o
         PUEAR1tWLHTs2mCJ1Q/PnTThvHUnVY6qZO2fYx4g5e4J2Vsn2xF4EfJJC9PBgB49mCcx
         ZT6cdb6hUEF44S18fXx2M5JfEaeRqhfnkN31Wv77Y0xo/BOU9vsM9BbeBW0ffmg+BodM
         Jg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=m7F/mxLFWZLNeab/gwm+kLOOAryW4hgve+rWdfNrj9Y=;
        b=PwJIflLIARPM3AkuYsxOKoq+w+s3cBdsw2D+quWAE5sEMrzdhTbO9+B9biwlUVvjJ8
         I9vYyYPG/mZgIwYErfq6ZNx1W8+uUa/rGuo9TK1k12CuFzfNh+bpYgb0Rg3kql5SVSGf
         MaGg0KOGyMaKrJio+J0mhyUCVnvj05RhdY4qH9kFnPwV//pTNvapH2Ao+aL/2J7hB76E
         BXbT3sFRPdAcOZrWUx+zIuwb7Em7yqHWFCnQgWRp/vNRSlPS8pehghkaCtYybR5p8Y7y
         5r2JdLuli1NfRnbiv3Pw2W+61hN7p5MgRHPQJCKTPYq+tCgFJSBepNc8ytcPBjVbCqeD
         9hwQ==
X-Gm-Message-State: ALQs6tCvCl4ukCDpe1J5t2JBj2xLDZYtBxL0Dd7fyUCPfiuEXVAOzRbs
        MYDISfaqgk30xqXaUq8CJ9tfuuMnqagzJj8DEEo=
X-Google-Smtp-Source: AB8JxZrL2KXx+5uN43O7suarItclC3hgqRzyz/uVN3ksNiDBpFJ3/MrhqJmlTsvtS3i+s81UEPiHs3Dy9Mfxj0FUZWA=
X-Received: by 2002:a6b:8168:: with SMTP id c101-v6mr20302562iod.54.1524459119586;
 Sun, 22 Apr 2018 21:51:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.23.67 with HTTP; Sun, 22 Apr 2018 21:51:58 -0700 (PDT)
In-Reply-To: <c5a26d6f1e6ba35a4d45450adfa36aa3@codeaurora.org>
References: <1524455600-30384-1-git-send-email-chenhc@lemote.com> <c5a26d6f1e6ba35a4d45450adfa36aa3@codeaurora.org>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Mon, 23 Apr 2018 12:51:58 +0800
X-Google-Sender-Auth: sVj-cS-WR5tiPlpZOVqbhk6Bso8
Message-ID: <CAAhV-H6R8=59WLEOHRNhMHvNsrZXUZnShr94BfCY2xhgZZj7+Q@mail.gmail.com>
Subject: Re: [PATCH] MIPS: io: Add barrier after register read in inX()
To:     Sinan Kaya <okaya@codeaurora.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63695
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

Your patch add rmb() before read in readX(), why inX() need rmb() after read?

Huacai

On Mon, Apr 23, 2018 at 12:31 PM,  <okaya@codeaurora.org> wrote:
> On 2018-04-22 23:53, Huacai Chen wrote:
>>
>> While a barrier is present in the outX() functions before the register
>> write, a similar barrier is missing in the inX() functions after the
>> register read. This could allow memory accesses following inX() to
>> observe stale data.
>>
>> This patch is very similar to commit a1cc7034e33d12dc1 ("MIPS: io: Add
>> barrier after register read in readX()"). Because war_io_reorder_wmb()
>> is both used by writeX() and outX(), if readX() need a barrier then so
>> does inX().
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> ---
>>  arch/mips/include/asm/io.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
>> index a7d0b83..cea8ad8 100644
>> --- a/arch/mips/include/asm/io.h
>> +++ b/arch/mips/include/asm/io.h
>> @@ -414,6 +414,8 @@ static inline type pfx##in##bwlq##p(unsigned long
>> port)                     \
>>         __val = *__addr;                                                \
>>         slow;                                                           \
>>                                                                         \
>> +       /* prevent prefetching of coherent DMA data prematurely */      \
>> +       rmb();                                                          \
>>         return pfx##ioswab##bwlq(__addr, __val);                        \
>>  }
>
>
> Typically read barrier is applied after register read.
