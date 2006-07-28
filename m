Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jul 2006 02:44:42 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:40249 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8134056AbWG1Boc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Jul 2006 02:44:32 +0100
Received: by mo.po.2iij.net (mo31) id k6S1iQx5027247; Fri, 28 Jul 2006 10:44:26 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox32) id k6S1iOt1059064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 28 Jul 2006 10:44:25 +0900 (JST)
Date:	Fri, 28 Jul 2006 10:44:24 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Peter Watkins <treestem@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Use compat code to translate siginfo_t for N32
Message-Id: <20060728104424.19e1bfaa.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <44C94FEA.1010607@gmail.com>
References: <44C94FEA.1010607@gmail.com>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12105
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

> diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
> index 881c467..108171a 100644
> --- a/arch/mips/kernel/Makefile
> +++ b/arch/mips/kernel/Makefile
> @@ -56,8 +56,8 @@ obj-$(CONFIG_32BIT)           += scall32-o32.o
>  obj-$(CONFIG_64BIT)            += scall64-64.o
>  obj-$(CONFIG_BINFMT_IRIX)      += binfmt_irix.o
>  obj-$(CONFIG_MIPS32_COMPAT)    += linux32.o signal32.o
> -obj-$(CONFIG_MIPS32_N32)       += binfmt_elfn32.o scall64-n32.o signal_n32.o
> -obj-$(CONFIG_MIPS32_O32)       += binfmt_elfo32.o scall64-o32.o ptrace32.o
> +obj-$(CONFIG_MIPS32_N32)       += binfmt_elfn32.o scall64-n32.o signal_n32.o compat32.o
> +obj-$(CONFIG_MIPS32_O32)       += binfmt_elfo32.o scall64-o32.o ptrace32.o compat32.o

Why do you separate comapt32.o ?

> diff --git a/arch/mips/kernel/compat32.c b/arch/mips/kernel/compat32.c
> new file mode 100644
> index 0000000..858f7db
> --- /dev/null
> +++ b/arch/mips/kernel/compat32.c

<snip>

> +int copy_siginfo_to_user32(compat_siginfo_t *to, siginfo_t *from)

see include/linux/compat.h .

int copy_siginfo_to_user32(struct compat_siginfo __user *to, siginfo_t *from);


> diff --git a/arch/mips/kernel/compat32.h b/arch/mips/kernel/compat32.h
> new file mode 100644
> index 0000000..e2bb23b
> --- /dev/null
> +++ b/arch/mips/kernel/compat32.h
> @@ -0,0 +1,76 @@

<snip>

> +int copy_siginfo_to_user32(compat_siginfo_t *to, siginfo_t *from);

It's already defined in include/linux/compat.h .

> diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
> index 477c533..f805bea 100644
> --- a/arch/mips/kernel/signal_n32.c
> +++ b/arch/mips/kernel/signal_n32.c

<snip>

> @@ -74,7 +76,7 @@ #if ICACHE_REFILLS_WORKAROUND_WAR
>  #else
>  	u32 rs_code[2];			/* signal trampoline */
>  #endif
> -	struct siginfo rs_info;
> +	compat_siginfo_t rs_info;

use struct compat_siginfo .

Yoichi
