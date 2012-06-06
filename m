Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2012 13:39:00 +0200 (CEST)
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49]:44072 "EHLO
        mail-lpp01m010-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903693Ab2FFLix (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2012 13:38:53 +0200
Received: by laap9 with SMTP id p9so5431394laa.36
        for <linux-mips@linux-mips.org>; Wed, 06 Jun 2012 04:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=echVHvWgnlwZVC3szW0NdIatkZFHnnb6bvVPbWSD050=;
        b=A8Skxntx00QwhJzY1Zht2emH/JN8Urx1CuHxF08fVj4CA8DF0ybwBx+lN3dLxjKOlM
         y8QNDobADECMJZw6O/0qB/+xfJHRat/fadCaSaZ5zS0j10THiGFbRqieDQlWp0V8l1oh
         8AHJWMiKxDnQVf5BhKK03o3AP0qNK+zuA4q08dyOIFCKwY9mGqzhh7k/pRxBJgFnQkwz
         CgPgFgMkJEYWUfJT6N1YRoDaVHkIcY1YQPD+qGlhp3UstWh9C1oiZYspqIvuBAYGxThK
         +K3ANHKPi+BXNs/clXIdauy3F7G5CpDZd5hj2N5kEv7Gi2KjnEq9u5iAlWZ76S28L+vi
         D3JA==
Received: by 10.112.43.67 with SMTP id u3mr9765833lbl.16.1338982728117;
        Wed, 06 Jun 2012 04:38:48 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-86-181.pppoe.mtu-net.ru. [91.79.86.181])
        by mx.google.com with ESMTPS id hz16sm2441386lab.6.2012.06.06.04.38.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 04:38:47 -0700 (PDT)
Message-ID: <4FCF4129.2010308@mvista.com>
Date:   Wed, 06 Jun 2012 15:38:17 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 13/35] MIPS: jz4740: Cleanup files effected by firmware
 changes.
References: <1338931179-9611-1-git-send-email-sjhill@mips.com> <1338931179-9611-14-git-send-email-sjhill@mips.com>
In-Reply-To: <1338931179-9611-14-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQlh3uqdiKw/6Cz8+P2ZDXCa6iuXnslJlfXK1XhPZsEj34Qz5mU1cQUv757SWgRNG26OGxSk
X-archive-position: 33567
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
>   arch/mips/jz4740/prom.c |   25 +++++++++----------------
>   1 file changed, 9 insertions(+), 16 deletions(-)

> diff --git a/arch/mips/jz4740/prom.c b/arch/mips/jz4740/prom.c
> index c5071ab..ea86605 100644
> --- a/arch/mips/jz4740/prom.c
> +++ b/arch/mips/jz4740/prom.c
> @@ -1,23 +1,14 @@
>   /*
> - *  Copyright (C) 2010, Lars-Peter Clausen<lars@metafoo.de>
> - *  JZ4740 SoC prom code
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
>   *
> - *  This program is free software; you can redistribute it and/or modify it
> - *  under  the terms of the GNU General  Public License as published by the
> - *  Free Software Foundation;  either version 2 of the License, or (at your
> - *  option) any later version.
> - *
> - *  You should have received a copy of the GNU General Public License along
> - *  with this program; if not, write to the Free Software Foundation, Inc.,
> - *  675 Mass Ave, Cambridge, MA 02139, USA.
> + *  JZ4740 SoC prom code
>   *
> + *  Copyright (C) 2010, Lars-Peter Clausen<lars@metafoo.de>
> + *  Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
>    */
> -
>   #include<linux/module.h>
> -#include<linux/kernel.h>
> -#include<linux/init.h>

    This header is needed explicitly because '__init' qualifier is used.
Documentation/SubmitChecklist says:

1: If you use a facility then #include the file that defines/declares
    that facility.  Don't depend on other header files pulling in ones
    that you use.

WBR, Sergei
