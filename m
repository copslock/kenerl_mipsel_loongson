Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Oct 2013 19:40:17 +0200 (CEST)
Received: from mail-oa0-f49.google.com ([209.85.219.49]:56927 "EHLO
        mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823123Ab3JQRkOwY0lN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Oct 2013 19:40:14 +0200
Received: by mail-oa0-f49.google.com with SMTP id j10so1918498oah.22
        for <multiple recipients>; Thu, 17 Oct 2013 10:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=KRc2gKtFW7AogKXlsSonrWIhx+h8AhyXecDjXok+Lbo=;
        b=mA0Oc3+JjJNoLYv0vr8OXVlIcFdwVUmLV9s8rivjIutqNYSmgEB4sPQwNuvHC9+noK
         bAfaBj7X5Tzx6A3yThe0NULnkONkshmCfL7bGw4hXQnjHcmivT8NNGuMCw1Dlr+uBwwF
         eS1c+xj1OaLIqM9H+jRPTwc2zBSA/zvfdnEVl7q+f2OxrsAF2YincdP0e8Nn/HYBbnr4
         zFLBavqmzGgxa+TdWChU4OY819AbBbemqcYbEZuHihUe/7GesKl5mmUUSyeh7dqxOEdt
         YLi5lUTKOO9VoQ5v1u8Cmt2VPfNuZ5E5zbqkY37Ej2XXlDjuffy0en6RIl9Pqod2LvXY
         JVig==
X-Received: by 10.182.144.136 with SMTP id sm8mr3316206obb.63.1382031608761;
        Thu, 17 Oct 2013 10:40:08 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ru3sm76501057obc.2.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 17 Oct 2013 10:40:08 -0700 (PDT)
Message-ID: <526020F6.80704@gmail.com>
Date:   Thu, 17 Oct 2013 10:40:06 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
CC:     linux-mips@linux-mips.org,
        Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>, ralf@linux-mips.org
Subject: Re: [PATCH 2/6] MIPS: APRP: Add VPE loader support for CMP platforms.
References: <1381976070-8413-1-git-send-email-Steven.Hill@imgtec.com> <1381976070-8413-3-git-send-email-Steven.Hill@imgtec.com>
In-Reply-To: <1381976070-8413-3-git-send-email-Steven.Hill@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38366
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

On 10/16/2013 07:14 PM, Steven J. Hill wrote:
> From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
>
> This patch adds VPE loader support for platforms having a CMP.
>
> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
> Reviewed-by: Qais Yousef <Qais.Yousef@imgtec.com>
> ---
>   arch/mips/kernel/Makefile  |    2 +-
>   arch/mips/kernel/vpe-cmp.c |  184 ++++++++++++++++++++++++++++++++++++++++++++
>   arch/mips/kernel/vpe-mt.c  |    4 +
>   3 files changed, 189 insertions(+), 1 deletion(-)
>   create mode 100644 arch/mips/kernel/vpe-cmp.c
>
> diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
> index 51f9117..912eb64 100644
> --- a/arch/mips/kernel/Makefile
> +++ b/arch/mips/kernel/Makefile
> @@ -54,7 +54,7 @@ obj-$(CONFIG_MIPS_MT_SMP)	+= smp-mt.o
>   obj-$(CONFIG_MIPS_CMP)		+= smp-cmp.o
>   obj-$(CONFIG_CPU_MIPSR2)	+= spram.o
>
> -obj-$(CONFIG_MIPS_VPE_LOADER)	+= vpe.o vpe-mt.o
> +obj-$(CONFIG_MIPS_VPE_LOADER)	+= vpe.o vpe-cmp.o vpe-mt.o
>   obj-$(CONFIG_MIPS_VPE_APSP_API) += rtlx.o
>
>   obj-$(CONFIG_I8259)		+= i8259.o
> diff --git a/arch/mips/kernel/vpe-cmp.c b/arch/mips/kernel/vpe-cmp.c
> new file mode 100644
> index 0000000..a5628ca
> --- /dev/null
> +++ b/arch/mips/kernel/vpe-cmp.c
> @@ -0,0 +1,184 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2004, 2005 MIPS Technologies, Inc.  All rights reserved.
> + * Copyright (C) 2013 Imagination Technologies Ltd.
> + */
> +#ifdef CONFIG_MIPS_CMP
> +

Get rid of all these #ifdef.

Use Kconfig symbols in the makefile instead.
