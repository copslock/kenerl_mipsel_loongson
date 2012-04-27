Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Apr 2012 19:03:36 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:63386 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903618Ab2D0RDU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Apr 2012 19:03:20 +0200
Received: by pbbrq13 with SMTP id rq13so1317634pbb.36
        for <multiple recipients>; Fri, 27 Apr 2012 10:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=IFc4uBfoYdArzZ9SB72P6FBMe9//6Us6PcJJ5HcwYiA=;
        b=0Ees0UGDOAIxsyXoXp/CnH8CSO+TpiqdFT9+FU4M7+GQPBl04hv/TDLK9/kt5E5o4b
         cLWTrhHRUb7s2mLFGnM+W6pFEEc9KsX0E82+wvA88DOAXZse5i4Js7vQXPVw54eJgP/M
         h7IY2PuxtBg1tQRpeal9wDRUj7hMJ+FebP64vY2HK9pdaRqUQlsdr7AB9roeYJmzYa2g
         gfLDfGumiKlOHRprLWi5z6Ed6tWWXQ3Df2545RF6XL/gWWlenr0A4z+B9HCkXSFOYZbk
         6hf1wiB8dwREihGcUGTs1WEP8yc+pkHMcwbRwyCIOlQaNfqlCwLq4I0wglvJ3YTtv0a4
         CHgw==
Received: by 10.68.132.197 with SMTP id ow5mr885143pbb.165.1335546193319;
        Fri, 27 Apr 2012 10:03:13 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ip6sm6983540pbc.16.2012.04.27.10.03.11
        (version=SSLv3 cipher=OTHER);
        Fri, 27 Apr 2012 10:03:12 -0700 (PDT)
Message-ID: <4F9AD14E.9060008@gmail.com>
Date:   Fri, 27 Apr 2012 10:03:10 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Artem Bityutskiy <dedekind1@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     MIPS Mailing List <linux-mips@linux-mips.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH 1/2] MIPS: Kbuild: remove -Werror
References: <1335534510-12573-1-git-send-email-dedekind1@gmail.com>
In-Reply-To: <1335534510-12573-1-git-send-email-dedekind1@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 33028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 04/27/2012 06:48 AM, Artem Bityutskiy wrote:
> From: Artem Bityutskiy<artem.bityutskiy@linux.intel.com>
>
> MIPS build fails with the standard W=1 Kbuild switch with because of the
> -Werror gcc switch.
>
> This patch removes the gcc switch to make W=1 work. Mips is the only
> architecture I know which does not build with W=1 and this upsets my aiaiai
> scripts. And in general, you never know which warnings newer versions of gcc
> will start emiting so having -Werror by default is not the best idea.
>
> Signed-off-by: Artem Bityutskiy<artem.bityutskiy@linux.intel.com>

I think the warning messages are enough, we don't need to break things.

Acked-by: David Daney <david.daney@cavium.com>

> ---
>   arch/mips/Kbuild |    5 -----
>   1 files changed, 0 insertions(+), 5 deletions(-)
>
> diff --git a/arch/mips/Kbuild b/arch/mips/Kbuild
> index 7dd65cf..0d37730 100644
> --- a/arch/mips/Kbuild
> +++ b/arch/mips/Kbuild
> @@ -1,8 +1,3 @@
> -# Fail on warnings - also for files referenced in subdirs
> -# -Werror can be disabled for specific files using:
> -# CFLAGS_<file.o>  := -Wno-error
> -subdir-ccflags-y := -Werror
> -
>   # platform specific definitions
>   include arch/mips/Kbuild.platforms
>   obj-y := $(platform-y)
