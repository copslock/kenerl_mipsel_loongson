Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Oct 2018 19:56:51 +0200 (CEST)
Received: from mail-qt1-x844.google.com ([IPv6:2607:f8b0:4864:20::844]:36344
        "EHLO mail-qt1-x844.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994562AbeJHR4mR21hO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Oct 2018 19:56:42 +0200
Received: by mail-qt1-x844.google.com with SMTP id u34-v6so21887236qth.3
        for <linux-mips@linux-mips.org>; Mon, 08 Oct 2018 10:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WLlcl054mHW8IfpNRHIlMdn/Q+MTcMIQHakbr7OJ9Uc=;
        b=CcUstuYHmKOYK1X3QxfF+t9Tu8SbdqKbU8bFcLdql3qpMfsfNwDcPQjLoTl7WCCNdK
         0faR6QYpGkMHysLGrsfMjZQKSbO71+qKzT20c/Eo8nuxWdvDBfksV3vFldyzdS26xEnZ
         RZgtuYfNZ38e04kKdc9FF1++Cn/5WTr7nKrh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WLlcl054mHW8IfpNRHIlMdn/Q+MTcMIQHakbr7OJ9Uc=;
        b=L03F6EiOhCgRepHwycxaK4XCeRq5M8H6UJzBpwki1wZLdx/ifCzFzcBmCRF2zRyMSz
         64iF95AloMRpScEIWdRJMg398/KkqKTSS6FgESMAneJ37+oKtEPXEKPvhiTgJoMtH+HD
         cUw9mNYjFn0cGDLmkIVIdwMVWT4shJJmhRSNOhUJJBNzGkNKxvq87fOyoOHEEB9xbOgH
         oSGSutfn+6PEn2bNqH5N7pzxHU+Abw3UlvNIVSgZ7pxqBj+P/VtZM/4rMu0uDlhR6BKn
         lcgoAW8WF6GvAparXonF824v8zu78N3x4lr96lHI08jydw4rMtPtRsP5kkYfH3G1puYB
         yksQ==
X-Gm-Message-State: ABuFfohRV8tMP6BOobCctq8hrYVmKMBN/5U/BD5B9CvsVsCFIFd6xoyk
        S/guu3H2YWDuj6M/WjoOpSP+tVUGOayGiu+4s3jZdw==
X-Google-Smtp-Source: ACcGV63YVSZEiu5ebBchOq20H9Hjc8gSItA/GiKTV5tp65ck+uremN/0R4lCwI1QATfTgNCVn38IBkMdXyyNw6ptZEA=
X-Received: by 2002:aed:210e:: with SMTP id 14-v6mr20962204qtc.9.1539021396101;
 Mon, 08 Oct 2018 10:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <1538067417-6007-1-git-send-email-maksym.kokhan@globallogic.com> <20180927185626.gcvx5qjemxbff3zt@pburton-laptop>
In-Reply-To: <20180927185626.gcvx5qjemxbff3zt@pburton-laptop>
From:   Maksym Kokhan <maksym.kokhan@globallogic.com>
Date:   Mon, 8 Oct 2018 20:56:25 +0300
Message-ID: <CAMT6-xi+E1-ATYRXpkmcAprrwykLVHnUc2D+QBQLgPBv4hhwUg@mail.gmail.com>
Subject: Re: [PATCH 7/8] mips: convert to generic builtin command line
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Daniel Walker <dwalker@fifo99.com>,
        Daniel Walker <danielwa@cisco.com>,
        Andrii Bordunov <aborduno@cisco.com>,
        Ruslan Bilovol <rbilovol@cisco.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <maksym.kokhan@globallogic.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maksym.kokhan@globallogic.com
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

Hi, Paul,

On Thu, Sep 27, 2018 at 9:56 PM Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Maksym,
>
> On Thu, Sep 27, 2018 at 07:56:57PM +0300, Maksym Kokhan wrote:
> > -choice
> > -     prompt "Kernel command line type" if !CMDLINE_OVERRIDE
> > -     default MIPS_CMDLINE_FROM_DTB if USE_OF && !ATH79 && !MACH_INGENIC && \
> > -                                      !MIPS_MALTA && \
> > -                                      !CAVIUM_OCTEON_SOC
> > -     default MIPS_CMDLINE_FROM_BOOTLOADER
> > -
> > -     config MIPS_CMDLINE_FROM_DTB
> > -             depends on USE_OF
> > -             bool "Dtb kernel arguments if available"
> > -
> > -     config MIPS_CMDLINE_DTB_EXTEND
> > -             depends on USE_OF
> > -             bool "Extend dtb kernel arguments with bootloader arguments"
> > -
> > -     config MIPS_CMDLINE_FROM_BOOTLOADER
> > -             bool "Bootloader kernel arguments if available"
> > -
> > -     config MIPS_CMDLINE_BUILTIN_EXTEND
> > -             depends on CMDLINE_BOOL
> > -             bool "Extend builtin kernel arguments with bootloader arguments"
> > -endchoice
> >%
> > -#define USE_PROM_CMDLINE     IS_ENABLED(CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER)
> > -#define USE_DTB_CMDLINE              IS_ENABLED(CONFIG_MIPS_CMDLINE_FROM_DTB)
> > -#define EXTEND_WITH_PROM     IS_ENABLED(CONFIG_MIPS_CMDLINE_DTB_EXTEND)
> > -#define BUILTIN_EXTEND_WITH_PROM     \
> > -     IS_ENABLED(CONFIG_MIPS_CMDLINE_BUILTIN_EXTEND)
> > -
> >  static void __init arch_mem_init(char **cmdline_p)
> >  {
> >       struct memblock_region *reg;
> >       extern void plat_mem_setup(void);
> >
> > -#if defined(CONFIG_CMDLINE_BOOL) && defined(CONFIG_CMDLINE_OVERRIDE)
> > -     strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
> > -#else
> > -     if ((USE_PROM_CMDLINE && arcs_cmdline[0]) ||
> > -         (USE_DTB_CMDLINE && !boot_command_line[0]))
> > -             strlcpy(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
> > -
> > -     if (EXTEND_WITH_PROM && arcs_cmdline[0]) {
> > -             if (boot_command_line[0])
> > -                     strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
> > -             strlcat(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
> > -     }
> > -
> > -#if defined(CONFIG_CMDLINE_BOOL)
> > -     if (builtin_cmdline[0]) {
> > -             if (boot_command_line[0])
> > -                     strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
> > -             strlcat(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
> > -     }
> > -
> > -     if (BUILTIN_EXTEND_WITH_PROM && arcs_cmdline[0]) {
> > -             if (boot_command_line[0])
> > -                     strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
> > -             strlcat(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
> > -     }
> > -#endif
> > -#endif
> > -
> >       /* call board setup routine */
> >       plat_mem_setup();
> >
> > @@ -893,6 +856,8 @@ static void __init arch_mem_init(char **cmdline_p)
> >       pr_info("Determined physical RAM map:\n");
> >       print_memory_map();
> >
> > +     cmdline_add_builtin(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
> > +
> >       strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
> >
> >       *cmdline_p = command_line;
>
> I love the idea of simplifying this & sharing code with other
> architectures, but unfortunately I believe the above will be problematic
> for systems using arguments from device tree.
>
> At the point you call cmdline_add_builtin we should expect that:
>
>   - boot_command_line contains arguments from the DT, if any, and
>     otherwise may contain CONFIG_CMDLINE copied there by
>     early_init_dt_scan_chosen().
>
>   - arcs_cmdline contains arguments from the bootloader, if any.
>
> If I understand correctly you overwrite boot_command_line with the
> concatenation of CONFIG_CMDLINE_PREPEND, arcs_cmdline &
> CONFIG_CMDLINE_APPEND. This will clobber/lose the DT arguments.
>
> I'd expect this to be reproducible under QEMU using its boston emulation
> (ie. -M boston) and a kernel built for the generic platform that
> includes boston support (eg. 64r6el_defconfig).

You are right, there is a mistake in our implementation, thank you for
your observation. This bug can be easily fixed in 2 ways.
First - modify mips-specific code adding if statement with
processing bootloader cmdline:
------------------------------8<-----------------------------------

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 60638dd..7d11ef5 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -856,7 +856,11 @@ static void __init arch_mem_init(char **cmdline_p)
        pr_info("Determined physical RAM map:\n");
        print_memory_map();

-       cmdline_add_builtin(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
+       if (arcs_cmdline[0]) {
+               strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
+               strlcat(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
+       }
+       cmdline_add_builtin(boot_command_line, NULL, COMMAND_LINE_SIZE);

        strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);

------------------------------8<-----------------------------------
This solution was tested under QEMU using malta emulation and it
works fine. Another way is to modify common code in
include/linux/cmdline.h, but I am not sure, which approach is better.

> It also doesn't allow for the various Kconfig options which allow us to
> ignore some of the sources of command line arguments, nor does it honor
> the ordering that those existing options allow. In practice perhaps we
> can cut down on some of this configurability anyway, but if we do that
> it needs to be thought through & the commit message should describe the
> changes in behaviour.

Yes, this generic command line implementation lacks some of the
features, existing in the current mips command line code, and we
are going to expand functionality of generic command line code to
correspond it, but it would be easier to initially merge this simple
implementation and then develop it step by step.

Thanks,
Maksym
