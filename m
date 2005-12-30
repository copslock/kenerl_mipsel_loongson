Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Dec 2005 09:46:18 +0000 (GMT)
Received: from mx01.qsc.de ([213.148.129.14]:55175 "EHLO mx01.qsc.de")
	by ftp.linux-mips.org with ESMTP id S8133470AbVL3JqB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 30 Dec 2005 09:46:01 +0000
Received: from port-195-158-168-159.dynamic.qsc.de ([195.158.168.159] helo=hattusa.textio)
	by mx01.qsc.de with esmtp (Exim 3.35 #1)
	id 1EsGrc-000582-00
	for linux-mips@linux-mips.org; Fri, 30 Dec 2005 10:47:56 +0100
Received: from ths by hattusa.textio with local (Exim 4.60)
	(envelope-from <ths@hattusa.textio>)
	id 1EsGrX-0005Tg-3B
	for linux-mips@linux-mips.org; Fri, 30 Dec 2005 10:47:51 +0100
Date:	Fri, 30 Dec 2005 10:47:51 +0100
To:	linux-mips@linux-mips.org
Subject: Re: Fixed kernel entry point suggestion
Message-ID: <20051230094750.GI1882@hattusa.textio>
References: <82e4189c0512272336xed0fe2ax9fee6119ea2d6b00@mail.gmail.com> <06af7c9f9f82dd2b306e02997869e709@embeddedalley.com> <82e4189c0512300136w5112edf2kf3d243ddbc9313d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82e4189c0512300136w5112edf2kf3d243ddbc9313d@mail.gmail.com>
User-Agent: Mutt/1.5.11
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Adil Hafeez wrote:
> Hi Dan,
> 
> Here is the patch.
> 
> diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
> index eebdaa2..a5e6d4e 100644
> --- a/arch/mips/kernel/head.S
> +++ b/arch/mips/kernel/head.S
> @@ -28,6 +28,7 @@
> #include <asm/mipsregs.h>
> #include <asm/stackframe.h>
> 
> +        j kernel_entry
> .text
> /*
> * Reserved space for exception handlers.

But certainly not _before_ .text. Also, it shouldn't move the reserved
space, it would need "align" instead of "space" afterwards.


Thiemo
