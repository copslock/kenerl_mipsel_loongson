Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Oct 2010 17:18:24 +0200 (CEST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53166 "EHLO
        smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491079Ab0J3PSV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Oct 2010 17:18:21 +0200
Received: from mail-iw0-f177.google.com (mail-iw0-f177.google.com [209.85.214.177])
        (authenticated bits=0)
        by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o9UFI30M030858
        (version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
        for <linux-mips@linux-mips.org>; Sat, 30 Oct 2010 08:18:13 -0700
Received: by iwn8 with SMTP id 8so4813426iwn.36
        for <linux-mips@linux-mips.org>; Sat, 30 Oct 2010 08:18:01 -0700 (PDT)
Received: by 10.231.30.74 with SMTP id t10mr11997644ibc.171.1288451881786;
 Sat, 30 Oct 2010 08:18:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.231.14.134 with HTTP; Sat, 30 Oct 2010 08:17:41 -0700 (PDT)
In-Reply-To: <AANLkTikXAde1yLZkB80GOjWu-sFZAvv0SL566rWssD1k@mail.gmail.com>
References: <4CCBC8B1.2080808@in.ibm.com> <AANLkTimE=uzwhDMz_-jVWKyb9NAONGuVvVo5KbjkkZVu@mail.gmail.com>
 <AANLkTikXAde1yLZkB80GOjWu-sFZAvv0SL566rWssD1k@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Oct 2010 08:17:41 -0700
Message-ID: <AANLkTinBNAUAh5uZ9V82zjv4uWH1UTXbUA2rPy1d2pCk@mail.gmail.com>
Subject: Re: [s390] 2.6.36-git14 build break - fs/compat.c :631
 (PAGE_CACHE_MASK undeclared)
To:     wu zhangjin <wuzhangjin@gmail.com>
Cc:     Sachin Sant <sachinp@in.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390@vger.kernel.org, linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <torvalds@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 30, 2010 at 1:12 AM, wu zhangjin <wuzhangjin@gmail.com> wrote:
>
> (Seems Linus added that patch, add him in this loop)

My bad. It was such a totally obvious and trivial patch, and it
compiled for me on x86-64. Too bad our header include dependencies are
such a mess, and actually change from one architecture to another.

I'd love to fix up the header mess, but that's not going to happen. So
I'll take the <linux/filemap.h> addition.

Thanks,

                                  Linus
