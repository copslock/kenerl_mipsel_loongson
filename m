Return-Path: <SRS0=xPwI=UA=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30197C28CC4
	for <linux-mips@archiver.kernel.org>; Sat,  1 Jun 2019 16:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CEC27758
	for <linux-mips@archiver.kernel.org>; Sat,  1 Jun 2019 16:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559406555;
	bh=zWBk10dzRErfJ9SACepYGw53HJJmChyH73elCQ7D4Jg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=l3OUwfvORKyxcHQ4lBog/VpsRvW/kHIsLqwY9XmEb+sg9+reI8w9f6lP7OTIA9sA8
	 YHIeK9Eq56S2WzcMHzR81uAhr7Z5vyn5dbzQSZjYkBi7FG6a3CCU/L3l18XOcBzNDM
	 ku67MxcMbYZ/504Bx5quxmXbnIxYZRnKq6rQPawY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfFAQ3O (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 1 Jun 2019 12:29:14 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40817 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfFAQ3N (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 1 Jun 2019 12:29:13 -0400
Received: by mail-lf1-f67.google.com with SMTP id a9so8951728lff.7
        for <linux-mips@vger.kernel.org>; Sat, 01 Jun 2019 09:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WbBlTtzN8zF5Iqk8bw1nVflVKcbi7cIeUDGHN5Yot1E=;
        b=Fa5BzECDkVJJVil3Feep0HbYjDwApJFYj92zZCD6f4aYCxc2Als39M3w9fuXET3xGS
         3dJFRH9YhqCQxcCzt7i+R2DDortv76Hw0c0yls+ilBPK12ky3bwefHhCdXxs096uQvMr
         JNZz4F8UnUXJp5G999kMQlHK92/csNz/XzzF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WbBlTtzN8zF5Iqk8bw1nVflVKcbi7cIeUDGHN5Yot1E=;
        b=OKhg0MKuMHOyPBgknBuIMxnAClafSv+CpH23R9EdrHDh4rBCfTlft21OiYVMmxbpMg
         1peP8UFM1OIkuM8fkoO/LO9dlE09nSVlPftmVkyR1VYCZk2F3SHkfG9CEYUq5Hqw8w3Q
         WiLwyTdFQdNNsFA1ZtO8U4rUJA0c6RP6nvcovxgf/txPfL6bVkGSBdNk6hWliVqJR3vm
         vgyLho+Da0OkZt6ld2Tnv/5lo42b/LwuNRo2ZCRb9DDMrKZtUT4UJM3DFYr3eUePA2N0
         LVjgnU3KH/ASmpufQM8WqQXvRJn5ETV7Q3O1IZRb80TGyVtSxu0aCfddGYY7mbOMllZZ
         LuUw==
X-Gm-Message-State: APjAAAXcGn8h5nveC3ZlZkRWsAMieaYfVqDE1Qi3dB0nGZak9hkH3BHA
        XZtqEgvAd4oVtsEjC4VY8v9FdKeF18M=
X-Google-Smtp-Source: APXvYqybnzjW0heAigUti3ZSX/J/CXzPGya6BkgxkOcRYYOnKwT7mEdPSRX4V/SXfdGBIfLZYz+RjA==
X-Received: by 2002:a19:ed07:: with SMTP id y7mr9562782lfy.56.1559406551451;
        Sat, 01 Jun 2019 09:29:11 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id x20sm1899232ljc.15.2019.06.01.09.29.10
        for <linux-mips@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jun 2019 09:29:10 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id q62so12447502ljq.7
        for <linux-mips@vger.kernel.org>; Sat, 01 Jun 2019 09:29:10 -0700 (PDT)
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr9481496ljj.147.1559406549964;
 Sat, 01 Jun 2019 09:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190601074959.14036-1-hch@lst.de> <20190601074959.14036-9-hch@lst.de>
In-Reply-To: <20190601074959.14036-9-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 1 Jun 2019 09:28:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj9w5NxTcJsqpvYUiL3OBOH-J3=4-vXcc3GaG_U8H-gJw@mail.gmail.com>
Message-ID: <CAHk-=wj9w5NxTcJsqpvYUiL3OBOH-J3=4-vXcc3GaG_U8H-gJw@mail.gmail.com>
Subject: Re: [PATCH 08/16] sparc64: add the missing pgd_page definition
To:     Christoph Hellwig <hch@lst.de>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-mips@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Linux-MM <linux-mm@kvack.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Both sparc64 and sh had this pattern, but now that I look at it more
closely, I think your version is wrong, or at least nonoptimal.

On Sat, Jun 1, 2019 at 12:50 AM Christoph Hellwig <hch@lst.de> wrote:
>
> +#define pgd_page(pgd)                  virt_to_page(__va(pgd_val(pgd)))

Going through the virtual address is potentially very inefficient, and
might in some cases just be wrong (ie it's definitely wrong for
HIGHMEM style setups).

It would likely be much better to go through the physical address and
use "pfn_to_page()". I realize that we don't have a "pgd to physical",
but neither do we really have a "pgd to virtual", and your
"__va(pgd_val(x))" thing is not at allguaranteed to work. You're
basically assuming that "pgd_val(x)" is the physical address, which is
likely not entirely incorrect, but it should be checked by the
architecture people.

The pgd value could easily have high bits with meaning, which would
also potentially screw up the __va(x) model.

So I thgink this would be better done with

     #define pgd_page(pgd)    pfn_to_page(pgd_pfn(pgd))

where that "pgd_pfn()" would need to be a new (but likely very
trivial) function. That's what we do for pte_pfn().

IOW, it would likely end up something like

  #define pgd_to_pfn(pgd) (pgd_val(x) >> PFN_PGD_SHIFT)

David?

                  Linus
