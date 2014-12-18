Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 20:08:23 +0100 (CET)
Received: from mail-ie0-f181.google.com ([209.85.223.181]:61405 "EHLO
        mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008789AbaLRTIVR0M-L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 20:08:21 +0100
Received: by mail-ie0-f181.google.com with SMTP id tp5so1718862ieb.12
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 11:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=qfxu/ILjR5QtM0gGA3juqJUuYAi3d0yGA1IF7HgFoB0=;
        b=UeuSruHrOnjk42AJL3R6wm403QJhW+wRYyE7Ah0mEy6kWyBa4HXWXbvIR6XMh9rdfs
         Wd5Ds2woWD2yQUNvgqyZrTWQeSZ0iZteyym20Ot3XyA3qEqsbWWrDuBCeW5Xj5q+bByC
         fCxcgOYmxM7bz9TnWxl70oRttOKQpG3cUEhXDX0rYt7vFaoFr+qSBJIjeqg8jmZUa1Xf
         Be3vrX+/tYTdFMC9blvqArJox7GNkf4v7NTMStRXvAuL8RHd0mUYc9ELENO3AmLBWTNE
         926dXIFyXTToVPY5Fkd6i2neK39Bm+SNLxp69C97AGVB9OFH5qcakcS/ha0WWDNWyhxL
         2khw==
X-Received: by 10.107.134.212 with SMTP id q81mr3442248ioi.62.1418929695716;
        Thu, 18 Dec 2014 11:08:15 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id hi15sm9596407igb.19.2014.12.18.11.08.14
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Dec 2014 11:08:15 -0800 (PST)
Message-ID: <5493261E.8070004@gmail.com>
Date:   Thu, 18 Dec 2014 11:08:14 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH RFC 57/67] MIPS: kernel: branch: Emulate the BNVC, BNEC
 and BNEZLAC R6 instructions
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com> <1418915416-3196-58-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1418915416-3196-58-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44814
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

On 12/18/2014 07:10 AM, Markos Chandras wrote:
> MIPS R6 uses the <R6 DADDI opcode for the new BNVC, BNEC and
> BNEZLAC instructions.
>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>   arch/mips/include/uapi/asm/inst.h | 2 +-
>   arch/mips/kernel/branch.c         | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
> index b95363e0551f..096f32153ce2 100644
> --- a/arch/mips/include/uapi/asm/inst.h
> +++ b/arch/mips/include/uapi/asm/inst.h
> @@ -25,7 +25,7 @@ enum major_op {
>   	andi_op, ori_op, xori_op, lui_op,
>   	cop0_op, cop1_op, cop2_op, cop1x_op,
>   	beql_op, bnel_op, blezl_op, bgtzl_op,
> -	daddi_op, daddiu_op, ldl_op, ldr_op,
> +	daddi_or_cbcond1_op, daddiu_op, ldl_op, ldr_op,

NAK.

Same as the other one.

This is a kernel ABI document, you cannot remove symbols.



>   	spec2_op, jalx_op, mdmx_op, spec3_op,
>   	lb_op, lh_op, lwl_op, lw_op,
>   	lbu_op, lhu_op, lwr_op, lwu_op,
> diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
> index cf390c76ba95..4cc9070682e1 100644
> --- a/arch/mips/kernel/branch.c
> +++ b/arch/mips/kernel/branch.c
> @@ -790,6 +790,8 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
>   		break;
>   	case addi_or_cbcond0_op:
>   		/* Compact branches: bovc, beqc, beqzalc */
> +	case daddi_or_cbcond1_op:
> +		/* Compact branches: bnvc, bnec, bnezlac */
>   		if (insn.i_format.rt && !insn.i_format.rs)
>   			regs->regs[31] = epc + 4;
>   		regs->cp0_epc += 8;
>
