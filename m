Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 11:26:08 +0100 (CET)
Received: from mail-lb0-f173.google.com ([209.85.217.173]:36426 "EHLO
        mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010839AbcBCK0GjmAAO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 11:26:06 +0100
Received: by mail-lb0-f173.google.com with SMTP id dx2so9156739lbd.3
        for <linux-mips@linux-mips.org>; Wed, 03 Feb 2016 02:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=0GJHaBaZXxHTqXCFumiW3CqNk/2Fe6lORKVon/525pI=;
        b=gMuxi1Kf09jY7yGmi/LNX8/XIyBrqnS2xQYffBTx2Nzh6yXqBmUEzGn6gC5ncducwF
         chKz3C7C1c5q49Bvq2I+NqMdP+pDp2FXs2/8r9fjhTdv+5bm2Ei3mnExkhBcgQK/sPHg
         jtLAFtV8OPyIY5pk/c8ILKpr50btSbJU3kTvVV/TTYUXH4+tLBckW3D33QV72Fb7/cJS
         RaZHsFnN+dkSD9w6YgpI5i7uFpHNQOvTktkA3iPnKp8ikvCHtFGpZD+TwmInaG5N2A8X
         l+oKCWiUO7e2ixhxpdZrynv4T2AzR558pQFmAahXu1QdEUFxb+umU0fGpiVSozj5V/zs
         7DvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=0GJHaBaZXxHTqXCFumiW3CqNk/2Fe6lORKVon/525pI=;
        b=f5ocoxSn2/t4FY5aILYHfa4eLHONcxXAjqOINJ8BtBGcMlmjtgWeGPI/pIwLdJHwLF
         24IwwuXZiAL6qRmh+2bXr0iV+OnGUeQBFJKkL6it7NaNUXZ8S1Zl0wcYR+1aBFHudkuE
         AzeM+ykl2zY2OMFo/b4s7rsMz/o52EbekYBDNDlR54G5NTRM/ud3TTRQhAODmo0IeQka
         1h6gpVRNcs0REIROc/7QCulRj4hbaKUUEmlJCD9FPbm5ZoK+z0JvIks+vU1O9yXw7O7l
         oi+vRHrfMKZSbkpXQ9sidI13tq6i3AqjxmDe8GkHucnILqxyGw6dEARAw3KqIz3Uye88
         r6Hg==
X-Gm-Message-State: AG10YOSASgpR+DLkhnGqVmCR4CswY2Mr4+HgFWxv3oWuqDVM8rodR0FDK8TIop9MHmuz2g==
X-Received: by 10.112.145.131 with SMTP id su3mr359475lbb.19.1454495159616;
        Wed, 03 Feb 2016 02:25:59 -0800 (PST)
Received: from [192.168.4.126] ([83.149.9.191])
        by smtp.gmail.com with ESMTPSA id q8sm796023lbf.24.2016.02.03.02.25.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 03 Feb 2016 02:25:58 -0800 (PST)
Subject: Re: [PATCH 4/5] MIPS: Support R_MIPS_PC16 rel-style reloc
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
References: <1454471085-20963-1-git-send-email-paul.burton@imgtec.com>
 <1454471085-20963-5-git-send-email-paul.burton@imgtec.com>
Cc:     Andrey Konovalov <adech.fo@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <56B1D5B5.6050208@cogentembedded.com>
Date:   Wed, 3 Feb 2016 13:25:57 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1454471085-20963-5-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51656
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

On 2/3/2016 6:44 AM, Paul Burton wrote:

> MIPS32 code uses rel-style relocs, and MIPS32r6 modules may include the
> R_MIPS_PC16 relocation. We thus need to support R_MIPS_PC16 rel-style
> relocations in order to load MIPS32r6 kernel modules. This patch adds
> such support, which is similar to the rela-style R_MIPS_PC16 support but

     R_MIPS_LO16, you mean?

> making use of the implicit addend from the instruction encoding.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>
>   arch/mips/kernel/module.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
> index 2adf572..f2de9b8 100644
> --- a/arch/mips/kernel/module.c
> +++ b/arch/mips/kernel/module.c
> @@ -183,13 +183,25 @@ out_danger:
>   	return -ENOEXEC;
>   }
>
> +static int apply_r_mips_pc16_rel(struct module *me, u32 *location, Elf_Addr v)
> +{
> +	u16 val;
> +
> +	val = *location;
> +	val += (v - (Elf_Addr)location) >> 2;
> +	*location = (*location & 0xffff0000) | val;
> +
> +	return 0;
> +}
> +
>   static int (*reloc_handlers_rel[]) (struct module *me, u32 *location,
>   				Elf_Addr v) = {
>   	[R_MIPS_NONE]		= apply_r_mips_none,
>   	[R_MIPS_32]		= apply_r_mips_32_rel,
>   	[R_MIPS_26]		= apply_r_mips_26_rel,
>   	[R_MIPS_HI16]		= apply_r_mips_hi16_rel,
> -	[R_MIPS_LO16]		= apply_r_mips_lo16_rel
> +	[R_MIPS_LO16]		= apply_r_mips_lo16_rel,
> +	[R_MIPS_PC16]		= apply_r_mips_pc16_rel,
>   };
>
>   int apply_relocate(Elf_Shdr *sechdrs, const char *strtab,

MBR, Sergei
