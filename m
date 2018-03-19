Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2018 06:54:10 +0100 (CET)
Received: from mail-pl0-x244.google.com ([IPv6:2607:f8b0:400e:c01::244]:41783
        "EHLO mail-pl0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990403AbeCSFyD0Q3Q9 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Mar 2018 06:54:03 +0100
Received: by mail-pl0-x244.google.com with SMTP id b7-v6so5546860plr.8;
        Sun, 18 Mar 2018 22:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DHNVlZUnAmGk0+D9gkYEJsGwKCn2eZ/QpfuyMGIZYHI=;
        b=GCg1ccy7/kbvTWKJLAEc7rgmsrRatj80vYhMbgA31KXcNXH1tlRXFqjEdVYrwiI0HN
         M6RZVZkgio8cloBKVuyEVryL5JbcGZ1TT0jRmuaVxUwv26C0BrjaQCdKReOd4tFnRN66
         e9hLJOzUiTfq3v8D3fvKdoRsIhOT1yIEGeqxO+aK7Igro7z/SJcixhlmL5Nyg9gdu++j
         RlanqPIRX+qKmnI53ZVTiBgQZhSsBPU5+upVdEiakIzHQzhH2SiTmKGvfbKMG4gcx4bl
         bA9ykHdhonqDXdFHpKtGXxO/xgl7PhG3UVIDaufFkZzYrFlz1fEqjUms2IaNnfJ9K4iP
         yi/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DHNVlZUnAmGk0+D9gkYEJsGwKCn2eZ/QpfuyMGIZYHI=;
        b=BabXiUPw1+R7yPDNq4EcR0Fjgk4l1XQhfcx41fNU+7edVW6vJkmU3BsE4+L9qcD0pL
         3iOniySeKpCeOgBDfsTP4U2DjAUiCm0/nGUjtrjaujZW4aJi//vTnF252tFCvJno1W1Y
         TGQtStZXmIHXWj4XNPYVJBAevgE0435xMCyGEfL5TiblENAFbmUV1h9UXe4ai5gTuiNV
         kPuiE0AThI7bexWO/DzhghdrF91Sg0tipd23ACzi+z1L7whIbz/4YAC1CV/utIN9oRUR
         FyP0AQ/+aURUxWuqXVERAwqLrC2+ZhxXJK8pIRaVLvqw1gEk29a44oQnKRcUeY9ADk2g
         3SEg==
X-Gm-Message-State: AElRT7GluTI/EsLVH1bO3v15QIwpNBThUBPHyuetgmRxXfGOQL1Saj2n
        GjFm83rXO4Hpus8UECHJVTFiTlCh
X-Google-Smtp-Source: AG47ELueLrsk7oWtWe1SBSBY0Oa+wKl6oSiNKE6/1ufJkor9Uwj5/T7mdgWCr8gTl0Suka9X5Es8cg==
X-Received: by 2002:a17:902:8212:: with SMTP id x18-v6mr1192039pln.372.1521438836922;
        Sun, 18 Mar 2018 22:53:56 -0700 (PDT)
Received: from [172.16.1.120] ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id y6sm30689421pfg.71.2018.03.18.22.53.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Mar 2018 22:53:56 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] MIPS: Fix missing arcs_cmdline
From:   Jaedon Shin <jaedon.shin@gmail.com>
In-Reply-To: <CA+7wUsyNO+JK7xGky98SwKiy-DZ=zx3YBHsBPdG3+aimaE=J2A@mail.gmail.com>
Date:   Mon, 19 Mar 2018 14:53:52 +0900
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <838D4280-D9DE-46B8-B87A-FDC208DCD2AC@gmail.com>
References: <20180316025939.5416-1-jaedon.shin@gmail.com>
 <CA+7wUsyNO+JK7xGky98SwKiy-DZ=zx3YBHsBPdG3+aimaE=J2A@mail.gmail.com>
To:     Mathieu Malaterre <malat@debian.org>
X-Mailer: Apple Mail (2.3445.5.20)
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63042
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

Mathieu,

