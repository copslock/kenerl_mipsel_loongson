Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jun 2017 14:51:19 +0200 (CEST)
Received: from mail-ot0-x242.google.com ([IPv6:2607:f8b0:4003:c0f::242]:34080
        "EHLO mail-ot0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993411AbdFFMtXZXawb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Jun 2017 14:49:23 +0200
Received: by mail-ot0-x242.google.com with SMTP id a2so1968013oth.1
        for <linux-mips@linux-mips.org>; Tue, 06 Jun 2017 05:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=VVGCrzYPYNl9UnSdgl6LGh57Dw+RALCxW2eBYRlY1JU=;
        b=FeGBj3GbM3i1R2sZYlf4dzWOD+GICdaqL4tjkq273zawHxchklogR6ffmhPYKGRTaW
         Gi4qU0mFf8hYuwZbxQzcVOshlY4ZNYVB5yzMyJG2iaE9/lbl2be4nw/OioOftyezru2/
         pUJAM7+9LQUXRMC7ttl1CQZkrFvgZnbOVRknzAShfBiPLSNQfpcNU4TVvEgs2T9DkxCV
         Xi1m7TPgbqf6jRF8swLn7V17IrQ2z4LuWBbSuCi3JQYiy+tqhJiCPwZXWCSQgjX0b88X
         wGUmK5kZ+OyERwyk8rCMXCXE20bFXKDU4wIdcV1Yucs1eKweO6SkZYcu2qvsxr3QDSBK
         vgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=VVGCrzYPYNl9UnSdgl6LGh57Dw+RALCxW2eBYRlY1JU=;
        b=Ma38iYVZIV0LxCQfEbPvYhU3dFKNd4vJr2ur7sPsHKcz3k4a+hwXsEwmb2I1WDhgna
         Mb2G0dptQyt5MrAqMuRK+g9CPeQOMU422qIuw+FwCT+GqAUgRlr1X/PVH7zQ5W+KYMD5
         IV+CPjGh3mJtALC1gm596GY4SeHjLIorX4n4H0TMSYcHb/ASecOaqwmBrLtRyRlF5nc2
         8gowpJ41ZqaPO/WkjOtNvk3pR4DdZa6XhIqKEuxJYoY6zhXuEBoq204DOA11sJh5U2Xl
         loUCAurEAyle6JzEFTqK3hviybgFOn10LM39o7dxMnKIhtvFyinkCM86LrpmjPLcABj1
         H0sg==
X-Gm-Message-State: AODbwcAibwSXrVqg1IbOIy4kXzh+zcYGXe4Z1wXa6GhoJWtx5ylTHGI5
        6Jokcl9wtllU2KWyr+xe7swNltp4TA==
X-Received: by 10.157.50.11 with SMTP id t11mr15432476otc.217.1496753355924;
 Tue, 06 Jun 2017 05:49:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.51.139 with HTTP; Tue, 6 Jun 2017 05:49:15 -0700 (PDT)
In-Reply-To: <20170603141515.9529-2-asarai@suse.de>
References: <20170603141515.9529-1-asarai@suse.de> <20170603141515.9529-2-asarai@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Jun 2017 14:49:15 +0200
X-Google-Sender-Auth: AIGo9HK52MW2xusMwko77acbauY
Message-ID: <CAK8P3a2Y2U58dfAxRYPKQL2-o8ufpkvxxF07c_LCr5DOuQ4=vw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] tty: add compat_ioctl callbacks
To:     Aleksa Sarai <asarai@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-alpha@vger.kernel.org,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-sh@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Valentin Rothberg <vrothberg@suse.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Sat, Jun 3, 2017 at 4:15 PM, Aleksa Sarai <asarai@suse.de> wrote:
> In order to avoid future diversions between fs/compat_ioctl.c and
> drivers/tty/pty.c, define .compat_ioctl callbacks for the relevant
> tty_operations structs. Since both pty_unix98_ioctl() and
> pty_bsd_ioctl() are compatible between 32-bit and 64-bit userspace no
> special translation is required.
>
> Signed-off-by: Aleksa Sarai <asarai@suse.de>

Looks good,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
