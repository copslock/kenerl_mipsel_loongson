Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 20:07:29 +0100 (CET)
Received: from mail-ie0-f180.google.com ([209.85.223.180]:38806 "EHLO
        mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008789AbaLRTH14x3jU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 20:07:27 +0100
Received: by mail-ie0-f180.google.com with SMTP id rp18so1739704iec.11
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 11:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=BdTtDVUVPZ3mDPipdPjePUMef4DWt0MkbdPDnL19jMo=;
        b=abNTuVbpfg+ERhgOCeqvA2wYuJjGp4YRRDyC+3cgLvKUDILCX2OyRr89jWoe27hNMh
         as8xI0OxUHQLkmvBXaMcm6OP3ooWQrkV+hXz7yNf4qb/YhgxsaMNiT22cJsmXDgG/16e
         x93A9MQrDtZ0umEGxQQtJsY1G4IsB6DsaneewD31BAP+YZCV/2eUTyksXMgENoA2As6b
         GTXf7haw2tqXProgI1+SfKVxDEoaMpzNEf2ARy2H/4PATvBfCZ5te7r5FW6bzCp7PJft
         oLfnYW2PyLof8I3yblepFR9I+1UphwYkHJH26Sqi8XHQrdfISg8iJ0yqBKwRCkRr3nfT
         HScg==
X-Received: by 10.50.8.7 with SMTP id n7mr2525429iga.16.1418929642101;
        Thu, 18 Dec 2014 11:07:22 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id d1sm4045976igz.13.2014.12.18.11.07.21
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Dec 2014 11:07:21 -0800 (PST)
Message-ID: <549325E8.3040802@gmail.com>
Date:   Thu, 18 Dec 2014 11:07:20 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH RFC 56/67] MIPS: kernel: branch: Emulate the BOVC, BEQC
 and BEQZALC R6 instructions
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com> <1418915416-3196-57-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1418915416-3196-57-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44813
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
> MIPS R6 uses the <R6 ADDI opcode for the new BOVC, BEQC and
> BEQZALC instructions.
>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>   arch/mips/include/uapi/asm/inst.h | 2 +-
>   arch/mips/kernel/branch.c         | 6 ++++++
>   2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
> index 648addfe1e1c..b95363e0551f 100644
> --- a/arch/mips/include/uapi/asm/inst.h
> +++ b/arch/mips/include/uapi/asm/inst.h
> @@ -21,7 +21,7 @@
>   enum major_op {
>   	spec_op, bcond_op, j_op, jal_op,
>   	beq_op, bne_op, blez_op, bgtz_op,
> -	addi_op, addiu_op, slti_op, sltiu_op,
> +	addi_or_cbcond0_op, addiu_op, slti_op, sltiu_op,

NAK.

This is a kernel ABI document, you cannot remove symbols.

>   	andi_op, ori_op, xori_op, lui_op,
>   	cop0_op, cop1_op, cop2_op, cop1x_op,
>   	beql_op, bnel_op, blezl_op, bgtzl_op,
> diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
> index d9e3a0d72a64..cf390c76ba95 100644
> --- a/arch/mips/kernel/branch.c
> +++ b/arch/mips/kernel/branch.c
> @@ -788,6 +788,12 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
>   	case lwc2_or_bc_op:
>   		regs->cp0_epc += 8;
>   		break;
> +	case addi_or_cbcond0_op:
> +		/* Compact branches: bovc, beqc, beqzalc */
> +		if (insn.i_format.rt && !insn.i_format.rs)
> +			regs->regs[31] = epc + 4;
> +		regs->cp0_epc += 8;
> +		break;
>   #endif
>   	}
>
>
