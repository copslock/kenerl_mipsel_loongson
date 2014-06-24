Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2014 18:44:10 +0200 (CEST)
Received: from mail-oa0-f53.google.com ([209.85.219.53]:62961 "EHLO
        mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816071AbaFXQoFMAWzF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jun 2014 18:44:05 +0200
Received: by mail-oa0-f53.google.com with SMTP id l6so654929oag.12
        for <linux-mips@linux-mips.org>; Tue, 24 Jun 2014 09:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=6aUiFlzoyglWoV3HG4s7ZfANLOUUgxsr4Oc8LmzvpNo=;
        b=lDVcx0n2LzTO4q0RkqdYdwUQvkzzByp1Vanbo+kQCVrSpOb4A5UaWL8dSOUit9WZrE
         h2/vvl3+lxmqzm1Qqlmdjw2TQca5CzSPAbx1NMzmzNiOskGrV/t9J/tNG+gT2IeKwNAr
         GupNhB9BnUPh82v0oEAhO4jlJwCcGumpsRZ2rst8uQTtosVKjVx1sQ+8hgYZfS9F/Mgy
         I5uxtZwvGr6Gc0NnvtiK/9/WA8+yH8f+CznqHJ2A1ZQP0UsQmm3CUAkCMye5julRdDZh
         lINBYM1DNjJ75t6ZU9TaNTt817lwAsLgJi1mKDySKhd/TTjIwkVBkxY+WuSBmPS/XoFF
         77YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=6aUiFlzoyglWoV3HG4s7ZfANLOUUgxsr4Oc8LmzvpNo=;
        b=axHXgVRzP9iIrGG5zs7NRF8pM6IfT+xRytd+o0RpFdKRv9c6QdW/rLVKFJbaVl0d4x
         QdRUhHmWaMxOC6ACvztVlkBBk/NC2kINuZjRxpULPFy6WDigCA1bicMyp+jMJ9l7M+kC
         2DOxYH/un0frXc6S4tet3aopUkOH99/0yR488=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=6aUiFlzoyglWoV3HG4s7ZfANLOUUgxsr4Oc8LmzvpNo=;
        b=Bozdl/AvAbW0mNbDwRg2+IneE5jBpXtTl+EpCfxSmnXZF3alNsx3UwGI9K11mV3nKk
         prN6QZMkdO/dS5V1/zNxpkGU2bTEenDoIie5vGMsW2T0YNQ6E4YGbkgi09ehbZBVa6QF
         d8pLXsuWV/hqtRuzsyBAzGyE7ywRqlxRwMcAgjJ4By7QdCTmdl8TfWmXYXj3rCAXWkvO
         erdMCorxv00NCM+kfuerHXQWnBiHeCffTgp0T+AcTnE+nPY0rAC+5lWUDZR4mIzoB4CM
         Z1pPQuZiPb5AOBLn6RVtdpUtKfZ4bGNKMoWK12x0iGoEbRYXgeCYqk9+rJMfd9tvUqlQ
         jS7g==
X-Gm-Message-State: ALoCoQlOndAd97o4mTYidJ1HqiWf0AYHtgR2oph/Y31Ys+1ZjGLlN4XyqpNrnPNkBVCQd/QxEX7B
MIME-Version: 1.0
X-Received: by 10.60.175.34 with SMTP id bx2mr2089327oec.49.1403628238791;
 Tue, 24 Jun 2014 09:43:58 -0700 (PDT)
Received: by 10.182.63.80 with HTTP; Tue, 24 Jun 2014 09:43:58 -0700 (PDT)
In-Reply-To: <53A95187.4010805@gmail.com>
References: <20140623220150.GM5412@outflux.net>
        <53A95187.4010805@gmail.com>
Date:   Tue, 24 Jun 2014 09:43:58 -0700
X-Google-Sender-Auth: NQIOUxYVJ08ACTVzzcRKIRSU3KA
Message-ID: <CAGXu5j+A1WCA13rRnREh_m0kwsYfBrZSwB25NXEdpQNpgjJfyw@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] man-pages: seccomp.2: document syscall
From:   Kees Cook <keescook@chromium.org>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <dborkman@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        David Drysdale <drysdale@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

On Tue, Jun 24, 2014 at 3:23 AM, Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
> On 06/24/2014 12:01 AM, Kees Cook wrote:
>> Combines documentation from prctl, and in-kernel seccomp_filter.txt,
>> along with new details specific to the new syscall.
>
> Great work on the man page, Kees! (BTW, just looking at the complexity detailed
> there further supports the decision to grant this functionality as a separate
> syscall, rather than multiplexed into prctl(2).

Great, thanks!

> Would there be some suitable, not too long program that we
> could put in the man page as an example for using filters?

Sure thing. I can modify the "dropper" sample in samples/seccomp. I
will resend the man-page with that added.

Thanks!

-Kees

-- 
Kees Cook
Chrome OS Security
