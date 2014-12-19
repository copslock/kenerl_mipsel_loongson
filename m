Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2014 13:06:08 +0100 (CET)
Received: from mail-la0-f43.google.com ([209.85.215.43]:63491 "EHLO
        mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009158AbaLSMGGbaool (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Dec 2014 13:06:06 +0100
Received: by mail-la0-f43.google.com with SMTP id s18so717556lam.16
        for <linux-mips@linux-mips.org>; Fri, 19 Dec 2014 04:06:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=UPgfCYRPCunurltQtWEEBGyzJox6yZlo6W6OAZ8l3ho=;
        b=cXkWOXxOknIEpso8+u0KSIRbWpVBP6YubmZX/c4wy0H5wARRHpFeNszme2F8ujf2WL
         ghNjAMEJY2HcWGG87r3FCSzsQ/wEUnfHZZ4jFSlLbiY6d7DLf3kc6tosmRpiOUp4y3wv
         06E1Y4ItC6JaT5CRo5L9YrrjpvbUi0FJYw8UT3RTa5jsTppaNHqbY7eFhfiAam4xcbUR
         gikHldoRBQ9RNvvpv6UvE6RjtBVe+rvAnwN4daM1JaX7UHWf83JEYotgQ9fcvMJBBYJY
         eNHvwP/46Ubq8rZPutFeK7AEE5VRF/K3Vb/dGEs2/St3JTYNm1PdgfpZJVd7ghDKuULs
         DktA==
X-Gm-Message-State: ALoCoQmfhNSi9atHJrXSI2c7nZSDMjSa6JFKAXVUQ7YWt6JLU/My3FoxtI0yjhAJRGzkDFWbZ1b0
X-Received: by 10.112.38.4 with SMTP id c4mr7573904lbk.46.1418990761168;
        Fri, 19 Dec 2014 04:06:01 -0800 (PST)
Received: from [192.168.3.154] (ppp83-237-251-130.pppoe.mtu-net.ru. [83.237.251.130])
        by mx.google.com with ESMTPSA id s16sm2663520lal.5.2014.12.19.04.05.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Dec 2014 04:06:00 -0800 (PST)
Message-ID: <549414A8.1030009@cogentembedded.com>
Date:   Fri, 19 Dec 2014 15:06:00 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH RFC 58/67] MIPS: kernel: branch: Emulate the BALC R6 instruction
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com> <1418915416-3196-59-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1418915416-3196-59-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44839
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

> MIPS R6 uses the <R6 swc2 opcode for the new BALC instructions.

> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>   arch/mips/kernel/branch.c | 6 ++++++
>   1 file changed, 6 insertions(+)

> diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
> index 4cc9070682e1..426f876403d0 100644
> --- a/arch/mips/kernel/branch.c
> +++ b/arch/mips/kernel/branch.c
> @@ -796,6 +796,12 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
>   			regs->regs[31] = epc + 4;
>   		regs->cp0_epc += 8;
>   		break;
> +	case swc2_or_balc_op:
> +		/* Compact branch: BALC */
> +		regs->regs[31] = epc + 4;
> +		epc = epc + 4 + (insn.i_format.simmediate << 2);

		epc += 4 + (insn.i_format.simmediate << 2);

> +		regs->cp0_epc = epc;
> +		break;

WBR, Sergei
