Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2018 15:04:05 +0100 (CET)
Received: from mail-vk0-x241.google.com ([IPv6:2607:f8b0:400c:c05::241]:43514
        "EHLO mail-vk0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994554AbeBMODzP9uPV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Feb 2018 15:03:55 +0100
Received: by mail-vk0-x241.google.com with SMTP id x203so10848611vkx.10;
        Tue, 13 Feb 2018 06:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=pE2hieMN2XdXL8VelvN2e1ntugIpGGYfMuzBUUqBSkI=;
        b=Bm1ymhYK6wLYN8ggpz9b5wmMmKhbRDfneKq+qHx+MsIZlp6hjOq0sGZyU1wFFkcRUY
         mAsQPneA3E+YZnVjEKbbkL1HBkGuQTz1UMjdd4b8P3mTaNgmUxln1yicf0Khr8+mDdnA
         owbGUA7eibYzX5QnUe7bTl56wNmdo+2t56WR148cRgKIjYb7RLw/NL1lON0QBZ7hubmo
         I68E2ULE7F1gSsi9xcbHezv9lVf4JkTbmrMg2LO6yRv4rKmH5FYS61wVU5JSrIPUXD/u
         Gvl5vOKuucJ9tuBtIQIx0CQ+TDARGqqYMI/Lb4LtM64LIxFFaPshK7Z0PtMRPLRDZ2Rg
         irnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=pE2hieMN2XdXL8VelvN2e1ntugIpGGYfMuzBUUqBSkI=;
        b=a1iQNF4JJbWizQrRJ1M/VHYYRm8mF/oRWaebPkdy6KcYblObVM+WxbZSorAZCnkRw4
         DtaYW3c4v06PaeeTl4cLkxDO+mx7TEes+67FliU024qL3pNBKTzyKNr83bKMy4IU3w2F
         Wqsc+43/RVmXyYaLm+/vsjx+7SKcYZVWjV/4P1mLEYKz8VxuS6WWQGvg5E7KXbCYZm7P
         OHrFyqUSioI1o6N7gYYBnzBFDV7+bha4phFv9HAHc/JyUteX7H+L4sVWfJLbmHQoQmx1
         b0ekA7UqVVorIVUbEo0C6YupkSHRFXB5mhNMXlReSnNkZSPL8deAA3hjjNwm7/L7iPwA
         25HA==
X-Gm-Message-State: APf1xPAajqGTMqIs5846e2ijs+wF6KCql3HfhZ4+tAoI6zORcEyN9+xa
        g+euDsKswZoEJRhniunv/atjkl5FKJrj6RurmIo=
X-Google-Smtp-Source: AH8x226QlxU/Minmn07x67/mKNJsY/FoAwTXQZZAY3hxKfZqXQufl2fh4ZuJuBvcZ3Ao/CO+BzHFJfkU1wOP+WlEyNc=
X-Received: by 10.31.106.133 with SMTP id f127mr1199591vkc.94.1518530625426;
 Tue, 13 Feb 2018 06:03:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.38.193 with HTTP; Tue, 13 Feb 2018 06:03:24 -0800 (PST)
In-Reply-To: <20180213133832.GD4290@saruman>
References: <20180201113721.24776-1-marcin.nowakowski@mips.com>
 <CA+7wUswiOdqunZfnL-6YFJ6gPfj7bXAdHYbetbW_PdQaN28GzQ@mail.gmail.com>
 <CA+7wUszerm6VQsboY9hhgzEZejFOyKZtoh+eCpAESho-xdmQXw@mail.gmail.com> <20180213133832.GD4290@saruman>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Tue, 13 Feb 2018 15:03:24 +0100
X-Google-Sender-Auth: UqyWiozmIMAukl4724xnKvABvSg
Message-ID: <CA+7wUswyQjRvY1=4g785jNBnfAAqSUbyYSWh3qKHieJVhmbxSg@mail.gmail.com>
Subject: Re: [PATCH v3] MIPS: fix incorrect mem=X@Y handling
To:     James Hogan <jhogan@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        linux-mips@linux-mips.org, "# v4 . 11" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62522
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

James,

On Tue, Feb 13, 2018 at 2:38 PM, James Hogan <jhogan@kernel.org> wrote:
> On Tue, Feb 13, 2018 at 01:14:29PM +0100, Mathieu Malaterre wrote:
>> On Thu, Feb 1, 2018 at 1:12 PM, Mathieu Malaterre <malat@debian.org> wrote:
>> > On Thu, Feb 1, 2018 at 12:37 PM, Marcin Nowakowski
>> > <marcin.nowakowski@mips.com> wrote:
>> >> Commit 73fbc1eba7ff ("MIPS: fix mem=X@Y commandline processing") added a
>> >> fix to ensure that the memory range between PHYS_OFFSET and low memory
>> >> address specified by mem= cmdline argument is not later processed by
>> >> free_all_bootmem.  This change was incorrect for systems where the
>> >> commandline specifies more than 1 mem argument, as it will cause all
>> >> memory between PHYS_OFFSET and each of the memory offsets to be marked
>> >> as reserved, which results in parts of the RAM marked as reserved
>> >> (Creator CI20's u-boot has a default commandline argument 'mem=256M@0x0
>> >> mem=768M@0x30000000').
>> >>
>> >> Change the behaviour to ensure that only the range between PHYS_OFFSET
>> >> and the lowest start address of the memories is marked as protected.
>> >>
>> >> This change also ensures that the range is marked protected even if it's
>> >> only defined through the devicetree and not only via commandline
>> >> arguments.
>> >>
>> >> Reported-by: Mathieu Malaterre <mathieu.malaterre@gmail.com>
>> >> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@mips.com>
>> >> Fixes: 73fbc1eba7ff ("MIPS: fix mem=X@Y commandline processing")
>> >> Cc: <stable@vger.kernel.org> # v4.11+
>> >> ---
>> >> v3: Update stable version, code cleanup as suggested by James Hogan
>> >> v2: Use updated email adress, add tag for stable.
>> >> ---
>> >>  arch/mips/kernel/setup.c | 16 ++++++++++++----
>> >>  1 file changed, 12 insertions(+), 4 deletions(-)
>> >>
>> >> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
>> >> index 702c678de116..e4a1581ce822 100644
>> >> --- a/arch/mips/kernel/setup.c
>> >> +++ b/arch/mips/kernel/setup.c
>> >> @@ -375,6 +375,7 @@ static void __init bootmem_init(void)
>> >>         unsigned long reserved_end;
>> >>         unsigned long mapstart = ~0UL;
>> >>         unsigned long bootmap_size;
>> >> +       phys_addr_t ramstart = (phys_addr_t)ULLONG_MAX;
>> >>         bool bootmap_valid = false;
>> >>         int i;
>> >>
>> >> @@ -395,7 +396,8 @@ static void __init bootmem_init(void)
>> >>         max_low_pfn = 0;
>> >>
>> >>         /*
>> >> -        * Find the highest page frame number we have available.
>> >> +        * Find the highest page frame number we have available
>> >> +        * and the lowest used RAM address
>> >>          */
>> >>         for (i = 0; i < boot_mem_map.nr_map; i++) {
>> >>                 unsigned long start, end;
>> >> @@ -407,6 +409,8 @@ static void __init bootmem_init(void)
>> >>                 end = PFN_DOWN(boot_mem_map.map[i].addr
>> >>                                 + boot_mem_map.map[i].size);
>> >>
>> >> +               ramstart = min(ramstart, boot_mem_map.map[i].addr);
>> >> +
>> >>  #ifndef CONFIG_HIGHMEM
>> >>                 /*
>> >>                  * Skip highmem here so we get an accurate max_low_pfn if low
>> >> @@ -436,6 +440,13 @@ static void __init bootmem_init(void)
>> >>                 mapstart = max(reserved_end, start);
>> >>         }
>> >>
>> >> +       /*
>> >> +        * Reserve any memory between the start of RAM and PHYS_OFFSET
>> >> +        */
>> >> +       if (ramstart > PHYS_OFFSET)
>> >> +               add_memory_region(PHYS_OFFSET, ramstart - PHYS_OFFSET,
>> >> +                                 BOOT_MEM_RESERVED);
>> >> +
>> >>         if (min_low_pfn >= max_low_pfn)
>> >>                 panic("Incorrect memory mapping !!!");
>> >>         if (min_low_pfn > ARCH_PFN_OFFSET) {
>> >> @@ -664,9 +675,6 @@ static int __init early_parse_mem(char *p)
>> >>
>> >>         add_memory_region(start, size, BOOT_MEM_RAM);
>> >>
>> >> -       if (start && start > PHYS_OFFSET)
>> >> -               add_memory_region(PHYS_OFFSET, start - PHYS_OFFSET,
>> >> -                               BOOT_MEM_RESERVED);
>> >>         return 0;
>> >>  }
>> >>  early_param("mem", early_parse_mem);
>> >> --
>> >> 2.14.1
>> >>
>> >
>> > Looks good to me:
>> >
>> > $ cat /proc/cpuinfo
>> > system type : JZ4780
>> > machine : Creator CI20
>> > processor : 0
>> > cpu model : Ingenic JZRISC V4.15  FPU V0.0
>> > BogoMIPS : 956.00
>> > wait instruction : yes
>> > microsecond timers : no
>> > tlb_entries : 32
>> > extra interrupt vector : yes
>> > hardware watchpoint : yes, count: 1, address/irw mask: [0x0fff]
>> > isa : mips1 mips2 mips32r1 mips32r2
>> > ASEs implemented :
>> > shadow register sets : 1
>> > kscratch registers : 0
>> > package : 0
>> > core : 0
>> > VCED exceptions : not available
>> > VCEI exceptions : not available
>> > $ uname -a
>> > Linux ci20 4.15.0+ #323 PREEMPT Thu Feb 1 13:08:11 CET 2018 mips GNU/Linux
>> >
>> > Tested-by: Mathieu Malaterre <malat@debian.org>
>> >
>> > Thanks
>>
>> Could you please review the patch v3 ?
>
> Yes, looks good to me, and Ralf had applied to his test branch so I
> presume he's happy with it too. I'll apply for 4.16.

Hum, just to be sure I understand the process. Which branch are you
talking about:

https://git.kernel.org/pub/scm/linux/kernel/git/ralf/linux.git

> Commit 73fbc1eba7ff ("MIPS: fix mem=X@Y commandline processing") which
> this fixes was evidently requested to be backported to stable (unsure
> who by) and added to the 4.9 queue, but then this arose and it was
> removed until this fix is merged (see
> https://patchwork.linux-mips.org/patch/17268/).
>
> Anybody know how far back before 4.11 both of these patches should be
> applied to stable? If not I'll just leave it at 4.11 and if its
> important before then for kexec or whatever they can be requested again.
