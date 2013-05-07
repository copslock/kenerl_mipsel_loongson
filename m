Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 May 2013 01:01:28 +0200 (CEST)
Received: from mail-da0-f50.google.com ([209.85.210.50]:55856 "EHLO
        mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827412Ab3EGXB052nGZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 May 2013 01:01:26 +0200
Received: by mail-da0-f50.google.com with SMTP id i23so594847dad.23
        for <multiple recipients>; Tue, 07 May 2013 16:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=mXQ29p89LyumZwEtdEJCOozXT6zzKjBgpetL+oH+c7c=;
        b=VSU8T4vVR8Es1DOifRgawYv6Bq7uqsh0pYcZwYqFRcHBLwki2ARlpJnLn4ajMLC2Yd
         2XM7/shFcvzAv3X66ULni08VHUXqa3SpjNFTpq1X7H6B4bTAeEC/stoyQJcRHKrh/SQc
         RS1R18paDSxMa8bQ2B/hzalG6AXaCmFvuXcnZscOfDs5T3upu6CBuWP9+p2g4l3IILFa
         RRi8hKBhtigWiciLUIPhbz+1l/+TA/+2C3xqukJv0yJvITlEc7BKF69CzHXu8nOu9AL6
         oH86zCR+X/RU+/7D7H06GTfZQmlVtYeO0nrHrjUK5WvUW6CRwvGPE8Ex+wPZGWfiLxvo
         jIFw==
X-Received: by 10.66.144.98 with SMTP id sl2mr5173822pab.92.1367967679853;
        Tue, 07 May 2013 16:01:19 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id bs3sm29846891pbb.36.2013.05.07.16.01.18
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 07 May 2013 16:01:18 -0700 (PDT)
Message-ID: <518987BD.7030900@gmail.com>
Date:   Tue, 07 May 2013 16:01:17 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH v99,11/13] MIPS: microMIPS: Optimise 'strncpy' core library
 function.
References: <1354856737-28678-1-git-send-email-sjhill@mips.com> <1354856737-28678-12-git-send-email-sjhill@mips.com>
In-Reply-To: <1354856737-28678-12-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36352
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

On 12/06/2012 09:05 PM, Steven J. Hill wrote:
> From: "Steven J. Hill" <sjhill@mips.com>
>
> Optimise 'strncpy' to use microMIPS instructions and/or optimisations
> for binary size reduction. When the microMIPS ISA is not being used,
> the library function compiles to the original binary code.

This is an untrue statement.  Why mislead us by saying the original 
binary code is obtained?

You don't really explain how the change helps optimization either.


>
> Signed-off-by: Steven J. Hill <sjhill@mips.com>
> ---
>   arch/mips/lib/strncpy_user.S |   28 +++++++++++++++-------------
>   1 file changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/arch/mips/lib/strncpy_user.S b/arch/mips/lib/strncpy_user.S
> index 7201b2f..dea9304 100644
> --- a/arch/mips/lib/strncpy_user.S
> +++ b/arch/mips/lib/strncpy_user.S
> @@ -3,7 +3,8 @@
>    * License.  See the file "COPYING" in the main directory of this archive
>    * for more details.
>    *
> - * Copyright (c) 1996, 1999 by Ralf Baechle
> + * Copyright (C) 1996, 1999 by Ralf Baechle
> + * Copyright (C) 2011 MIPS Technologies, Inc.
>    */
>   #include <linux/errno.h>
>   #include <asm/asm.h>
> @@ -33,22 +34,23 @@ LEAF(__strncpy_from_user_asm)
>   	bnez		v0, .Lfault
>
>   FEXPORT(__strncpy_from_user_nocheck_asm)
> -	move		v0, zero
> -	move		v1, a1
>   	.set		noreorder
> -1:	EX(lbu, t0, (v1), .Lfault)
> +	move		t0, zero
> +	move		v1, a1
> +1:	EX(lbu, v0, (v1), .Lfault)

Look at these changes.  v0 and t0 are not the same thing.  the binary is 
being changed.


>   	PTR_ADDIU	v1, 1
>   	R10KCBARRIER(0(ra))
> -	beqz		t0, 2f
> -	 sb		t0, (a0)
> -	PTR_ADDIU	v0, 1
> -	.set		reorder
> -	PTR_ADDIU	a0, 1
> -	bne		v0, a2, 1b
> -2:	PTR_ADDU	t0, a1, v0
> -	xor		t0, a1
> -	bltz		t0, .Lfault
> +	beqz		v0, 2f
> +	 sb		v0, (a0)
> +	PTR_ADDIU	t0, 1
> +	bne		t0, a2, 1b
> +	 PTR_ADDIU	a0, 1
> +2:	PTR_ADDU	v0, a1, t0
> +	xor		v0, a1
> +	bltz		v0, .Lfault
> +	 nop
>   	jr		ra			# return n
> +	move		v0, t0
>   	END(__strncpy_from_user_asm)
>
>   .Lfault:	li		v0, -EFAULT
>
