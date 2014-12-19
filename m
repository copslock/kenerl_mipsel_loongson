Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2014 13:10:32 +0100 (CET)
Received: from mail-la0-f47.google.com ([209.85.215.47]:65142 "EHLO
        mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008749AbaLSMKbDGWwG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Dec 2014 13:10:31 +0100
Received: by mail-la0-f47.google.com with SMTP id hz20so693092lab.20
        for <linux-mips@linux-mips.org>; Fri, 19 Dec 2014 04:10:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=XAGTTymdIS38n83lO2+CIuolTETeEr/hgSlrLtRd2yw=;
        b=SNM1wKwKOlM/C+Hk9mdJaj6J4EwUi2Vfl1cf1cPKHpqGe0KnM1Wv+Tjao4Eaus6Fyj
         Q8UB1w3wHau3JVudjEdBgo4tTfdPihe8v5KSGSbNpdGts5Cf3QgKWacU/kRSODa9STq6
         g/dkTaQI+PCOgeY13KJgXC7oeLvU31Ri81hsBaf2XnY5zAECrNoDMfNMRkhGoKiXkRyu
         5kmyBV9F8rlnAXgvOzcdUrK+Hfqptn4fhoARMxG2MdJRRGlijtAXjqtM+ruT3YiHzIHh
         mAfzPLRPmMs4ArhtFEKTPoOW4d88iBGTE/zb8gv/JztXhR2jA+n56CAuvhxNABGPCAYg
         QoeA==
X-Gm-Message-State: ALoCoQkfbNozJyrJXOFfFz1+rIJVUOpmV9LpptrRgPx907peKBLtRWNXzjIeRIz/0HaguXGprUSk
X-Received: by 10.112.129.228 with SMTP id nz4mr7481198lbb.8.1418991025689;
        Fri, 19 Dec 2014 04:10:25 -0800 (PST)
Received: from [192.168.3.154] (ppp83-237-251-130.pppoe.mtu-net.ru. [83.237.251.130])
        by mx.google.com with ESMTPSA id g7sm2666417lae.15.2014.12.19.04.10.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Dec 2014 04:10:24 -0800 (PST)
Message-ID: <549415B0.1060701@cogentembedded.com>
Date:   Fri, 19 Dec 2014 15:10:24 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH RFC 60/67] MIPS: math-emu: cp1emu: Move the fpucondbit
 struct to a header
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com> <1418915416-3196-61-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1418915416-3196-61-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44841
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

> The fpucondbit struct will be used later on by the MIPS R2 instruction

    It's not *struct*.

> emulator, so in order to access it, we need to move it to a header.

> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>   arch/mips/include/asm/fpu_emulator.h | 12 ++++++++++++
>   arch/mips/math-emu/cp1emu.c          | 12 ------------
>   2 files changed, 12 insertions(+), 12 deletions(-)

> diff --git a/arch/mips/include/asm/fpu_emulator.h b/arch/mips/include/asm/fpu_emulator.h
> index 3ee347713307..d7670bd80855 100644
> --- a/arch/mips/include/asm/fpu_emulator.h
> +++ b/arch/mips/include/asm/fpu_emulator.h
> @@ -30,6 +30,18 @@
>   #include <asm/local.h>
>   #include <asm/processor.h>
>
> +/* convert condition code register number to csr bit */
> +static const unsigned int fpucondbit[8] = {

    Why not *extern* declaration instead? We don't define data in the header 
files.

> +	FPU_CSR_COND0,
> +	FPU_CSR_COND1,
> +	FPU_CSR_COND2,
> +	FPU_CSR_COND3,
> +	FPU_CSR_COND4,
> +	FPU_CSR_COND5,
> +	FPU_CSR_COND6,
> +	FPU_CSR_COND7
> +};
> +
[...]

WBR, Sergei
