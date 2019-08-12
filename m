Return-Path: <SRS0=4POb=WI=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E78C433FF
	for <linux-mips@archiver.kernel.org>; Mon, 12 Aug 2019 19:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97BB120663
	for <linux-mips@archiver.kernel.org>; Mon, 12 Aug 2019 19:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQfWb4yF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfHLTpJ (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 12 Aug 2019 15:45:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52239 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfHLTpJ (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 12 Aug 2019 15:45:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so665560wms.2;
        Mon, 12 Aug 2019 12:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zbqcR8Gm7CUEaTh+RQEFIgeFFaQXE5F4/3ORKyv2UHE=;
        b=lQfWb4yFhgQ4mRFnN01RTsLonKuYclvrzI3yhZrJfxK+IO6uNZI3yee4F1raLgB0c9
         1UUTDmErlG1v+oNqGJp4ZYAd3vRLQ1FnAWycuLywbO7M3NZy0xzKmfQPwd45Io5HUXF1
         uF3Ln9pUWp5/sKEmf65C3VgUEX0STyuMhsEuzItdAPk/Tstx0htxMKv7eumaWPddXq25
         LPFx39t+pnKHhBSDeOJfHM16X4YLpgUHAKbXrs12/HCSMzSxvYa4kZSSpIT9e9jtf7BJ
         eQ2MggDlyGHceQ7mh9f4wV150ON3UchpJG8RvSwq/5LRGayDcetKqbI3OSjaV7yBUWCy
         cFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zbqcR8Gm7CUEaTh+RQEFIgeFFaQXE5F4/3ORKyv2UHE=;
        b=Jsws1uQT5T5lfNVbtZwQutLkjdXdm4Wn1hjqRDTs3SlA99rAQEtzknPQlVfI0gRcsh
         dFZuHLeR9ncFJSBbqdLvVpr4wzePdtH3mcgtPaZbuF2E/IMARa+0cZbclWxA4y2FQYfp
         NPiCvlVkZSeiGf99W9cFFryU2I3MXZduPGlUuaTUFUoNJ7V7GNhucxxoghvRWPJL5dLu
         Bqcm3LpUUzudH7t/1OcxoXzKUgSy2gtMqNibAzNYsAdLb5+SdttFChCmbCNEWco8I3G4
         lbGn/fBv/A3YBcUsPvHsEI1F2tYV4BhBQ8ZNHSfAfcKoerQgKTq2Y/OniuRrGpSz7ESL
         ecoA==
X-Gm-Message-State: APjAAAVpV5kiAR6KwGz9ad8ICJHGAQXxUsOzLmVPij46dkuwC8R+CqN2
        j9/q4FLqbrSViSmxwoPBJcc=
X-Google-Smtp-Source: APXvYqyqLvF1Fc7Eg5qhiPGnQdHLeN968UiUjTvxVBktu+SVk34L6MLUBhsdwqaNmHwT1Sb5ojMRGg==
X-Received: by 2002:a7b:cb8e:: with SMTP id m14mr942713wmi.10.1565639106989;
        Mon, 12 Aug 2019 12:45:06 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id f17sm443561wmf.27.2019.08.12.12.45.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 12:45:06 -0700 (PDT)
Date:   Mon, 12 Aug 2019 12:45:04 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jussi Kivilinna <jussi.kivilinna@iki.fi>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Vladimir Serbinenko <phcoder@gmail.com>,
        gcrypt-devel <gcrypt-devel@gnupg.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 3/5] lib/mpi: Fix for building for MIPS32 with Clang
Message-ID: <20190812194504.GA121197@archlinux-threadripper>
References: <20190812033120.43013-1-natechancellor@gmail.com>
 <20190812033120.43013-4-natechancellor@gmail.com>
 <ec4666a6-c7db-247b-de81-bb784bb9d649@iki.fi>
 <20190812171448.GA10039@archlinux-threadripper>
 <1ba05172-500b-6b42-00ad-27fb33eff070@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ba05172-500b-6b42-00ad-27fb33eff070@iki.fi>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Mon, Aug 12, 2019 at 10:40:49PM +0300, Jussi Kivilinna wrote:
> That's quite complicated approach. Fast and easier process would be if you
> just own the patch yourself. Libgcrypt (and target file in libgcrypt) 
> is LGPL v2.1+, so the license is compatible with kernel and you are good 
> to go with just your own (kernel DCO) signed-off-by.
> 
> -Jussi

I have gone this route as another developer pointed out that we can
eliminate all of the inline asm umul_ppmm definitions because the kernel
requires GCC 4.6 and newer and that is completely different from the
libgcrypt patches.

https://lore.kernel.org/lkml/20190812193256.55103-1-natechancellor@gmail.com/

Thanks for weighing in and cheers!
Nathan
