Return-Path: <SRS0=j293=UT=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA35C43613
	for <linux-mips@archiver.kernel.org>; Thu, 20 Jun 2019 17:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69B62083B
	for <linux-mips@archiver.kernel.org>; Thu, 20 Jun 2019 17:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561051327;
	bh=Sh+i3/+atKsLHq20f7BYR2YeUmM7aHDmKCg2/Gz2RQM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ibeoMecWIMh6mhoblmmysZ8aofgpEg1qEKto4suTfvHKFiET6MYpqWxcVJSci2HUP
	 Esm1oz6v9BY2PY9kp++2yJpPhwKh67IqJFUa1LpNPmw5jQp8/3YgBljyPfEEEIlOYg
	 2fNs4xrM6G2x69DQXFZkLIt23WDAWXvv5vCEeEbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfFTRWG (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:22:06 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33986 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfFTRWG (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 20 Jun 2019 13:22:06 -0400
Received: by mail-lf1-f67.google.com with SMTP id y198so3033165lfa.1
        for <linux-mips@vger.kernel.org>; Thu, 20 Jun 2019 10:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8s7nWa83ZrllVywYBO3+qENQEvSqioKh5iSEDp3yvQc=;
        b=g1mjJHSB+/44ZB7V3d991RQ8lmWdxyz7cRKmwtk9byrjcNUD9YP2uS+RZIIrKE7lKn
         tVpZNvyJkolb6AtIXbb56yLA6c56wf2OFIIZEIPMa1TRDMJb6FE75meYgwCBSBqSYdRC
         O8jEDgU+LfyGIAqseIIvIOnHddyiMVgjB9lIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8s7nWa83ZrllVywYBO3+qENQEvSqioKh5iSEDp3yvQc=;
        b=nurs1yZS98ROq3T/I/HxdrPSBO79U30U8T9+LAkAVg5dcd/1gbjaEPaEx7nJq9EiqG
         o8VLFucq0QvZLtcS4TO4yl1hBlF6sq2LURwZXZVXvRs0imjNLWi7b8qDT9w2/FqzmHps
         P1ShcXkB+wLw48AtO08c5WS6kaQGRBFh4hJtd1s8EaCkt5sZUzy0pTApyZXHsOO6a5+N
         +k0H8NjBH0rsfskfqOY0rip5+bh/8Ef3rCnfwiSEUlWcB8ou1sPfdrRJeMjSpvvArldZ
         ViC3mgpBEBjwFoIfGBChZnfHvCFR1FGuGgxPj/5LW909xibuQaLNwUIvnyFW8kQgFQbt
         HiWQ==
X-Gm-Message-State: APjAAAUTe3ZYaPYK5Gp+yLskz5CvmdwuQ7QFGgU0952FZpezrVRjCDUl
        a+06ZsHntxfQZGV7GZ6HQr+omDYxI+8=
X-Google-Smtp-Source: APXvYqwFBfBNcjhNIEW3nC2VfrCiUmHC0DciHLMH/cPjd78wKibMKRzI+/dhOhUkSAJWhS3XT5u/NQ==
X-Received: by 2002:ac2:546a:: with SMTP id e10mr18416296lfn.75.1561051323862;
        Thu, 20 Jun 2019 10:22:03 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id h11sm43388lfm.14.2019.06.20.10.22.02
        for <linux-mips@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 10:22:02 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 136so2995184lfa.8
        for <linux-mips@vger.kernel.org>; Thu, 20 Jun 2019 10:22:02 -0700 (PDT)
X-Received: by 2002:ac2:5601:: with SMTP id v1mr51955604lfd.106.1561051322002;
 Thu, 20 Jun 2019 10:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190611144102.8848-1-hch@lst.de> <20190611144102.8848-17-hch@lst.de>
 <1560300464.nijubslu3h.astroid@bobo.none> <CAHk-=wjSo+TzkvYnAqrp=eFgzzc058DhSMTPr4-2quZTbGLfnw@mail.gmail.com>
 <1561032202.0qfct43s2c.astroid@bobo.none>
In-Reply-To: <1561032202.0qfct43s2c.astroid@bobo.none>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Jun 2019 10:21:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh46y3x5O0HkR=R4ETh6e5pDCrEsJ94CtC0fyQiYYAf6A@mail.gmail.com>
Message-ID: <CAHk-=wh46y3x5O0HkR=R4ETh6e5pDCrEsJ94CtC0fyQiYYAf6A@mail.gmail.com>
Subject: Re: [PATCH 16/16] mm: pass get_user_pages_fast iterator arguments in
 a structure
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>,
        James Hogan <jhogan@kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Burton <paul.burton@mips.com>,
        Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Thu, Jun 20, 2019 at 5:19 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> The processor aliasing problem happens because the struct will
> be initialised with stores using one base register (e.g., stack
> register), and then same memory is loaded using a different
> register (e.g., parameter register).

Hmm. Honestly, I've never seen anything like that in any kernel profiles.

Compared to the problems I _do_ see (which is usually the obvious
cache misses, and locking), it must either be in the noise or it's
some problem specific to whatever CPU you are doing performance work
on?

I've occasionally seen pipeline hiccups in profiles, but it's usually
been either some serious glass jaw of the core, or it's been something
really stupid we did (or occasionally that the compiler did: one in
particular I remember was how there was a time when gcc would narrow
stores when it could, so if you set a bit in a word, it would do it
with a byte store, and then when you read the whole word afterwards
you'd get a major pipeline stall and it happened to show up in some
really hot paths).

            Linus
