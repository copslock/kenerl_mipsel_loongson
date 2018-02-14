Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Feb 2018 11:36:17 +0100 (CET)
Received: from mail-ua0-x241.google.com ([IPv6:2607:f8b0:400c:c08::241]:37147
        "EHLO mail-ua0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991128AbeBNKgKpIhXw convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Feb 2018 11:36:10 +0100
Received: by mail-ua0-x241.google.com with SMTP id q8so13390830uae.4;
        Wed, 14 Feb 2018 02:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=3swUwf5DOs6xEu0I8RBkfrNNgO6fI7mHnJDCd21Q/cs=;
        b=GLsGBcgVD5lnkFn3ev6MYrM3023RuDb7ng8h8exkqyoyMB0WFALeJvEghm/MkF+1Uy
         p8Osl6+wpVLtOOtQVbdqfuHBI6tRusduuVh4QRltmmS4j5y3/wvhS/W9Z8cvb/Z0orSi
         NUtzyMRwf1kyaqsDj8+2coVmtWjiJfZLQdpWeC/dj1wCHbiN4dVYO5ndCmSAqLeWqhcb
         DbPQPRjdPPuhdPA1xnsXrYuRIMa8A2WSkSkiaKYnnL3VI0Sq3Dap7giGxTLenweyBefR
         0YmZsYh1Zd7G/GvxJ1jZuLubauKB2D1Mla2HK92Bp7Xvpj5qIo1yRKg80NsSZJ/S+T1O
         oWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=3swUwf5DOs6xEu0I8RBkfrNNgO6fI7mHnJDCd21Q/cs=;
        b=OHz1PhXPPWAXYHAuSM9Zy4S3EEUlIWBPBG97G7hpZV5PeI1tqtUO3sUcbwEf+WcsMj
         4DPuA2+2K0nPB9ppr4BRhvtOB5O51qkEx3fXlaJX+UNCZO2V1aGbzH3xooRNt0qduvqA
         heCxn+ggcc43ft2LQ8qGZvKkZQ4+7egyucdP9slCwvFJnZlBweK5I/UAYp9lEIgoTDx0
         SFFUcrEYfHh3iBRhAcqaDP90bf4FSZ98xIdVcIREG3lVE7b6bDKi59z7pePR0gJdrzoB
         hZkbi3BjrzvxGesBM6tohI/W/ZTfOsWgYUgWbo11h/dbv0euIN9M/ySVxLrM+YBwR2eZ
         5pFw==
X-Gm-Message-State: APf1xPCwzouWOSPSMe4/yZG6rggN+VDuPFvaU7Jh32QBupyF6NAuqTNL
        foEJ1oRPzJDHeCkrhto+7s9d5taMkZABvxGqp74=
X-Google-Smtp-Source: AH8x225BrMrBJXGsQOrU0OVIc8vuLBqlWsDHkcHT/DI02kt31F02Sj/ogXt7XqoyQrygXvbgWKxGno2ku/vnz9faQ8I=
X-Received: by 10.159.49.135 with SMTP id v7mr4080413uad.17.1518604564439;
 Wed, 14 Feb 2018 02:36:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.38.193 with HTTP; Wed, 14 Feb 2018 02:35:44 -0800 (PST)
In-Reply-To: <CA+7wUszh=xpNMsZXS0fNu2Vcp=GK9xkzfog5qB2_LGizhadv1Q@mail.gmail.com>
References: <20171226113717.15074-1-malat@debian.org> <20171226113717.15074-2-malat@debian.org>
 <20180102093127.GM5027@jhogan-linux.mipstec.com> <CA+7wUszh=xpNMsZXS0fNu2Vcp=GK9xkzfog5qB2_LGizhadv1Q@mail.gmail.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 14 Feb 2018 11:35:44 +0100
X-Google-Sender-Auth: aQ_nYBWzh3QMmr9LnMwDDCLL_5U
Message-ID: <CA+7wUsyNrLzd0fM5B4_89wp8G9g=VHLu=xQ3o4bK47PLv4p1LQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: Remove a warning when PHYS_OFFSET is 0x0
To:     James Hogan <james.hogan@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

On Tue, Jan 2, 2018 at 7:55 PM, Mathieu Malaterre <malat@debian.org> wrote:
> Hi James,
>
> On Tue, Jan 2, 2018 at 10:31 AM, James Hogan <james.hogan@mips.com> wrote:
>> On Tue, Dec 26, 2017 at 12:37:14PM +0100, Mathieu Malaterre wrote:
>>> Rewrite the comparison in `else if` statement, case where `min_low_pfn >
>>> ARCH_PFN_OFFSET` has already been checked in the first `if` statement:
>>>
>>>   if (min_low_pfn > ARCH_PFN_OFFSET) {
>>>
>>> Fix non-fatal warning:
>>>
>>> arch/mips/kernel/setup.c: In function ‘bootmem_init’:
>>> arch/mips/kernel/setup.c:461:25: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
>>>   } else if (min_low_pfn < ARCH_PFN_OFFSET) {
>>>                          ^
>>
>> What compiler version is that with out of interest? It isn't exactly new
>> code.
>
> I've clarified in v2, that this happen during compilation using W=1
>
> For reference:
>
> $ mipsel-linux-gnu-gcc -dumpversion
> 6.3.0
>
>
>>>
>>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>>
>> Reviewed-by: James Hogan <jhogan@kernel.org>
>
> Thanks !

ping ?

https://patchwork.linux-mips.org/project/linux-mips/list/?series=623
