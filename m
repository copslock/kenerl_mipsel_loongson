Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Dec 2004 14:38:05 +0000 (GMT)
Received: from mfo06.iij.ad.jp ([IPv6:::ffff:210.130.1.94]:38599 "EHLO
	mfo06.iij.ad.jp") by linux-mips.org with ESMTP id <S8225296AbULHOh7>;
	Wed, 8 Dec 2004 14:37:59 +0000
Received: MFO(mfo06) for <linux-mips@linux-mips.org> id iB8E6xr6021158; Wed, 8 Dec 2004 23:06:59 +0900 (JST)
Received: MO(mo00) for <linux-mips@linux-mips.org> id iB8E6l0T010344; Wed, 8 Dec 2004 23:06:48 +0900 (JST)
Received: MDO(mdo01) id iB8E6lYi027037; Wed, 8 Dec 2004 23:06:47 +0900 (JST)
Received: 4UMRO00 id iB8E6ksM001286; Wed, 8 Dec 2004 23:06:47 +0900 (JST)
	from stratos (localhost [127.0.0.1])
	for <linux-mips@linux-mips.org>; (authenticated)
Date: Wed, 8 Dec 2004 23:06:45 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: linux-mips <linux-mips@linux-mips.org>
Subject: early_initcall
Message-Id: <20041208230645.7f1c33e8.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi,

Since early_initcall is not defined in generic 2.6.10-rc3,
MIPS has a problem in generic kernel.

I investigated why early_initcall is not defined in generic kernel.
I found a following mail in LKML.

We need to move early_initcall to MIPS-specific header file.
Where do you think is a suitable header file for it?

Yoichi

---- Andrew's comment ----
From: Andrew Morton <akpm@osdl.org>
To: Samium Gromoff <deepfire@sic-elvis.zel.ru>
Cc: linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [2.6.5][MIPS] oneliners somehow not made it into mainline [3/3]
Date: 	Mon, 12 Apr 2004 14:06:28 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)

Samium Gromoff <deepfire@sic-elvis.zel.ru> wrote:
>
> Without this one it fails to run the earlyinitcall stuff, and hence
> explodes at some point.
> 
> diff -urN -X './#cdiff.pattern' ./linux-2.6.5/include/linux/init.h ./mc-2.6.5/include/linux/init.h
> --- ./linux-2.6.5/include/linux/init.h  2004-04-12 16:07:45.000000000 +0400
> +++ ./mc-2.6.5/include/linux/init.h     2004-04-12 18:05:28.000000000 +0400
> @@ -83,6 +83,7 @@
>         static initcall_t __initcall_##fn __attribute_used__ \
>         __attribute__((__section__(".initcall" level ".init"))) = fn
> 
> +#define early_initcall(fn)             __define_initcall(".early1",fn)
>  #define core_initcall(fn)              __define_initcall("1",fn)
>  #define postcore_initcall(fn)          __define_initcall("2",fn)
>  #define arch_initcall(fn)              __define_initcall("3",fn)

early_initcall() is a mips-specific thing.  If we add this macro to
<linux/init.h> then someone will use it in generic code and all the other
architectures explode.

We need to either make this entirely mips-private, or rework the mips code
to not use it at all, or justify its introduction and then introduce it for
all architectures.
