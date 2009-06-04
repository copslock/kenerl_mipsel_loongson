Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 14:47:25 +0100 (WEST)
Received: from mx1.moondrake.net ([212.85.150.166]:56677 "EHLO
	mx1.mandriva.com" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S20022648AbZFDNrR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 14:47:17 +0100
Received: by mx1.mandriva.com (Postfix, from userid 501)
	id D6F52274001; Thu,  4 Jun 2009 15:47:15 +0200 (CEST)
Received: from office-abk.mandriva.com (office-abk.mandriva.com [84.55.162.90])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.mandriva.com (Postfix) with ESMTP id 9FEED274006;
	Thu,  4 Jun 2009 15:47:14 +0200 (CEST)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
	by office-abk.mandriva.com (Postfix) with ESMTP id 31BFB82820;
	Thu,  4 Jun 2009 15:52:52 +0200 (CEST)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
	by anduin.mandriva.com (Postfix) with ESMTP id D479FFF855;
	Thu,  4 Jun 2009 15:51:18 +0200 (CEST)
From:	Arnaud Patard <apatard@mandriva.com>
To:	wuzhangjin@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: Re: [loongson-PATCH-v3 17/25] add a machtype kernel command line argument
References: <cover.1244120575.git.wuzj@lemote.com>
	<d1f4caa360114f843459dc71827b1175232a24be.1244120575.git.wuzj@lemote.com>
Organization: Mandriva
Date:	Thu, 04 Jun 2009 15:51:18 +0200
In-Reply-To: <d1f4caa360114f843459dc71827b1175232a24be.1244120575.git.wuzj@lemote.com> (wuzhangjin@gmail.com's message of "Thu,  4 Jun 2009 21:08:03 +0800")
Message-ID: <m3iqjcm7jd.fsf@anduin.mandriva.com>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <arnaud.patard@mandriva.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23270
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
> the difference between yeeloong-7inch and yeeloong-8.9inch is very
> small, only including the screen size and shutdown logic. so, it's very
> important to share the same kernel image file between them instead of
> adding some new kernel config options. benefit from this, the
> distribution developers only have a need to compile the kernel one time.
>
> to share the same kernel image file between yeelooong-7inch and
> yeeloong-8.9inch, there is a need to add a kernel command line, here I
> name is machtype, it works like this:
>
> 	machtype=lemote-yeeloong-2f-7inch
> 	      company - product - cpu revision - size

I'm curious. Why can't you use the boot monitor to pass the right
machine type instead ? iirc, you're using pmon and pmon has a variable
called "systype". If the systype variable is not designed for that, I'll
be happy to know its use :)


Arnaud
