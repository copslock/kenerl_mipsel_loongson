Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Aug 2012 01:02:14 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:58418 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903257Ab2H2XCJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Aug 2012 01:02:09 +0200
Received: by pbbrq8 with SMTP id rq8so2108453pbb.36
        for <multiple recipients>; Wed, 29 Aug 2012 16:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Y/LVngYRWoXnWo/P7NMj7nHubXXLOKpcgAbKu5NtL/M=;
        b=o05YYJgySRdVq3JrIMxwb8u7A23TH+JhJvtDId3rT9aV2//f56MeoWwvRoVJMWCLgc
         vW1ca5zSIBSHLtdfnpj9TMtK1vaMsuT/pHrErG8h/jldb+Q+1S3j3EtFOTTF/1e1DXv7
         gPhNE+/pCaMEZ6m8fbKbYtZTFGrDm0+Ja9h8d+/S80V4v+WTIWrWNM7PHk+v9nWPUWhx
         dSUB2AFbbgidzThfcXppSeI8Nc2FlFoj5911L8D73/JFCFXcgDVEDYqoWkkAv6yUOXf6
         U4Li8TKr3rRA8kfgxNGQfXpZnM6DCCV6rNKOlFFlk2tx6tBZWqNT+aK3Rc1LxovHKqD3
         zqZg==
Received: by 10.68.227.169 with SMTP id sb9mr7635120pbc.104.1346281322016;
        Wed, 29 Aug 2012 16:02:02 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ty1sm185632pbc.76.2012.08.29.16.01.59
        (version=SSLv3 cipher=OTHER);
        Wed, 29 Aug 2012 16:02:00 -0700 (PDT)
Message-ID: <503E9F66.9030200@gmail.com>
Date:   Wed, 29 Aug 2012 16:01:58 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
MIME-Version: 1.0
To:     Jim Quinlan <jim2101024@gmail.com>, ralf@linux-mips.org
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH V2 1/2] asm-offsets.c: adding #define to break circular
 dependency
References: <y> <1346279647-27955-1-git-send-email-jim2101024@gmail.com>
In-Reply-To: <1346279647-27955-1-git-send-email-jim2101024@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 08/29/2012 03:34 PM, Jim Quinlan wrote:
> irqflags.h depends on asm-offsets.h, but asm-offsets.h depends
> on irqflags.h when generating asm-offsets.h.

What is there in irqflags.h that is required by asm-offsets.c?

Why can't the include tangle be undone so that that part can be factored 
out to a separate file?



> Adding a definition
> to the top of asm-offsets.c allows us to break this circle.  There
> is a similar define in bounds.c
>
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>   arch/mips/kernel/asm-offsets.c |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
> index 6b30fb2..035f167 100644
> --- a/arch/mips/kernel/asm-offsets.c
> +++ b/arch/mips/kernel/asm-offsets.c
> @@ -8,6 +8,7 @@
>    * Kevin Kissell, kevink@mips.com and Carsten Langgaard, carstenl@mips.com
>    * Copyright (C) 2000 MIPS Technologies, Inc.
>    */
> +#define __GENERATING_OFFSETS_S
>   #include <linux/compat.h>
>   #include <linux/types.h>
>   #include <linux/sched.h>
>
