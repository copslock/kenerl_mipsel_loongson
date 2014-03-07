Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Mar 2014 02:25:07 +0100 (CET)
Received: from mail-qa0-f45.google.com ([209.85.216.45]:54453 "EHLO
        mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823083AbaCGBZE5GBBO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Mar 2014 02:25:04 +0100
Received: by mail-qa0-f45.google.com with SMTP id hw13so3404894qab.18
        for <linux-mips@linux-mips.org>; Thu, 06 Mar 2014 17:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=hxRfcYpNpoiWSGScTcggrZBqQJRHqpZueK4Phig1pEA=;
        b=LuX6ScVsDxZTvrZP2K4zkJhz86twZGQlHMVs+oHpgKncybjZGFFmPK70zPocE+jDun
         zvbWlHlWgFLUKKrCCXVQmfUy7X2ThqRkhoN/o+eozPg0aWNcQSJsieX+XLDmf7Gnz+Ak
         BZqx/IfoEjmGVfcx/N1QHFe/r8aVehOFNrb+h2x0DI6BFjShLWBmKCO91DmWlw/KkgR4
         7dSUPNeoqDa/miUzF9qUjDlpulTDUzmOdZqMPPdGtwQ5pDVL/O01eDGxElPbJnGuRx/o
         B8rv5BQd53t/NiRQFx9uf4H5jplno1JjIloUqyoa1uP1x2sAbMFHq3h6+PIVmhUQFzXv
         IGwA==
X-Received: by 10.224.112.6 with SMTP id u6mr18133286qap.78.1394155498799;
        Thu, 06 Mar 2014 17:24:58 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id u15sm8107721qge.2.2014.03.06.17.24.57
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 06 Mar 2014 17:24:58 -0800 (PST)
Message-ID: <53191FE9.1040606@gmail.com>
Date:   Thu, 06 Mar 2014 17:24:57 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
CC:     linux-mips@linux-mips.org, paul.burton@imgtec.com,
        Leonid.Yegoshin@imgtec.com, Steven.Hill@imgtec.com
Subject: Re: [PATCH] MIPS FPU emulator: Fix prefx detection and COP1X function
 field definition
References: <1394154327-16677-1-git-send-email-dengcheng.zhu@imgtec.com>
In-Reply-To: <1394154327-16677-1-git-send-email-dengcheng.zhu@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39439
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

On 03/06/2014 05:05 PM, Deng-Cheng Zhu wrote:
> From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
>
> When running applications which contain the instruction "prefx" on FPU-less
> CPUs, a message "Illegal instruction" will be seen. This instruction is
> supposed to be ignored by the FPU emulator. However, its current detection
> and function field encoding are incorrect. This patch fix the issue.
>
> Reviewed-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Reviewed-by: Paul Burton <paul.burton@imgtec.com>
> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>

Looks good.

Acked-by: David Daney <david.daney@cavium.com>


> ---
>   arch/mips/include/uapi/asm/inst.h | 4 ++--
>   arch/mips/math-emu/cp1emu.c       | 6 +++---
>   2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
> index b39ba25..0832fac 100644
> --- a/arch/mips/include/uapi/asm/inst.h
> +++ b/arch/mips/include/uapi/asm/inst.h
> @@ -163,8 +163,8 @@ enum cop1_sdw_func {
>    */
>   enum cop1x_func {
>   	lwxc1_op     =	0x00, ldxc1_op	   =  0x01,
> -	pfetch_op    =	0x07, swxc1_op	   =  0x08,
> -	sdxc1_op     =	0x09, madd_s_op	   =  0x20,
> +	swxc1_op     =  0x08, sdxc1_op	   =  0x09,
> +	pfetch_op    =	0x0f, madd_s_op	   =  0x20,
>   	madd_d_op    =	0x21, madd_e_op	   =  0x22,
>   	msub_s_op    =	0x28, msub_d_op	   =  0x29,
>   	msub_e_op    =	0x2a, nmadd_s_op   =  0x30,
> diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
> index 506925b..0b4e2e3 100644
> --- a/arch/mips/math-emu/cp1emu.c
> +++ b/arch/mips/math-emu/cp1emu.c
> @@ -1538,10 +1538,10 @@ static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
>   		break;
>   	}
>
> -	case 0x7:		/* 7 */
> -		if (MIPSInst_FUNC(ir) != pfetch_op) {
> +	case 0x3:
> +		if (MIPSInst_FUNC(ir) != pfetch_op)
>   			return SIGILL;
> -		}
> +
>   		/* ignore prefx operation */
>   		break;
>
>
