Return-Path: <SRS0=VxEc=R4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C24C43381
	for <linux-mips@archiver.kernel.org>; Mon, 25 Mar 2019 16:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5469320879
	for <linux-mips@archiver.kernel.org>; Mon, 25 Mar 2019 16:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ZDbQf6wF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfCYQpY (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:45:24 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43297 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfCYQpY (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 25 Mar 2019 12:45:24 -0400
Received: by mail-qt1-f195.google.com with SMTP id v32so11045581qtc.10
        for <linux-mips@vger.kernel.org>; Mon, 25 Mar 2019 09:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=azszLIWADnCz8AeAgm8+58HpL8DqZnCAWctdIVFE5Zo=;
        b=ZDbQf6wFJU+EYUfgK208d7q5xgEAsedfDWsH7HcS+TgxZe1Tssa2BPdsAG2/hwMAys
         rsvWpbV2F4p94YwmKTFIuX4ZYCNds18YVeb5XKR3N/q/IwU3EkNwJcTVzYn6EDh7fZln
         2OZxPHIHWfFGj7YZXdyCqHS05W2dh7149lXSg4/ukEQUMHL7D7Y6NtaabG2aYj9KasxM
         PHuOzwzg4iM4288xlpCX0Y7+myHdwiQDA5aQ9iytY8LSSCnI+uBbm/mNp75vQ71uvTOh
         1u0QcVedoEpv2k/lmslIikFO/JBL2Dw9XFQLEa1MLkr1UZsADEa008jT8NGlhOraW5UW
         A0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=azszLIWADnCz8AeAgm8+58HpL8DqZnCAWctdIVFE5Zo=;
        b=YTFYtUDZ7PmJ3wM4xd/9YrWmdIj/S7F1jqFuz/HEDF7QY63pAY5sPPhC6ryXhe0AWP
         x4QuGYG6bLY3NQ7M6XFHWG8s4ZkAXi2JM1h0FudgNjH/4tzxJ/j3w1Hb0hZf+4n0pDDv
         9CeMFgLrsjk5zfHoNYkb37EKc4GolcJDFQFttFaeHFOOjWAMoUaqhaEXDuEC2FU9p9CT
         XDWybDpS7aybmHKFhexQ4hgy4ELmFuYKu7ZvHcpL0Pwoi6I56lzxSwgLkZJ5UGh86XeN
         FoRBSD6eUOPQUMIwsKAcOo40ToOQG5hsG9DjhLgePYWYe2XQnUnmJFBx+itPUTtHMPk8
         2Jlg==
X-Gm-Message-State: APjAAAUQpBqwExzBVvMR3ZwAczY1LwT+8XK+lL84InIC34Zwawh0JKHi
        +ZaO2yN/lYuFHExm9WBKwvssKV7mlu0bnizp+J9YoA==
X-Google-Smtp-Source: APXvYqwyqN1SmdoxO8BNg708b3bvqvBy5e7BsLNFvrI9L6R6ElZeTlrOFSa7GssTU28fSAH0U/YXsNRayrnRchybewU=
X-Received: by 2002:ac8:2396:: with SMTP id q22mr22096706qtq.382.1553532323693;
 Mon, 25 Mar 2019 09:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190317183438.2057-1-ira.weiny@intel.com> <20190317183438.2057-2-ira.weiny@intel.com>
 <CAA9_cmffz1VBOJ0ykBtcj+hiznn-kbbuotu1uUhPiJtXiFjJXg@mail.gmail.com> <20190325061941.GA16366@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20190325061941.GA16366@iweiny-DESK2.sc.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 25 Mar 2019 09:45:12 -0700
Message-ID: <CAPcyv4hPxoX1+u=fjzCeVYOd9Bck9d=A9SQ-mjzeMA2tf9B9dA@mail.gmail.com>
Subject: Re: [RESEND 1/7] mm/gup: Replace get_user_pages_longterm() with FOLL_LONGTERM
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Mon, Mar 25, 2019 at 7:21 AM Ira Weiny <ira.weiny@intel.com> wrote:
[..]
> > > @@ -1268,10 +1246,14 @@ static long check_and_migrate_cma_pages(unsigned long start, long nr_pages,
> > >                                 putback_movable_pages(&cma_page_list);
> > >                 }
> > >                 /*
> > > -                * We did migrate all the pages, Try to get the page references again
> > > -                * migrating any new CMA pages which we failed to isolate earlier.
> > > +                * We did migrate all the pages, Try to get the page references
> > > +                * again migrating any new CMA pages which we failed to isolate
> > > +                * earlier.
> > >                  */
> > > -               nr_pages = get_user_pages(start, nr_pages, gup_flags, pages, vmas);
> > > +               nr_pages = __get_user_pages_locked(tsk, mm, start, nr_pages,
> > > +                                                  pages, vmas, NULL,
> > > +                                                  gup_flags);
> > > +
> >
> > Why did this need to change to __get_user_pages_locked?
>
> __get_uer_pages_locked() is now the "internal call" for get_user_pages.
>
> Technically it did not _have_ to change but there is no need to call
> get_user_pages() again because the FOLL_TOUCH flags is already set.  Also this
> call then matches the __get_user_pages_locked() which was called on the pages
> we migrated from.  Mostly this keeps the code "symmetrical" in that we called
> __get_user_pages_locked() on the pages we are migrating from and the same call
> on the pages we migrated to.
>
> While the change here looks funny I think the final code is better.

Agree, but I think that either needs to be noted in the changelog so
it's not a surprise, or moved to a follow-on cleanup patch.
