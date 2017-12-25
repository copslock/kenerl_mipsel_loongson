Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Dec 2017 18:43:49 +0100 (CET)
Received: from mail-pl0-x241.google.com ([IPv6:2607:f8b0:400e:c01::241]:47031
        "EHLO mail-pl0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990426AbdLYRnlSymMW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Dec 2017 18:43:41 +0100
Received: by mail-pl0-x241.google.com with SMTP id i6so16867995plt.13;
        Mon, 25 Dec 2017 09:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GD6f0QMjongdb1Lr5FxFbDlgm/RJdwszNEf/wNSd6A4=;
        b=soNdCE+/SPm2oqDYTUysp4UgPSuUsfFr6uPnMCWqkOVi8cx1E30ESaQTE5pCnaLw5e
         MqBTOWiEP7buqr7A7Ylla4jOc5UiLFfBxPOCaqT/OQm8DdWqtgWFAEyS8dEolVL13EgW
         0x8Xj6xe6lkoCGIwo5qZYqyw4t70LMJuRZQfWuTJv8aE0s2TsyLY33T4IqErZIgSI/8T
         Sc4nLFCW92rRhreLfQprWmpi3+qIU+0pXGDTlTeVYTz5V2H4Rf3pztxfTi4PP8LE71uK
         zpo/fAyFjzXg3UcY3WERO4RdBIScZnBxVgmJKLgeoPC4Ba4Da8N9JSrrMMHkSijPlVGO
         6jIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GD6f0QMjongdb1Lr5FxFbDlgm/RJdwszNEf/wNSd6A4=;
        b=Go2jzRobCXATHlsxAwyi+g7zr0yDwfW5J1hnPkPyVW9TKoWMWEUDmCq4BHZ8nViD8a
         75ihMbeomHmbcy56bGzJevhtFfz6I0Ew08kNmLdp+qX03tUcVvPVyWwzCPGtVqqlEvva
         qKhP+SriFgXKSjfsvhq0dOo87whgPk/HV+aae9+Me1+wz+xggK8sNWRWWPEtTIpQcyeN
         kZNfqNMXlo1MdMI9vwyuwG7Wu+OopWNUWqlQ3GMRojTljDRtmNVu4CySy25IGPv/o7Kx
         hMFrVHLf4ku6nKQBu2AsKHvh1V/nzNM0IXMG2naV0eTYRsjAYy2XQVtnJ1xkJD5M/9No
         FCXQ==
X-Gm-Message-State: AKGB3mIXRhL1tqvrLFRfN9buNsNuy5LHEW7W2u1TTRdPgrR0+b9bZN2O
        sNDf54FOlMoVE/1FDXaCHlc=
X-Google-Smtp-Source: ACJfBou9oDHcjGwXi3TX0ZbZUG61S7N7gZQ+/l7TouRquG7MtKK/7C2L58z9E68YWTjjzlS86dNZ4Q==
X-Received: by 10.84.168.162 with SMTP id f31mr22835321plb.249.1514223814676;
        Mon, 25 Dec 2017 09:43:34 -0800 (PST)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id e70sm29560830pfc.185.2017.12.25.09.43.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Dec 2017 09:43:34 -0800 (PST)
Date:   Mon, 25 Dec 2017 09:43:33 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     James Hogan <james.hogan@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-kernel@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        linux-mips@linux-mips.org
Subject: Re: MIPS: Fix CPS SMP NS16550 UART defaults
Message-ID: <20171225174333.GA28567@roeck-us.net>
References: <20171121000240.4058-1-james.hogan@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171121000240.4058-1-james.hogan@mips.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61570
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Tue, Nov 21, 2017 at 12:02:40AM +0000, James Hogan wrote:
> From: James Hogan <jhogan@kernel.org>
> 
> The MIPS_CPS_NS16550_BASE and MIPS_CPS_NS16550_SHIFT options have no
> defaults for non-Malta platforms which select SYS_SUPPORTS_MIPS_CPS
> (i.e. the pistachio and generic platforms). This is problematic for
> automated allyesconfig and allmodconfig builds based on these platforms,
> since make silentoldconfig tries to ask the user for values, and
> especially since v4.15 where the default platform was switched to
> generic.
> 
> Default these options to 0 and arrange for MIPS_CPS_NS16550 to be no
> when using that default base address, so that the option only has an
> effect when the default is provided (i.e. Malta) or when a value is
> provided by the user.
> 
> Fixes: 609cf6f2291a ("MIPS: CPS: Early debug using an ns16550-compatible UART")
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Reviewed-by: Paul Burton <paul.burton@mips.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-mips@linux-mips.org
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Still not applied, mips builds still broken both in mainline and -next
(and worse in -next). Doesn't 0day report all this breakage automatically ?

Guenter

> ---
> Guenter: I'm guessing this is the problem you're referring to.
> ---
>  arch/mips/Kconfig.debug | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
> index 464af5e025d6..0749c3724543 100644
> --- a/arch/mips/Kconfig.debug
> +++ b/arch/mips/Kconfig.debug
> @@ -124,30 +124,36 @@ config SCACHE_DEBUGFS
>  
>  	  If unsure, say N.
>  
> -menuconfig MIPS_CPS_NS16550
> +menuconfig MIPS_CPS_NS16550_BOOL
>  	bool "CPS SMP NS16550 UART output"
>  	depends on MIPS_CPS
>  	help
>  	  Output debug information via an ns16550 compatible UART if exceptions
>  	  occur early in the boot process of a secondary core.
>  
> -if MIPS_CPS_NS16550
> +if MIPS_CPS_NS16550_BOOL
> +
> +config MIPS_CPS_NS16550
> +	def_bool MIPS_CPS_NS16550_BASE != 0
>  
>  config MIPS_CPS_NS16550_BASE
>  	hex "UART Base Address"
>  	default 0x1b0003f8 if MIPS_MALTA
> +	default 0
>  	help
>  	  The base address of the ns16550 compatible UART on which to output
>  	  debug information from the early stages of core startup.
>  
> +	  This is only used if non-zero.
> +
>  config MIPS_CPS_NS16550_SHIFT
>  	int "UART Register Shift"
> -	default 0 if MIPS_MALTA
> +	default 0
>  	help
>  	  The number of bits to shift ns16550 register indices by in order to
>  	  form their addresses. That is, log base 2 of the span between
>  	  adjacent ns16550 registers in the system.
>  
> -endif # MIPS_CPS_NS16550
> +endif # MIPS_CPS_NS16550_BOOL
>  
>  endmenu