> On 16 Mar 2018, at 9:43 PM, Mathieu Malaterre <malat@debian.org> wrote:
> 
> Jaedon,
> 
> On Fri, Mar 16, 2018 at 3:59 AM, Jaedon Shin <jaedon.shin@gmail.com> wrote:
>> Due to commit 8ce355cf2e38 ("MIPS: Setup boot_command_line before
>> plat_mem_setup"), the value of arcs_command by prom_init is removed.
>> boot_command_line is initialized with __dt_setup_arch from
>> plat_mem_setup, but arcs_command is copied to boot_command_line before
>> plat_mem_setup by previous commit. This commit recover missing
>> arcs_command by prom_init.
> 
> If I cherry-pick your commit into my local branch I can no longer boot
> my MIPS Creator CI20. The sad part is that nothing shows up in the log
> (screen + tty) to indicate what the issue might be.

Did it work before this patch was cherry-picked?
But I find this patch has problem that didn't work CONFIG_CMDLINE with
__dt_setup_arch.

I have problem that bootloader argument (applied in prom_init) are removed.
Other MIPS_CMDLINE_* options may have also.

The previous patch 8ce355cf2e38 ("MIPS: Setup boot_command_line before plat_mem_setup")
fixes only duplicating in NO bootargs and CONFIG_CMDLINE. It cause problems
MIPS_CMDLINE_* options and CONFIG_CMDLINE_{BOOL,OVERRIDE}+__dt_setup_arch.
So we'll have to revert it and change the CONFIG_CMDLINE_{BOOL,OVERRIDE}
or append the CONFIG_CMDLINE_{BOOL,OVERRIDE} to fdt.c.

Thanks,
Jaedon

> 
>> Fixes: 8ce355cf2e38 ("MIPS: Setup boot_command_line before plat_mem_setup")
>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>> ---
>> arch/mips/kernel/setup.c | 36 +++++++++++++++++-------------------
>> 1 file changed, 17 insertions(+), 19 deletions(-)
>> 
>> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
>> index 5f8b0a9e30b3..e87f468f76dc 100644
>> --- a/arch/mips/kernel/setup.c
>> +++ b/arch/mips/kernel/setup.c
>> @@ -836,30 +836,12 @@ static void __init arch_mem_init(char **cmdline_p)
>> 
>> #if defined(CONFIG_CMDLINE_BOOL) && defined(CONFIG_CMDLINE_OVERRIDE)
>>        strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
>> -#else
>> -       if ((USE_PROM_CMDLINE && arcs_cmdline[0]) ||
>> -           (USE_DTB_CMDLINE && !boot_command_line[0]))
>> -               strlcpy(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
>> -
>> -       if (EXTEND_WITH_PROM && arcs_cmdline[0]) {
>> -               if (boot_command_line[0])
>> -                       strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
>> -               strlcat(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
>> -       }
>> -
>> -#if defined(CONFIG_CMDLINE_BOOL)
>> +#elif defined(CONFIG_CMDLINE_BOOL)
>>        if (builtin_cmdline[0]) {
>>                if (boot_command_line[0])
>>                        strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
>>                strlcat(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
>>        }
>> -
>> -       if (BUILTIN_EXTEND_WITH_PROM && arcs_cmdline[0]) {
>> -               if (boot_command_line[0])
>> -                       strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
>> -               strlcat(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
>> -       }
>> -#endif
>> #endif
>> 
>>        /* call board setup routine */
>> @@ -881,6 +863,22 @@ static void __init arch_mem_init(char **cmdline_p)
>>        pr_info("Determined physical RAM map:\n");
>>        print_memory_map();
>> 
>> +       if ((USE_PROM_CMDLINE && arcs_cmdline[0]) ||
>> +           (USE_DTB_CMDLINE && !boot_command_line[0]))
>> +               strlcpy(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
>> +
>> +       if (EXTEND_WITH_PROM && arcs_cmdline[0]) {
>> +               if (boot_command_line[0])
>> +                       strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
>> +               strlcat(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
>> +       }
>> +
>> +       if (BUILTIN_EXTEND_WITH_PROM && arcs_cmdline[0]) {
>> +               if (boot_command_line[0])
>> +                       strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
>> +               strlcat(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
>> +       }
>> +
>>        strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
>> 
>>        *cmdline_p = command_line;
>> --
>> 2.16.2
>> 
