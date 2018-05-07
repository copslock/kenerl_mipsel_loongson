Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 May 2018 18:04:35 +0200 (CEST)
Received: from mail-it0-x241.google.com ([IPv6:2607:f8b0:4001:c0b::241]:37200
        "EHLO mail-it0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994614AbeEGQE0vC2Mu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 May 2018 18:04:26 +0200
Received: by mail-it0-x241.google.com with SMTP id 70-v6so12434519ity.2
        for <linux-mips@linux-mips.org>; Mon, 07 May 2018 09:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=V8430Yf2cE0D7Zj6Fe/G9AoxLIg45KH53g7C0uu2RgQ=;
        b=DK/+EfP37oD03rfMG5/+5KNwWe3kz04/Ue2WSkJaTt+sfnRI/zu8c98SMJXsvYdi8C
         f65/U/WDwK2/Zf0O28RFz38vlsQB23e35lJPJ08seFDNQbjEosHj6la5O9WP3ER7qxBj
         amYsYhdgUQfRgQmkDjA4aIU9raSTOatmQQC3xhzRdxk7m4h/PkzN9yicjheDaNg26atk
         0eIoNBD0iTTS65oGv/V2Zddi4KYwd0gxMQx/zFe0j8XckcZxCuQK4UdzCqQi1nYnnxPh
         m/z8nJMeatekgTDF1zFdxMoj4c4RhCkdn07JH3ocK+UXPxWuRKwNkjXB+eVmM09m6uEb
         S57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=V8430Yf2cE0D7Zj6Fe/G9AoxLIg45KH53g7C0uu2RgQ=;
        b=ZinksXp8oK1MsjBNnskd7U9+YUqsydgVyq5tL7EKtTGlroEMJ0mihCdA2XmfWnSN+i
         u0+HaP0UPF006lV/mRgNHeLpHlomViq71egt+PviCDyFGQcAXFV+mI8NO2vm3QqC41hB
         8R7Fu9bELbXLJcS/W4/hPeExWOFHsn9O/m5bVycsT8GE2PqCvo4S3eLn6WNrIbL2sMRe
         y+yb7Wb/6EpvWqD7+ijaAHtJy9ScBX9O3XRq1TrbbecqOPFMHz3piI147PZ0Uc8znT+i
         pQIaD4PyPpi2o6otN/DcvRgqf8sVfECHXf2Ty43hO/x5TA1w2wG5dqA4BKA+QnCe2msF
         qghA==
X-Gm-Message-State: ALKqPwc/eI+KZtKDbU6yvULyjelZmlNCR3qxPEr5xBLLl9d3ItC5mqTj
        f59KqhkzjjkRDybnoGKO83kronrNMsKXx8ax3EY=
X-Google-Smtp-Source: AB8JxZqYi/UBrns3oLnHL98rCdO80uG/BwApkfHRtVERig15PeayzyYpa3wnvswv8p9B6sgIjIwQwubRgzHCFYRFU8w=
X-Received: by 2002:a24:6d86:: with SMTP id m128-v6mr1881970itc.75.1525709059620;
 Mon, 07 May 2018 09:04:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:7109:0:0:0:0:0 with HTTP; Mon, 7 May 2018 09:03:58 -0700 (PDT)
In-Reply-To: <20180507084240.GA26491@jamesdev>
References: <cover.ebc99f68d5063a817328b9184d747f539800cff0.1523959603.git-series.jhogan@kernel.org>
 <a20761a842efe590da08e835ecc5690a4cf50213.1523959603.git-series.jhogan@kernel.org>
 <CAEdQ38HfabRWgfLTStuZDOz0yjnfMNRc5beRdVcQhFfMi1SFKg@mail.gmail.com> <20180507084240.GA26491@jamesdev>
From:   Matt Turner <mattst88@gmail.com>
Date:   Mon, 7 May 2018 09:03:58 -0700
Message-ID: <CAEdQ38FDSqRbikxZZ4uVmyT0JkV1uGOdtiEjwJafbDb9m4vDtw@mail.gmail.com>
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
X-archive-position: 63889
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

On Mon, May 7, 2018 at 1:42 AM, James Hogan <jhogan@kernel.org> wrote:
> On Sun, May 06, 2018 at 12:33:21PM -0700, Matt Turner wrote:
>> On Tue, Apr 17, 2018 at 3:11 AM, James Hogan <jhogan@kernel.org> wrote:
>> > Use CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING and CONFIG_OPTIMIZE_INLINING
>> > instead of undefining the inline macros in the alpha specific
>> > asm/compiler.h. This is to allow asm/compiler.h to become a general
>> > header that can be used for overriding linux/compiler*.h.
>> >
>> > A build of alpha's defconfig on GCC 7.3 before and after this series
>> > (i.e. this commit and "compiler.h: Allow arch-specific overrides" which
>> > includes asm/compiler.h from linux/compiler_types.h) results in the
>> > following size differences, which appear harmless to me:
>> >
>> > $ ./scripts/bloat-o-meter vmlinux.1 vmlinux.2
>> > add/remove: 1/1 grow/shrink: 3/0 up/down: 264/-348 (-84)
>> > Function                                     old     new   delta
>> > cap_bprm_set_creds                          1496    1664    +168
>> > cap_issubset                                   -      68     +68
>> > flex_array_put                               328     344     +16
>> > cap_capset                                   488     500     +12
>> > nonroot_raised_pE.constprop                  348       -    -348
>> > Total: Before=5823709, After=5823625, chg -0.00%
>> >
>> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> > Signed-off-by: James Hogan <jhogan@kernel.org>
>> > Cc: Richard Henderson <rth@twiddle.net>
>> > Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
>> > Cc: Matt Turner <mattst88@gmail.com>
>> > Cc: linux-alpha@vger.kernel.org
>>
>> Looks fine to me.
>>
>> Acked-by: Matt Turner <mattst88@gmail.com>
>
> Thanks
>
>>
>> Should I take it through the alpha tree?
>
> I'll take all 3 through the MIPS tree if thats okay with you, as its a
> prerequisite to allowing MIPS to override stuff in linux/compiler-gcc.h
> using asm/compiler.h, which is needed to fix build breakage in 4.17.

Thanks. That works for me.
