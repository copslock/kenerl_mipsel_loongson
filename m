Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2014 13:08:08 +0100 (CET)
Received: from mail-la0-f43.google.com ([209.85.215.43]:47780 "EHLO
        mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008749AbaLSMIHPqSlT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Dec 2014 13:08:07 +0100
Received: by mail-la0-f43.google.com with SMTP id s18so713039lam.30
        for <linux-mips@linux-mips.org>; Fri, 19 Dec 2014 04:08:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=AfIhBorIU+h41f1uO3HTqAXys1+LVePhV5MHdBp78LM=;
        b=XjSfdiUGiI00tkrhXkKkGwFgfgDGd5CzXUc7QhBbc3uJAjBKG/nHUobU/xx4xcVqID
         MavvIxLsWDiHt4a/iIJarhb5+jomCBQ9Wx5QvurEJX05umw4wi57fXbE2CaQ177x4fwk
         vJa0q6+XRu/4ei3tZ0VbPoYfdV2Ergdnd46AbVrV2bACPqWd77VoyMjqQihWZIR1l8Wj
         wjp4dpDzNKvqlh6Qaj4QhSZo3z/PlsKfCRDRLM2qIsMqEYK5J8wRTsd40R0hX33DofFt
         12F5ARIXaj8Fq02Te0HV7rbUdpbql4fLOXK6UIzKchS0AKORZXZ1h2ZrSvCnLjlhePRn
         jWaQ==
X-Gm-Message-State: ALoCoQlVJB0tbJR/XPxUnGmNxzwZZTGwmz1oElt/JF4waFnjCP3VnoV8xS6Vf1N3PEDgZPU8yUIP
X-Received: by 10.112.135.197 with SMTP id pu5mr7461985lbb.22.1418990881922;
        Fri, 19 Dec 2014 04:08:01 -0800 (PST)
Received: from [192.168.3.154] (ppp83-237-251-130.pppoe.mtu-net.ru. [83.237.251.130])
        by mx.google.com with ESMTPSA id ph5sm2661120lbb.40.2014.12.19.04.08.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Dec 2014 04:08:00 -0800 (PST)
Message-ID: <54941521.60808@cogentembedded.com>
Date:   Fri, 19 Dec 2014 15:08:01 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH RFC 59/67] MIPS: kernel: branch: Emulate the BEQZC and
 JIC instructions
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com> <1418915416-3196-60-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1418915416-3196-60-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44840
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

On 12/18/2014 6:10 PM, Markos Chandras wrote:

> MIPS R6 uses the <R6 ldc2 opcode for the new BEQZC and JIC instructions

> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>   arch/mips/kernel/branch.c | 9 +++++++++
>   1 file changed, 9 insertions(+)

> diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
> index 426f876403d0..4473c23cacf2 100644
> --- a/arch/mips/kernel/branch.c
> +++ b/arch/mips/kernel/branch.c
> @@ -802,6 +802,15 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
>   		epc = epc + 4 + (insn.i_format.simmediate << 2);
>   		regs->cp0_epc = epc;
>   		break;
> +	case ldc2_or_bzcjic_op:
> +		/* Compact branch: BEQZC || JIC */
> +		if (insn.i_format.rs) /* BEQZC */
> +			epc = epc + 8;

			epc += 8;

[...]

WBR, Sergei
