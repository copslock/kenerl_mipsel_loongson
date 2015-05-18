Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 May 2015 22:51:56 +0200 (CEST)
Received: from mail-ie0-f177.google.com ([209.85.223.177]:34770 "EHLO
        mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012890AbbERUvy1N5cl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 May 2015 22:51:54 +0200
Received: by ieczm2 with SMTP id zm2so109101811iec.1
        for <linux-mips@linux-mips.org>; Mon, 18 May 2015 13:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=EPo3PNaUHXa4WwmgSThN3bX1rX93EoiF4ni8XddGAxQ=;
        b=iSOQNejxbmM4UfdoSpMAVeIRFAJEX41N3gT6GEPv2yeslG8vwpg3qMQssw9DPK0vVg
         3xNQ3XWo3dteNeglqG25/Z9uwLhuxgpFSOfY8oAZ/vT8uwRWsKWVKFcdSZGH+7wlIHOH
         HBO2D4ebdwOVN8PT76FCKxXOi2HhcqvtXMDi2Mp50XjQ2wSRpYJ94wlaJyZv4LUUXZYl
         1jgNCaw0EYK9VHFoUZy1eSwXrsVwAUV00ShNbV1nghTrF8a83MHS0EVYqLBvynTJyuWx
         suwx9IHHjnmXVWFZ1+WoIHt6CUi6PjeI9af2U2tIQ0digWN1c3R04DhQ7HVaTKulT+gL
         vVIw==
X-Received: by 10.107.28.146 with SMTP id c140mr32636660ioc.67.1431982310816;
        Mon, 18 May 2015 13:51:50 -0700 (PDT)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by mx.google.com with ESMTPSA id i191sm8465863ioe.0.2015.05.18.13.51.48
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 18 May 2015 13:51:49 -0700 (PDT)
Message-ID: <555A50E2.2040802@gmail.com>
Date:   Mon, 18 May 2015 13:51:46 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: asm: spinlock: Adjust arch_spin_lock back-off time
References: <1429523674-4335-1-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1429523674-4335-1-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47463
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

On 04/20/2015 02:54 AM, Markos Chandras wrote:
> Make it similar to the trylock and R10000_LLSC_WAR cases.
>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
> I can't find a reference on why this was different compared to the other
> cases so I presume it was just an overlook in commit
> 2a31b03335e570dce5fdd082e0d71d48b2cb4290

I suspect you are correct.  Although in practice, it doesn't matter.

We are doing a mask of the difference between the ticket and now serving 
values.  You would have to have more than 0x1fff (8191) CPUs in a system 
to hit this limit.

That said, I think the patch is OK.

David Daney


> ---
>   arch/mips/include/asm/spinlock.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/include/asm/spinlock.h b/arch/mips/include/asm/spinlock.h
> index 1fca2e0793dc..cc771a21899d 100644
> --- a/arch/mips/include/asm/spinlock.h
> +++ b/arch/mips/include/asm/spinlock.h
> @@ -109,7 +109,7 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
>   		"	 subu	%[ticket], %[my_ticket], %[ticket]	\n"
>   		"2:							\n"
>   		"	.subsection 2					\n"
> -		"4:	andi	%[ticket], %[ticket], 0x1fff		\n"
> +		"4:	andi	%[ticket], %[ticket], 0xffff		\n"
>   		"	sll	%[ticket], 5				\n"
>   		"							\n"
>   		"6:	bnez	%[ticket], 6b				\n"
>
