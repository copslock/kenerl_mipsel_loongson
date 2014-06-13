Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2014 12:02:40 +0200 (CEST)
Received: from mail-la0-f45.google.com ([209.85.215.45]:41251 "EHLO
        mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825074AbaFMKCgNy8jk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Jun 2014 12:02:36 +0200
Received: by mail-la0-f45.google.com with SMTP id s18so1333624lam.18
        for <multiple recipients>; Fri, 13 Jun 2014 03:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:cc:content-type;
        bh=EdYxmGy0Rq79Qd/rEIs5+8RtEBhyT9iHYAejWC3u4wM=;
        b=oL5otzYBTAJNaOaVqIqyV/mdyCn0zwuRVeSIvBzftljymBpEHy04Wf0TUhBLU5Q8lz
         oqjgqrA4EM9PFfWEbsrHsoelubSshre7kChF2A6cdLnEo2MMb4skWyNo6JxfcZHHbAtw
         AW48iY9U/O/sE4ekXZThh7blzLc20NvgJWF5zuYw5qzqpxI6Sr7919XZUmLwkFr34/2v
         Vifm0Adb8abU4ZPzABetwaZ2o2mJ4vzmGsEGgzU1hNg7PKee7yuztIqWQcWyjmj1WUEL
         T0ZR0bNjfMDe0xCwGTjBBf4bB7i4foupNAXOzyJ3ACr2p5DqCaI1nQf4UqiGkqufanVb
         L8iQ==
MIME-Version: 1.0
X-Received: by 10.152.29.200 with SMTP id m8mr1128978lah.49.1402653750636;
 Fri, 13 Jun 2014 03:02:30 -0700 (PDT)
Received: by 10.152.43.4 with HTTP; Fri, 13 Jun 2014 03:02:30 -0700 (PDT)
Date:   Fri, 13 Jun 2014 12:02:30 +0200
X-Google-Sender-Auth: yciS48otrN-ws_ttzeedwf599Zc
Message-ID: <CAMuHMdWSXBw554dy4mTGu9dGbhtKCfVE1=13QP1ykV=BkkBrnw@mail.gmail.com>
Subject: mips: Accidental removal of paravirt_cpus_done?
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        kvm@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

Hi Ralf,

It seems you accidentally assimilated an (unwanted?) kvm change in my
patch:

On Tue, Jun 10, 2014 at 3:31 AM, Linux Kernel Mailing List
<linux-kernel@vger.kernel.org> wrote:
> Gitweb:     http://git.kernel.org/linus/;a=commit;h=5e888e8fb55cf3da870b85d04fef6bfe0d57c974
> Commit:     5e888e8fb55cf3da870b85d04fef6bfe0d57c974
> Parent:     a1eace4ba53546bc7a6670b1c380cd5c1287ae8b
> Refname:    refs/heads/master
> Author:     Geert Uytterhoeven <geert@linux-m68k.org>
> AuthorDate: Tue Apr 22 12:51:13 2014 +0200
> Committer:  Ralf Baechle <ralf@linux-mips.org>
> CommitDate: Mon Jun 2 16:34:41 2014 +0200
>
>     mips: Update the email address of Geert Uytterhoeven
>
>     All my Sony addresses are defunct.
>
>     Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>     Cc: linux-mips@linux-mips.org
>     Patchwork: https://patchwork.linux-mips.org/patch/6817/
>     Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> ---
>  arch/mips/include/asm/nile4.h     |    2 +-
>  arch/mips/paravirt/paravirt-smp.c |    5 -----
>  arch/mips/pci/ops-pmcmsp.c        |    2 +-
>  arch/mips/pci/ops-tx3927.c        |    2 +-
>  4 files changed, 3 insertions(+), 8 deletions(-)

> diff --git a/arch/mips/paravirt/paravirt-smp.c b/arch/mips/paravirt/paravirt-smp.c
> index 73a123e..0164b0c 100644
> --- a/arch/mips/paravirt/paravirt-smp.c
> +++ b/arch/mips/paravirt/paravirt-smp.c
> @@ -99,10 +99,6 @@ static void paravirt_smp_finish(void)
>         local_irq_enable();
>  }
>
> -static void paravirt_cpus_done(void)
> -{
> -}
> -
>  static void paravirt_boot_secondary(int cpu, struct task_struct *idle)
>  {
>         paravirt_smp_gp[cpu] = (unsigned long)task_thread_info(idle);
> @@ -141,7 +137,6 @@ struct plat_smp_ops paravirt_smp_ops = {
>         .send_ipi_mask          = paravirt_send_ipi_mask,
>         .init_secondary         = paravirt_init_secondary,
>         .smp_finish             = paravirt_smp_finish,
> -       .cpus_done              = paravirt_cpus_done,
>         .boot_secondary         = paravirt_boot_secondary,
>         .smp_setup              = paravirt_smp_setup,
>         .prepare_cpus           = paravirt_prepare_cpus,

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
