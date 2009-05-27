Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 May 2009 10:48:22 +0100 (BST)
Received: from mx1.moondrake.net ([212.85.150.166]:48096 "EHLO
	mx1.mandriva.com" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S20023985AbZE0JsQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 27 May 2009 10:48:16 +0100
Received: by mx1.mandriva.com (Postfix, from userid 501)
	id 31144274005; Wed, 27 May 2009 11:48:15 +0200 (CEST)
Received: from office-abk.mandriva.com (office-abk.mandriva.com [84.55.162.90])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.mandriva.com (Postfix) with ESMTP id 9A2B3274001;
	Wed, 27 May 2009 11:48:13 +0200 (CEST)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
	by office-abk.mandriva.com (Postfix) with ESMTP id 6DFDF8281C;
	Wed, 27 May 2009 11:53:27 +0200 (CEST)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
	by anduin.mandriva.com (Postfix) with ESMTP id CB59EFF855;
	Wed, 27 May 2009 11:51:11 +0200 (CEST)
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
Subject: Re: [loongson-PATCH-v2 23/23] Hibernation Support in mips system
References: <cover.1243362545.git.wuzj@lemote.com>
	<1483a7cb0f587bd329ea3ca8d3af2881afadaf5e.1243362545.git.wuzj@lemote.com>
Organization: Mandriva
Date:	Wed, 27 May 2009 11:51:11 +0200
In-Reply-To: <1483a7cb0f587bd329ea3ca8d3af2881afadaf5e.1243362545.git.wuzj@lemote.com> (wuzhangjin@gmail.com's message of "Wed, 27 May 2009 03:10:05 +0800")
Message-ID: <m3my8yoovk.fsf@anduin.mandriva.com>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <arnaud.patard@mandriva.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips

wuzhangjin@gmail.com writes:

Hi,

[...]

> +LEAF(swsusp_arch_resume)
> +	PTR_L t0, restore_pblist
> +0:
> +	PTR_L t1, PBE_ADDRESS(t0)   /* source */
> +	PTR_L t2, PBE_ORIG_ADDRESS(t0) /* destination */
> +	PTR_ADDIU t3, t1, _PAGE_SIZE
> +1:
> +	REG_L t8, (t1)
> +	REG_S t8, (t2)
> +	PTR_ADDIU t1, t1, SZREG
> +	PTR_ADDIU t2, t2, SZREG
> +	bne t1, t3, 1b
> +	PTR_L t0, PBE_NEXT(t0)
> +	bnez t0, 0b

you really need to flush cache/tlb here. If you don't do that you'll get
some weird bugs.


Arnaud
