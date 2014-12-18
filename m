Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 19:56:58 +0100 (CET)
Received: from mail-ie0-f177.google.com ([209.85.223.177]:44413 "EHLO
        mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007227AbaLRS44V1x32 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 19:56:56 +0100
Received: by mail-ie0-f177.google.com with SMTP id rd18so1634671iec.8;
        Thu, 18 Dec 2014 10:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=G+rqRwPUTdV+vpSTbMmTN16oCqGgDC0e4QG7yveUieA=;
        b=oaNe1JrpAQk7tOsKxVzIzrCm7NtJwb0hY+OFid8yJERxfWhvt5dUAnjmjJtS8ziKct
         IF1FMShYulWuZeJfGGWR94H/Z67VHWyqgBrTktxuVSz5JmMbwkSwdjNQjqLyAUaXwexe
         E3x5YX98BsCRgkbm67/U/2cGCLyV98BORyCXqtNIXutFtpO4cT5WHkSbI3Gdd/B81sIs
         G1jeMS6KCkE0BNeRMfIuH7I0nsRWZAhyPDd7R2y0HcU0SuT2Y9I0cXV9NQrLgrNcCbQj
         kMV7oL5D4ATWSwFanDXq3AMigD/EUwYKsvUYuv3Mb/mBQPoxQDM86qrQ27OLlPa928jD
         jjgw==
X-Received: by 10.50.107.36 with SMTP id gz4mr3999350igb.25.1418929010651;
        Thu, 18 Dec 2014 10:56:50 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id j82sm3510852iod.12.2014.12.18.10.56.49
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Dec 2014 10:56:50 -0800 (PST)
Message-ID: <54932370.605@gmail.com>
Date:   Thu, 18 Dec 2014 10:56:48 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH RFC 12/67] MIPS: asm: asmmacro: Replace add instructions
 with "addui"
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com> <1418915416-3196-13-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1418915416-3196-13-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44808
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
> The use of "add" instruction for immediate operations is wrong and
> relies to gas being smart enough to notice that and replace it with
> either addi or addui. However, MIPS R6 removed the addi instruction
> so, fix this problem properly by using the correct instruction
> directly.
>

This is another case of the use of "add" being a real bug.  We should 
never have faulting instructions like this in the kernel.

Can you send all patches in this set that fix this bug as a separate 
patch?  Since they are obviously correct, and really should be used by 
all non-R6 processors, we can get them in sooner that the entire R6 thing.

Thanks,
David Daney

> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>   arch/mips/include/asm/asmmacro.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
> index fe08084f5adb..55c07c40c199 100644
> --- a/arch/mips/include/asm/asmmacro.h
> +++ b/arch/mips/include/asm/asmmacro.h
> @@ -304,7 +304,7 @@
>   	.set	push
>   	.set	noat
>   	SET_HARDFLOAT
> -	add	$1, \base, \off
> +	addiu	$1, \base, \off
>   	.word	LDD_MSA_INSN | (\wd << 6)
>   	.set	pop
>   	.endm
> @@ -313,7 +313,7 @@
>   	.set	push
>   	.set	noat
>   	SET_HARDFLOAT
> -	add	$1, \base, \off
> +	addiu	$1, \base, \off
>   	.word	STD_MSA_INSN | (\wd << 6)
>   	.set	pop
>   	.endm
>
