Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Oct 2018 03:04:18 +0200 (CEST)
Received: from mail-it1-f194.google.com ([209.85.166.194]:38527 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994074AbeJRBENn0yOb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Oct 2018 03:04:13 +0200
Received: by mail-it1-f194.google.com with SMTP id i76-v6so5004382ita.3;
        Wed, 17 Oct 2018 18:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/54642iGviT3fuBVEquGySV/2TZ1AT6y2hDZg0lxW2o=;
        b=fBjwqBnXHzer8uUjoa6kGH0jJgPF1H6yk5D8ZLTTWHy5xnhhelkaa4mr3tOGeE0ZoT
         oLRABFvMV48yIcybnWQyjmhV6iOGthrQkj1Fhc53zaXQNRQn57f/pNPHq/qwab/yogb9
         PXfS40uYN7N0s1+N6t2GWshoWPCBNNFPtNyJr0Zg5oDJGeK8HA36+bwqytXUQuqma01M
         jhPUnAqTMsormfZIotGdj8DWLLWNJjJBlBnedbJQ4hs2QOI+vHK7jnu4HBkaQay+k0uP
         uNA7x+1uPm+Udf5MlkuguXEQcvO6cXfyDskQ0QcFTSkfrHq44j6Gl6TLp2E15i9JKIAw
         J17Q==
X-Gm-Message-State: ABuFfohrVHX29pr0M6+dCwTp1HkxeLO4nVF8z9QcHWhbnlhz0P/KucCE
        Pflf1yT44MjGshQUhtkAnG02WXXMTS7yV1plvVg=
X-Google-Smtp-Source: ACcGV61XBtg/ngyTZmVEsu7OXy5U5m4gLue2FXZQOJ0kKQ0LezN3VPXfV4VtoxOyEJtbuIwtM8CW5oTQlaLQu65S2FA=
X-Received: by 2002:a05:660c:441:: with SMTP id d1mr3414110itl.22.1539824647585;
 Wed, 17 Oct 2018 18:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <1539736193-27332-1-git-send-email-chenhc@lemote.com> <20181017201910.27kdwnml6kq7qff5@pburton-laptop>
In-Reply-To: <20181017201910.27kdwnml6kq7qff5@pburton-laptop>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Thu, 18 Oct 2018 09:09:54 +0800
Message-ID: <CAAhV-H4JXW4oQQRtFqASdS71iXLM82N3PDOQX07AXOikYq5Dvw@mail.gmail.com>
Subject: Re: [PATCH] cacheinfo: Keep the old value if of_property_read_u32 fails
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        zhangfx <zhangfx@lemote.com>, wu zhangjin <wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Hi, Paul,

I'm sorry to send to a wrong maillist... And please review another
patch (About VDSO, I'm sorry that I hadn't do enough tests before).

Huacai
On Thu, Oct 18, 2018 at 4:19 AM Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Huacai,
>
> On Wed, Oct 17, 2018 at 08:29:53AM +0800, Huacai Chen wrote:
> > Commit 448a5a552f336bd7b847b1951 ("drivers: base: cacheinfo: use OF
> > property_read_u32 instead of get_property,read_number") makes cache
> > size and number_of_sets be 0 if DT doesn't provide there values. I
> > think this is unreasonable so make them keep the old values, which is
> > the same as old kernels.
> >
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > ---
> >  drivers/base/cacheinfo.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
>
> Since this isn't a MIPS-related patch you'll need to send it to the
> maintainers & reviewers for the file you modified. They would be:
>
>   $ ./scripts/get_maintainer.pl -f drivers/base/cacheinfo.c
>   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     (supporter:DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS)
>   "Rafael J. Wysocki" <rafael@kernel.org>
>     (reviewer:DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS)
>   linux-kernel@vger.kernel.org (open list)
>
> Thanks,
>     Paul
