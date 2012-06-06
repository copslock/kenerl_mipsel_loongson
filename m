Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2012 04:14:51 +0200 (CEST)
Received: from mail-wi0-f169.google.com ([209.85.212.169]:60812 "EHLO
        mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901351Ab2FFCOo convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 6 Jun 2012 04:14:44 +0200
Received: by wibhn14 with SMTP id hn14so3649240wib.0
        for <multiple recipients>; Tue, 05 Jun 2012 19:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WunF15KMlx/ITZq0G/k0BxX3A3ypS3lK4JFSKmc7jVI=;
        b=eHjZ+5DGg/7dKxuP4ktlgTH4KnPO/Au0BcMtU4XSa3OLtK8kthS2u+hif3F/mlS2TS
         vEZi/FfXtFNXg4egTPunS69JoTDyqfSFACYJaLYu6ptfd0ir/2Rzh4zlaxR+UiRMARG2
         lkpmV7UYqNEQjq6+77+lLxMxprHJPKheCrq2JgGCWsG0u9yQ8g24Oo2GijhiRJJoVsQ/
         ofC48OM+WBE4pbQW8yGKcV/2dM4P70IjStUEmTNWyME0B3d4ZG4DCzk2VKuY9e3HL2tG
         BblN67aTUiLsWKDlJZsSvh5xP3FEpwue2CqN6hPCI8S2+2mvMKHmI+4bSshMqbQyjdV3
         ypKg==
MIME-Version: 1.0
Received: by 10.216.213.79 with SMTP id z57mr15490279weo.27.1338948879127;
 Tue, 05 Jun 2012 19:14:39 -0700 (PDT)
Received: by 10.180.84.136 with HTTP; Tue, 5 Jun 2012 19:14:39 -0700 (PDT)
In-Reply-To: <1338931179-9611-36-git-send-email-sjhill@mips.com>
References: <1338931179-9611-1-git-send-email-sjhill@mips.com>
        <1338931179-9611-36-git-send-email-sjhill@mips.com>
Date:   Wed, 6 Jun 2012 11:14:39 +0900
X-Google-Sender-Auth: JpJgQ4iHuymhbnkdBDYZiR5f3_o
Message-ID: <CACBHAewrmejSTYdx5A95GqHmAt8ovBTzedE2w+LCE9aTf3tQuw@mail.gmail.com>
Subject: Re: [PATCH 35/35] MIPS: vr41xx: Cleanup files effected by firmware changes.
From:   Yuasa Yoichi <yuasa@linux-mips.org>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 33551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
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

Hi,

2012/6/6 Steven J. Hill <sjhill@mips.com>:
> From: "Steven J. Hill" <sjhill@mips.com>
>
> Make headers consistent across the files and make changes based on
> running the checkpatch script.
>
> Signed-off-by: Steven J. Hill <sjhill@mips.com>
> ---
>  arch/mips/vr41xx/common/init.c |   27 ++++++---------------------
>  1 file changed, 6 insertions(+), 21 deletions(-)
>
> diff --git a/arch/mips/vr41xx/common/init.c b/arch/mips/vr41xx/common/init.c
> index a2fa7f0..783b7f8 100644
> --- a/arch/mips/vr41xx/common/init.c
> +++ b/arch/mips/vr41xx/common/init.c
> @@ -1,30 +1,15 @@
>  /*
> - *  init.c, Common initialization routines for NEC VR4100 series.
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
>  *
> - *  Copyright (C) 2003-2009  Yoichi Yuasa <yuasa@linux-mips.org>
> + * init.c, Common initialization routines for NEC VR4100 series.
>  *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, write to the Free Software
> - *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + * Copyright (C) 2003-2009  Yoichi Yuasa <yuasa@linux-mips.org>
> + * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
>  */
> -#include <linux/init.h>
> -#include <linux/ioport.h>
...
> -#include <linux/string.h>

These are required include files.
Please remove only <linux/irq.h> and <asm/vr41xx/irq.h>

Yoichi
