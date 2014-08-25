Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2014 21:30:11 +0200 (CEST)
Received: from mail-wg0-f42.google.com ([74.125.82.42]:50063 "EHLO
        mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006760AbaHYTaJ6vbzh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Aug 2014 21:30:09 +0200
Received: by mail-wg0-f42.google.com with SMTP id l18so13356653wgh.1
        for <multiple recipients>; Mon, 25 Aug 2014 12:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xYUsOnuNZjSGAECY0DZvKHYxlwILH364fhgbqVPH38M=;
        b=LGkO4SKvbvpbC+2KTa8qAkakR6kq/XAB6B3bjLqElfQAWkXsv96eShXFbFn498VLxJ
         CUI9/kC5oGR1Te0bT1mFsCNzI+GH/FFLl0/7UL79pte0Qds1zoLVGvsrcvAtapTPNlRj
         fR+eO/01mzo5hrKw2NlU82zGzGgRAByy9CuOWVEjCQWH/bMf4rTGs7z9T3hFHzGrHLxQ
         gpbEk1anuk3mv1DSP2tL+xwNuP8PvDmvsWv+sCQVbV9SZkBV706Wm2VgVdfj2GCjFlBe
         mOK6ovbAyaNCQxN+KFUNOpOp0kNcCvhuisfuK0hHU/KEkWBOrMoq2brkw+WXel85d6UC
         /wxQ==
X-Received: by 10.194.203.105 with SMTP id kp9mr25323497wjc.41.1408995004656;
 Mon, 25 Aug 2014 12:30:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.216.36.67 with HTTP; Mon, 25 Aug 2014 12:29:24 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.11.1408251502140.18483@eddie.linux-mips.org>
References: <1408465632-34262-1-git-send-email-manuel.lauss@gmail.com>
 <20140825125107.GA25892@linux-mips.org> <alpine.LFD.2.11.1408251502140.18483@eddie.linux-mips.org>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Mon, 25 Aug 2014 21:29:24 +0200
Message-ID: <CAOLZvyG4F_PCb5hbws1_e8nCeJ+odvnC5u=yitSe9CwY3TWZdw@mail.gmail.com>
Subject: Re: [RFC PATCH V2] MIPS: fix build with binutils 2.24.51+
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On Mon, Aug 25, 2014 at 4:27 PM, Maciej W. Rozycki <macro@linux-mips.org> wrote:

> 1. Determine whether `-Wa,-msoft-float' and `.set hardfloat' are available
>    (a single check will do, they were added to GAS both at the same time)
>    and only enable them if supported by binutils being used to build the
>    kernel, e.g. (for the `.set' part):
>
> #ifdef GAS_HAS_SET_HARDFLOAT
> #define SET_HARDFLOAT .set      hardfloat
> #else
> #define SET_HARDFLOAT
> #endif
>
>    Otherwise we'd have to bump the binutils requirement up to 2.19; this

Do people really update their toolchain so rarely?


> 2. Use `.set hardfloat' only around the places that really require it,
>    i.e.:
>
>         .set    push
>         SET_HARDFLOAT
> # Do the FP stuff.
>         .set    pop
>
>    (so the arch/mips/kernel/r4k_fpu.S piece is good except for maybe using
>    a macro, depending on the outcome of #1 above, but the other ones are
>    not).

I'll update the patch.

Thank you!
        Manuel
