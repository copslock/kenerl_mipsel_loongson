Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Mar 2013 19:32:17 +0100 (CET)
Received: from mail-la0-f41.google.com ([209.85.215.41]:42315 "EHLO
        mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834955Ab3CWScQ3CSJc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Mar 2013 19:32:16 +0100
Received: by mail-la0-f41.google.com with SMTP id fo12so9208250lab.14
        for <linux-mips@linux-mips.org>; Sat, 23 Mar 2013 11:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=7wGKlxdkHFLfGfIOIR4qdaP+r6GbBCCmxW5w4f/iJnY=;
        b=Rhrwxk40hrRtDXsNC8OgblqPHKe2gBKGgjkXSA+3GqEJJyUcqHlXdfYfxoPjP7KBDe
         +xKamsFOxmDpYouEqKg3XSe3t8S4Sn20Anbzf2+9dIj/Iy+dYXZ7Sq2wIvZpR3CejEFo
         L5HEMTMlmLgUYKfx1E/GbAkyLdB2JAwxB07QKmMzZlqNe4GqaBw9Mo7fsMum4hDKzZ7b
         vq1SmS4KwEcrxb1zgqg29umIjydfiCPDOS9rAV2pTPyostohiF/lk4pJMmgzo8y60dMz
         9JLYfB1OUCEj6OCTjR5jAV5gwX3vPddYOJOIP6iGmd6p4HM7tCOlOO98pAIjn9hxuA+0
         gnZw==
X-Received: by 10.112.155.9 with SMTP id vs9mr2933072lbb.6.1364063530756;
        Sat, 23 Mar 2013 11:32:10 -0700 (PDT)
Received: from wasted.dev.rtsoft.ru (ppp91-79-81-91.pppoe.mtu-net.ru. [91.79.81.91])
        by mx.google.com with ESMTPS id c10sm2692073lbu.11.2013.03.23.11.32.09
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 23 Mar 2013 11:32:09 -0700 (PDT)
Message-ID: <514E038D.50108@cogentembedded.com>
Date:   Sat, 23 Mar 2013 22:33:33 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Jayachandran C <jchandra@broadcom.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 2/9] MIPS: Netlogic: Remove unused EIMR/EIRR functions
References: <cover.1364062916.git.jchandra@broadcom.com> <9e189bdc53ac2650d22d18f037df89dd2e412be9.1364062916.git.jchandra@broadcom.com>
In-Reply-To: <9e189bdc53ac2650d22d18f037df89dd2e412be9.1364062916.git.jchandra@broadcom.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkJ+6RjuBt3e9IN3gE2yDbYIr/7lGPNo2DNXumeyrg32Jg1rbTmtL+nL7Ec28v7O3vGeeoW
X-archive-position: 35961
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 03/23/2013 09:27 PM, Jayachandran C wrote:

> Remove the definitions of {read,write}_c0_{eirr,eimr}. These functions
> are now unused after the PIC and IRQ code has been updated to use
> optimized EIMR/EIRR functions which work on both 32-bit and 64-bit.
>
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
>   arch/mips/include/asm/netlogic/mips-extns.h |    7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/arch/mips/include/asm/netlogic/mips-extns.h b/arch/mips/include/asm/netlogic/mips-extns.h
> index 69d18a0..f299d31 100644
> --- a/arch/mips/include/asm/netlogic/mips-extns.h
> +++ b/arch/mips/include/asm/netlogic/mips-extns.h
[...]
> @@ -140,7 +136,6 @@ static inline uint64_t read_c0_eirr_and_eimr(void)
>   		".set	pop"
>   		: "=r" (val));
>   #endif
> -

    Unrelated whitespace change.

>   	return val;
>   }
>

WBR, Sergei
