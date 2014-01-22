Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jan 2014 00:21:37 +0100 (CET)
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33384 "EHLO
        mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825879AbaAVXVfImuS0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jan 2014 00:21:35 +0100
Received: by mail-pd0-f175.google.com with SMTP id w10so995532pde.34
        for <multiple recipients>; Wed, 22 Jan 2014 15:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=bI4yZRoM58k91avb68BO+W1RKvsMc8k+tdjpPrHY2f4=;
        b=jAO/Pae8hytpeJrCtftooPblVeHP+1LuQnuv1ejYsKQ7ERH176JjZiCWsha+JbPKAr
         JhYttlggp95E/vr+l/WtUTXME6kpSFWp+kdx7R6IZ0+8ceLW004Wlf+PCrFC7ZNpBqcM
         UjtmPXIF7EDYt/Xm/c0lOJPRHr0cJnBgqsjz1f7QrsOYvi8IPuTptJh7SVTDlLiZmBXy
         orJpzKCxlloIy9ybRUJSqpwD3TKhEsaao3AnRM0kZ4tFI7A+HIqf+QVSK8Ke3DMH1ZH3
         z3q4hUhg1k3jcXytIgWnZ1AtyTF3uxYRVe6ilIstXjcwyT4EDUXH15TC5HRXNSpVrmP2
         Rstw==
X-Received: by 10.66.149.37 with SMTP id tx5mr4425875pab.81.1390432888171;
 Wed, 22 Jan 2014 15:21:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.68.186.101 with HTTP; Wed, 22 Jan 2014 15:20:47 -0800 (PST)
In-Reply-To: <20140122231113.GE14169@linux-mips.org>
References: <1389812722-30035-1-git-send-email-florian@openwrt.org> <20140122231113.GE14169@linux-mips.org>
From:   Florian Fainelli <florian@openwrt.org>
Date:   Wed, 22 Jan 2014 15:20:47 -0800
X-Google-Sender-Auth: XEJJ6s2T4qm-9-2wvQ6aGciqesw
Message-ID: <CAGVrzcbXBg+XzA=7Ok=nqrFu2TpK130pWkdbS8cp1qHXqc8-Sw@mail.gmail.com>
Subject: Re: [PATCH mips-for-linux-next] MIPS: check for D$ line size and CONFIG_MIPS_L1_SHIFT
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

2014/1/22 Ralf Baechle <ralf@linux-mips.org>:
> On Wed, Jan 15, 2014 at 11:05:22AM -0800, Florian Fainelli wrote:
>
>> When a platform overrides the dcache_line_size detection in its
>> cpu-features-override.h file, check that the value matches
>> (1 << CONFIG_MIPS_L1_SHIFT) to ensure both settings are correct.
>
> Conceptually wrong - the two values serve an entirely different purpose.
> dcache_line_size is used for cache maintenance by the MIPS code while
> CONFIG_MIPS_L1_SHIFT - which has to be a constant due to the way it's
> being used - are being used to define L1_CACHE_SHIFT in <asm/cache.h>
> which in turn is being used primarily to optimize the memory layout of
> various structures for performance - and in case of IP27 we lie, set
> L1_CACHE_SHIFT to 7 which is the size of the S-cache.
>
> On top of that it breaks the ip27 build.
>
> And while we're at it, the use of CONFIG_MIPS_L1_SHIFT in
> arch/mips/kernel/vmlinux.lds.S is fishy - but it needs a constant and
> this should be good enough for all users.

Fair enough, feel free to revert these commits and fix vmlinux.lds.S
while at it.
-- 
Florian
