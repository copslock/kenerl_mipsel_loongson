Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Nov 2013 21:58:37 +0100 (CET)
Received: from mail-ie0-f169.google.com ([209.85.223.169]:65352 "EHLO
        mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817179Ab3K0U6fmkb7M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Nov 2013 21:58:35 +0100
Received: by mail-ie0-f169.google.com with SMTP id e14so13256184iej.28
        for <multiple recipients>; Wed, 27 Nov 2013 12:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=i8XvftrUHieCN6j9pTEdSMWn9YHWTse9fx3Wx5DkSEc=;
        b=auClh7JYIOWEzIX+JzfyZi07CQd1BNqKf4osuE9rDJaY7p2vpL73dkkoRgXoVb0k0g
         JOFYyAy07iNYwutTLN9xwcl7FCxZzcrBa/V+rfljB1psLqtakVJayxaoMwFus+Om1Vzf
         lEj4pvA7vLrayVVM2gRtyJCq3hSSSgNiVBVpB2jnPJxPUSGE+S8/4LMzdFt85WW4ZZ61
         PMnLXh/AT+YSt+8Rw3FjNYLNGnW4Csio8HBdRMYTg0W1wYZ5Cqjf+8zz5rQxdlZsXrIC
         udEDaVFQ2AWX/OpJ3OqWhQGfjNxxhcS65uLXGBp960hgtZ6vGtkcekcydy4b8F/qEc70
         eudw==
X-Received: by 10.50.30.166 with SMTP id t6mr4894552igh.7.1385585909135;
        Wed, 27 Nov 2013 12:58:29 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id p14sm40316964igr.7.2013.11.27.12.58.27
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 27 Nov 2013 12:58:28 -0800 (PST)
Message-ID: <52965CF2.20005@gmail.com>
Date:   Wed, 27 Nov 2013 12:58:26 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Jim Quinlan <jim2101024@gmail.com>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org, cernekee@gmail.com
Subject: Re: [PATCH] MIPS: make local_irq_disable macro safe for non-mipsr2
References: <1385584490-20589-1-git-send-email-jim2101024@gmail.com>
In-Reply-To: <1385584490-20589-1-git-send-email-jim2101024@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38590
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

On 11/27/2013 12:34 PM, Jim Quinlan wrote:
> For non-mipsr2 processors, the local_irq_disable contains an mfc0-mtc0
> pair with instructions inbetween.  With preemption enabled, this sequence
> may get preempted and effect a stale value of CP0_STATUS when executing
> the mtc0 instruction.  This commit avoids this scenario by incrementing
> the preempt count before the mfc0 and decrementing it after the mtc9.
>
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>   arch/mips/include/asm/asmmacro.h |   11 +++++++++++
>   1 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
> index 6c8342a..3f809a4 100644
> --- a/arch/mips/include/asm/asmmacro.h
> +++ b/arch/mips/include/asm/asmmacro.h
> @@ -9,6 +9,7 @@
>   #define _ASM_ASMMACRO_H
>
>   #include <asm/hazards.h>
> +//#include <asm/asm-offsets.h>

I'm guessing it didn't pass checkpatch.pl

>
>   #ifdef CONFIG_32BIT
>   #include <asm/asmmacro-32.h>
> @@ -54,11 +55,21 @@
>   	.endm
>
>   	.macro	local_irq_disable reg=t0
> +#ifdef CONFIG_PREEMPT
> +	lw      \reg, TI_PRE_COUNT($28)
> +	addi    \reg, \reg, 1
> +	sw      \reg, TI_PRE_COUNT($28)
> +#endif

Does this need to be atomic?

More importantly, how does that prevent the problem you describe?

An interrupt can still occur between the mfc0 and mtc0 causing Status 
bits to be changed.  What bits do we care about?  is it IM*, I doubt you 
would see CU* changing.

Which bits are getting clobbered that shouldn't be?


>   	mfc0	\reg, CP0_STATUS
>   	ori	\reg, \reg, 1
>   	xori	\reg, \reg, 1
>   	mtc0	\reg, CP0_STATUS
>   	irq_disable_hazard
> +#ifdef CONFIG_PREEMPT
> +	lw      \reg, TI_PRE_COUNT($28)
> +	addi    \reg, \reg, -1
> +	sw      \reg, TI_PRE_COUNT($28)
> +#endif
>   	.endm
>   #endif /* CONFIG_MIPS_MT_SMTC */
>
>
