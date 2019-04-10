Return-Path: <SRS0=erdp=SM=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279E4C10F11
	for <linux-mips@archiver.kernel.org>; Wed, 10 Apr 2019 18:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4292082A
	for <linux-mips@archiver.kernel.org>; Wed, 10 Apr 2019 18:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bSr7MxHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbfDJSeb (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:34:31 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34653 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbfDJSeb (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 10 Apr 2019 14:34:31 -0400
Received: by mail-vs1-f65.google.com with SMTP id t78so1979964vsc.1
        for <linux-mips@vger.kernel.org>; Wed, 10 Apr 2019 11:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EWEqtNllEvpYJI4SR8SxraijSXCc4AK8CwC4R1aamEI=;
        b=bSr7MxHCBXn6h0g3WRGDyc2DhbuqqkdN6kW4p22Hos+GjTZLWrFrQlrp7jWHR6ShdZ
         2uemyxpXrWgr4x5PSuKplueV9Xenc396YezASzbUdmimeusHUAsVR9xEc9/Ce4YVvdd/
         +FKf9Ta+3vfdBUTnObARr7b4AQUoa15vGEWKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EWEqtNllEvpYJI4SR8SxraijSXCc4AK8CwC4R1aamEI=;
        b=Apc6rmRZpP8vKymYcG/nZASSPzYkVNQWBsBaRbG7AN3rHWh61KOQ8BMseBLj8KZoR+
         PDqwpl0s2LPbkwVY5X3Rok9pdejDuW6H5zpOrqh4rFz3fK/ii/qPaMHEwpIZPV9m4XgV
         6A+z1l2ANNzXyE1ufsZmqMYyFGiCTCZ10hFTxtlm6sIdkvuc3O98s9NQm1nJ9vU8nmOR
         ufvH2rpcc4vUzIgPQB/JIYHHjahSAV8MRGQuOD1TJ+Ps3dGz589TvLxDE5kpatWVE5sw
         Gfu6ErZNCUD/4mq3ET5eClUINdUx/hJvyWpSOK4kgIfCcCORohNq1KnW6ycoeFFNjdRL
         m6dw==
X-Gm-Message-State: APjAAAV3tawyvI6hbw/A9f7LWEv0BWQVQCgWR1/PJeD3MGtTr3JDXAW6
        /HPPIK6Gy6z3X9JU92+ZpzmZxYdUqYE=
X-Google-Smtp-Source: APXvYqzLQi8Crhwljj7Ap58FlHrDns+eEKVpPv+efHtENzJ8ipRiernunO8JZ3p5AOhdc8Y8QAEB6A==
X-Received: by 2002:a67:e418:: with SMTP id d24mr25101350vsf.8.1554921270077;
        Wed, 10 Apr 2019 11:34:30 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id u6sm2177140vsu.12.2019.04.10.11.34.29
        for <linux-mips@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 11:34:29 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id g127so1958534vsd.6
        for <linux-mips@vger.kernel.org>; Wed, 10 Apr 2019 11:34:29 -0700 (PDT)
X-Received: by 2002:a67:7816:: with SMTP id t22mr24096520vsc.115.1554920858548;
 Wed, 10 Apr 2019 11:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190404055128.24330-1-alex@ghiti.fr> <20190404055128.24330-3-alex@ghiti.fr>
 <20190410065908.GC2942@infradead.org> <8d482fd0-b926-6d11-0554-a0f9001d19aa@ghiti.fr>
In-Reply-To: <8d482fd0-b926-6d11-0554-a0f9001d19aa@ghiti.fr>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 11:27:27 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKt8f7=DKrvcPg-NUJGbc-vanMNojfDsEiBt3vP05G4oQ@mail.gmail.com>
Message-ID: <CAGXu5jKt8f7=DKrvcPg-NUJGbc-vanMNojfDsEiBt3vP05G4oQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] arm64, mm: Move generic mmap layout functions to mm
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Paul Burton <paul.burton@mips.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Wed, Apr 10, 2019 at 12:33 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> On 04/10/2019 08:59 AM, Christoph Hellwig wrote:
> > On Thu, Apr 04, 2019 at 01:51:25AM -0400, Alexandre Ghiti wrote:
> >> - fix the case where stack randomization should not be taken into
> >>    account.
> > Hmm.  This sounds a bit vague.  It might be better if something
> > considered a fix is split out to a separate patch with a good
> > description.
>
> Ok, I will move this fix in another patch.

Yeah, I think it'd be best to break this into a few (likely small) patches:
- update the compat case in the arm64 code
- fix the "not randomized" case
- move the code to mm/ (line-for-line identical for easy review)

That'll make it much easier to review (at least for me).

Thanks!

-- 
Kees Cook
