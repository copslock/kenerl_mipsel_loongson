Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2012 19:27:16 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:46890 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903659Ab2EKR1J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2012 19:27:09 +0200
Received: by lbbgg6 with SMTP id gg6so2566401lbb.36
        for <linux-mips@linux-mips.org>; Fri, 11 May 2012 10:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=5azGUXphmcdBQ93kXhR0aPY1SrITrYHnDZG1mtYZNN0=;
        b=deXhe51cez/85iX6lW+tD8n7bd5a8FXSXQq+ZrpHtGIBCOyDpvNieeQBtIDq9b3hKL
         5eW4cCZ1SniAaeaC89+RL7DJmMZf0CGti89zNBET/Jfsv/tJB75EuWYWLFKCS8A3UKgG
         9wiRVUMdKj1TijM67jPB7eVGRzIKMzMD1cKZAvIpxDqq5kviBJ/+G/ukCbOE8rPdTC9O
         9ibwlbv5tjynj39Xo8ymI9A1SKT2gADmtmNiZcjHBj3apaMwW7rQNVlOPsuPLiS6yzdw
         ug5qBzYIwNEVKxmgHyRK2fLx9vVK0kA4F4E+/2R1u/xmEk8VeNjLgcg0ovN9deK5SvFl
         WVSw==
Received: by 10.152.104.212 with SMTP id gg20mr9299300lab.24.1336757223776;
        Fri, 11 May 2012 10:27:03 -0700 (PDT)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru. [213.79.90.226])
        by mx.google.com with ESMTPS id gt19sm6975566lab.17.2012.05.11.10.27.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 May 2012 10:27:02 -0700 (PDT)
Message-ID: <4FAD4B9E.70803@mvista.com>
Date:   Fri, 11 May 2012 21:25:50 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Leonid Yegoshin <yegoshin@mips.com>
Subject: Re: [PATCH v2] Add MIPS64R2 core support.
References: <1336717784-853-1-git-send-email-sjhill@mips.com>
In-Reply-To: <1336717784-853-1-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQlIHdz6dBUZv9EAjXjnojARsZZbRIkNdcNXNsgcidiQ6YN7pKlx7PNTqBJ8gGnPFt/MBqAP
X-archive-position: 33263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 05/11/2012 10:29 AM, Steven J. Hill wrote:

> From: "Steven J. Hill"<sjhill@mips.com>

    Looks like the subject is incorrect. Should be "Add MIPS 5KE support"?

> Signed-off-by: Leonid Yegoshin<yegoshin@mips.com>
> Signed-off-by: Steven J. Hill<sjhill@mips.com>
[...]

> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index d0570f4..862a9c3 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -282,6 +282,7 @@ config MIPS_MALTA
>   	select SYS_HAS_CPU_MIPS32_R1
>   	select SYS_HAS_CPU_MIPS32_R2
>   	select SYS_HAS_CPU_MIPS64_R1
> +	select SYS_HAS_CPU_MIPS64_R2
>   	select SYS_HAS_CPU_NEVADA
>   	select SYS_HAS_CPU_RM7000
>   	select SYS_HAS_EARLY_PRINTK
> @@ -2488,6 +2489,7 @@ config TRAD_SIGNALS
>   config MIPS32_COMPAT
>   	bool "Kernel support for Linux/MIPS 32-bit binary compatibility"
>   	depends on 64BIT
> +	default y if CPU_SUPPORTS_32BIT_KERNEL && SYS_SUPPORTS_32BIT_KERNEL
>   	help
>   	  Select this option if you want Linux/MIPS 32-bit binary
>   	  compatibility. Since all software available for Linux/MIPS is
> @@ -2507,6 +2509,7 @@ config SYSVIPC_COMPAT
>   config MIPS32_O32
>   	bool "Kernel support for o32 binaries"
>   	depends on MIPS32_COMPAT
> +	default y if CPU_SUPPORTS_32BIT_KERNEL&&  SYS_SUPPORTS_32BIT_KERNEL
>   	help
>   	  Select this option if you want to run o32 binaries.  These are pure
>   	  32-bit binaries as used by the 32-bit Linux/MIPS port.  Most of
> @@ -2525,6 +2528,10 @@ config MIPS32_N32
>
>   	  If unsure, say N.
>
> +comment "64bit kernel, but support of 32bit applications is disabled!"
> +	depends on 64BIT&&  !MIPS32_O32&&  !MIPS32_N32
> +	depends on CPU_SUPPORTS_32BIT_KERNEL&&  SYS_SUPPORTS_32BIT_KERNEL
> +

    The above looks like a material for separate patch...

WBR, Sergei
