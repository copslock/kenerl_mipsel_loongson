Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2012 14:00:48 +0200 (CEST)
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49]:52714 "EHLO
        mail-lpp01m010-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903693Ab2FFMAi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2012 14:00:38 +0200
Received: by laap9 with SMTP id p9so5445843laa.36
        for <linux-mips@linux-mips.org>; Wed, 06 Jun 2012 05:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=k0kNoxVdlgyIFS6sUzcZc810q/vU4ZpqhukRrjGLqe0=;
        b=ZhAKxiRwklLp2mX8poDfSLK01BJ9t8N3POgGm8xRVre+jFsPh5ikDtHC1acrPORHg2
         sGVIDioQ2pdAwaJ7e8YEyVXavyYi6al6KSxCpcBK0fBNtKbrZOWn3ccWqsgXtGhIbpgY
         BtudnW0TUX4nLogIvRnnIEJvxr5MokKiXSZBJHc0PR0UNliFGF/fjhHTOmiuKc+E0A/c
         6djgQvPbjantbaGIguCo6LdejPVH15uFcAazgIWmOyR5pHQ77sjqwcjWbX4Z9IJwCosD
         zNaG+jkDjCa7hWyT99MdFdTnVIffcWjSqAkUCRyfz6mlqWk7Z7Gyo/EWdzC31AgzjmUB
         XJLg==
Received: by 10.112.83.169 with SMTP id r9mr9657841lby.66.1338984032864;
        Wed, 06 Jun 2012 05:00:32 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-86-181.pppoe.mtu-net.ru. [91.79.86.181])
        by mx.google.com with ESMTPS id ta2sm2502470lab.15.2012.06.06.05.00.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 05:00:31 -0700 (PDT)
Message-ID: <4FCF4641.2060906@mvista.com>
Date:   Wed, 06 Jun 2012 16:00:01 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 23/35] MIPS: Netlogic: Cleanup files effected by firmware
 changes.
References: <1338931179-9611-1-git-send-email-sjhill@mips.com> <1338931179-9611-24-git-send-email-sjhill@mips.com>
In-Reply-To: <1338931179-9611-24-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQmuT2w3zAj58ufWx2VHV4r7mgZIaoiOZ2VgbmxuHuaQ4EdBuvL8+ZPIpf6jfIHadc/Ho+0n
X-archive-position: 33569
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

    I don't see any checkpatch.pl induced changes.

> Signed-off-by: Steven J. Hill<sjhill@mips.com>
> ---
>   arch/mips/netlogic/xlr/setup.c |   35 +++++------------------------------
>   1 file changed, 5 insertions(+), 30 deletions(-)
>
> diff --git a/arch/mips/netlogic/xlr/setup.c b/arch/mips/netlogic/xlr/setup.c
> index 113a402..324c071 100644
> --- a/arch/mips/netlogic/xlr/setup.c
> +++ b/arch/mips/netlogic/xlr/setup.c
> @@ -1,37 +1,12 @@
>   /*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *

    You removed the NetLogic license.

>    * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
>    * reserved.
> - *
> - * This software is available to you under a choice of one of two
> - * licenses.  You may choose to be licensed under the terms of the GNU
> - * General Public License (GPL) Version 2, available from the file
> - * COPYING in the main directory of this source tree, or the NetLogic
> - * license below:
> - *
> - * Redistribution and use in source and binary forms, with or without
> - * modification, are permitted provided that the following conditions
> - * are met:
> - *
> - * 1. Redistributions of source code must retain the above copyright
> - *    notice, this list of conditions and the following disclaimer.
> - * 2. Redistributions in binary form must reproduce the above copyright
> - *    notice, this list of conditions and the following disclaimer in
> - *    the documentation and/or other materials provided with the
> - *    distribution.
> - *
> - * THIS SOFTWARE IS PROVIDED BY NETLOGIC ``AS IS'' AND ANY EXPRESS OR
> - * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
> - * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> - * ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE LIABLE
> - * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> - * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
> - * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
> - * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
> - * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
> - * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
> - * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.

    Reshuffling the header is not really a good reason for adding your copyright.

WBR, Sergei
