Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2010 11:58:57 +0100 (CET)
Received: from mail-ew0-f212.google.com ([209.85.219.212]:33309 "EHLO
        mail-ew0-f212.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491776Ab0BHK6u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2010 11:58:50 +0100
Received: by ewy4 with SMTP id 4so885319ewy.27
        for <multiple recipients>; Mon, 08 Feb 2010 02:58:43 -0800 (PST)
Received: by 10.213.109.129 with SMTP id j1mr5276607ebp.79.1265626723326;
        Mon, 08 Feb 2010 02:58:43 -0800 (PST)
Received: from ?192.168.2.2? (ppp91-77-214-141.pppoe.mtu-net.ru [91.77.214.141])
        by mx.google.com with ESMTPS id 16sm2976222ewy.10.2010.02.08.02.58.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Feb 2010 02:58:42 -0800 (PST)
Message-ID: <4B6FEE4A.6090504@ru.mvista.com>
Date:   Mon, 08 Feb 2010 13:58:18 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 3/4] MIPS: Add TLBP to uasm.
References: <4B6CA90C.1000609@caviumnetworks.com> <1265412431-28526-3-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1265412431-28526-3-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

David Daney wrote:

> The soon to follow Read Inhibit/eXecute Inhibit patch needs TLBP
>   

  But you're adding TLBR support, not TLBP?

> support in uasm.
>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  arch/mips/include/asm/uasm.h |    1 +
>  arch/mips/mm/uasm.c          |    5 ++++-
>  2 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
> index 3d153ed..b18588b 100644
> --- a/arch/mips/include/asm/uasm.h
> +++ b/arch/mips/include/asm/uasm.h
> @@ -95,6 +95,7 @@ Ip_u2u1u3(_srl);
>  Ip_u3u1u2(_subu);
>  Ip_u2s3u1(_sw);
>  Ip_0(_tlbp);
> +Ip_0(_tlbr);
>  Ip_0(_tlbwi);
>  Ip_0(_tlbwr);
>  Ip_u3u1u2(_xor);
> diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
> index e3ca0f7..8f4f14d 100644
> --- a/arch/mips/mm/uasm.c
> +++ b/arch/mips/mm/uasm.c
> @@ -63,7 +63,8 @@ enum opcode {
>  	insn_jr, insn_ld, insn_ll, insn_lld, insn_lui, insn_lw, insn_mfc0,
>  	insn_mtc0, insn_ori, insn_pref, insn_rfe, insn_sc, insn_scd,
>  	insn_sd, insn_sll, insn_sra, insn_srl, insn_subu, insn_sw,
> -	insn_tlbp, insn_tlbwi, insn_tlbwr, insn_xor, insn_xori, insn_dins
> +	insn_tlbp, insn_tlbr, insn_tlbwi, insn_tlbwr, insn_xor, insn_xori,
> +	insn_dins
>  };
>  
>  struct insn {
> @@ -128,6 +129,7 @@ static struct insn insn_table[] __cpuinitdata = {
>  	{ insn_subu,  M(spec_op, 0, 0, 0, 0, subu_op),  RS | RT | RD },
>  	{ insn_sw,  M(sw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
>  	{ insn_tlbp,  M(cop0_op, cop_op, 0, 0, 0, tlbp_op),  0 },
> +	{ insn_tlbr,  M(cop0_op, cop_op, 0, 0, 0, tlbr_op),  0 },
>  	{ insn_tlbwi,  M(cop0_op, cop_op, 0, 0, 0, tlbwi_op),  0 },
>  	{ insn_tlbwr,  M(cop0_op, cop_op, 0, 0, 0, tlbwr_op),  0 },
>  	{ insn_xor,  M(spec_op, 0, 0, 0, 0, xor_op),  RS | RT | RD },
> @@ -381,6 +383,7 @@ I_u2u1u3(_srl)
>  I_u3u1u2(_subu)
>  I_u2s3u1(_sw)
>  I_0(_tlbp)
> +I_0(_tlbr)
>  I_0(_tlbwi)
>  I_0(_tlbwr)
>  I_u3u1u2(_xor)
>   

WBR, Sergei
