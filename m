Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2012 07:39:27 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:53122 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1901761Ab2FFFjX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 6 Jun 2012 07:39:23 +0200
Message-ID: <4FCEECE8.8010901@phrozen.org>
Date:   Wed, 06 Jun 2012 07:38:48 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH 15/35] MIPS: lantiq: Cleanup files effected by firmware
 changes.
References: <1338931179-9611-1-git-send-email-sjhill@mips.com> <1338931179-9611-16-git-send-email-sjhill@mips.com>
In-Reply-To: <1338931179-9611-16-git-send-email-sjhill@mips.com>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33559
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

On 05/06/12 23:19, Steven J. Hill wrote:
> From: "Steven J. Hill" <sjhill@mips.com>
> 
> Make headers consistent across the files and make changes based on
> running the checkpatch script.


i dont see any checkpatch related changes


> 
> Signed-off-by: Steven J. Hill <sjhill@mips.com>
> ---
>  arch/mips/lantiq/prom.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
> index aa9da9e..56470c6 100644
> --- a/arch/mips/lantiq/prom.c
> +++ b/arch/mips/lantiq/prom.c
> @@ -1,15 +1,15 @@
>  /*
> - *  This program is free software; you can redistribute it and/or modify it
> - *  under the terms of the GNU General Public License version 2 as published
> - *  by the Free Software Foundation.
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
>   *

The change in License is not related to the Subject / commit message.

Why do you change the license in the first place ? the code was GPLv2
and after your change it only GPL ?

NAK on this one ...


>   * Copyright (C) 2010 John Crispin <blogic@openwrt.org>
> + * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.

Does a include fixup justify a Copyright holder change ?


>   */
> -
>  #include <linux/export.h>
>  #include <linux/clk.h>
>  #include <linux/of_platform.h>
> -#include <asm/time.h>
> +#include <linux/time.h>
>  
>  #include <asm/fw/fw.h>
>  #include <lantiq.h>
