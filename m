Return-Path: <SRS0=rpqp=SU=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553D2C10F0E
	for <linux-mips@archiver.kernel.org>; Thu, 18 Apr 2019 14:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C10206B6
	for <linux-mips@archiver.kernel.org>; Thu, 18 Apr 2019 14:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FBq8bKtw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389132AbfDRO0F (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:26:05 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41673 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733192AbfDRO0F (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 18 Apr 2019 10:26:05 -0400
Received: by mail-vs1-f65.google.com with SMTP id g187so1250122vsc.8
        for <linux-mips@vger.kernel.org>; Thu, 18 Apr 2019 07:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8eV2vUS51UMgePfSSxCuXJhq0Gtq0aUu2F6TTcKETz0=;
        b=FBq8bKtw8jKgNvkAesGOL5wEhVUfIvOVZLawNU9Os5filzXur33S5KXLGi3G59zEmJ
         MNxbw1dkanZJyl6+Bh/X7hbbi4DCuJUT+N82rjvvIQb1baWE98HINAsh1KYITkSEbQsv
         WkyhKK/r8PDat9cP9eHISsDMRa0TxCyHkKPk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8eV2vUS51UMgePfSSxCuXJhq0Gtq0aUu2F6TTcKETz0=;
        b=iPcABJL0Zy5XL4A0lnFQs+5mOLvjikE1zE+3RlNe6oV0r/nbByGD7q9VEC2RD24Lew
         Sotp7DknWKseG/clW0pu/KXauPQm+PYwfboe13lWakO2xRuhXE/UqMWdp52nLajww3Wo
         RuQvbuhLmzASXQktjJ+FVrOLvxL6J52zAux96li4jMoF2kYDfsnzm0cB8owtXIMsOXn3
         GgfUU8Bk+l9vKVcBYF6lJaPYkr031k2QfMRo+IE/qRD9SB+Jzz9WOEC5wqhd+Lq71ZIY
         X8emNd3K6FfYNtIl0uek7sXCf9m42hhi80BDlE9e6/cNFrTCOUehrKkG9YLuiJlFSQaJ
         iFbw==
X-Gm-Message-State: APjAAAW7gnmRh0XzDB7MxcunlnQqeTu2Ked+5YTyrdWnFSU4foRJhWNy
        8desRBU8yMM2dSXXFT6U5H29Qa7J0kg=
X-Google-Smtp-Source: APXvYqzzbUcN4eUKBiHjHjpaS11RN/Ke/s+R2V2aAsMmxHpzF7orNBNDr0rGUI+AGc9qwvGvWYwgQQ==
X-Received: by 2002:a67:f849:: with SMTP id b9mr30082920vsp.188.1555597564508;
        Thu, 18 Apr 2019 07:26:04 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id u6sm1285387vke.54.2019.04.18.07.26.04
        for <linux-mips@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 07:26:04 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id x2so486649vkx.13
        for <linux-mips@vger.kernel.org>; Thu, 18 Apr 2019 07:26:04 -0700 (PDT)
X-Received: by 2002:a1f:2e07:: with SMTP id u7mr50481033vku.44.1555597170338;
 Thu, 18 Apr 2019 07:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190417052247.17809-1-alex@ghiti.fr> <20190417052247.17809-5-alex@ghiti.fr>
 <CAGXu5j+NV7nfQ044kvsqqSrWpuXH5J6aZEbvg7YpxyBFjdAHyw@mail.gmail.com> <fd2b02b3-5872-ccf6-9f52-53f692fba02d@ghiti.fr>
In-Reply-To: <fd2b02b3-5872-ccf6-9f52-53f692fba02d@ghiti.fr>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 18 Apr 2019 09:19:18 -0500
X-Gmail-Original-Message-ID: <CAGXu5j+NkQ+nwRShuKeHMwuy6++3x0QMS9djE=wUzUUtAkVf3g@mail.gmail.com>
Message-ID: <CAGXu5j+NkQ+nwRShuKeHMwuy6++3x0QMS9djE=wUzUUtAkVf3g@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] arm64, mm: Move generic mmap layout functions to mm
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Thu, Apr 18, 2019 at 12:55 AM Alex Ghiti <alex@ghiti.fr> wrote:
> Regarding the help text, I agree that it does not seem to be frequent to
> place
> comment above config like that, I'll let Christoph and you decide what's
> best. And I'll
> add the possibility for the arch to define its own STACK_RND_MASK.

Yeah, I think it's very helpful to spell out the requirements for new
architectures with these kinds of features in the help text (see
SECCOMP_FILTER for example).

> > I think CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT should select
> > CONFIG_ARCH_HAS_ELF_RANDOMIZE. It would mean moving
>
>
> I don't think we should link those 2 features together: an architecture
> may want
> topdown mmap and don't care about randomization right ?

Given that the mmap randomization and stack randomization are already
coming along for the ride, it seems weird to make brk randomization an
optional feature (especially since all the of the architectures you're
converting include it). I'd also like these kinds of security features
to be available by default. So, I think one patch to adjust the MIPS
brk randomization entropy and then you can just include it in this
move.

> Actually, I had to add those ifdefs for mmap_rnd_compat_bits, not
> is_compat_task.

Oh! In that case, use CONFIG_HAVE_ARCH_MMAP_RND_BITS. :) Actually,
what would be maybe cleaner would be to add mmap_rnd_bits_min/max
consts set to 0 for the non-CONFIG_HAVE_ARCH_MMAP_RND_BITS case at the
top of mm/mmap.c.

I really like this clean-up! I think we can move x86 to it too without
too much pain. :)

-- 
Kees Cook
