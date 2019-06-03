Return-Path: <SRS0=xtk4=UC=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3255C04AB5
	for <linux-mips@archiver.kernel.org>; Mon,  3 Jun 2019 16:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872A827440
	for <linux-mips@archiver.kernel.org>; Mon,  3 Jun 2019 16:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559578142;
	bh=FVVoo4+poeWonnJJM6ojm7XX1p60P1ky76MuzIox/T4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=k18X1b9pBk7tT//vO56Sp9y5P78356EwdCXxShlYUvGOG6E84TOD2lKkplk7ljN6t
	 ltzNG2qf5x7Vyb7zwk0W4skwHSu6w59UVoDKFU4Ie/kO8czI8Pe1yghoaL10U5W36G
	 lClWFpUKQ1fSrWu/juVTOpgMy2SOW5bDDUW2UwLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfFCQJC (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 3 Jun 2019 12:09:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43123 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbfFCQJC (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 3 Jun 2019 12:09:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id 16so3182701ljv.10
        for <linux-mips@vger.kernel.org>; Mon, 03 Jun 2019 09:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lgsfrWNkeAwXitTJcoIdmm+S5jV0yGJC2wH7GAyc/RM=;
        b=WCXqjpyK9CxskKR1Rsa2JsUVjNbLjTBCO3DKbpdiCOAgDG3/x4OwA5zT3oR9AF+TAb
         KoxRzjysV3/yPddUMg57RzzWz8pj3wl00UXp/zI8qmqY5Pxb0GSO0BkOluklf9MnQYLn
         o8mf30F5cjoqsx0tY+OcCybKIrmRF+OMKq7aY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lgsfrWNkeAwXitTJcoIdmm+S5jV0yGJC2wH7GAyc/RM=;
        b=pJOcXcjwFw1vVySkZ3lYGRLAHPdwDM2NxsB6F1V8N9yLcbBF8f5wSZCIoduKmmSDUd
         mTfKSiWNULHxnE99IiyBEj3KeEfBA/I7xt31isfvt6ZhV5KGdSgwuGgG/vcU4vjmG/A0
         2CFTPeBlg1JeOKIg1j7bPtrRnzJBd1BibRyv5fa4U3nypP71legaLUqDL+9DxYrcGxxt
         nT/010Likprfk0mrnqToRS7eTE48RJan93xuvPhKkOPDlENadPaK6rRopQK4lXJ3Vg1D
         iXI5lfcNYvLSri3DMV9c3peHmX1JOnw/mXOEp7rrWLFrfwUDEwdsWohF8KkkbiRu8qr1
         uFgg==
X-Gm-Message-State: APjAAAU+diqzPsAvZsUhTsoONNXQC3bRm87KL5rX2fu91tjsz9Rn++mn
        KILzFDp5QFZAY8c6rVcyuhLcwP/dUpI=
X-Google-Smtp-Source: APXvYqxEGOcK1zdO1CWoUJUJZw5xyIT2BPUtgf/Zu8/Py3QlU8t2RS55UN5RsL7CFlCNcL8Bii4tPg==
X-Received: by 2002:a2e:81c4:: with SMTP id s4mr1706895ljg.182.1559578140173;
        Mon, 03 Jun 2019 09:09:00 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id i23sm512111ljb.7.2019.06.03.09.08.59
        for <linux-mips@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 09:09:00 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 16so3182633ljv.10
        for <linux-mips@vger.kernel.org>; Mon, 03 Jun 2019 09:08:59 -0700 (PDT)
X-Received: by 2002:a2e:4246:: with SMTP id p67mr14377820lja.44.1559578139147;
 Mon, 03 Jun 2019 09:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190601074959.14036-1-hch@lst.de> <20190601074959.14036-4-hch@lst.de>
 <CAHk-=whusWKhS=SYoC9f9HjVmPvR5uP51Mq=ZCtktqTBT2qiBw@mail.gmail.com> <20190603074121.GA22920@lst.de>
In-Reply-To: <20190603074121.GA22920@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Jun 2019 09:08:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg5mww3StP8HqPN4d5eij3KmEayM743v-nDKAMgRe2J6g@mail.gmail.com>
Message-ID: <CAHk-=wg5mww3StP8HqPN4d5eij3KmEayM743v-nDKAMgRe2J6g@mail.gmail.com>
Subject: Re: [PATCH 03/16] mm: simplify gup_fast_permitted
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

On Mon, Jun 3, 2019 at 12:41 AM Christoph Hellwig <hch@lst.de> wrote:
>
> I only removed a duplicate of it.

I don't see any remaining cases.

> The full (old) code in get_user_pages_fast() looks like this:
>
>         if (nr_pages <= 0)
>                 return 0;
>
>         if (unlikely(!access_ok((void __user *)start, len)))
>                 return -EFAULT;
>
>         if (gup_fast_permitted(start, nr_pages)) {

Yes, and that code was correct.

The new code has no test at all for "nr_pages == 0", afaik.

                 Linus
