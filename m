Return-Path: <SRS0=hlE+=RL=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FA4C43381
	for <linux-mips@archiver.kernel.org>; Fri,  8 Mar 2019 21:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3BB20851
	for <linux-mips@archiver.kernel.org>; Fri,  8 Mar 2019 21:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P6TjMG7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfCHVKA (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:10:00 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33999 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfCHVKA (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 8 Mar 2019 16:10:00 -0500
Received: by mail-pg1-f194.google.com with SMTP id i130so15087654pgd.1
        for <linux-mips@vger.kernel.org>; Fri, 08 Mar 2019 13:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S1cde1jQsu/UmZpXHCI4YVyEziLBMknSj83sr+RMBZs=;
        b=P6TjMG7fGRK7XyKsHWb0VTW6Q9whc9pDX0eApYKLPbELPHCHHvNO1r7DQOut67QdQf
         FuTtzYitbpr7AHdi+ap23htEvIVldeQFt0CZig1xUByIAmLIDI2O4k4YHsBwJ64kaQWd
         tv9j1KHx2JH1J2tmZPJhMNVFB8etwLial5vzaeR/9qwAV2c1yBvLA3TTyt4/i+HmPcTL
         T/oBwnARgQbuOoODRHRkgsClw63M47siEORCvHIoDAARpKe6irP/WtLHcw7Dj8eT5JuA
         Ilbxwx/EPXlacKb9cRMv1rJi0/JemVW4Hm0J0lIdqHk5YR9babjNToAKh+r2oIKnNfY4
         f0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S1cde1jQsu/UmZpXHCI4YVyEziLBMknSj83sr+RMBZs=;
        b=bd31puNKnCNG3mak6PMxmbTZW72Yqt+ga/YFeDY5Kq7b6ZUipgXzfYx1cEx2tgL0xf
         vn/v1U/dHTNRAzyGyxd9BeP06quzC1tv0UErLJVXousVB/j7qwx1mNemevUfUY1DPIM3
         vnuznhNkjE7S/EyaUAC4ZvpjKWaZCLzVOS8mXRaNmFLUpG3nEvM5dr9GRdw7iWpuy3w5
         oo138oDypn3nktj81zipD9/aUF+STKqMaAzg2js6IFPrtEsi2dFNYe83fpmc9gfYl1zl
         IsHr/FWp2S9aWI+WKePRMZM1jcoNWyOQ2NABaxEYKo8dSGOMzMfBhhBQXu5NLH28fJQZ
         Yk9g==
X-Gm-Message-State: APjAAAW6S7nwEF04pE+K+QqbU82XOZiU4p3VSDVWjEB/ts6RpqxgZ4Oh
        F/96p9A11aIu44JAyKLCvgdzogbsBRGde8Y6mVUsAg==
X-Google-Smtp-Source: APXvYqxaUQ5jhATdW1RKgLqB4lqdILD9dACC3jIaYW5eDACGP9qzaugQ2z2LCqttDQxBnJJNnWoLEVD25z3YeGBTuYs=
X-Received: by 2002:a17:902:56a:: with SMTP id 97mr20702494plf.320.1552079398761;
 Fri, 08 Mar 2019 13:09:58 -0800 (PST)
MIME-Version: 1.0
References: <20190307091218.2343836-1-arnd@arndb.de> <20190307152805.GA25101@redhat.com>
 <CAK8P3a2fuD-UBJET_OBKekCxrTDpnAxb0Bpu2LCCXaVT3pXTMQ@mail.gmail.com>
 <20190307164647.GC25101@redhat.com> <CAK8P3a2FU55-7wQnLXDAmRCgiZ-W+2rY6p7CrTiKNe0wda-Hsg@mail.gmail.com>
 <CAKwvOd=nyhM72CxdO-YYSsXr7rh3LUALn_ezVNzyiBaOD7KZkA@mail.gmail.com> <31b6d5bdfda9cbadffa6d8cb3ad0991e237a364c.camel@perches.com>
In-Reply-To: <31b6d5bdfda9cbadffa6d8cb3ad0991e237a364c.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 Mar 2019 13:09:47 -0800
Message-ID: <CAKwvOd=+_FjWmo2McyLOAL3r6JOuu1wZEzQknY-GToDnCwzhsQ@mail.gmail.com>
Subject: Re: [PATCH] signal: fix building with clang
To:     Joe Perches <joe@perches.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Thu, Mar 7, 2019 at 4:27 PM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2019-03-07 at 16:22 -0800, Nick Desaulniers wrote:
> > On Thu, Mar 7, 2019 at 1:45 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > I'd have to try, but I think you are right. It was probably an
> > > overoptimization back in 1997 when the code got added to
> > > linux-2.1.68pre1, and compilers have become smarter in the
> > > meantime ;-)
> >
> > How do you track history pre-git (2.6.XX)?
>
> https://landley.net/kdocs/fullhist/

Ah neat! Thanks for the link.  Now to wire that up to fugitive:
http://vimcasts.org/episodes/fugitive-vim-exploring-the-history-of-a-git-repository/

The LLVM project recently switched to git from svn.  For quite some
time the move was delayed in order to preserve history (including for
parked release branches and all kinds of edge cases and things that
don't quite translate from svn to git).  Now I better appreciate the
history preservation.
-- 
Thanks,
~Nick Desaulniers
