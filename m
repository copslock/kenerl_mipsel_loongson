Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Nov 2017 05:07:56 +0100 (CET)
Received: from conssluserg-05.nifty.com ([210.131.2.90]:42814 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990491AbdKREHtWpQOX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 18 Nov 2017 05:07:49 +0100
Received: from mail-yw0-f177.google.com (mail-yw0-f177.google.com [209.85.161.177]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id vAI475Ax007935
        for <linux-mips@linux-mips.org>; Sat, 18 Nov 2017 13:07:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com vAI475Ax007935
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1510978026;
        bh=jFIqLRMBg+RvF21gaJFaXb7aL1H4ve9fYNkrt46s+dY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=YwLLnrWFLzJt6L4sp0XMtJYWrIoT9jSC7tpO0If9rWPQ+v2uFw09TLGYbkz38JXcF
         Xl6CrE62NTJbHaL7hfnHP6/HVb3YgZ612y1zgdcesBJEAPG3wRKS62SdN1yBSLlNFY
         x795fnf3DNNZltEHMRnQOoMwzZowRFJHd4s4Ugna9tQ0LUkhVZuD18MJ2T7aaNQLfg
         svOT/oEta+c8TTEyBap6MxrJG+wS9xYdfxcFGvC0g6CPdXrTLrkHoCiOKL6YlYpR5V
         /F5t5Cjex3j0WzOdkCdiue9gFgqRTg3waC5+/kPnuCwYuAxae783dzLA+yRvxsBU8R
         yty8P0PWjxPCw==
X-Nifty-SrcIP: [209.85.161.177]
Received: by mail-yw0-f177.google.com with SMTP id a4so2430582ywh.3
        for <linux-mips@linux-mips.org>; Fri, 17 Nov 2017 20:07:05 -0800 (PST)
X-Gm-Message-State: AJaThX4KmBh2gX1FTz95AHAd12qP3FLeYgDDX3LzYAvykkLIZoDGtrOn
        EJEjyo3NJowJMNJZb6p/jgOg+QRMD7SlFZTuDkU=
X-Google-Smtp-Source: AGs4zMaBjGzQqQNOHXyRKhkEgQ++3cXka5qZSyLL6YWi+qpzFWJT6/RJZ/UIZ9hn20UoFzfg1mLzs/QhlzTULkor8XI=
X-Received: by 10.129.160.141 with SMTP id x135mr4565447ywg.209.1510978024522;
 Fri, 17 Nov 2017 20:07:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.110.139 with HTTP; Fri, 17 Nov 2017 20:06:24 -0800 (PST)
In-Reply-To: <1510072307-16819-2-git-send-email-yamada.masahiro@socionext.com>
References: <1510072307-16819-1-git-send-email-yamada.masahiro@socionext.com> <1510072307-16819-2-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 18 Nov 2017 13:06:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNASt+4oNw3niSOcM=++Z8D0CF5jy8z1d2oz7Lp=CT2b6tg@mail.gmail.com>
Message-ID: <CAK7LNASt+4oNw3niSOcM=++Z8D0CF5jy8z1d2oz7Lp=CT2b6tg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: create built-in.o automatically if parent
 directory wants it
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <mmarek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yamada.masahiro@socionext.com
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

2017-11-08 1:31 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> "obj-y += foo/" syntax requires Kbuild to visit the "foo" subdirectory
> and link built-in.o from that directory.  This means foo/Makefile is
> responsible for creating built-in.o even if there is no object to
> link (in this case, built-in.o is an empty archive).
>
> We have had several fixups like commit 4b024242e8a4 ("kbuild: Fix
> linking error built-in.o no such file or directory"), then ended up
> with a complex condition as follows:
>
>   ifneq ($(strip $(obj-y) $(obj-m) $(obj-) $(subdir-m) $(lib-target)),)
>   builtin-target := $(obj)/built-in.o
>   endif
>
> We still have more cases not covered by the above, so we need to add
>   obj- := dummy.o
> in several places just for creating empty built-in.o.
>
> A key point is, the parent Makefile knows whether built-in.o is needed
> or not.  If a subdirectory needs to create built-in.o, its parent can
> tell the fact when Kbuild descends into it.
>
> If non-empty $(need-builtin) flag is passed from the parent, built-in.o
> should be created.  $(obj-y) should be still checked to support the
> single target "%/".  All of ugly tricks will go away.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>

Applied to linux-kbuild/kbuild.



-- 
Best Regards
Masahiro Yamada
