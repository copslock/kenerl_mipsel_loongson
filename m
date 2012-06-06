Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2012 13:16:44 +0200 (CEST)
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49]:55576 "EHLO
        mail-lpp01m010-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903701Ab2FFLQh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2012 13:16:37 +0200
Received: by laap9 with SMTP id p9so5416610laa.36
        for <linux-mips@linux-mips.org>; Wed, 06 Jun 2012 04:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=sFmgQBUHXrJpgpC3G8PWO8FDqDIWGA2PHVlbjHauysc=;
        b=QDF6zGd1HQuLmalFavrQDLXpbA7c6RDX1d7A0fYpZN36K8moxrVghRxABdjgnegU/b
         lAued9MeByfZ3WeONV9ZCbepYtMphL2siQhEljOUGyIqXhnqjnApuxwzMYJN/mcAW8Cl
         AY92cTDkwBBLOnwR/zgVngqn6YQs3KnRV1E9oRTIfIq+qc/LRZoP/xl+DBy8qIr4Bum6
         XApmjMEjDRk5ZVQvKkDI0BQT+Cn1qS6KXdgB4JmJg1gUJ8IZMrmfR8uIrk+H0r4eqNQq
         /fM9rPMX6ugyGoLHWaXGEEx1MbEI01Oyzjs1zmPLFBOEXjZaZFJTLpXl2fgpIgZT/KMh
         zE4Q==
Received: by 10.112.42.66 with SMTP id m2mr9781104lbl.46.1338981392207;
        Wed, 06 Jun 2012 04:16:32 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-86-181.pppoe.mtu-net.ru. [91.79.86.181])
        by mx.google.com with ESMTPS id hg4sm2354681lab.11.2012.06.06.04.16.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 04:16:30 -0700 (PDT)
Message-ID: <4FCF3BF0.8070405@mvista.com>
Date:   Wed, 06 Jun 2012 15:16:00 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 07/35] MIPS: ath79: Cleanup files effected by firmware
 changes.
References: <1338931179-9611-1-git-send-email-sjhill@mips.com> <1338931179-9611-8-git-send-email-sjhill@mips.com>
In-Reply-To: <1338931179-9611-8-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQmy+1Ice67bCCo/veZ6KDN0T1IGAhf8iD69avMjrc0yDdd+JAr49xoY/AS2SSXEw6fledQS
X-archive-position: 33565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
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

Hello.

On 06-06-2012 1:19, Steven J. Hill wrote:

> From: "Steven J. Hill"<sjhill@mips.com>

> Make headers consistent across the files and make changes based on
> running the checkpatch script.

> Signed-off-by: Steven J. Hill<sjhill@mips.com>
> ---
>   arch/mips/ath79/prom.c |   13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/arch/mips/ath79/prom.c b/arch/mips/ath79/prom.c
> index adbe614..9ead18a 100644
> --- a/arch/mips/ath79/prom.c
> +++ b/arch/mips/ath79/prom.c
> @@ -1,18 +1,15 @@
>   /*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *

    Why move/change this text at all?

>    *  Atheros AR71XX/AR724X/AR913X specific prom routines
>    *
>    *  Copyright (C) 2008-2010 Gabor Juhos<juhosg@openwrt.org>
>    *  Copyright (C) 2008 Imre Kaloz<kaloz@openwrt.org>
> - *
> - *  This program is free software; you can redistribute it and/or modify it
> - *  under the terms of the GNU General Public License version 2 as published
> - *  by the Free Software Foundation.
> + *  Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
>    */
> -
> -#include<linux/kernel.h>
> -#include<linux/init.h>
>   #include<linux/io.h>
> -#include<linux/string.h>

    Removing a few #include's doesn't justify copyrighting the file. You 
generally need to do some substantial change (some people say about 1/3) to 
the file to claim the copyright.

WBR, Sergei
