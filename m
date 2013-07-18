Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jul 2013 19:30:42 +0200 (CEST)
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35807 "EHLO
        mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835855Ab3GRRUBEhxSy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jul 2013 19:20:01 +0200
Received: by mail-pd0-f169.google.com with SMTP id y10so3319161pdj.0
        for <multiple recipients>; Thu, 18 Jul 2013 10:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ruwju3mvtyshQ8dZfPrpPe9lgXeSWFFcw9R7mwPrJ0Q=;
        b=HE6L6QP0/KvDa6DEr3DlIaqdqaihFrlfyQ3UWAJ2y7FM20P37O/DXLi7jCHpuLoFU4
         fRMxEg9V59C8nL9SQut+BYXhaYWbs/SktQy6Red9Y/ajT6psOJ6IYBtMEZPk+nbEfjHU
         YKKKr43VQCHaXdpp7yuFedJLnS5oLW0kg+f53lwqKRc1FUIDtBBWNXAApr2RSPlEM5YA
         9m0OmImcbhaN/1BsOKsgIAMTEMhstkG0I9c8IuYzGfI0cTmMcr9o4AR155pEOXgSezLS
         xp0HAw2qeSTjRgLsf9Pn/lGRnNW9eZr3Do5IRjl23AJJzF+Jv6Bkvp9bai2TCm7bjure
         UUiw==
X-Received: by 10.68.1.226 with SMTP id 2mr12869173pbp.150.1374167993574;
        Thu, 18 Jul 2013 10:19:53 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id mr3sm14812313pbb.27.2013.07.18.10.19.51
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 10:19:52 -0700 (PDT)
Message-ID: <51E823B7.6040200@gmail.com>
Date:   Thu, 18 Jul 2013 10:19:51 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: tlbex: fix broken build in v3.11-rc1
References: <1373876517-14646-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1373876517-14646-1-git-send-email-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37318
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

On 07/15/2013 01:21 AM, Aaro Koskinen wrote:
> Commit 6ba045f9fbdafb48da42aa8576ea7a3980443136 (MIPS: Move generated code
> to .text for microMIPS) deleted tlbmiss_handler_setup_pgd_array, but some
> references were not converted. Fix that to enable building a MIPS kernel.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Yes, this appears to be needed.

Acked-by: David Daney <david.daney@cavium.com>


> ---
>   arch/mips/mm/tlbex.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index 9ab0f90..cc34521 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -1466,7 +1466,7 @@ static void __cpuinit build_r4000_setup_pgd(void)
>   {
>   	const int a0 = 4;
>   	const int a1 = 5;
> -	u32 *p = tlbmiss_handler_setup_pgd_array;
> +	u32 *p = tlbmiss_handler_setup_pgd;
>   	const int tlbmiss_handler_setup_pgd_size =
>   		tlbmiss_handler_setup_pgd_end - tlbmiss_handler_setup_pgd;
>   	struct uasm_label *l = labels;
>
