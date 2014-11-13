Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 13:25:48 +0100 (CET)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:46132 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013586AbaKMMZjd5ydc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Nov 2014 13:25:39 +0100
Received: by mail-lb0-f177.google.com with SMTP id z12so4145909lbi.22
        for <linux-mips@linux-mips.org>; Thu, 13 Nov 2014 04:25:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=AyzDsWm/PZkUs1FPlIaXLUOU6hbpwLZlnuil/0/COvg=;
        b=lXssEMd7+N3Ofa6rYMs42C8pu+Ok7IEvwHpUJRyNlt/9MbTEySqFdghEclj03HgOrc
         Kvppi2BFKWCiGL9D4RpRArqdkjTZk1OQ82rOp59PHZ2x0+ervYvREMIZaEzutPVhGtCv
         BWPhgZEUw15sD7XKbuBbG08OC4SCn4Uz1D6KrcW4OGUI5Z8blRbvaaNysS7svv35P1Kt
         YGjuLK1d7bV2aV1n7ZLlRSivxYWURXy/+LtIr+Y3FcX0RLSeQm6kaNYYFKOSyz0NPTsW
         rRK4kirKpGTJs9NkQZ59ttKkUufsiM+feCBjTTwz0tS2A9C1DXe7hbA4dFBbQzalsYYu
         aJdg==
X-Gm-Message-State: ALoCoQk8XzMy1dtGeKzHIKl4h6hn5KAeF1znVSPIbT1CL7ggomcllhxebEgKu2ZbZk5/mShx+kgk
X-Received: by 10.152.43.80 with SMTP id u16mr2126282lal.53.1415881534108;
        Thu, 13 Nov 2014 04:25:34 -0800 (PST)
Received: from [192.168.2.5] (ppp83-237-250-130.pppoe.mtu-net.ru. [83.237.250.130])
        by mx.google.com with ESMTPSA id f6sm7454828lbh.10.2014.11.13.04.25.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Nov 2014 04:25:33 -0800 (PST)
Message-ID: <5464A33C.1060502@cogentembedded.com>
Date:   Thu, 13 Nov 2014 15:25:32 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org
CC:     ralf@linux-mips.org
Subject: Re: [PATCH 06/11] MIPS: Add CP0 macros for extended EntryLo registers
References: <1415858743-24492-1-git-send-email-Steven.Hill@imgtec.com> <1415858743-24492-7-git-send-email-Steven.Hill@imgtec.com>
In-Reply-To: <1415858743-24492-7-git-send-email-Steven.Hill@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44117
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

On 11/13/2014 9:05 AM, Steven J. Hill wrote:

> From: "Steven J. Hill" <Steven.Hill@imgtec.com>

> Add read/write macros to access the upper bits of the
> extended EntryLo0 and EntryLo1 registers used by XPA.

> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
> ---
>   arch/mips/include/asm/mipsregs.h |   39 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)

> diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
> index d767838..eaae8b0 100644
> --- a/arch/mips/include/asm/mipsregs.h
> +++ b/arch/mips/include/asm/mipsregs.h
> @@ -997,6 +997,39 @@ do {									\
>   	local_irq_restore(__flags);					\
>   } while (0)
>
> +#define __readx_32bit_c0_register(source)				\
> +({									\
> +	unsigned int __res;						\
> +									\
> +	__asm__ __volatile__(						\
> +	"	.set	push					\n"	\
> +	"	.set	noat					\n"	\
> +	"	.set	mips32r2				\n"	\
> +	"	.insn						\n"	\
> +	"	# mfhc0 $1, %1					\n"	\
> +	"	.word	(0x40410000 | ((%1 & 0x1f) << 11))	\n"	\
> +	"	move	%0, $1					\n"	\
> +	"	.set	pop					\n"	\
> +	: "=r" (__res)							\
> +	: "i" (source));						\
> +	__res;								\
> +})
> +
> +#define __writex_32bit_c0_register(register, value)			\
> +do {									\
> +	__asm__ __volatile__(						\
> +	"	.set	push					\n"	\
> +	"	.set	noat					\n"	\
> +	"	.set	mips32r2				\n"	\
> +	"	move	$1, %0					\n"	\
> +	"	# mthc0 $1, %1					\n"	\
> +	"	.insn						\n"	\
> +	"	.word	(0x40c10000 | ((" #register " & 0x1f) << 11))	\n"	\

    Not %1 again?

> +	"	.set	pop					\n"	\
> +	:								\
> +	: "r" (value), "i" (register));					\
> +} while (0)
> +
[...]

WBR, Sergei
