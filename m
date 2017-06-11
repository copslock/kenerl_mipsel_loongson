Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Jun 2017 12:33:50 +0200 (CEST)
Received: from mail-ua0-x243.google.com ([IPv6:2607:f8b0:400c:c08::243]:36657
        "EHLO mail-ua0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992160AbdFKKdoLSbaj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Jun 2017 12:33:44 +0200
Received: by mail-ua0-x243.google.com with SMTP id f14so6972343uaa.3;
        Sun, 11 Jun 2017 03:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=p+UMki/ox/ziaUOme1o6XQK0oS7d4dotcPfd7xj9yEI=;
        b=FGYEK+FC9yeyFStQoSwujIPd0fVzgqFzhHlUw/tSgt5PsDgNfTigvQMTVW41OMcGgZ
         Rn/2h6UHKdUzlkMXmwCrs54DFx3ry/7UWf5Ml1d1Mb7DdviNImwPiQPx8ZwtH6rA8E2e
         W5uIUGKX9PmYUKDOQGECZCstBgUDL4fprZKTW33OerfVJeqrmYPcAADwDfIwBuwPzqhg
         DybS4qpUGSnAnxVIVGk1ttmHuDOYA7nEqMZr/OOgtjEqpoBdQ68lHiqjnElyA4QTtZT8
         LpVkmiTbcPHfpULrXx/oTQuDLcrUxc6LDRpMXnOhZ92FClS2Qoap3K+qXRRT8CHB4j8p
         d+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=p+UMki/ox/ziaUOme1o6XQK0oS7d4dotcPfd7xj9yEI=;
        b=BKfkCOcMg8GawQ/9VleUW51jEarFVi1Xneyoh3H/t7rx5eYsfyFeQRRnKx/OiQK2c7
         7P4+RM0U08Nq7xuwvX9TpvBtqqPj140xrOOdKVgLqrOg8P1zamyGMjrjgxXqh8JwvLRa
         m7YKmkGVOZ8ooRErjoXHbcvl9WmIUNEe6apPn5PAw4RrzG3V4klLFKZzzIKT3xTPLX32
         LPJW7JFJ4hw0yzC4PpNop9hpHP3J26dOCM4O964VBtLXaOCgEFzmoGfWwSl7Dg/jGQKc
         7lbknK/vzVhKyHaA+yizGvDuWkR41eRlrYMJPeJAe/BLD8QVxR1YFlU514KPAP9KTYCv
         hxPg==
X-Gm-Message-State: AODbwcD6Q+s71BGtPP251WCbYZsDT0yfk9CGt9cTLWP9JmUs+Z0c2bBV
        aEz/M+NJQrsxtXvklkIzCMRJ9OTIWQ==
X-Received: by 10.176.81.4 with SMTP id e4mr30299691uaa.33.1497177218395; Sun,
 11 Jun 2017 03:33:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.64.135 with HTTP; Sun, 11 Jun 2017 03:33:18 -0700 (PDT)
In-Reply-To: <2d887f2f-b83b-3540-37dd-182aeed1fc0e@caviumnetworks.com>
References: <1496776596-5045-1-git-send-email-andrea.merello@gmail.com>
 <fd8ad5f4-ab71-e8fc-a7ee-5177877cfb74@gmail.com> <2d887f2f-b83b-3540-37dd-182aeed1fc0e@caviumnetworks.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Sun, 11 Jun 2017 12:33:18 +0200
Message-ID: <CAOiHx=mocjOMDk4_p6=epCJgMmH1QFay1oq6Eo1uwiV-oG6ZkQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: fix boot with DT passed via UHI
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

On 8 June 2017 at 00:47, David Daney <ddaney@caviumnetworks.com> wrote:
> On 06/07/2017 06:16 AM, Daniel Schwierzeck wrote:
>>
>>
>>
>> Am 06.06.2017 um 21:16 schrieb Andrea Merello:
>>>
>>> commit 15f37e158892 ("MIPS: store the appended dtb address in a
>>> variable")
>>> seems to have introduced code that relies on delay slots after branch,
>>> however it seems that, since no directive ".set noreorder" is present,
>>> the
>>> AS already fills delay slots with NOPs.
>>>
>>> This caused failure in assigning proper DT blob address to fw_passed_dtb
>>> variable, causing failure when booting passing DT via UHI; this has been
>>> seen on a Lantiq VR9 SoC (Fritzbox 3370) and u-boot as bootloader.
>>>
>>> [    0.000000] Linux version 4.12.0-fritz+ (andrea@horizon) (gcc version
>>> 4.9.0 (GCC) ) #29 SMP Tue Jun 6 20:49:59 CEST 2017
>>> [    0.000000] SoC: xRX200 rev 1.2
>>> [    0.000000] bootconsole [early0] enabled
>>> [    0.000000] CPU0 revision is: 00019556 (MIPS 34Kc)
>>> [    0.000000] Determined physical RAM map:
>>> [    0.000000]  memory: 00696000 @ 00002000 (usable)
>>> [    0.000000]  memory: 00038000 @ 00698000 (usable after init)
>>> [    0.000000] Wasting 64 bytes for tracking 2 unused pages
>>> [    0.000000] Kernel panic - not syncing: No memory area to place a
>>> bootmap bitmap
>>> [    0.000000] Rebooting in 1 seconds..
>>> [    0.000000] Reboot failed -- System halted
>>>
>>> This patch moves the instruction meant to be placed in the delay slot
>>> before the preceding BEQ instruction, while the delay slot will be
>>> filled with a NOP by the AS.
>>>
>>> After this patch the kernel fetches the DR correctly
>>>
>>> [    0.000000] Linux version 4.12.0-fritz+ (andrea@horizon) (gcc version
>>> 4.9.0 (GCC) ) #30 SMP
>>> Tue Jun 6 20:52:40 CEST 2017
>>> [    0.000000] SoC: xRX200 rev 1.2
>>> [    0.000000] bootconsole [early0] enabled
>>> [    0.000000] CPU0 revision is: 00019556 (MIPS 34Kc)
>>> [    0.000000] MIPS: machine is FRITZ3370 - Fritz!Box WLAN 3370
>>> [    0.000000] Determined physical RAM map:
>>> [    0.000000]  memory: 08000000 @ 00000000 (usable)
>>> [    0.000000] Detected 1 available secondary CPU(s)
>>> [    0.000000] Primary instruction cache 32kB, VIPT, 4-way, linesize 32
>>> bytes.
>>> [    0.000000] Primary data cache 32kB, 4-way, VIPT, cache aliases,
>>> linesize 32 bytes
>>> [    0.000000] Zone ranges:
>>> [    0.000000]   Normal   [mem 0x0000000000000000-0x0000000007ffffff]
>>> [    0.000000] Movable zone start for each node
>>> [    0.000000] Early memory node ranges
>>> [    0.000000]   node   0: [mem 0x0000000000000000-0x0000000007ffffff]
>>> [    0.000000] Initmem setup node 0 [mem
>>> 0x0000000000000000-0x0000000007ffffff]
>>> [    0.000000] percpu: Embedded 15 pages/cpu @8110c000 s30176 r8192
>>> d23072 u61440
>>> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
>>> Total pages: 32512
>>> [    0.000000] Kernel command line: rootwait root=/dev/sda1
>>> console=ttyLTQ0
>>> ...
>>>
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: Jonas Gorski <jogo@openwrt.org>
>>> Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
>>> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
>>>
>>> diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
>>> index cf05220..d1bb506 100644
>>> --- a/arch/mips/kernel/head.S
>>> +++ b/arch/mips/kernel/head.S
>>> @@ -106,8 +106,8 @@ NESTED(kernel_entry, 16, sp)                        #
>>> kernel entry point
>>>         beq             t0, t1, dtb_found
>>>   #endif
>>>         li              t1, -2
>>> -       beq             a0, t1, dtb_found
>>>         move            t2, a1
>>> +       beq             a0, t1, dtb_found
>>>         li              t2, 0
>>>   dtb_found:
>>>
>>
>> The fix looks correct. Without ".set noreorder" one should not
>
>
> s/should/must/
>
>> manually
>> put instructions in the delay slot. This should be left to the AS as an
>> option for optimization.
>
>
> By definition, it is what the assembler does.  When ".set noreorder" is not
> in effect, the source code *must* be written as if branch delay slots do not
> exist.  There is no option here.

My assembly knowledge is mostly from reading disassembled code where
delay slots always matter, so when writing this code it didn't even
cross my mind that the the assembler might do that.

So thanks for fixing it!


Regards
Jonas
