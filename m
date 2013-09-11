Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Sep 2013 21:11:59 +0200 (CEST)
Received: from mail-ie0-f169.google.com ([209.85.223.169]:48391 "EHLO
        mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823124Ab3IKTL5DbK-Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Sep 2013 21:11:57 +0200
Received: by mail-ie0-f169.google.com with SMTP id tp5so20730533ieb.28
        for <multiple recipients>; Wed, 11 Sep 2013 12:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=U8YOjYUfA5aQCvo1LRASpEAx9wgvaJ+IVp9jmDAD1Tc=;
        b=QPmvz0bqufJo3KW4eKjFf3GCyV0QTknaTMMkwhemjZAyFHcOm7Afb+mUqyPjEYEHpz
         Aj+usLzRsMj/ToAe55rAo5uh8uzdU6B4X+mU4fz9ySOuMlPyH3v1yj5InFKmbigkI0D+
         GUL1QbyJw9t0PhDwhDe51c9lOs9SKACvRrO6ziFCSwCp0Bzp1TP6I5dTFjVXEyj9GYb0
         BLSwk5OdDQ9y8YOxqC3b23HftrA3PJt+ij26K9E8MgOL6kmIED/MeQciM+J40QWPCFUn
         xbTIKzoJzIljya8h1drp4ZsyuQ2Eci39ktjIC6Kl2YJpMcsfm8FTG1sVAToHPC9x4UwH
         tmvw==
X-Received: by 10.50.13.66 with SMTP id f2mr12574961igc.17.1378926710866;
        Wed, 11 Sep 2013 12:11:50 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id i1sm5141567iga.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 11 Sep 2013 12:11:50 -0700 (PDT)
Message-ID: <5230C073.8050703@gmail.com>
Date:   Wed, 11 Sep 2013 12:11:47 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>, ralf@linux-mips.org
CC:     linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH] MIPS: GIC: Select R4K counter as fallback.
References: <1378925634-5830-1-git-send-email-Steven.Hill@imgtec.com>
In-Reply-To: <1378925634-5830-1-git-send-email-Steven.Hill@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37789
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

On 09/11/2013 11:53 AM, Steven J. Hill wrote:
> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>
> If CONFIG_CSRC_GIC is selected and the GIC is not found during
> boot, then fallback to the R4K counter gracefully.
>
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
> ---
>   arch/mips/include/asm/time.h |   10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
> index 2d7b9df..1194c31 100644
> --- a/arch/mips/include/asm/time.h
> +++ b/arch/mips/include/asm/time.h
> @@ -75,11 +75,13 @@ extern int init_r4k_clocksource(void);
>
>   static inline int init_mips_clocksource(void)
>   {
> -#if defined(CONFIG_CSRC_R4K) && !defined(CONFIG_CSRC_GIC)
> -	return init_r4k_clocksource();
> -#else
> -	return 0;
> +#ifdef CONFIG_CSRC_R4K
> +#ifdef CONFIG_CSRC_GIC
> +	if (!gic_present)
>   #endif
> +		return init_r4k_clocksource();
> +#endif
> +	return 0;
>   }

An alternative would be to place in gic.h something like:

#ifdef CONFIG_CSRC_GIC
# define use_mips_gic_csrc gic_present
#else
# define use_mips_gic_csrc 0
#endif

Then the above code would be


if (!use_mips_gic_csrc)
	return init_r4k_clocksource();


With less #if ugliness


>
>   static inline void clockevent_set_clock(struct clock_event_device *cd,
>
