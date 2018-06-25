Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jun 2018 11:07:34 +0200 (CEST)
Received: from mail-ua0-f193.google.com ([209.85.217.193]:40074 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991783AbeFYJH1Grm0D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jun 2018 11:07:27 +0200
Received: by mail-ua0-f193.google.com with SMTP id j17-v6so1698273uap.7
        for <linux-mips@linux-mips.org>; Mon, 25 Jun 2018 02:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TorOwruUNp57xWE0RsAcyQ/AI6wGTDQqMCU/mvNIRRI=;
        b=gwINoZ2sydI7F7kkoZTTV0BFdZC9CqNZb1Pi2dDDFjd2VXPld3cEb7lpmiOAgGD4Bb
         oMXBu+HUglSEKliT8HGO26MjPd7qzncs6McXMIlDMnbiyr6qrO5CQWq0BBcT8mR5jFEG
         bGBqkDd5RpSh9Q+PzN1458aADSEEGJHkyLBbiNawCHXlI1GNV5/EdL30WAhzZ0Eo6hRk
         D6R0BCWWdV3eCIS4AEVhnQ9pyOfJNT4grY/8Qeh6xq1luSiBrs5I+zkwYejSiTcAi4R0
         /CROhtZ78AxF0zt0IjOJqm1W4xI79z9w+2Go/ktG7K5njrsdyOjuUiPCxGdEumbMaIO/
         Thsw==
X-Gm-Message-State: APt69E0lzpz9GZp7lEF/KLPTrSSnXoyNVq7dBxD7uZ27/7Z+t6D5N7ab
        X4Q8qoU14nc6+rYuYY20Ijb+hZv08+HUelH+Hzg=
X-Google-Smtp-Source: ADUXVKKxQXIP8MoglaZsNyW80mC0eXS0orm9chMYNwAR4dRqKy87WrIvKqltUfY1HAmX4IBJZjWCKFwqGKy5xrWF7Kg=
X-Received: by 2002:ab0:265:: with SMTP id 92-v6mr8025779uas.26.1529917640801;
 Mon, 25 Jun 2018 02:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180625090329.10895-1-geert@linux-m68k.org>
In-Reply-To: <20180625090329.10895-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Jun 2018 11:07:09 +0200
Message-ID: <CAMuHMdW--a2btaTWu3ZP_KtTD6zKFCYsG8FV9KA0y-W6Vg0gQw@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.18-rc2
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64427
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

On Mon, Jun 25, 2018 at 11:04 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.18-rc2[1] to v4.18-rc1[3], the summaries are:
>   - build errors: +6/-4

  + /kisskb/src/arch/mips/kernel/signal.c: error: passing argument 1
of 'rseq_handle_notify_resume' from incompatible pointer type
[-Werror=incompatible-pointer-types]:  => 873:29
  + /kisskb/src/arch/mips/kernel/signal.c: error: passing argument 1
of 'rseq_handle_notify_resume' from incompatible pointer type
[-Werror]:  => 873:3
  + /kisskb/src/arch/mips/kernel/signal.c: error: passing argument 1
of 'rseq_signal_deliver' from incompatible pointer type
[-Werror=incompatible-pointer-types]:  => 804:22
  + /kisskb/src/arch/mips/kernel/signal.c: error: passing argument 1
of 'rseq_signal_deliver' from incompatible pointer type [-Werror]:  =>
804:2
  + /kisskb/src/arch/mips/kernel/signal.c: error: too few arguments to
function 'rseq_handle_notify_resume':  => 873:3
  + /kisskb/src/arch/mips/kernel/signal.c: error: too few arguments to
function 'rseq_signal_deliver':  => 804:2

Lots of MIPS, fix available.

> [1] http://kisskb.ellerman.id.au/kisskb/head/7daf201d7fe8334e2d2364d4e8ed3394ec9af819/ (231 out of 244 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/ce397d215ccd07b8ae3f71db689aedb85d56ab40/ (233 out of 244 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
