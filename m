Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Apr 2018 20:51:51 +0200 (CEST)
Received: from mail-ot0-x242.google.com ([IPv6:2607:f8b0:4003:c0f::242]:43287
        "EHLO mail-ot0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990427AbeDYSvnqE2Fi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Apr 2018 20:51:43 +0200
Received: by mail-ot0-x242.google.com with SMTP id y10-v6so13517504otg.10;
        Wed, 25 Apr 2018 11:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=WCeh/Wv2QQsPlrSygLIJ7wPJT8XQpXFtD/+pLpoin04=;
        b=Em7kNGiPnblv9ijF5Pj6UwSFlpb9q8vMFD25oVKAaeQhGEZwFbZIaI35lVSxe/Kor4
         Y+c61uu8q4hAz0cJ7f8g/amTbEO6ja5hGUz0Q9UQKZQtYttLbWic0aippsvMeStCWUUM
         XwPUJpnQ3e1ZqEZd57EcC21/OFuR+Mtx9zq1pJF6ce8ExypG+Wbh4JXcjVCZ2bz0z1z1
         n9Di+jdRXCBYldqrkwZtYxfXWuDh8zTpHYZX4jdbizinT0zZ8Zq50kFqg9cyPSInzgKG
         UiG44V/qJDgIA/s1OwY12VJwaolk/E4AnTrHx0/RU16NEP6vYw59HnS93zXGsBN63NHT
         YjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=WCeh/Wv2QQsPlrSygLIJ7wPJT8XQpXFtD/+pLpoin04=;
        b=llUSHny+IAcPhYGgNA8ebNSY0Rk110sUI7rIYXdg5ftvJoN+loDLnLqBf1kU6ElLno
         4+vfFQ440C35lhEJvoBRLBHmU0IVYBihoNghwN2Gkr84XpyVsHqSRgQki9fnP+xkM2go
         89k2WEgIeFaPb4rG/ym1EmFGn1ws143qHZpiTDyW3PLH/Ix3We6sk40OXEzm3pSbUgz2
         B66o4uyHMwHMvFd6nl5h9Zo6VNu7FNhNlDQxaWnoI5jDQsdPlVmeQPNNDPWi+36T6hLk
         Yn4x4s1UbsxHtHOzVn/DcY+mgO9YoQukOW4sbUSW3g+sMTRG6gCDq0hjWPGbOXkPbxnh
         rK7Q==
X-Gm-Message-State: ALQs6tB+zmryW1iWe9/C7zK4tvthWBSTLuKTGq+okujQPLSNGYrvNc0a
        UeQoE9pZ+YPwiRj9ZIEbBdfYlu+a9Kkn+XHee9s=
X-Google-Smtp-Source: AB8JxZrrWVQncUHYQHBugnoHRzplfzzLf6PLo03zJ7qW5wgrji0lFRKBwcEqv6drt/wIM0gZBPuR0+J8GYWqlsoSXyQ=
X-Received: by 2002:a9d:3c0a:: with SMTP id q10-v6mr13119417otc.39.1524682297249;
 Wed, 25 Apr 2018 11:51:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.138.3.5 with HTTP; Wed, 25 Apr 2018 11:51:16 -0700 (PDT)
In-Reply-To: <15246720861733@kroah.com>
References: <15246720861733@kroah.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 25 Apr 2018 20:51:16 +0200
X-Google-Sender-Auth: JbnDp9NFkDfpzpIKDWNZ0eQlAhQ
Message-ID: <CA+7wUszxmW8Lsq-aEovy5QYmq3GABOQf6O1cz=AqcH2mcBBPoA@mail.gmail.com>
Subject: Re: Patch "MIPS: fix mem=X@Y commandline processing" has been added
 to the 4.9-stable tree
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     amit.pundir@linaro.org, Linux-MIPS <linux-mips@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        stable-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63782
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

Hi Greg,

Why is this patch coming back ? This was discussed previously at:

https://www.spinics.net/lists/kernel/msg2617572.html

The correct fix is rather 67a3ba25aa955.

Thanks


On Wed, Apr 25, 2018 at 6:01 PM,  <gregkh@linuxfoundation.org> wrote:
>
> This is a note to let you know that I've just added the patch titled
>
>     MIPS: fix mem=X@Y commandline processing
>
> to the 4.9-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>      mips-fix-mem-x-y-commandline-processing.patch
> and it can be found in the queue-4.9 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>
> From 73fbc1eba7ffa3bf0ad12486232a8a1edb4e4411 Mon Sep 17 00:00:00 2001
> From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
> Date: Wed, 23 Nov 2016 14:43:49 +0100
> Subject: MIPS: fix mem=X@Y commandline processing
>
> From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
>
> commit 73fbc1eba7ffa3bf0ad12486232a8a1edb4e4411 upstream.
>
> When a memory offset is specified through the commandline, add the
> memory in range PHYS_OFFSET:Y as reserved memory area.
> Otherwise the bootmem allocator is initialised with low page equal to
> min_low_pfn = PHYS_OFFSET, and in free_all_bootmem will process pages
> starting from min_low_pfn instead of PFN(Y).
>
> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
> Cc: linux-mips@linux-mips.org
> Patchwork: https://patchwork.linux-mips.org/patch/14613/
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> Cc: Amit Pundir <amit.pundir@linaro.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> ---
>  arch/mips/kernel/setup.c |    4 ++++
>  1 file changed, 4 insertions(+)
>
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -661,6 +661,10 @@ static int __init early_parse_mem(char *
>                 start = memparse(p + 1, &p);
>
>         add_memory_region(start, size, BOOT_MEM_RAM);
> +
> +       if (start && start > PHYS_OFFSET)
> +               add_memory_region(PHYS_OFFSET, start - PHYS_OFFSET,
> +                               BOOT_MEM_RESERVED);
>         return 0;
>  }
>  early_param("mem", early_parse_mem);
>
>
> Patches currently in stable-queue which might be from marcin.nowakowski@imgtec.com are
>
> queue-4.9/irqchip-mips-gic-fix-local-interrupts.patch
> queue-4.9/mips-fix-mem-x-y-commandline-processing.patch
>
