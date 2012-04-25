Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Apr 2012 15:51:49 +0200 (CEST)
Received: from mail-vx0-f177.google.com ([209.85.220.177]:61856 "EHLO
        mail-vx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903668Ab2DYNvg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Apr 2012 15:51:36 +0200
Received: by vcbf13 with SMTP id f13so71590vcb.36
        for <multiple recipients>; Wed, 25 Apr 2012 06:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hpWF8RCb8bGZO2L2mO83AmvuKxz2kCPeHA3RT7T5UWI=;
        b=fAClRwBkzAt2xnA5aIx314WvDZ5/RPj/VGdt4xMiLzOiZ/I/IfDZcuEjIL4kj+7VTz
         SBfjw4cEiWKiCyUNKe4RElUIkI81IMdMnSJ9/wmXJs1eENAbMqtQ6j6zP2Y/9ENzI1gr
         3DZyzsIQyHgQWCF12fBRqEiMeDqDclY74Y7v9quzhDGcbN/ZFdybJwhPuWt9ynMGkoJz
         qJD702m8bzwU9TWytCgnauz6ce7JYq3sH+D+nyXzKmt1r00CmYf3tW+aK+/JQqgEEuwu
         QusNfNSWEL+37yksIkZnW6VT2aVFUoBtGQ42Dr2Ny3qaQWpBM4rGYYJ7DGvw6JZo9Kwi
         haxw==
MIME-Version: 1.0
Received: by 10.220.150.148 with SMTP id y20mr2651481vcv.26.1335361888907;
 Wed, 25 Apr 2012 06:51:28 -0700 (PDT)
Received: by 10.220.118.131 with HTTP; Wed, 25 Apr 2012 06:51:28 -0700 (PDT)
In-Reply-To: <4F9737D9.9080008@gmail.com>
References: <CAJd=RBBWia26FaPjn5-RvmAy9MBRtF0Bthkc0f7kxEWcFz6=oQ@mail.gmail.com>
        <4F9737D9.9080008@gmail.com>
Date:   Wed, 25 Apr 2012 21:51:28 +0800
Message-ID: <CAJd=RBDFdjQrxxTSVGJ02ocx4PvobKO8ikXZKG_494Xi7x7hug@mail.gmail.com>
Subject: Re: [PATCH 2/3] MIPS: changes in mm for adding THP
From:   Hillf Danton <dhillf@gmail.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 33011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, Apr 25, 2012 at 7:31 AM, David Daney <ddaney.cavm@gmail.com> wrote:
>
> With a change like that, I would like to retest the patches and try to get
> them merged.
>
Good news, thank you, David:)
