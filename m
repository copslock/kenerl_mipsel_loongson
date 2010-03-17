Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Mar 2010 14:52:36 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:34974 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492194Ab0CQNwb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 17 Mar 2010 14:52:31 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2HDqP30004844;
        Wed, 17 Mar 2010 14:52:26 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2HDqNEb004841;
        Wed, 17 Mar 2010 14:52:23 +0100
Date:   Wed, 17 Mar 2010 14:52:23 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     linux-mips@linux-mips.org,
        Shinya Kuribayashi <shinya.kuribayashi@necel.com>,
        Zhang Le <r0bertz@gentoo.org>, Wu Zhangjin <wuzj@lemote.com>
Subject: Re: [PATCH v3 2/3] Loongson-2F: Enable fixups of binutils 2.20.1
Message-ID: <20100317135223.GA4554@linux-mips.org>
References: <cover.1268453720.git.wuzhangjin@gmail.com>
 <ecc51ee134ab84c95b6b02534544df3731bb9562.1268453720.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecc51ee134ab84c95b6b02534544df3731bb9562.1268453720.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Mar 13, 2010 at 12:34:16PM +0800, Wu Zhangjin wrote:

> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 2f2eac2..5ae342e 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -135,7 +135,9 @@ cflags-$(CONFIG_CPU_LOONGSON2)	+= -Wa,--trap
>  cflags-$(CONFIG_CPU_LOONGSON2E) += \
>  	$(call cc-option,-march=loongson2e,-march=r4600)
>  cflags-$(CONFIG_CPU_LOONGSON2F) += \
> -	$(call cc-option,-march=loongson2f,-march=r4600)
> +	$(call cc-option,-march=loongson2f,-march=r4600) \
> +	$(call as-option,-Wa$(comma)-mfix-loongson2f-nop,) \
> +	$(call as-option,-Wa$(comma)-mfix-loongson2f-jump,)

Shouldn't these options be used unconditionally?  It seems a kernel build
should rather fail than a possibly unreliable kernel be built - possibly
even without the user noticing the problem.

  Ralf
