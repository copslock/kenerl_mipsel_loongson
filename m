Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 19:55:45 +0100 (CET)
Received: from mail-ua0-x243.google.com ([IPv6:2607:f8b0:400c:c08::243]:35132
        "EHLO mail-ua0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990475AbeABSzihzCc0 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Jan 2018 19:55:38 +0100
Received: by mail-ua0-x243.google.com with SMTP id g16so20529281uak.2;
        Tue, 02 Jan 2018 10:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=o2JaF/AgITKESM/OQX/15Io2wII/VABOnNkRgh8HBsk=;
        b=tgslJfOTJScfv2rDktQg1A9ruaZavfTvIqb57OyGKV2sdlVuKwkfogNAwYwq0wHXvW
         GuHdzvYNQbIaaG8lr0V/Ip9ob/39EBngHwINZgYAIngmCBy21VPL0HFpRxI196/Yvf3P
         M+kwhOOot5qc8ZCh5USHIx5Bc8ci5WfqJdZcghAi7lv8KzwWszMfqbk0nnjQMAXzUGIm
         A0Rl+JGhw/pMzKG7sOUmQd1Taa3lg9HxoUIX3xQZRmCHDTRuLyuFex7MfrLE/xpmNUNY
         CCnOxzNKOhU9CUqjkaiXbQfMdcVa/PtMnXANE4HYe+vdSHyP0njT8zSqGWG2SgwFMH/Y
         itew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=o2JaF/AgITKESM/OQX/15Io2wII/VABOnNkRgh8HBsk=;
        b=K8lSkpT9gFctG2FiWB4MJY8UT1rYELVrOq606g4WRKHwxrdaX+tcHSyIHulCLgBaRG
         LNU0zNVZmqPXo8oMlQgiWvaz4LCVeQ8MGTSz+8x+1yYUrNyqTMquatQFgPh1gKtq3LOK
         P0Nxo7bb8ECv84lIBrVGfopvkxJn4suFWY5K8n+E2+dONaJqPeno1PNjp15Flnf5Cg2O
         81XQagSXSCgx/aW1t6nOoigW6L1d0s7lGSLn/XqZ447NfWs1TiUnMliRnyphVOiOvIgz
         o2AcVZfMrd/dq4DIgk/E8b5up9tzConMAYInSwEVo3kDPI2brNLB9dQoixklu01HLz9f
         0fYA==
X-Gm-Message-State: AKGB3mIAsKxP2NAiQ3QxOdBNaQYJr9cOa5kMEOWcRSH0uxqcpiF746bl
        jjsBYMHsbQJnoN2mUtPe9sdHyK0bLcSG5gvyxjk=
X-Google-Smtp-Source: ACJfBotqqYtZoAzwvtA7iVK40o1IjC2f4RU2iXXC8mvUaxA1R8j/BiCFQZYoXbtyyFwxyv4wbBBvJpLyNowthbsOfE0=
X-Received: by 10.176.5.161 with SMTP id e30mr26129138uae.17.1514919332353;
 Tue, 02 Jan 2018 10:55:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.4.199 with HTTP; Tue, 2 Jan 2018 10:55:11 -0800 (PST)
In-Reply-To: <20180102093127.GM5027@jhogan-linux.mipstec.com>
References: <20171226113717.15074-1-malat@debian.org> <20171226113717.15074-2-malat@debian.org>
 <20180102093127.GM5027@jhogan-linux.mipstec.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Tue, 2 Jan 2018 19:55:11 +0100
X-Google-Sender-Auth: UbWEhII2zPm3BpNY8_AKW9na-gc
Message-ID: <CA+7wUszh=xpNMsZXS0fNu2Vcp=GK9xkzfog5qB2_LGizhadv1Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: Remove a warning when PHYS_OFFSET is 0x0
To:     James Hogan <james.hogan@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61865
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

Hi James,

On Tue, Jan 2, 2018 at 10:31 AM, James Hogan <james.hogan@mips.com> wrote:
> On Tue, Dec 26, 2017 at 12:37:14PM +0100, Mathieu Malaterre wrote:
>> Rewrite the comparison in `else if` statement, case where `min_low_pfn >
>> ARCH_PFN_OFFSET` has already been checked in the first `if` statement:
>>
>>   if (min_low_pfn > ARCH_PFN_OFFSET) {
>>
>> Fix non-fatal warning:
>>
>> arch/mips/kernel/setup.c: In function ‘bootmem_init’:
>> arch/mips/kernel/setup.c:461:25: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
>>   } else if (min_low_pfn < ARCH_PFN_OFFSET) {
>>                          ^
>
> What compiler version is that with out of interest? It isn't exactly new
> code.

I've clarified in v2, that this happen during compilation using W=1

For reference:

$ mipsel-linux-gnu-gcc -dumpversion
6.3.0


>>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>
> Reviewed-by: James Hogan <jhogan@kernel.org>

Thanks !
