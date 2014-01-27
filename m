Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 18:07:00 +0100 (CET)
Received: from mail-lb0-f172.google.com ([209.85.217.172]:36177 "EHLO
        mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823991AbaA0RG5nAC-c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jan 2014 18:06:57 +0100
Received: by mail-lb0-f172.google.com with SMTP id c11so4747062lbj.3
        for <linux-mips@linux-mips.org>; Mon, 27 Jan 2014 09:06:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=BKtxvj8qSGIjvU1tClDU8UgAg/FWteWGdXAk8EjzFE4=;
        b=Msdb+QpSSkGA+p9pUqC8CavdEd1UqtytOqQrImY32X3dJlmTkmZ8+fRrZ44x5JIYTz
         ctFlhI8u+erTCwBkY+AjRke96dAcyFL/cSnq9hfB4brVjyfem+gfsatbjMLSZumx/+94
         YvYMhmsX3WLDURLbmLfIAPJq6A4SoVTKM35mcfTkRo8jJTvg9gdYMCjbKkHYZLNv+yFE
         lGkZdybZR6wQxANL+WZYanaRJU2npy6WgBTUllpxjusjoUyB6Upc6nFHE7C2bGNbGGCa
         QsJxOrKVySJ3UQB+HUiBEkeLHYBwieHUZ8GupnHoykdf0Qnu2U42cQMemmhrBJIkVCdF
         +jqQ==
X-Gm-Message-State: ALoCoQnW7MiRd0C73slBhwSuhDd553tb0pgAkpRltD2/QHhP454ZplkIL2R4jqxd7c2aGWoBdsRw
X-Received: by 10.152.229.225 with SMTP id st1mr18272774lac.2.1390842412055;
        Mon, 27 Jan 2014 09:06:52 -0800 (PST)
Received: from wasted.cogentembedded.com (ppp83-237-62-70.pppoe.mtu-net.ru. [83.237.62.70])
        by mx.google.com with ESMTPSA id k1sm7119972lbc.5.2014.01.27.09.06.51
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 27 Jan 2014 09:06:51 -0800 (PST)
Message-ID: <52E6A03C.6070303@cogentembedded.com>
Date:   Mon, 27 Jan 2014 21:06:52 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 06/15] mips: clear upper bits of FP registers on emulator
 writes
References: <1390836194-26286-1-git-send-email-paul.burton@imgtec.com> <1390836194-26286-7-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1390836194-26286-7-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39110
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

Hello.

On 01/27/2014 06:23 PM, Paul Burton wrote:

> The upper bits of an FP register are architecturally defined as
> unpredictable following an instructions which only writes the lower
> bits. The prior behaviour of the kernel is to leave them unmodified.
> This patch modifies that to clear the upper bits to zero. This is what
> the MSA architecture reference manual specifies should happen for its
> wider registers and is still permissible for scalar FP instructions
> given the bits unpredictability there.

> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>   arch/mips/math-emu/cp1emu.c | 25 ++++++++++++++++++++-----
>   1 file changed, 20 insertions(+), 5 deletions(-)

> diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
> index 9144842..c484f5f 100644
> --- a/arch/mips/math-emu/cp1emu.c
> +++ b/arch/mips/math-emu/cp1emu.c
> @@ -884,20 +884,35 @@ static inline int cop1_64bit(struct pt_regs *xcp)
>   } while (0)
>
>   #define SITOREG(si, x) do {						\
> -	if (cop1_64bit(xcp))						\
> +	if (cop1_64bit(xcp)) {						\
> +		unsigned i;						\
>   		set_fpr32(&ctx->fpr[x], 0, si);				\
> -	else								\
> +		for (i = 1; i < ARRAY_SIZE(ctx->fpr[x].val32); i++)	\
> +			set_fpr32(&ctx->fpr[x], i, 0);			\
> +	} else {							\
>   		set_fpr32(&ctx->fpr[(x) & ~1], (x) & 1, si);		\
> +	}								\
>   } while (0)
>
>   #define SIFROMHREG(si, x)	((si) = get_fpr32(&ctx->fpr[x], 1))
> -#define SITOHREG(si, x)		set_fpr32(&ctx->fpr[x], 1, si)
> +
> +#define SITOHREG(si, x) do {						\
> +	unsigned i;							\
> +	set_fpr32(&ctx->fpr[x], 1, si);					\
> +	for (i = 2; i < ARRAY_SIZE(ctx->fpr[x].val32); i++)		\
> +			set_fpr32(&ctx->fpr[x], i, 0);			\

    This line is over-indented, no? Compare the loop below...

> +} while (0)
>
>   #define DIFROMREG(di, x) \
>   	((di) = get_fpr64(&ctx->fpr[(x) & ~(cop1_64bit(xcp) == 0)], 0))
>
> -#define DITOREG(di, x) \
> -	set_fpr64(&ctx->fpr[(x) & ~(cop1_64bit(xcp) == 0)], 0, di)
> +#define DITOREG(di, x) do {						\
> +	unsigned fpr, i;						\
> +	fpr = (x) & ~(cop1_64bit(xcp) == 0);				\
> +	set_fpr64(&ctx->fpr[fpr], 0, di);				\
> +	for (i = 1; i < ARRAY_SIZE(ctx->fpr[x].val64); i++)		\
> +		set_fpr64(&ctx->fpr[fpr], i, 0);			\
> +} while (0)

WBR, Sergei
