Return-Path: <SRS0=hzgf=TZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A7CC07542
	for <linux-mips@archiver.kernel.org>; Sat, 25 May 2019 17:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2402081C
	for <linux-mips@archiver.kernel.org>; Sat, 25 May 2019 17:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558803968;
	bh=JCyz2AHEnuFqjY1vov/YDirUQKDfQDhkKPswnqOMK3Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jD7eQ1/tFQ5ne3K4Opv+Ik632IXE6qho1cl+DlkqdPBXrLr+LSEdYcyddVkBGu/Cv
	 Yfwuw52anK7VWGbX3IKZ2VwXRaa38xzymSWMdu/CaJwUUG+kcj/vXcOUw7f0uocYc5
	 pMedSOehdx0J7NvXokqpOnsxAt0BHQ8432trBIDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfEYRGH (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 25 May 2019 13:06:07 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:32811 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbfEYRGG (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 25 May 2019 13:06:06 -0400
Received: by mail-lf1-f67.google.com with SMTP id y17so1407043lfe.0
        for <linux-mips@vger.kernel.org>; Sat, 25 May 2019 10:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eUnPUEw25xH84DOq6zJ0v6Aw5NodbUsM/I1jFeyU0KM=;
        b=ZvNWnuQZMG/SkUan4dFz03SkF+F6NtqRC/Cgx2fb5lXthFpCjyzEbczW/SDraYncIR
         zQgHz3FqW2dkuJzWrU9AHwiQ6MhmEIkM0Uwmoc25goSdoXSqyrERxHA6nnEdyvmvjOcJ
         rQ898QL/9J9sDjvhm9K66P/TQWm9eicsR7EOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eUnPUEw25xH84DOq6zJ0v6Aw5NodbUsM/I1jFeyU0KM=;
        b=Hpk6nx4T16fdhoI08b6ZurLFUVF7FNDfDXy0B64cRHiDu4ht97H1SZr2FFJGhGuZy6
         J3zf075v9Wk3ZtKe1wgA0Anr2RwZJIxgU4utgtX7fcz+ZqtFCD91mk6rMpNLFWmzWa0Z
         pfX3A/JA7CP+JCf9lXJMJNvLxvgmQzJMavk3gxXR9RjM0yZd+cWC4Dfcr5zGrxgfCHLR
         onFCGYcpvYitV7cjFuLD4I3P6BDqqeI6kCIvIsjyPvlqzmWrgT9Lh/q2ONVtwezJ1O+D
         skzaWOaC5a4mWHtXtjteIKcGSnHIBfDb2/pLe1Z3vCbzWtDPP3rxM/1XLCWeoXliJBnn
         FNWw==
X-Gm-Message-State: APjAAAVaROtvHv+SRTejGMvGQPLHwR+5tOyF8ENo0nr4tOGUT7B24e4L
        /p5NEeZMk/7nnjc6syKyvJX43FBPPfw=
X-Google-Smtp-Source: APXvYqwbCMCOuILnCx69S3ifb3j7CnyX9OOpCXkVOKG/BIW+HU6xo/g7X7irM/tZ6J6FxVXm1qy0MQ==
X-Received: by 2002:a05:6512:245:: with SMTP id b5mr16340234lfo.24.1558803964350;
        Sat, 25 May 2019 10:06:04 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id g15sm1162768ljk.83.2019.05.25.10.06.01
        for <linux-mips@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 10:06:01 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id m15so8662686lfh.4
        for <linux-mips@vger.kernel.org>; Sat, 25 May 2019 10:06:01 -0700 (PDT)
X-Received: by 2002:ac2:59c9:: with SMTP id x9mr629669lfn.52.1558803961013;
 Sat, 25 May 2019 10:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190525133203.25853-1-hch@lst.de> <20190525133203.25853-5-hch@lst.de>
In-Reply-To: <20190525133203.25853-5-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 May 2019 10:05:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg-KDU9Gp8NGTAffEO2Vh6F_xA4SE9=PCOMYamnEj0D4w@mail.gmail.com>
Message-ID: <CAHk-=wg-KDU9Gp8NGTAffEO2Vh6F_xA4SE9=PCOMYamnEj0D4w@mail.gmail.com>
Subject: Re: [PATCH 4/6] mm: add a gup_fixup_start_addr hook
To:     Christoph Hellwig <hch@lst.de>,
        Khalid Aziz <khalid.aziz@oracle.com>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-mips@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

[ Adding Khalid, who added the sparc64 code ]

On Sat, May 25, 2019 at 6:32 AM Christoph Hellwig <hch@lst.de> wrote:
>
> This will allow sparc64 to override its ADI tags for
> get_user_pages and get_user_pages_fast.  I have no idea why this
> is not required for plain old get_user_pages, but it keeps the
> existing sparc64 behavior.

This is actually generic. ARM64 has tagged pointers too. Right now the
system call interfaces are all supposed to mask off the tags, but
there's been noise about having the kernel understand them.

That said:

> +#ifndef gup_fixup_start_addr
> +#define gup_fixup_start_addr(start)    (start)
> +#endif

I'd rather name this much more specifically (ie make it very much
about "clean up pointer tags") and I'm also not clear on why sparc64
actually wants this. I thought the sparc64 rules were the same as the
(current) arm64 rules: any addresses passed to the kernel have to be
the non-tagged ones.

As you say, nothing *else* in the kernel does that address cleanup,
why should get_user_pages_fast() do it?

David? Khalid? Why does sparc64 actually need this? It looks like the
generic get_user_pages() doesn't do it.

                Linus
