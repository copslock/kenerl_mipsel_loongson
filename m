Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2009 16:45:13 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:57838 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S20024507AbZE1Po4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 May 2009 16:44:56 +0100
Received: from localhost (p7181-ipad208funabasi.chiba.ocn.ne.jp [60.43.108.181])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id CFDC9A73F; Fri, 29 May 2009 00:44:50 +0900 (JST)
Date:	Fri, 29 May 2009 00:44:52 +0900 (JST)
Message-Id: <20090529.004452.242161110.anemo@mba.ocn.ne.jp>
To:	wuzhangjin@gmail.com
Cc:	apatard@mandriva.com, huhb@lemote.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org, yanh@lemote.com, philippe@cowpig.ca,
	r0bertz@gentoo.org, zhangfx@lemote.com,
	loongson-dev@googlegroups.com, der.herr@hofr.at, liujl@lemote.com,
	erwan@thiscow.com
Subject: Re: [loongson-PATCH-v2 23/23] Hibernation Support in mips system
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1243450339.11263.125.camel@falcon>
References: <1483a7cb0f587bd329ea3ca8d3af2881afadaf5e.1243362545.git.wuzj@lemote.com>
	<m3my8yoovk.fsf@anduin.mandriva.com>
	<1243450339.11263.125.camel@falcon>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 28 May 2009 02:52:19 +0800, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> diff --git a/arch/mips/power/hibernate.S b/arch/mips/power/hibernate.S
> index 9dbe48e..1f06fd5 100644
> --- a/arch/mips/power/hibernate.S
> +++ b/arch/mips/power/hibernate.S
...
> @@ -39,6 +47,16 @@ LEAF(swsusp_arch_resume)
>         bne t1, t3, 1b
>         PTR_L t0, PBE_NEXT(t0)
>         bnez t0, 0b
> +       /* flush caches to make sure context is in memory */
> +       PTR_LA t1, flush_cache_all
> +       PTR_L t0, 0(t1)
> +       jalr t0
> +       nop

flush_cache_all is cache_noop on r4k.  Maybe __flush_cache_all ?

Also, you can write this like:

	PTR_L t0, flush_cache_all
	jalr t0

The nop just after the jalr is not needed since or are in "reorder"
mode here.

---
Atsushi Nemoto
