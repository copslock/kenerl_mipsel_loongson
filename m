Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Sep 2013 12:41:09 +0200 (CEST)
Received: from mail-ie0-f176.google.com ([209.85.223.176]:37383 "EHLO
        mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818991Ab3IZKlFxzht- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Sep 2013 12:41:05 +0200
Received: by mail-ie0-f176.google.com with SMTP id as1so1091979iec.7
        for <multiple recipients>; Thu, 26 Sep 2013 03:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4bbWXS6LUw2y645I9VV6il9w2Tk3cB5gRERJKJzzO6o=;
        b=QSksAfVlHoXq0lSPTR1sJblVrbawQUU+ViZL6aqbLywS+4tfonfW/C4qGTwPS1cetY
         hYLovk8brTR5c7qnpbMsbJuERoX0gY8smdLBzHLLVZ2/Rqd6+o8IZFwS5d5V/hTeraFL
         wHPYUw7lLCl9SYw9RM2sKFbR3anBEsOk4XajdxRhX807sbdZzD1G9oUJHHGP+tZO8A2m
         94u5h7j2whQV7pOFmT8VRkZpA1MtPmcxAs820gH4T89a4W+/tbgSLVJm2spx3ExV8l91
         /lp50vdETosO1YnFeyRWk7Gv24nd7TeJ49NF7N+0/jYfw8RAsPizdB6UHHIBBqZ6rsy/
         kPuQ==
X-Received: by 10.43.104.73 with SMTP id dl9mr177100icc.39.1380192059669; Thu,
 26 Sep 2013 03:40:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.73.36 with HTTP; Thu, 26 Sep 2013 03:40:19 -0700 (PDT)
In-Reply-To: <1377073172-3662-3-git-send-email-richard@nod.at>
References: <1377073172-3662-1-git-send-email-richard@nod.at> <1377073172-3662-3-git-send-email-richard@nod.at>
From:   Ramkumar Ramachandra <artagnon@gmail.com>
Date:   Thu, 26 Sep 2013 16:10:19 +0530
Message-ID: <CALkWK0kCrQ9hPABD_XQ9QFG-vByP+xZWZs+RkVK77+cX7Odz7g@mail.gmail.com>
Subject: Re: [PATCH 2/8] um: Do not use SUBARCH
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.cz>,
        geert@linux-m68k.org, ralf@linux-mips.org, lethal@linux-sh.org,
        Jeff Dike <jdike@addtoit.com>, gxt@mprc.pku.edu.cn,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kbuild@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net
Content-Type: text/plain; charset=UTF-8
Return-Path: <artagnon@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: artagnon@gmail.com
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

Richard Weinberger wrote:
> This patch is based on: https://lkml.org/lkml/2013/7/4/396

This is the original patch I sent across in July.

> diff --git a/arch/um/Makefile b/arch/um/Makefile
> index 133f7de..5bc7892 100644
> --- a/arch/um/Makefile
> +++ b/arch/um/Makefile
> @@ -8,6 +8,8 @@
>
>  ARCH_DIR := arch/um
>  OS := $(shell uname -s)
> +OS_ARCH := $(shell uname -m)
> +
>  # We require bash because the vmlinux link and loader script cpp use bash
>  # features.
>  SHELL := /bin/bash
> @@ -20,15 +22,14 @@ core-y                      += $(ARCH_DIR)/kernel/          \
>
>  MODE_INCLUDE   += -I$(srctree)/$(ARCH_DIR)/include/shared/skas
>
> -HEADER_ARCH    := $(SUBARCH)
> -
> -# Additional ARCH settings for x86
> -ifeq ($(SUBARCH),i386)
> -        HEADER_ARCH := x86
> -endif
> -ifeq ($(SUBARCH),x86_64)
> -        HEADER_ARCH := x86
> -       KBUILD_CFLAGS += -mcmodel=large
> +# Currently we support only i386 and x86_64, if you port UML to another arch
> +# add another if branch...
> +ifeq ($(OS_ARCH),x86_64)
> +       HEADER_ARCH := x86
> +       KBUILD_DEFCONFIG := x86_64_defconfig
> +else
> +       HEADER_ARCH := x86
> +       KBUILD_DEFCONFIG := i386_defconfig
>  endif

I honestly don't get why this approach is superior to the original
one. In the original, I could set SUBARCH to whatever target
architecture and attempt to build user-mode Linux. Fact that it is
only implemented for i386 and x86_64 aside, keeping a SUBARCH means
that it's possible to build a 32-bit kernel on a 64-bit machine and
vice-versa. If you want stuff to work automagically (ie. in the 90%
case), you have to shell out to uname -m to figure out the host's real
architecture. Which both versions do sufficiently well.

Forget all that. What matters is that upstream is still broken, and
users are suffering. Despite a reasonable fix being submitted in July.
