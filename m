Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Aug 2014 20:40:19 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:38461 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6842522AbaHHSkQ3uU0g (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 8 Aug 2014 20:40:16 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 5EDFB2844F5;
        Fri,  8 Aug 2014 20:37:43 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qa0-f53.google.com (mail-qa0-f53.google.com [209.85.216.53])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 8047C280531;
        Fri,  8 Aug 2014 20:37:37 +0200 (CEST)
Received: by mail-qa0-f53.google.com with SMTP id v10so5800131qac.26
        for <multiple recipients>; Fri, 08 Aug 2014 11:40:08 -0700 (PDT)
X-Received: by 10.229.82.74 with SMTP id a10mr39699821qcl.21.1407523208677;
 Fri, 08 Aug 2014 11:40:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.84.244 with HTTP; Fri, 8 Aug 2014 11:39:48 -0700 (PDT)
In-Reply-To: <1405162157-30357-1-git-send-email-jogo@openwrt.org>
References: <1405162157-30357-1-git-send-email-jogo@openwrt.org>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Fri, 8 Aug 2014 20:39:48 +0200
Message-ID: <CAOiHx=mS-CSE-rM7nWxoRwO9twYiO2F4ObMf9ZVLo1oskZVKLg@mail.gmail.com>
Subject: Re: [PATCH RFC v2] MIPS: add support for vmlinux.bin appended DTB
To:     MIPS Mailing List <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Sat, Jul 12, 2014 at 12:49 PM, Jonas Gorski <jogo@openwrt.org> wrote:
> (snip)
> diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
> index 3b46f7c..8009530 100644
> --- a/arch/mips/kernel/vmlinux.lds.S
> +++ b/arch/mips/kernel/vmlinux.lds.S
> @@ -127,6 +127,12 @@ SECTIONS
>         }
>
>         PERCPU_SECTION(1 << CONFIG_MIPS_L1_CACHE_SHIFT)
> +
> +#ifdef CONFIG_MIPS_APPENDED_DTB
> +       __appended_dtb = .;
> +       /* leave space for appended DTB */
> +       . = . + 0x100000;
> +#endif

Okay, this won't work for non SMP kernels - PERCPU is empty there, so
the actual binary end is then __mips_machine_end, not __per_cpu_end
(unless mips_machine_end happens to satisfty the per_cpu alignment
requirements).

So back to the drawing board.


Jonas
