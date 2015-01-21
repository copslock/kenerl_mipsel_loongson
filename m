Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 18:58:21 +0100 (CET)
Received: from mail-ie0-f182.google.com ([209.85.223.182]:62372 "EHLO
        mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008667AbbAUR6Tqfq-q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jan 2015 18:58:19 +0100
Received: by mail-ie0-f182.google.com with SMTP id ar1so11963909iec.13;
        Wed, 21 Jan 2015 09:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=6YWvWGXifjzPhoN9B5ntX2qf3+8k3ylsZ7RiG3Zjiig=;
        b=eYjpSwMTO8269fRJh3zKTauc5a1Gbsmb37eIA6RDuMdtWjZsWXi+DyYZrgkBU3Gc0a
         sYwSC0JHIVqLohmiCaD9rMe1WTWaRFzlC8QwvmDsQyY2xordcEIMeexNFuM+JANIjm3c
         u+yUfhIZ1Twe/Fz9h0+9VA6kcEF4s7viv/xsIV+86Um0fNzK+x3Ic+arNGGsGyAH+Ne9
         YvMEebL9Elz5Y4wbYTPlceMHDosoXKZ6MCiRm+kap9FGwtUUqyiuRyIA7alLWWZCGGaZ
         j45INnvNyR86FLv7n89TCnqO+c6/KKIe+mm+fJNWIgCdiJI78lMfFW3chbbkup/KSLOy
         DQTQ==
X-Received: by 10.50.138.40 with SMTP id qn8mr6235158igb.27.1421863093744;
        Wed, 21 Jan 2015 09:58:13 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id t8sm6362023igs.21.2015.01.21.09.58.12
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 21 Jan 2015 09:58:13 -0800 (PST)
Message-ID: <54BFE8B4.7060506@gmail.com>
Date:   Wed, 21 Jan 2015 09:58:12 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>
CC:     linux-mips@linux-mips.org, Paul Burton <paul.burton@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: asm: asmmacro: Replace "add" instructions with
 "addu"
References: <1421853983-28858-1-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1421853983-28858-1-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45416
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

On 01/21/2015 07:26 AM, Markos Chandras wrote:
> The "add" instruction is actually a macro in binutils and depending on
> the size of the immediate it can expand to an "addi" instruction.
> However, the "addi" instruction traps on overflows which is not
> something we want on address calculation.
>

I like it:

Acked-by: David Daney <david.daney@cavium.com>


> Link: http://www.linux-mips.org/archives/linux-mips/2015-01/msg00121.html
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: Maciej W. Rozycki <macro@linux-mips.org>
> Cc: <stable@vger.kernel.org> # v3.15+

Is it causing problems with existing kernels, or is it only in 
preparation for MIPS r6?  If the later, it probably isn't stable material.


> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
> Moving this out of the R6 patchset as requested by Maciej
> ---
>   arch/mips/include/asm/asmmacro.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
> index fe08084f5adb..42b90c9fd756 100644
> --- a/arch/mips/include/asm/asmmacro.h
> +++ b/arch/mips/include/asm/asmmacro.h
> @@ -304,7 +304,7 @@
>   	.set	push
>   	.set	noat
>   	SET_HARDFLOAT
> -	add	$1, \base, \off
> +	addu	$1, \base, \off
>   	.word	LDD_MSA_INSN | (\wd << 6)
>   	.set	pop
>   	.endm
> @@ -313,7 +313,7 @@
>   	.set	push
>   	.set	noat
>   	SET_HARDFLOAT
> -	add	$1, \base, \off
> +	addu	$1, \base, \off
>   	.word	STD_MSA_INSN | (\wd << 6)
>   	.set	pop
>   	.endm
>
