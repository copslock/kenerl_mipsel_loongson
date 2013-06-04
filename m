Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jun 2013 20:43:03 +0200 (CEST)
Received: from mail-ie0-f171.google.com ([209.85.223.171]:58564 "EHLO
        mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827511Ab3FDSm5iF5Ar (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Jun 2013 20:42:57 +0200
Received: by mail-ie0-f171.google.com with SMTP id s9so1251578iec.2
        for <multiple recipients>; Tue, 04 Jun 2013 11:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=y/DCpmC6E3RNwRaLTiWdQrjQpktAw195al60Phksrb4=;
        b=PppBWBXaGha2gYqdf9I84mncecHF45u/ONSn7Ad2mQ913+Dr6nK/tm+eClDDXGKVQD
         Rp/Clzb+XaVr7MGnZaznk4dAMzAiH1h5mNBQdmhNNkKBpjBBciQ650uZXcly4DoJeTKV
         2Co0Y7Fg7Ayv1X7xe6PE79fbsOzGJ2kW7DrDNQLXJp6rx8oqS9qJZZVrn2wVMQhkQdnS
         NzrHw65ZTiMmF19KuRExELhRXHhnIkIy11sNCj90+vwhUOy2a/pM791Kwr2heJimaQCG
         kboHAYR8HQAjOx+ReybhNkJ2ZeHHrqvMOQG7tgwuCOb/OKzgGS8smDGKLq2f0rKicD1k
         uwZQ==
X-Received: by 10.50.65.9 with SMTP id t9mr1523093igs.102.1370371370979;
        Tue, 04 Jun 2013 11:42:50 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id jj6sm2946810igb.6.2013.06.04.11.42.49
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 11:42:50 -0700 (PDT)
Message-ID: <51AE3528.8020601@gmail.com>
Date:   Tue, 04 Jun 2013 11:42:48 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: micromips: Fix improper definition of ISA exception
 bit.
References: <1370370127-19681-1-git-send-email-Steven.Hill@imgtec.com>
In-Reply-To: <1370370127-19681-1-git-send-email-Steven.Hill@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36673
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

On 06/04/2013 11:22 AM, Steven J. Hill wrote:
> The ISA exception bit selects whether exceptions are taken in classic
> MIPS or microMIPS mode. This bit is Config3.ISAOnExc and is bit 16. It
> It was improperly defined as bits 16 and 17. Fortunately, bit 17 is
> read-only and did not effect microMIPS operation. However, detecting
> a classic or microMIPS kernel when examining the /proc/cpuinfo file,
> the result always showed a microMIPS kernel.
>
> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
> ---
>   arch/mips/include/asm/mipsregs.h |    2 +-
>   arch/mips/kernel/cpu-probe.c     |   11 ++++++-----
>   2 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
> index 87e6207..fed1c3e 100644
> --- a/arch/mips/include/asm/mipsregs.h
> +++ b/arch/mips/include/asm/mipsregs.h
> @@ -596,7 +596,7 @@
>   #define MIPS_CONF3_RXI		(_ULCAST_(1) << 12)
>   #define MIPS_CONF3_ULRI		(_ULCAST_(1) << 13)
>   #define MIPS_CONF3_ISA		(_ULCAST_(3) << 14)
> -#define MIPS_CONF3_ISA_OE	(_ULCAST_(3) << 16)
> +#define MIPS_CONF3_ISA_OE	(_ULCAST_(1) << 16)
>   #define MIPS_CONF3_VZ		(_ULCAST_(1) << 23)
>
>   #define MIPS_CONF4_MMUSIZEEXT	(_ULCAST_(255) << 0)
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index c6568bf..822bfe4 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -256,6 +256,12 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
>   		c->ases |= MIPS_ASE_SMARTMIPS;
>   		c->options |= MIPS_CPU_RIXI;
>   	}
> +	if (config3 & MIPS_CONF3_ISA) {
> +		c->options |= MIPS_CPU_MICROMIPS;
> +#ifdef CONFIG_CPU_MICROMIPS
> +		write_c0_config3(config3 | MIPS_CONF3_ISA_OE);
> +#endif
> +	}

This function is supposed to be decoding the bits in config3, it 
shouldn't be changing the CPU operating mode.

Please move this to some other place (like prom_init() or 
kernel_entry_setup).


>   	if (config3 & MIPS_CONF3_RXI)
>   		c->options |= MIPS_CPU_RIXI;
>   	if (config3 & MIPS_CONF3_DSP)
> @@ -270,11 +276,6 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
>   		c->ases |= MIPS_ASE_MIPSMT;
>   	if (config3 & MIPS_CONF3_ULRI)
>   		c->options |= MIPS_CPU_ULRI;
> -	if (config3 & MIPS_CONF3_ISA)
> -		c->options |= MIPS_CPU_MICROMIPS;
> -#ifdef CONFIG_CPU_MICROMIPS
> -	write_c0_config3(read_c0_config3() | MIPS_CONF3_ISA_OE);
> -#endif
>   	if (config3 & MIPS_CONF3_VZ)
>   		c->ases |= MIPS_ASE_VZ;
>
>
