Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Feb 2013 13:09:06 +0100 (CET)
Received: from mail-lb0-f172.google.com ([209.85.217.172]:65386 "EHLO
        mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817544Ab3BFMJCQ60-I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Feb 2013 13:09:02 +0100
Received: by mail-lb0-f172.google.com with SMTP id n8so1127794lbj.31
        for <linux-mips@linux-mips.org>; Wed, 06 Feb 2013 04:08:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=wgSoAVQ9+kOPm2tWRd+QQ5h/ltl+rAde41vl7U+oJQw=;
        b=NZmcsSn2vHMSxhDylthQmdhQ7gzE7r7t9zqQttkjBdSC2B6+JjsJtZcOs9y2ZaOTww
         pjYRnNgNOi5HILgWDmTPTx7gE+203Klet3alk/ASoogjWAILLeDHVGqAM8RalACpYjr0
         6SVe0TC9Ut1SZmgC3/GrjYsl7oRyd8WrFL3uDcsglIbfG92VcvphjkZ+WIQmq1zPt9i1
         V2r2KVk1D0hqNzLKcS2Bf/6XxkH1tP73Y603CF+B+Gf3ThDJxn4WeaGLxMBrY8cEutfh
         dNa61V+RYL1FYZc2h1ACgJQnvxEafmVI64vBvvEUMX0GhRKgE/exzh1ivSW6RIBq8Mkz
         FfXQ==
X-Received: by 10.152.113.165 with SMTP id iz5mr26508653lab.50.1360152536725;
        Wed, 06 Feb 2013 04:08:56 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-91-246.pppoe.mtu-net.ru. [91.79.91.246])
        by mx.google.com with ESMTPS id f2sm7725851lbz.4.2013.02.06.04.08.54
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 06 Feb 2013 04:08:55 -0800 (PST)
Message-ID: <511247C1.2010401@mvista.com>
Date:   Wed, 06 Feb 2013 16:08:33 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org, cernekee@gmail.com,
        kevink@paralogos.com, ddaney.cavm@gmail.com
Subject: Re: [PATCH 4/4] MIPS: microMIPS: Add instruction utility macros.
References: <1360104723-29529-1-git-send-email-sjhill@mips.com> <1360104723-29529-5-git-send-email-sjhill@mips.com>
In-Reply-To: <1360104723-29529-5-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQmU9q72YL0bR7pm+zCUgp1Aln9u005d8R4cbK9PT96dsctRNGZJwU8wBi6EZ6xQZohYvF+o
X-archive-position: 35714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 06-02-2013 2:52, Steven J. Hill wrote:

> From: "Steven J. Hill" <sjhill@mips.com>

> Add two new macros for microMIPS. One checks if an exception was
> taken in either microMIPS or classic MIPS mode. The other checks
> if a microMIPS instruction is 16-bit or 32-bit in length.

> Signed-off-by: Steven J. Hill <sjhill@mips.com>
> ---
>   arch/mips/include/asm/mipsregs.h |   18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)

> diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
> index f206ef2..13e1d68 100644
> --- a/arch/mips/include/asm/mipsregs.h
> +++ b/arch/mips/include/asm/mipsregs.h
> @@ -622,6 +622,24 @@
>   #ifndef __ASSEMBLY__
>
>   /*
> + * Macros for handling the ISA mode bit for microMIPS.
> + */
> +#define get_isa16_mode(x)		((x) & 0x1)
> +#define msk_isa16_mode(x)		((x) & ~0x1)
> +#define set_isa16_mode(x)		do { (x) |= 0x1; } while(0)
> +
> +/*
> + * microMIPS instructions can be 16-bit or 32-bit in length. This
> + * returns a 1 if the instruction is 16-bit and a 0 if 32-bit.
> + */
> +static inline int mm_insn_16bit(u16 insn)
> +{
> +	u16 opcode = (insn >> 10) & 0x7;
> +
> +	return ((opcode >= 1 && opcode <= 3) ? 1 : 0);

    Parens are not really necessary there, are they?

WBR, Sergei
