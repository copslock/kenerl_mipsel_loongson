Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2012 11:30:23 +0200 (CEST)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:34826 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903745Ab2HAJaO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Aug 2012 11:30:14 +0200
Received: by eekc13 with SMTP id c13so1831674eek.36
        for <multiple recipients>; Wed, 01 Aug 2012 02:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:organization:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type;
        bh=Oaiek5evV6IlSGiHIRqDK4FeOShLYSFNXg4FE6aQFOs=;
        b=RP7PTZpMyXm/+q6oOUMdVdI2VINiS/c3t/wwtewz3xGg/oFK/rZKyM3iCVVtTaYDE8
         uZUg8GsResnXgs3MKnC1qgM1kHN3AVu5JA5BjmXAM9T2pXMkASAjZlaWp4XbR6L1MI1e
         IeoyjIjQT7Geoo7i9Rem2spIFqvDkN9YT/SjRlHvTFqf7AknzCTap+AqdUIa+E+8NcDr
         L27l57Eo1ZN3lamEPJgsio4/Ro1b8ciWR0/88M9uFLDGlQoV8GdfmjJzRGqRUIOyfi02
         okWyta50dR7c9qZxpgkKDTlwH6RP9hLRLLJhXi3TjvEmeTCaLhEAGAMXgwr3SXwrLttz
         bQYg==
Received: by 10.14.2.5 with SMTP id 5mr7353781eee.33.1343813409257;
        Wed, 01 Aug 2012 02:30:09 -0700 (PDT)
Received: from flexo.localnet (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id u48sm7207047eep.7.2012.08.01.02.30.08
        (version=SSLv3 cipher=OTHER);
        Wed, 01 Aug 2012 02:30:08 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Yoichi Yuasa <yuasa@linux-mips.org>, ralf@linux-mips.org
Subject: Re: [PATCH 1/4] MIPS: AR7: add select HAVE_CLK
Date:   Wed, 01 Aug 2012 11:27:02 +0200
Message-ID: <1570204.DdPLElo9Hz@flexo>
Organization: OpenWrt
User-Agent: KMail/4.8.4 (Linux/3.2.0-24-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <20120801153800.22d81b6d674d6722b2392574@linux-mips.org>
References: <20120801153800.22d81b6d674d6722b2392574@linux-mips.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-archive-position: 34013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

On Wednesday 01 August 2012 15:38:00 Yoichi Yuasa wrote:
> fix redefinition of clk_*
> 
> arch/mips/ar7/clock.c:420:5: error: redefinition of 'clk_enable'
> include/linux/clk.h:295:19: note: previous definition of 'clk_enable' was 
here
> arch/mips/ar7/clock.c:426:6: error: redefinition of 'clk_disable'
> include/linux/clk.h:300:20: note: previous definition of 'clk_disable' was 
here
> arch/mips/ar7/clock.c:431:15: error: redefinition of 'clk_get_rate'
> include/linux/clk.h:302:29: note: previous definition of 'clk_get_rate' was 
here
> arch/mips/ar7/clock.c:437:13: error: redefinition of 'clk_get'
> include/linux/clk.h:281:27: note: previous definition of 'clk_get' was here
> arch/mips/ar7/clock.c:454:6: error: redefinition of 'clk_put'
> include/linux/clk.h:291:20: note: previous definition of 'clk_put' was here
> make[2]: *** [arch/mips/ar7/clock.o] Error 1
> 
> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>

Acked-by: Florian Fainelli <florian@openwrt.org>

> ---
>  arch/mips/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 7e78a83..50fc7a1 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -78,6 +78,7 @@ config AR7
>  	select SYS_SUPPORTS_ZBOOT_UART16550
>  	select ARCH_REQUIRE_GPIOLIB
>  	select VLYNQ
> +	select HAVE_CLK
>  	help
>  	  Support for the Texas Instruments AR7 System-on-a-Chip
>  	  family: TNETD7100, 7200 and 7300.
> -- 
> 1.7.0.4
> 
> 
