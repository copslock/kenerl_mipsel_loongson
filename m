Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 May 2018 21:33:55 +0200 (CEST)
Received: from mail-io0-x244.google.com ([IPv6:2607:f8b0:4001:c06::244]:40974
        "EHLO mail-io0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993001AbeEFTdrvur9v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 May 2018 21:33:47 +0200
Received: by mail-io0-x244.google.com with SMTP id e12-v6so31234654iob.8
        for <linux-mips@linux-mips.org>; Sun, 06 May 2018 12:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=omRzlOpKABUbZoIFWBOWZAHJwXr5O5qBQ/hIKYF+bK8=;
        b=Tq3UYLvkvN+oSqgigDcofD+h/uv+RCAuQrEAJMS6vQ+5xCev4vwDQFpU5X27NBW3NR
         EHrK1SicZQtzTxQCnfQLQ8BJPG83mUAfIml29qGSVYtedC9MA2G7Lg7upcvKDaO8uINs
         bvlg3PEc+iFxMvlP8NA54W41dXC5dTr0vjPXg5Fawest58K9oAKKBiQLIhZA2EFKoOY+
         d7mX79Dk+PmkYw5Ugza6oTDZrgvtDFHZQs2enW8LNZ+NKcO7kmhv7EsQsrLOvO7l7MoN
         0KBhApVLHaEIi4HCDT/NBpSPT5WDQvQDuaj5lHZcBDTNKR8Z2eWtflR+zucwQJreESFv
         cUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=omRzlOpKABUbZoIFWBOWZAHJwXr5O5qBQ/hIKYF+bK8=;
        b=TLWHgtoomxoJhcE0Fx22ziRG0v/74oDFxKbNBHThW+LydVRol2IBjbwRfbIPCYxspk
         TYG/3I3DbOXODvbwwHa0UisgIV+M5IsnKcGnxwQjrI/b5HRREz1i692e4gt2S+Xz0gtL
         6JY4iEK+YKyrNYkMwpvQNfAPBycCClOfaOxZpGAY5Db7c1GALwXrKUrjuK38W+DCFM8R
         xFnMfR74OjkZ6rt7QdukvLs8s6D2nzTV4HyUZBT86+eTSa9r+iNmzMq1UvWQphYH1SF1
         oGepCRrwCAdRYNEAhITCDGjCFUMOuKs1rWX0rnnLAGc7ldA2BW4TTOAee5BFzIY+22it
         w4xw==
X-Gm-Message-State: ALQs6tBQiKmTla/8yY5Dzr4iTE+aS/qokyltd3OtF+1K4la4ZqwDwh7P
        FW3qXyAGzkkC9yPOeOItwYclMVO5zDgyOd6esoc=
X-Google-Smtp-Source: AB8JxZp0jfM3XerOGam55w40DnFCOBBQMPF51rK7N9T4PvjQ8dttenMVmQKjxvHgfdFpveU6RVXxrLSkJF+fKEF/FpI=
X-Received: by 2002:a6b:1604:: with SMTP id 4-v6mr34161380iow.147.1525635221439;
 Sun, 06 May 2018 12:33:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:7109:0:0:0:0:0 with HTTP; Sun, 6 May 2018 12:33:21 -0700 (PDT)
In-Reply-To: <a20761a842efe590da08e835ecc5690a4cf50213.1523959603.git-series.jhogan@kernel.org>
References: <cover.ebc99f68d5063a817328b9184d747f539800cff0.1523959603.git-series.jhogan@kernel.org>
 <a20761a842efe590da08e835ecc5690a4cf50213.1523959603.git-series.jhogan@kernel.org>
From:   Matt Turner <mattst88@gmail.com>
Date:   Sun, 6 May 2018 12:33:21 -0700
Message-ID: <CAEdQ38HfabRWgfLTStuZDOz0yjnfMNRc5beRdVcQhFfMi1SFKg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] alpha: Use OPTIMIZE_INLINING instead of asm/compiler.h
To:     James Hogan <jhogan@kernel.org>
Cc:     linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-alpha <linux-alpha@vger.kernel.org>,
        linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mattst88@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
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

On Tue, Apr 17, 2018 at 3:11 AM, James Hogan <jhogan@kernel.org> wrote:
> Use CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING and CONFIG_OPTIMIZE_INLINING
> instead of undefining the inline macros in the alpha specific
> asm/compiler.h. This is to allow asm/compiler.h to become a general
> header that can be used for overriding linux/compiler*.h.
>
> A build of alpha's defconfig on GCC 7.3 before and after this series
> (i.e. this commit and "compiler.h: Allow arch-specific overrides" which
> includes asm/compiler.h from linux/compiler_types.h) results in the
> following size differences, which appear harmless to me:
>
> $ ./scripts/bloat-o-meter vmlinux.1 vmlinux.2
> add/remove: 1/1 grow/shrink: 3/0 up/down: 264/-348 (-84)
> Function                                     old     new   delta
> cap_bprm_set_creds                          1496    1664    +168
> cap_issubset                                   -      68     +68
> flex_array_put                               328     344     +16
> cap_capset                                   488     500     +12
> nonroot_raised_pE.constprop                  348       -    -348
> Total: Before=5823709, After=5823625, chg -0.00%
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-alpha@vger.kernel.org

Looks fine to me.

Acked-by: Matt Turner <mattst88@gmail.com>

Should I take it through the alpha tree?
