Return-Path: <SRS0=/lG2=RK=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EA6C43381
	for <linux-mips@archiver.kernel.org>; Thu,  7 Mar 2019 18:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A4D20840
	for <linux-mips@archiver.kernel.org>; Thu,  7 Mar 2019 18:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vafn/w0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfCGSmJ (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:42:09 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40304 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfCGSmJ (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 7 Mar 2019 13:42:09 -0500
Received: by mail-pf1-f196.google.com with SMTP id h1so12108855pfo.7
        for <linux-mips@vger.kernel.org>; Thu, 07 Mar 2019 10:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=syMuOUX+NyBjsexHT3nIQGZMwkRMNmkMzF/yisR8Uvk=;
        b=Vafn/w0pLnlUrgV6tAQB6whf6NX1Xmde7Rnpz2+pxaJI1gv+ylQB+Wv60n3+S8rOZE
         35dNLdybRHWAxCJvq8jQuq3d8f26wlG20cBTT+SCp4VOxeOzSwh8adyqhs904YeEBevG
         9WzrSw421vVdwwYFaPB7eyNppr4up7qZS/bS7bxh7pYl9mgUcwUE8u++sEXZOL1z+tjJ
         tv/w/oq8hTsVT51epqLa2qZjoumoUAAbiBAZ3d13fEKwMC3NlwQthSG7Q8myalQYESLC
         M9+7ez9cwGszsc846TOAfujqX5tKg89eoN3cp3TJ5umrS3QmQqHZm5sMQ3vQOywFomso
         Oxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=syMuOUX+NyBjsexHT3nIQGZMwkRMNmkMzF/yisR8Uvk=;
        b=C0cIsR5uCj33LAEU+emYqUH+QR2QVykWH+h9V5aJFFUNTAMhLQnS/gDO4pGmhdIBwM
         +2vcNdZ77M+812egmUBCG+mHErAnXiRGv1h7eENIMFxVBmeyjFGJV12dBciGK+9wayrS
         CdW8Ae59GMTCUCjR2W7Zn0JUkiJMUMB4NginTFL1w+tLcj1N2ayv6Irzk83tnxe80+p2
         Ka2EXGrN6Xe+X10KBT0FhAYw0T/DV3u4Aje/iXFRSdIAsaa7T/X0TFsebfIvFwqpyQBM
         gwu6FK1Bfz1dAmG8QCZnkduiaeo7id2vVXlqyNtOsPfOen+RQY82BKRzqkVQ91mjVR72
         WTrg==
X-Gm-Message-State: APjAAAW8NaJ5E6/Sb6FHwM3iI29qMG5YP1YfIMu1SA8CT/+7Fs8Cvm91
        URS43YhMguhbhDcP2Qk1BI+d1D54Z1IBmauMH6BIyw==
X-Google-Smtp-Source: APXvYqxqzX2bt612izBVJoo3/WkPC8gH19MlydCt4yNsD6Jsnbsvm9vxqXika+H4eP8TTJY4O55zabvLHzxF+aIsev8=
X-Received: by 2002:a17:902:56a:: with SMTP id 97mr14185528plf.320.1551984128301;
 Thu, 07 Mar 2019 10:42:08 -0800 (PST)
MIME-Version: 1.0
References: <20190307091218.2343836-1-arnd@arndb.de> <20190307152805.GA25101@redhat.com>
 <CAK8P3a2fuD-UBJET_OBKekCxrTDpnAxb0Bpu2LCCXaVT3pXTMQ@mail.gmail.com> <20190307164647.GC25101@redhat.com>
In-Reply-To: <20190307164647.GC25101@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 Mar 2019 10:41:57 -0800
Message-ID: <CAKwvOdkEuK04iqdrGR1CaHGc-3zCAS+tGnvfN8R0+j728TTPtQ@mail.gmail.com>
Subject: Re: [PATCH] signal: fix building with clang
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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

On Thu, Mar 7, 2019 at 8:46 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 03/07, Arnd Bergmann wrote:
> >
> > We could use % everywhere,
>
> Yes.
>
> But again, why not simply use the "for (;;)" loops? Why we can't kill the
> supid switch(_NSIG_WORDS) tricks altogether?
>
> Oleg.
>
> --- x/include/linux/signal.h
> +++ x/include/linux/signal.h
> @@ -121,26 +121,9 @@
>  #define _SIG_SET_BINOP(name, op)                                       \
>  static inline void name(sigset_t *r, const sigset_t *a, const sigset_t *b) \
>  {                                                                      \
> -       unsigned long a0, a1, a2, a3, b0, b1, b2, b3;                   \
> -                                                                       \
> -       switch (_NSIG_WORDS) {                                          \
> -       case 4:                                                         \
> -               a3 = a->sig[3]; a2 = a->sig[2];                         \
> -               b3 = b->sig[3]; b2 = b->sig[2];                         \
> -               r->sig[3] = op(a3, b3);                                 \
> -               r->sig[2] = op(a2, b2);                                 \
> -               /* fall through */                                      \
> -       case 2:                                                         \
> -               a1 = a->sig[1]; b1 = b->sig[1];                         \
> -               r->sig[1] = op(a1, b1);                                 \
> -               /* fall through */                                      \
> -       case 1:                                                         \
> -               a0 = a->sig[0]; b0 = b->sig[0];                         \
> -               r->sig[0] = op(a0, b0);                                 \
> -               break;                                                  \
> -       default:                                                        \
> -               BUILD_BUG();                                            \
> -       }                                                               \
> +       int i;                                                          \
> +       for (i = 0; i < ARRAY_SIZE(r->sig); ++i)                        \
> +               r->sig[i] = op(a->sig[i], b->sig[i]);                   \
>  }
>
>  #define _sig_or(x,y)   ((x) | (y))
>

That looks much cleaner IMO.
-- 
Thanks,
~Nick Desaulniers
