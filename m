Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Apr 2012 05:59:10 +0200 (CEST)
Received: from mail-qa0-f49.google.com ([209.85.216.49]:48344 "EHLO
        mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903638Ab2DJD6y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Apr 2012 05:58:54 +0200
Received: by qafi29 with SMTP id i29so1886901qaf.15
        for <multiple recipients>; Mon, 09 Apr 2012 20:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PowEYgX6gyftAFlxbGK9y8HNaa6DaHNTOeeY1SmORBs=;
        b=ofSoHTNnRkoSu9yGIwPV8PgzoVDEGJ6bcSspfkSTCvua0xeGUMnQbEjvqRkvfz2Nbo
         NNpSQ/+hjYku1E/laP6pgIhW+Epe5+/rrbaOIrpSdyDKjawhuOn9htkDAK6j0yWIBVpa
         FEBnNSC4iVJc9rwK58g/u0Sa8FAuTWLXJy2nHitd3q/+5iK2qAlJBQHo2B77jWM39Jub
         oVqd32nvfIUxx88SgS4zTvQcLAhnT56ugQFLaTs4Uka7yWGsGJ8HdOBw/OfYfoWv74AZ
         Ebxo7zC8TDBM89uzFRzKTyfsvUV8+RkiXOxlrkkjp8gAjC8kqqbU37eH5WZSao/hk0aX
         OcaQ==
MIME-Version: 1.0
Received: by 10.224.220.211 with SMTP id hz19mr12457162qab.33.1334030328564;
 Mon, 09 Apr 2012 20:58:48 -0700 (PDT)
Received: by 10.224.125.69 with HTTP; Mon, 9 Apr 2012 20:58:48 -0700 (PDT)
In-Reply-To: <3cvb8sm16wfjrw35b2tyxnfu.1334026758779@email.android.com>
References: <1333988075-1289-1-git-send-email-sjhill@mips.com>
        <CAJiQ=7A-Bmn9ULb3+YXaXgYTKiHZm1Dbsd-NQBjeL0TLjKAafQ@mail.gmail.com>
        <3cvb8sm16wfjrw35b2tyxnfu.1334026758779@email.android.com>
Date:   Mon, 9 Apr 2012 20:58:48 -0700
Message-ID: <CAJiQ=7Dm0JBzxbL_ueZvvLWAQZPMY_swy0icVj_od95t3V3VOQ@mail.gmail.com>
Subject: Re: [PATCH] Revert fixrange_init() limiting to the FIXMAP region.
From:   Kevin Cernekee <cernekee@gmail.com>
To:     "Yegoshin, Leonid" <yegoshin@mips.com>
Cc:     "Hill, Steven" <sjhill@mips.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 32919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, Apr 9, 2012 at 7:59 PM, Yegoshin, Leonid <yegoshin@mips.com> wrote:
> Sorry, it was a couple of months ago while I worked on HIGHMEM with cache aliasing. I got a soak test failure and rollback of this patch helped.

Is it possible that HIGHMEM / kmap was using pages above the PKMAP
range, and the bug was masked by re-enabling the old behavior (create
PMDs all the way up to the top of the virtual address space)?

>Besides that it is clearly wrong to add unmodified memory area length to aligned start address of that memory. It seems easy to fix but I hadn't time.

On the pre-464fd83e implementation, that would have been a problem
because of the "vaddr != end" terminating condition.

On the post-464fd83e implementation, it should be fine because we are
checking for "vaddr < end" instead.  This means we should get just
enough PMDs to cover the requested range.

I just checked one of my systems and it is calling
fixrange_init(0xff000000, 0xff039000, pgd_base).  This creates a
single PMD covering a 4MB range, as expected.
