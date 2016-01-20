Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jan 2016 19:55:22 +0100 (CET)
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33954 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014822AbcATSzTgQLIS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jan 2016 19:55:19 +0100
Received: by mail-oi0-f68.google.com with SMTP id x140so918734oif.1;
        Wed, 20 Jan 2016 10:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=vO0eGub3mHGrtFUf0j95VEPNjqzFJBekvVChmb7e7/g=;
        b=KCHDluZ7CdIF2f6Qy1YA1mAJ8uxPtZdEtiM3HMpnjIes5jNRmchqOwWa1k+ksikr6m
         wg7tktvZ3CGM5uGIvCLDmzMAmgd8xCUMLBulFYSh2xEhG5USUlCm3NFtsBdsFKj5CnMS
         mPu25iec/wXb5PrRq8z5w6w81Dj3w5kz0WrN+rGSVzMI3LziJSiMHi7OTA4ydgM09DAs
         xnvW0UfBt0FQzU4UTv9JGRqk9mGjwHd5L1q1Wy/QqCk5cJ8PT0JsBFG9F8PsHRQYFPh1
         9o+cVWfgyIIi5/6nYiUbncDYfsQxep2C2IpbCjmLc7tR6t09kyCzpHM1NAhqzrgMgG5N
         gs9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=vO0eGub3mHGrtFUf0j95VEPNjqzFJBekvVChmb7e7/g=;
        b=ifHdLO9NpVRxbevzD9t6bVu+euFG90gOT6TyCFZ+8jigg0ekwffP0Sp1hy/dGOP1EQ
         gDdqKCmg+xJWMZDvDfvByj8aZO0H253mrDIC48mXpPK5HF7HB0OostB/mkMFPqmy+36S
         nRPEoX39Pey33sOvputR6f3bUdxwh6XrfIcuWMlgBDx9FbY29vQKPemRWKgbRKc8/Rn5
         Q04vmPQMIw2BiTUpdJbN4i2BAcS0DCZeQ1fewNdc2wzwRUhXuXTSpCPAce68g7CYSJL7
         9oVsjrzdyuCdRssow9Lj3KJJm6QKOHPj8fRkDIjbYUl2dBJ/R/RY0cXZCFLALg2vJQvL
         0DCQ==
X-Gm-Message-State: ALoCoQmc2Fo/z85e4SUMo8uLYm28OzrDPHu9sRoVK2YoOKvaVVDpXwfP5pxyab/vaESsFkxZprokyyFc5zgnpq0AYOKId6rrxg==
X-Received: by 10.202.0.204 with SMTP id 195mr28501830oia.131.1453316113833;
        Wed, 20 Jan 2016 10:55:13 -0800 (PST)
Received: from ?IPv6:2001:470:d:73f:587d:c5d8:81cd:4741? ([2001:470:d:73f:587d:c5d8:81cd:4741])
        by smtp.googlemail.com with ESMTPSA id mm4sm18740114obb.1.2016.01.20.10.55.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Jan 2016 10:55:12 -0800 (PST)
Subject: Re: [PATCH v2 2/2] kbuild: Remove stale asm-generic wrappers
To:     James Hogan <james.hogan@imgtec.com>,
        Michal Marek <mmarek@suse.com>
References: <1453210670-12596-1-git-send-email-james.hogan@imgtec.com>
 <1453210670-12596-3-git-send-email-james.hogan@imgtec.com>
Cc:     linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mips@linux-mips.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <569FD80F.2000109@gmail.com>
Date:   Wed, 20 Jan 2016 10:55:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1453210670-12596-3-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51259
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Le 19/01/2016 05:37, James Hogan a écrit :
> When a header file is removed from generic-y (often accompanied by the
> addition of an arch specific header), the generated wrapper file will
> persist, and in some cases may still take precedence over the new arch
> header.
> 
> For example commit f1fe2d21f4e1 ("MIPS: Add definitions for extended
> context") removed ucontext.h from generic-y in arch/mips/include/asm/,
> and added an arch/mips/include/uapi/asm/ucontext.h. The continued use of
> the wrapper when reusing a dirty build tree resulted in build failures
> in arch/mips/kernel/signal.c:
> 
> arch/mips/kernel/signal.c: In function ‘sc_to_extcontext’:
> arch/mips/kernel/signal.c:142:12: error: ‘struct ucontext’ has no member named ‘uc_extcontext’
>   return &uc->uc_extcontext;
>             ^
> 
> Fix by detecting and removing wrapper headers in generated header
> directories that do not correspond to a filename in generic-y, genhdr-y,
> or the newly introduced generated-y.
> 
> Reported-by: Jacek Anaszewski <j.anaszewski@samsung.com>
> Reported-by: Hauke Mehrtens <hauke@hauke-m.de>
> Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks for looking into this James.

> Cc: Michal Marek <mmarek@suse.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> ---
> Changes in v2:
> - Rewrite a bit, drawing inspiration from Makefile.headersinst.
> - Exclude genhdr-y and generated-y (thanks to kbuild test robot).
> ---
>  scripts/Makefile.asm-generic | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.asm-generic b/scripts/Makefile.asm-generic
> index 045e0098e962..24c29f16f029 100644
> --- a/scripts/Makefile.asm-generic
> +++ b/scripts/Makefile.asm-generic
> @@ -13,11 +13,26 @@ include scripts/Kbuild.include
>  # Create output directory if not already present
>  _dummy := $(shell [ -d $(obj) ] || mkdir -p $(obj))
>  
> +# Stale wrappers when the corresponding files are removed from generic-y
> +# need removing.
> +generated-y   := $(generic-y) $(genhdr-y) $(generated-y)
> +all-files     := $(patsubst %, $(obj)/%, $(generated-y))
> +old-headers   := $(wildcard $(obj)/*.h)
> +unwanted      := $(filter-out $(all-files),$(old-headers))
> +
>  quiet_cmd_wrap = WRAP    $@
>  cmd_wrap = echo "\#include <asm-generic/$*.h>" >$@
>  
> -all: $(patsubst %, $(obj)/%, $(generic-y))
> +quiet_cmd_remove = REMOVE  $(unwanted)
> +cmd_remove = rm -f $(unwanted)
> +
> +all: $(patsubst %, $(obj)/%, $(generic-y)) FORCE
> +	$(if $(unwanted),$(call cmd,remove),)
>  	@:
>  
>  $(obj)/%.h:
>  	$(call cmd,wrap)
> +
> +.PHONY: $(PHONY)
> +PHONY += FORCE
> +FORCE: ;
> 


-- 
Florian
