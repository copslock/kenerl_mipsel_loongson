Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2012 12:14:31 +0200 (CEST)
Received: from mail-gh0-f177.google.com ([209.85.160.177]:42651 "EHLO
        mail-gh0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6892001Ab2JDKOOiuPjm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2012 12:14:14 +0200
Received: by mail-gh0-f177.google.com with SMTP id f20so39504ghb.36
        for <multiple recipients>; Thu, 04 Oct 2012 03:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pWr8IvVNlvAgqinVJoHCR0zLA+OnJMgO7FoVhRPj+FU=;
        b=q/4RLp5x0K1Bqg4AS7dwVVBNfsPNKcWfKMcGKyb4A7zw8aZPeDmKmjwCor31Xn7o/6
         vtz99OLQvjf2Y1preNa6l2YnAx514plhvjngmdrqyvARYS3mo2a6aVTb01a4BoCXLNp4
         LJdF2MY+ZO6s/NLd9oYSn0L+jS5TfhtyboF2Fr/xea7rUacvku7/KL9sqe5FNV+u4m5H
         4C0kisHhUcxHeKcHSUrG+dZs/LyMCg0hpxGvrKX0lifYOUHA1uwCLcw+kbxQuGqTwdCU
         Sr0pdpsjDt7nby3IE/TYJxqZjOElloCIYwQ7riAKC3Y5QiD7hgcEmwQUrSNfkVJtZ21B
         uFiQ==
Received: by 10.101.132.11 with SMTP id j11mr639573ann.65.1349277737729; Wed,
 03 Oct 2012 08:22:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.176.229 with HTTP; Wed, 3 Oct 2012 08:21:37 -0700 (PDT)
In-Reply-To: <1349276601-8371-26-git-send-email-florian@openwrt.org>
References: <1349276601-8371-1-git-send-email-florian@openwrt.org> <1349276601-8371-26-git-send-email-florian@openwrt.org>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Wed, 3 Oct 2012 17:21:37 +0200
Message-ID: <CAOLZvyHyQGZ=Rs1=k07Saq16aZcntUe8N0Fc5iMoeOTeMpjcSw@mail.gmail.com>
Subject: Re: [PATCH 24/25] MIPS: Alchemy: use the OHCI platform driver
To:     Florian Fainelli <florian@openwrt.org>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Thomas Meyer <thomas@m3y3r.de>,
        "David S. Miller" <davem@davemloft.net>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34585
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, Oct 3, 2012 at 5:03 PM, Florian Fainelli <florian@openwrt.org> wrote:
> This also greatly simplifies the power_{on,off} callbacks and make them
> work on platform device id instead of checking the OHCI controller base
> address like what was done in ohci-au1xxx.c.

That was by design -- the base address is far more reliable in identifying the
correct controller instance than the platform device id.   There are systems
in the field which don't use the alchemy/common/platform.c file at all.


Manuel
