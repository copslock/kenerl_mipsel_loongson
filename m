Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 13:14:02 +0200 (CEST)
Received: from mail-la0-f46.google.com ([209.85.215.46]:32848 "EHLO
        mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822680Ab3FTLOAu6nmR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Jun 2013 13:14:00 +0200
Received: by mail-la0-f46.google.com with SMTP id eg20so5547143lab.19
        for <linux-mips@linux-mips.org>; Thu, 20 Jun 2013 04:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=BiE4QDLI/Kq/1MnGh/xmxU8EmSOg0+OGOT4bo8zIKx8=;
        b=UhBsX9JPLejN2GKxQ3TXkkRyS/Cxarp4p6CZpkpq7ksvaGAJ1OYSqPvCDVsNMrKH7/
         bOw1pan3fDCfBAEh4ueIXp2dTpGHUCv9gi/YspzDGwZzve/bvxnoNCeEnML+MWi0vodM
         EehcFmwcvJ01DgA8YRe9IUTdtzoGlNaz8rdFxx3O4q8pElSlMqER4aBLdqfb/RI3BSwJ
         D+8OMM3f/BJxX8eK6oWhqsr1VIP6+lzKvUejGdViW8nVGxRlx5FsjUKEEaQRx0sAWN01
         +hYHbHH+cWOg/NpulCYhTM/LxQnnBrGmWXPNYPf03XTnHGNi8cW7UaRNSFUqRwiUGlD1
         ztrw==
X-Received: by 10.152.18.129 with SMTP id w1mr3471637lad.10.1371726834988;
        Thu, 20 Jun 2013 04:13:54 -0700 (PDT)
Received: from [192.168.2.4] (ppp91-76-149-191.pppoe.mtu-net.ru. [91.76.149.191])
        by mx.google.com with ESMTPSA id x5sm170067lbx.8.2013.06.20.04.13.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Jun 2013 04:13:54 -0700 (PDT)
Message-ID: <51C2E3F5.7040507@cogentembedded.com>
Date:   Thu, 20 Jun 2013 15:13:57 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
CC:     linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: Add missing hazard barrier in TLB load handler.
References: <1371707874-6632-1-git-send-email-Steven.Hill@imgtec.com>
In-Reply-To: <1371707874-6632-1-git-send-email-Steven.Hill@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQm+N6UrSu0g/ePTw71n32BZK4KnJV8dQdDhT4211SHOZkQfIgSNPblFf3bADgyTMQzSaWYi
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 20-06-2013 9:57, Steven J. Hill wrote:

> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

> MIPS R2 documents state that an execution hazard barrier is needed
> after a TLBR before reading EntryLo.

> Change-Id: Idef3b6abbb63a1bbd5e153c6110a979fa7bd5896

    Sigh...

> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
> ---
>   arch/mips/mm/tlbex.c |   10 ++++++++++
>   1 files changed, 10 insertions(+), 0 deletions(-)

> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index d9969d2..5ef426c 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -1922,6 +1922,11 @@ static void build_r4000_tlb_load_handler(void)
>   		uasm_i_nop(&p);
>
>   		uasm_i_tlbr(&p);
> +#if !defined(CONFIG_CPU_CAVIUM_OCTEON)

     Suggesting to use if (!IS_ENABLED(CONFIG_CPU_CAVIUM_OCTEON)) to 
avoid #ifdef...

> +		/* hazard barrier after TLBR but before read EntryLo */
> +		if (cpu_has_mips_r2)
> +			uasm_i_ehb(&p);
> +#endif
>   		/* Examine  entrylo 0 or 1 based on ptr. */
>   		if (use_bbit_insns()) {
>   			uasm_i_bbit0(&p, wr.r2, ilog2(sizeof(pte_t)), 8);
> @@ -1976,6 +1981,11 @@ static void build_r4000_tlb_load_handler(void)
>   		uasm_i_nop(&p);
>
>   		uasm_i_tlbr(&p);
> +#if !defined(CONFIG_CPU_CAVIUM_OCTEON)

    Same here.

> +		/* hazard barrier after TLBR but before read EntryLo */
> +		if (cpu_has_mips_r2)
> +			uasm_i_ehb(&p);
> +#endif

WBR, Sergei
