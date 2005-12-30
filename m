Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Dec 2005 21:02:46 +0000 (GMT)
Received: from mx01.qsc.de ([213.148.129.14]:7873 "EHLO mx01.qsc.de")
	by ftp.linux-mips.org with ESMTP id S8133656AbVL3VC3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 30 Dec 2005 21:02:29 +0000
Received: from port-195-158-168-159.dynamic.qsc.de ([195.158.168.159] helo=hattusa.textio)
	by mx01.qsc.de with esmtp (Exim 3.35 #1)
	id 1EsRQO-00009w-00; Fri, 30 Dec 2005 22:04:32 +0100
Received: from ths by hattusa.textio with local (Exim 4.60)
	(envelope-from <ths@hattusa.textio>)
	id 1EsRQJ-0008WP-5T; Fri, 30 Dec 2005 22:04:27 +0100
Date:	Fri, 30 Dec 2005 22:04:27 +0100
To:	Adil Hafeez <adilhafeez80@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Fixed kernel entry point suggestion
Message-ID: <20051230210427.GJ1882@hattusa.textio>
References: <82e4189c0512272336xed0fe2ax9fee6119ea2d6b00@mail.gmail.com> <06af7c9f9f82dd2b306e02997869e709@embeddedalley.com> <82e4189c0512300136w5112edf2kf3d243ddbc9313d@mail.gmail.com> <20051230094750.GI1882@hattusa.textio> <82e4189c0512300222k426764e0ldefeafb232ad36d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82e4189c0512300222k426764e0ldefeafb232ad36d@mail.gmail.com>
User-Agent: Mutt/1.5.11
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Adil Hafeez wrote:
> What about placing the jump instruction just after reserved space, like this
> 
>         .text
>         /*
>          * Reserved space for exception handlers.
>          * Necessary for machines which link their kernels at KSEG0.
>          */
>         .fill   0x400
> 
>         /* The following two symbols are used for kernel profiling. */
>         EXPORT(stext)
>         EXPORT(_stext)
> =>     j kernel_entry
>         __INIT
> 
> I disassembled vmlinux binary and now jump instruction is placed after
> reserved space

This only works iff the fill is done with NOPs. On a more general note,
it is usually considered to be the bootloader's job to find the correct
entry, not the kernel's one.


Thiemo
