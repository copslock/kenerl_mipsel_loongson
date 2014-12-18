Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 20:05:56 +0100 (CET)
Received: from mail-ie0-f182.google.com ([209.85.223.182]:38139 "EHLO
        mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008789AbaLRTFy1j27z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 20:05:54 +0100
Received: by mail-ie0-f182.google.com with SMTP id x19so1693065ier.41;
        Thu, 18 Dec 2014 11:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=KChmpL7jQaNDEk9fSew3elvDGcMcJ776FwWzPY3a5o4=;
        b=0FIonqqVSjfj7nvKOmYkhjVbHMEGu+MMBm+AOMY8OIFKKRl9tprmnv/m4aqE4OD3pR
         c+fUWzVBmmWwBBmnkrOoQQH4Qnyy/RVVVf1klE6UIlwSwZ6iPJCmHeno1/ni3eceyQYo
         gre1LAtuWPt6dUBvwAbRNaklHQzBXiIyglZ0zXkOVZO9g36p2qkRU7t8MXHktiPQNJxx
         JJYtxqWCcHCO60GZnTfDJ22wX21eVZi2v6PcIzZG/Fnylwe/MmlTTeymYSlmeQBPov96
         L3YNFS+TBDxBl2VGE/Lyi1XZiXLJ4MXI8OubNBwElnPoCmRE1e+f5wU1m/K5zLjhMuyZ
         mGQQ==
X-Received: by 10.50.122.73 with SMTP id lq9mr14016161igb.10.1418929548532;
        Thu, 18 Dec 2014 11:05:48 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id n2sm4042676igp.16.2014.12.18.11.05.47
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Dec 2014 11:05:48 -0800 (PST)
Message-ID: <5493258B.30408@gmail.com>
Date:   Thu, 18 Dec 2014 11:05:47 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>
CC:     linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH RFC 40/67] MIPS: mm: tlbex: Add MIPS R6 case for the EHB
 instruction
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com> <1418915416-3196-41-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1418915416-3196-41-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44811
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

On 12/18/2014 07:09 AM, Markos Chandras wrote:
> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>
> The EHB instruction is supported by MIPS R6 so add the relevant
> option.

NAK.

In cpu-features.h we have the symbol cpu_has_mips_r2_exec_hazard.  Use 
that instead.

We need to move all those exceptions for different CPU revisions to the 
CPU probing code so that cpu_has_mips_r2_exec_hazard reports the right 
thing, and then always use cpu_has_mips_r2_exec_hazard.

Also you missed other EHB sites in tlbex.c, so this patch may not 
correct even as is.

David Daney

>
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>   arch/mips/mm/tlbex.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index 14e5fae71a06..8a8a86a8942f 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -501,7 +501,7 @@ static void build_tlb_write_entry(u32 **p, struct uasm_label **l,
>   	case tlb_indexed: tlbw = uasm_i_tlbwi; break;
>   	}
>
> -	if (cpu_has_mips_r2) {
> +	if (cpu_has_mips_r2 || cpu_has_mips_r6) {
>   		/*
>   		 * The architecture spec says an ehb is required here,
>   		 * but a number of cores do not have the hazard and
>
