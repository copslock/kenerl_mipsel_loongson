Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 09:24:11 +0100 (BST)
Received: from mx1.moondrake.net ([212.85.150.166]:46786 "EHLO
	mx1.mandriva.com" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S20021828AbZEOIYF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2009 09:24:05 +0100
Received: by mx1.mandriva.com (Postfix, from userid 501)
	id 4B75127400C; Fri, 15 May 2009 10:24:04 +0200 (CEST)
Received: from office-abk.mandriva.com (office-abk.mandriva.com [84.55.162.90])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.mandriva.com (Postfix) with ESMTP id B06FA274009;
	Fri, 15 May 2009 10:24:02 +0200 (CEST)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
	by office-abk.mandriva.com (Postfix) with ESMTP id 7D29282946;
	Fri, 15 May 2009 10:28:40 +0200 (CEST)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
	by anduin.mandriva.com (Postfix) with ESMTP id 32626FF855;
	Fri, 15 May 2009 10:25:22 +0200 (CEST)
From:	Arnaud Patard <apatard@mandriva.com>
To:	wuzhangjin@gmail.com
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Erwan Lerale <erwan@thiscow.com>, Zhang Le <r0bertz@gentoo.org>
Subject: Re: [GIT repo] loongson: Merge and Clean up fuloong(2e), fuloong(2f) and yeeloong(2f) support
References: <1242357553.30339.66.camel@falcon>
Organization: Mandriva
Date:	Fri, 15 May 2009 10:25:22 +0200
In-Reply-To: <1242357553.30339.66.camel@falcon> (Wu Zhangjin's message of "Fri, 15 May 2009 11:19:13 +0800")
Message-ID: <m3iqk2rcwd.fsf@anduin.mandriva.com>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <arnaud.patard@mandriva.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips

Wu Zhangjin <wuzhangjin@gmail.com> writes:

Hi,

> Dear all,
>
> I have cleaned up the source code of loongson-based machines support and
> updated it to linux-2.6.29.3, the result is put to the following git
> repository:
>
>    git://dev.lemote.com/rt4ls.git linux-2.6.29-stable-loongson-to-ralf
>
> this job is based on the to-mips branch of Yanhua's
> git://dev.lemote.com/linux_loongson.git and the lm2e-fixes branch of
> Philippe's git://git.linux-cisco.org/linux-mips.git. thanks goes to
> them.

I'd like to look at your patches but getting a git url prevents me to do
this because replying/commenting is not possible. Can you please send
patches to the list instead ?

>
> I have tested it with gcc 4.3 on fuloong(2e), fuloong(2f), yeeloong(2f),
> both 32bit and 64bit kernel works well, if you want to try it with gcc
> 4.4, please use the patch from attachment.

I have some questions/comments :

- Why this patch is not merged in your patchset ?
- even if it should not affect the kernel, compiling with
  -march=loongson2f even for 2e (you're matching on loongson2 so 2e and
  2f) looks weird.
- you're using the -mfix-ls2f-kernel binutils flag but afaik upstream
  binutils doesn't know it. I really don't know how such a thing should
  be handled but it seems strange to use this flag before binutils has
  been patched for it. (the previous comment about -march=loongson2f
  applies here too)

>
> * the current source code architecture

fwiw, I like this new organisation. thanks.

>
> $ tree arch/mips/loongson/
> arch/mips/loongson/
> |-- Kconfig
> |-- Makefile
> |-- common
> |   |-- Makefile
> |   |-- bonito-irq.c
> |   |-- clock.c
> |   |-- cmdline.c
> |   |-- cs5536_vsm.c
> |   |-- early_printk.c
> |   |-- init.c
> |   |-- irq.c
> |   |-- mem.c
> |   |-- mfgpt.c
> |   |-- mipsdha.c

hm.. I thought that the mipsdha stuff was refused when submitting 2e
support. Can someone check ?

Arnaud
