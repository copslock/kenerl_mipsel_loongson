Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2012 13:13:04 +0100 (CET)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:60256 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817667Ab2KAMM7sBrR2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Nov 2012 13:12:59 +0100
Received: by mail-lb0-f177.google.com with SMTP id gi11so1693732lbb.36
        for <linux-mips@linux-mips.org>; Thu, 01 Nov 2012 05:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=682SZPIdAXOFOxoxlw801XY/P69lALsAk7tTIWMQMCg=;
        b=cio6tmgAkJZTMrT0AQhqyZX5DOpdXRcjs8mcR6gGujFyh0u90R7+UVZXq2IImul/at
         Z/X/CgwAQ57k7NOvvC4NqEc751Af6bDoPHBW/5Ubm5YNkj644whkP/UxWUebtnCR6M9+
         4ta1OlSK/GjG/1nZrgsHlzkjOPlm3KatYFnJ+icQIgnl+yGg1oAEf9bNC5D4WCegQ3V2
         2tlzHCRRhLlefg/fE7HuBi5rdeDbG8m5epLZ9uLnt3aSgkZrRBt507mBKyDuy7vb1erO
         pD6M4q3rKR4dkf7gdfU4vQHKM8OdU3FUV5O/6AlNkBdtaD1GZcB7w2gZicPkLAo73YYE
         yPQA==
Received: by 10.152.48.111 with SMTP id k15mr36667952lan.17.1351771974171;
        Thu, 01 Nov 2012 05:12:54 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-82-15.pppoe.mtu-net.ru. [91.79.82.15])
        by mx.google.com with ESMTPS id y10sm2254561lbg.4.2012.11.01.05.12.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2012 05:12:53 -0700 (PDT)
Message-ID: <509266FC.60909@mvista.com>
Date:   Thu, 01 Nov 2012 16:11:40 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
MIME-Version: 1.0
To:     Sanjay Lal <sanjayl@kymasys.com>
CC:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 14/20] MIPS: Use the UM bit instead of the CU0 enable
 bit in the status register to figure out the stack for  saving regs.
References: <6BC12683-224F-4867-818C-FE4CF722B272@kymasys.com>
In-Reply-To: <6BC12683-224F-4867-818C-FE4CF722B272@kymasys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQlTnhEzdanH8W+bhqM3Acmw/5EUbcFhdALkrgXnQgzCJbf9X5WJ7mDAO4D3a60j5qKxv1QZ
X-archive-position: 34841
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

On 31-10-2012 19:20, Sanjay Lal wrote:

> Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
> ---
>   arch/mips/include/asm/stackframe.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

> diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
> index cb41af5..59c9245 100644
> --- a/arch/mips/include/asm/stackframe.h
> +++ b/arch/mips/include/asm/stackframe.h
> @@ -30,7 +30,7 @@
>   #define STATMASK 0x1f
>   #endif
>
> -#ifdef CONFIG_MIPS_MT_SMTC
> +#if defined(CONFIG_MIPS_MT_SMTC) || defined (CONFIG_MIPS_HW_FIBERS)

    Does this change have anything to do with the patch subject?

WBR, Sergei
