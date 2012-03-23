Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2012 22:36:29 +0100 (CET)
Received: from mail-we0-f177.google.com ([74.125.82.177]:54144 "EHLO
        mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903742Ab2CWVgN convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Mar 2012 22:36:13 +0100
Received: by werp11 with SMTP id p11so3636521wer.36
        for <linux-mips@linux-mips.org>; Fri, 23 Mar 2012 14:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=V/u0CBW1Hww/z2u6rj1XZPqats0P2RiTnxRE2jkxlZA=;
        b=e0Ud41+4p2xbkwYG2oZ99cl5oD+4yvTVzMHuQK/Xz5Rpc/RQHfnoiTqQSuQznxhGch
         OMgFMr2o5ntRCAWEV2ZuQPLfLjl5J6SNunJr1/A0ePnxIHRE4AFTQvUzuVHNSMWfhWYA
         6IYfALSSoab7mEDe3CaqPAfYhkfqBwz/QOxEesL81BO0HlklrDaeEwazOOOpdmxw1nsI
         DHaUPLdCewELS5ZrKDkhQZolLPWxcORR5mI9+slUWW2+ucOxhzAMrz1sh4MHbtL2z1ni
         XMh2xCroicOSt6SU3FmE0bbhmj+8lsVh0iGc/67+oGYhrz29RSvUnYt2iRjiRmOvGAN8
         xj3w==
Received: by 10.180.80.104 with SMTP id q8mr355693wix.14.1332538568458; Fri,
 23 Mar 2012 14:36:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.180.103.163 with HTTP; Fri, 23 Mar 2012 14:35:48 -0700 (PDT)
In-Reply-To: <1332228283-29077-1-git-send-email-m.szyprowski@samsung.com>
References: <1332228283-29077-1-git-send-email-m.szyprowski@samsung.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Mar 2012 14:35:48 -0700
X-Google-Sender-Auth: kSZ5nqSZH1I5cpZoP5ckbA_ybIQ
Message-ID: <CA+55aFy9oxMrfm-+deMqV=XnFOa98aKXqW+8PR-P-zOARtC2BQ@mail.gmail.com>
Subject: Re: [GIT PULL] DMA-mapping framework updates for 3.4
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Dave Airlie <airlied@linux.ie>
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mips@linux-mips.org, discuss@x86-64.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linaro-mm-sig@lists.linaro.org, Jonathan Corbet <corbet@lwn.net>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 32743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Mar 20, 2012 at 12:24 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
>  git://git.infradead.org/users/kmpark/linux-samsung dma-mapping-next
>
> Those patches introduce a new alloc method (with support for memory
> attributes) in dma_map_ops structure, which will later replace
> dma_alloc_coherent and dma_alloc_writecombine functions.

So I'm quite unhappy with these patches.

Here's just the few problems I saw from some *very* quick look-through
of the git tree:

 - I'm not seeing ack's from the architecture maintainers for the
patches that change some architecture.

 - Even more importantly, what I really want is acks and comments from
the people who are expected to *use* this.

 - it looks like patches break compilation half-way through the
series. Just one example I noticed: the "x86 adaptation" patch changes
the functions in lib/swiotlb.c, but afaik ia64 *also* uses those. So
now ia64 is broken until a couple of patches later. I suspect there
are other examples like that.

 - the sign-off chains are odd. What happened there? Several patches
are signed off by Kyungmin Park, but he doesn't seem to be "in the
chain" at all. Whazzup? (*)

(Btw, I notice the same thing in the tree I pulled from Dave Airlie,
btw - what the F is going on with samsung submissions - those are
marked as committed by Dave Airlie, and don't have Dave in the
sign-off chain at all!)

 - Finally, how/why are "dma attributes" different from the per-device
dma limits ("device_dma_parameters")

Hmm?

                  Linus

(*) Btw, I notice the same thing in the tree I pulled from Dave
Airlie, btw - what the F is going on with samsung submissions - those
are marked as committed by Dave Airlie, and don't have Dave in the
sign-off chain at all! Dave?
