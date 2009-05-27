Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 May 2009 10:19:47 +0100 (BST)
Received: from mx1.moondrake.net ([212.85.150.166]:48844 "EHLO
	mx1.mandriva.com" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S20023634AbZE0JTk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 27 May 2009 10:19:40 +0100
Received: by mx1.mandriva.com (Postfix, from userid 501)
	id 8DDE9274002; Wed, 27 May 2009 11:19:39 +0200 (CEST)
Received: from office-abk.mandriva.com (office-abk.mandriva.com [84.55.162.90])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.mandriva.com (Postfix) with ESMTP id AB87F274001;
	Wed, 27 May 2009 11:19:37 +0200 (CEST)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
	by office-abk.mandriva.com (Postfix) with ESMTP id 597208281C;
	Wed, 27 May 2009 11:24:51 +0200 (CEST)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
	by anduin.mandriva.com (Postfix) with ESMTP id 7F6A8FF855;
	Wed, 27 May 2009 11:22:35 +0200 (CEST)
From:	Arnaud Patard <apatard@mandriva.com>
To:	wuzhangjin@gmail.com
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: Re: [loongson-PATCH-v2 20/23] add gcc 4.4 support for MIPS and loongson
References: <cover.1243362545.git.wuzj@lemote.com>
	<afda033feccfe0946c308eddc86b2049f4919be2.1243362545.git.wuzj@lemote.com>
Organization: Mandriva
Date:	Wed, 27 May 2009 11:22:35 +0200
In-Reply-To: <afda033feccfe0946c308eddc86b2049f4919be2.1243362545.git.wuzj@lemote.com> (wuzhangjin@gmail.com's message of "Wed, 27 May 2009 03:09:13 +0800")
Message-ID: <m33aaqq4ro.fsf@anduin.mandriva.com>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <arnaud.patard@mandriva.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips

wuzhangjin@gmail.com writes:
Hi,

> From: Wu Zhangjin <wuzj@lemote.com>
>
> the gcc 4.4 support for MIPS mostly refer to this PATCH:
> http://www.nabble.com/-PATCH--MIPS:-Handle-removal-of-%27h%27-constraint-in-GCC-4.4-td22192768.html
> but have been tuned a little.
>
> because only gcc 4.4 have loongson-specific support, so, we need to
> choose the suitable -march argument for gcc <= 4.3 and gcc >= 4.4, and
> we also need to consider use -march=loongson2e and -march=loongson2f for
> loongson2e and loongson2f respectively. this is handled by adding two
> new kernel options: CPU_LOONGSON2E and CPU_LOONGSON2F(thanks for the
> solutin provided by ZhangLe).
>
> I have tested it on FuLoong(2f) in 32bit and 64bit with gcc-4.4 and
> gcc-4.3. so, basically, it works.
>
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/Makefile               |    9 +++++-
>  arch/mips/include/asm/compiler.h |   10 ++++++
>  arch/mips/include/asm/delay.h    |   58 +++++++++++++++++++++++++------------
>  3 files changed, 57 insertions(+), 20 deletions(-)
>
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index a25c2e5..1ee5504 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -120,7 +120,14 @@ cflags-$(CONFIG_CPU_R4300)	+= -march=r4300 -Wa,--trap
>  cflags-$(CONFIG_CPU_VR41XX)	+= -march=r4100 -Wa,--trap
>  cflags-$(CONFIG_CPU_R4X00)	+= -march=r4600 -Wa,--trap
>  cflags-$(CONFIG_CPU_TX49XX)	+= -march=r4600 -Wa,--trap
> -cflags-$(CONFIG_CPU_LOONGSON2)	+= -march=r4600 -Wa,--trap
> +
> +# only gcc >= 4.4 have the loongson-specific support
> +cflags-$(CONFIG_CPU_LOONGSON2)	+= -Wa,--trap
> +cflags-$(CONFIG_CPU_LOONGSON2E)	+= $(shell if [ $(call cc-version) -lt 0440 ] ; then \
> +	echo $(call cc-option,-march=r4600); else echo $(call cc-option,-march=loongson2e); fi ;)
> +cflags-$(CONFIG_CPU_LOONGSON2F)	+= $(shell if [ $(call cc-version) -lt 0440 ] ; then \
> +	echo $(call cc-option,-march=r4600); else echo $(call cc-option,-march=loongson2f); fi ;)
> +

why not using something like that ? :
        cflags-$(CONFIG_LOONGSON2E) += \
                $(call cc-option,-march=loongson2e,$(call cc-option,-march=r4600))
        cflags-$(CONFIG_LOONGSON2F) += \
                $(call cc-option,-march=loongson2f,$(call cc-option,-march=r4600))

Arnaud
