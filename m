Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Oct 2013 07:46:38 +0200 (CEST)
Received: from mail-ea0-f178.google.com ([209.85.215.178]:47901 "EHLO
        mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819547Ab3JHFqTY5kPM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Oct 2013 07:46:19 +0200
Received: by mail-ea0-f178.google.com with SMTP id a15so3728943eae.9
        for <multiple recipients>; Mon, 07 Oct 2013 22:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=u1VwJ2ScCHiWhcPimb/lG2HPNOjvvzgWSeDmG7g9ItA=;
        b=g6QEpctE2oWBL9gmssEHhBtwf8NKnezwFOUZcoKm2lqP6z14XzvdBUObExeqGHIE87
         WjjkUWU2hYtprP8S1AVxNPe5ZCGxY9lk1M1NDrb3emOLmL3UW8ooRGUSySvhraPkBKjR
         8PCLDckigbzIs5mHVKB8NwK5Fz9TbUY6UurUcWv+Fw19Feoe5qIXad1oFaGPFUwFjTLP
         dUEIf9+Vah74IqQQOzMjC5NTEqkK0Iv/9r2fET6Z1hhCbLcoJg/J+AZ7YeJAenTw7+tD
         oT353LJY3diBKTAMfjlAQJVSNfXEUjp8VFAQqG2chFZXTrlp3DzLabCmesSaFqJPsZLo
         E0/Q==
X-Received: by 10.14.3.9 with SMTP id 9mr295077eeg.72.1381211173800;
        Mon, 07 Oct 2013 22:46:13 -0700 (PDT)
Received: from gmail.com (BC24D856.catv.pool.telekom.hu. [188.36.216.86])
        by mx.google.com with ESMTPSA id a43sm71536301eep.9.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 07 Oct 2013 22:46:13 -0700 (PDT)
Date:   Tue, 8 Oct 2013 07:46:10 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mark Salter <msalter@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
        linux-alpha@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        microblaze-uclinux@itee.uq.edu.au,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Paul Mundt <lethal@linux-sh.org>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH v2 14/14] Kconfig cleanup (PARPORT_PC dependencies)
Message-ID: <20131008054610.GE14353@gmail.com>
References: <1381209030-351-1-git-send-email-msalter@redhat.com>
 <1381209030-351-15-git-send-email-msalter@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1381209030-351-15-git-send-email-msalter@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <mingo.kernel.org@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38250
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@kernel.org
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


* Mark Salter <msalter@redhat.com> wrote:

> Remove messy dependencies from PARPORT_PC by having it depend on one
> Kconfig symbol (ARCH_MAY_HAVE_PC_PARPORT) and having architectures
> which need it, select ARCH_MAY_HAVE_PC_PARPORT in arch/*/Kconfig.
> New architectures are unlikely to need PARPORT_PC, so this avoids
> having an ever growing list of architectures to exclude. Those
> architectures which do select ARCH_MAY_HAVE_PC_PARPORT in this
> patch are the ones which have an asm/parport.h (or use the generic
> version).
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>
> CC: Richard Henderson <rth@twiddle.net>
> CC: linux-alpha@vger.kernel.org
> CC: Vineet Gupta <vgupta@synopsys.com>
> CC: Russell King <linux@arm.linux.org.uk>
> CC: linux-arm-kernel@lists.infradead.org
> CC: Tony Luck <tony.luck@intel.com>
> CC: Fenghua Yu <fenghua.yu@intel.com>
> CC: linux-ia64@vger.kernel.org
> CC: Geert Uytterhoeven <geert@linux-m68k.org>
> CC: linux-m68k@lists.linux-m68k.org
> CC: Michal Simek <monstr@monstr.eu>
> CC: microblaze-uclinux@itee.uq.edu.au
> CC: Ralf Baechle <ralf@linux-mips.org>
> CC: linux-mips@linux-mips.org
> CC: "James E.J. Bottomley" <jejb@parisc-linux.org>
> CC: Helge Deller <deller@gmx.de>
> CC: linux-parisc@vger.kernel.org
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Paul Mackerras <paulus@samba.org>
> CC: linuxppc-dev@lists.ozlabs.org
> CC: Paul Mundt <lethal@linux-sh.org>
> CC: linux-sh@vger.kernel.org
> CC: "David S. Miller" <davem@davemloft.net>
> CC: sparclinux@vger.kernel.org
> CC: Guan Xuetao <gxt@mprc.pku.edu.cn>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: "H. Peter Anvin" <hpa@zytor.com>
> CC: x86@kernel.org
> ---
>  drivers/parport/Kconfig | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/parport/Kconfig b/drivers/parport/Kconfig
> index 70694ce..a079b18 100644
> --- a/drivers/parport/Kconfig
> +++ b/drivers/parport/Kconfig
> @@ -31,13 +31,17 @@ menuconfig PARPORT
>  
>  	  If unsure, say Y.
>  
> +config ARCH_MAY_HAVE_PC_PARPORT
> +	bool
> +	help
> +	  Select this config option from the architecture Kconfig if
> +	  the architecture may have PC parallel port hardware.
> +
>  if PARPORT
>  
>  config PARPORT_PC
>  	tristate "PC-style hardware"
> -	depends on (!SPARC64 || PCI) && !SPARC32 && !M32R && !FRV && !S390 && \
> -		(!M68K || ISA) && !MN10300 && !AVR32 && !BLACKFIN && \
> -		!XTENSA && !CRIS && !H8300
> +	depends on ARCH_MAY_HAVE_PC_PARPORT
>  
>  	---help---
>  	  You should say Y here if you have a PC-style parallel port. All

Since it's not a permission to have a parallel port but a possibility,
I suspect the whole series needs a:

  s/MAY_HAVE/MIGHT_HAVE
  s/may have/might have

Otherwise:

  Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
