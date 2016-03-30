Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2016 21:13:48 +0200 (CEST)
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34563 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008467AbcC3TNri5Pwh convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Mar 2016 21:13:47 +0200
Received: by mail-lf0-f43.google.com with SMTP id c62so43376268lfc.1;
        Wed, 30 Mar 2016 12:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZyIjqMEfgq9NBVAxdUUVqmhdYmr2B1kOK5MQ0M2o5g0=;
        b=Vmsvjb07sF81Ya2qdJg4mbJ/CUVeroY+ddncwkltJsUwIdPMgNjMtfuoT20Ys8zw4f
         KZCEDVcA7rf8PxXnCRIIyUs8gV10eQJNXVUUVq7q1a69HW5+RuCJZUnoRkbS4HzmiAS7
         DuOwQb3b7Xr7TB9XOSvEeAZaiHTrg29uxl7aiv2tRxyTLPNZE+Z/cXikAD6x/Yyf50un
         0CcKaSD8j1HpmZSymu1QaJDiIJC/f197vJvahndgszD2JYSyDjaqUmtKIPCkHMsPLOM5
         spjLydUz74xwV4uPwVww0GlY7loWl1cdcfZ1KefZJ3aIe80JkHF2g6sEv5aJW1bnIUMj
         xw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZyIjqMEfgq9NBVAxdUUVqmhdYmr2B1kOK5MQ0M2o5g0=;
        b=QP0yI3O4FD6E9b7jvkeipSSX0UY3nPJkR09bs0pHG7SdcDppL/pvdP9FZE0wKrtxTm
         Zm8kuURUW3Im+1hgaN+F1kHYhUSVJRbN3j+QUsivvAtAyCcs3QcF5zG1qlRE++A6iS+a
         HVUimM4j/RyzmzSNf+WNurESBFsfnJdiXrI81t8YplcR45djKkb5DzrB5wG31s144f0J
         yTtRVB+YSSbtAkd0XDD9fqo6IcaQTAwcF8Mfh3mJBAWwlmt2IE8RLxt31FQasgeEUmtD
         OEopLttI7CrcVV+G8UCwzykYDJolZzDbYRfHVI3JLL8HuMMDmLhMH4vOOOj54N1dgkLe
         GynQ==
X-Gm-Message-State: AD7BkJI99NUBcnMjbjpi7ZBizuggLo7czIqPNJpdg+dzpee/d54g/08ujtxxiiDK2hmzwA==
X-Received: by 10.25.22.217 with SMTP id 86mr4883641lfw.66.1459365222200;
        Wed, 30 Mar 2016 12:13:42 -0700 (PDT)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id o187sm823350lfo.26.2016.03.30.12.13.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2016 12:13:41 -0700 (PDT)
Date:   Wed, 30 Mar 2016 22:13:29 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: ath79: fix build failure
Message-Id: <20160330221329.25ca0849d782e55c0564f139@gmail.com>
In-Reply-To: <1459351789-24544-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1459351789-24544-1-git-send-email-sudipm.mukherjee@gmail.com>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

On Wed, 30 Mar 2016 16:29:49 +0100
Sudip Mukherjee <sudipm.mukherjee@gmail.com> wrote:

> The ath79_defconfig build of mips was faling with the errors:
> 
> arch/mips/ath79/setup.c: In function 'plat_mem_setup':
> arch/mips/ath79/setup.c:226:20: error: invalid storage class for function 'ath79_of_plat_time_init'
>  static void __init ath79_of_plat_time_init(void)
>                     ^
> arch/mips/ath79/setup.c:226:1: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
>  static void __init ath79_of_plat_time_init(void)
>  ^
> arch/mips/ath79/setup.c:284:20: error: invalid storage class for function 'ath79_setup'
>  static  __init int ath79_setup(void)
>                     ^
> arch/mips/ath79/setup.c:299:1: error: initializer element is not constant
>  arch_initcall(ath79_setup);
> 
> It turns out to be a simple error of a missed closing brace.
> 
> Fixes: f63ba725caa7 ("MIPS: ath79: Disable platform code for OF boards.")
> Cc: Antony Pavlov <antonynpavlov@gmail.com>
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> ---
> 
> Build log of next-20160330 is at:
> https://travis-ci.org/sudipm-mukherjee/parport/jobs/119417999
> 
>  arch/mips/ath79/setup.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
> index 897f49a..e0ff6f3 100644
> --- a/arch/mips/ath79/setup.c
> +++ b/arch/mips/ath79/setup.c
> @@ -214,6 +214,7 @@ void __init plat_mem_setup(void)
>  						 AR71XX_PLL_SIZE);
>  		ath79_detect_sys_type();
>  		ath79_ddr_ctrl_init();
> +	}
>  
>  	detect_memory_region(0, ATH79_MEM_SIZE_MIN, ATH79_MEM_SIZE_MAX);
>  	/* OF machines should use the reset driver */

It is very strange because my original patch has this closing brace.
Please see my original patch
https://www.linux-mips.org/archives/linux-mips/2016-03/msg00267.html

Also I suppose that we have no need in detect_memory_region() if we use devicetree,
e.g.

                ath79_detect_sys_type();
                ath79_ddr_ctrl_init();
 +              detect_memory_region(0, ATH79_MEM_SIZE_MIN, ATH79_MEM_SIZE_MAX);
 +      }
  
 -      detect_memory_region(0, ATH79_MEM_SIZE_MIN, ATH79_MEM_SIZE_MAX);


-- 
Best regards,
  Antony Pavlov
