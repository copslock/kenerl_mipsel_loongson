Return-Path: <SRS0=CBLp=R6=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D67C43381
	for <linux-mips@archiver.kernel.org>; Wed, 27 Mar 2019 16:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A4620651
	for <linux-mips@archiver.kernel.org>; Wed, 27 Mar 2019 16:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jPVIDhFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfC0QZV (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:25:21 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:39914 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbfC0QZU (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 27 Mar 2019 12:25:20 -0400
Received: by mail-ua1-f66.google.com with SMTP id d5so454432uan.6
        for <linux-mips@vger.kernel.org>; Wed, 27 Mar 2019 09:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bpwWCz5S/eK94PUEocrnBlFeInwqE4hvKSz6SqcHPTU=;
        b=jPVIDhFfP2g6/5fmXwhEwnSwot4rKvqCaI7dbjWFTe7jbIQqNNj5nrPv+HU65dqRi1
         nn//Su5xweQCbmWsFuroQZfZQ/R+tl2F9DT/yiEf+kOx5x1DErgY8HPltR0p33jOUert
         rimjjVQmY6brzxOcVq3wXjTT7PMDlesEpHl8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bpwWCz5S/eK94PUEocrnBlFeInwqE4hvKSz6SqcHPTU=;
        b=KgUl2tVIEc+3QvcuPYO6O3xlxBQaXS8nWhAOEBS0TellyFpoSwyRaC7qldzAJDls0Z
         xOqorg5btqT+JLy0iGoUncX718/HDV1JAgfdercu6d7G/qPJFGSevo7061tDCBs8WHZo
         l5DN0n8kkTU11BJ4LA2V9uip7UU/HJwN2XC6QBKlc7/L3+/zQFInkMXQw6KrSKVg4Ps9
         g2yOTIa8bwTss6iRyuJTauecBU4v6vIhARImLt514lbjx0d6Pn6sJYCU/nrneYUGWhTc
         XmmqCuvaaliTt58OUXiITj746LKQ31fGcCwal3axvIRno28uhgZoy3mjmUOlpL8cVtzK
         6saw==
X-Gm-Message-State: APjAAAWxzCNmbcHx3SzHAnwZ3d2n9zv98LDyBy1nkuq4vtB/pBAQjuc+
        Zsm9JSmY01JHDqlXqqtvsT7Q6QOXDZk=
X-Google-Smtp-Source: APXvYqwf0MfoF2BmKwFlWdCiTDwglMypQsRYB59bQk/p6dSCNoLwDMAwtxdnpM745AaYV7fuxYrR2Q==
X-Received: by 2002:ab0:2a5a:: with SMTP id p26mr22397890uar.105.1553703919647;
        Wed, 27 Mar 2019 09:25:19 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id j11sm5720072vkj.13.2019.03.27.09.25.18
        for <linux-mips@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 09:25:18 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id w13so10288485vsc.4
        for <linux-mips@vger.kernel.org>; Wed, 27 Mar 2019 09:25:18 -0700 (PDT)
X-Received: by 2002:a67:c812:: with SMTP id u18mr5947372vsk.87.1553703917672;
 Wed, 27 Mar 2019 09:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190327150551.12851-1-qiaochong@loongson.cn>
In-Reply-To: <20190327150551.12851-1-qiaochong@loongson.cn>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 27 Mar 2019 09:25:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WAvzz+wXZzoLZvxBhO4P_RjV2op=uiX9dHD2dPdSCruw@mail.gmail.com>
Message-ID: <CAD=FV=WAvzz+wXZzoLZvxBhO4P_RjV2op=uiX9dHD2dPdSCruw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: KGDB: fix kgdb support for SMP platforms.
To:     qiaochong <qiaochong@loongson.cn>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-mips@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi,

On Wed, Mar 27, 2019 at 8:06 AM qiaochong <qiaochong@loongson.cn> wrote:
>
> KGDB_call_nmi_hook is called by other cpu through smp call.
> MIPS smp call is processed in ipi irq handler and regs is saved in
>  handle_int.
> So kgdb_call_nmi_hook get regs by get_irq_regs and regs will be passed
>  to kgdb_cpu_enter.
>
> Signed-off-by: qiaochong <qiaochong@loongson.cn>

Note that you might want to adjust your git settings.  Usually in the
kernel they require that a Signed-off-by have your real name, not just
your username.  You probably need to spin your patch to fix this.  You
should make sure that the authorship of the patch also has your real
name.


> ---
>  arch/mips/kernel/kgdb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/kernel/kgdb.c b/arch/mips/kernel/kgdb.c
> index 6e574c02e4c3b..ea781b29f7f17 100644
> --- a/arch/mips/kernel/kgdb.c
> +++ b/arch/mips/kernel/kgdb.c
> @@ -33,6 +33,7 @@
>  #include <asm/processor.h>
>  #include <asm/sigcontext.h>
>  #include <linux/uaccess.h>
> +#include <asm/irq_regs.h>
>
>  static struct hard_trap_info {
>         unsigned char tt;       /* Trap type code for MIPS R3xxx and R4xxx */
> @@ -214,7 +215,7 @@ void kgdb_call_nmi_hook(void *ignored)
>         old_fs = get_fs();
>         set_fs(KERNEL_DS);
>
> -       kgdb_nmicallback(raw_smp_processor_id(), NULL);
> +       kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
>
>         set_fs(old_fs);
>  }

As per my reply on V1, feel free to add:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
