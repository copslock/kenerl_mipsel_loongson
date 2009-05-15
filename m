Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 11:38:51 +0100 (BST)
Received: from mail-px0-f187.google.com ([209.85.216.187]:49153 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022126AbZEOKip (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2009 11:38:45 +0100
Received: by pxi17 with SMTP id 17so1075188pxi.22
        for <multiple recipients>; Fri, 15 May 2009 03:38:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=WlnwP3hG8oFmu8hXv+CNlXeTXVYEWnsottLBGDVaESc=;
        b=L+h6N2x5woP+uhpgkDa2nyIlFoR7LFIZ2CS7Wsm7msr/utIMrjqlW/eBMLm/ECJaQJ
         Mdfj0NbaLm5v266JoCx5HNpXEs004cQ1yYdjEl2X09h8ROUjrooL59nAb3pmQ92XVe2B
         TI8ZJqHyWNB9oQNTinMrc/TIYjGzoiZPIdIAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=yCMWn60dqN6ZakA0k3UihPRa208hbG5wis4Q9TjRzbIImLViO76Ti6ZFqQnfjTqSNS
         jqEnnDnjo7g5Y7zDpOJLwuXiEF4n+eKmkQUV7y9bhfy0RoXs3uT7cBibZ9FHeZzAVFd5
         d9RrGtqaIrF0dnKOkNeVcp8Rk+nhUWRs1nBiQ=
Received: by 10.114.122.9 with SMTP id u9mr4466257wac.129.1242383916941;
        Fri, 15 May 2009 03:38:36 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id t1sm3779537poh.23.2009.05.15.03.38.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 03:38:36 -0700 (PDT)
Subject: Re: [GIT repo] loongson: Merge and Clean up fuloong(2e),
 fuloong(2f) and yeeloong(2f) support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Arnaud Patard <apatard@mandriva.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Erwan Lerale <erwan@thiscow.com>, Zhang Le <r0bertz@gentoo.org>
In-Reply-To: <m3iqk2rcwd.fsf@anduin.mandriva.com>
References: <1242357553.30339.66.camel@falcon>
	 <m3iqk2rcwd.fsf@anduin.mandriva.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Fri, 15 May 2009 18:38:23 +0800
Message-Id: <1242383903.10164.118.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2009-05-15 at 10:25 +0200, Arnaud Patard wrote:
> Wu Zhangjin <wuzhangjin@gmail.com> writes:
> 
> Hi,
> 
> > Dear all,
> >
> > I have cleaned up the source code of loongson-based machines support and
> > updated it to linux-2.6.29.3, the result is put to the following git
> > repository:
> >
> >    git://dev.lemote.com/rt4ls.git linux-2.6.29-stable-loongson-to-ralf
> >
> > this job is based on the to-mips branch of Yanhua's
> > git://dev.lemote.com/linux_loongson.git and the lm2e-fixes branch of
> > Philippe's git://git.linux-cisco.org/linux-mips.git. thanks goes to
> > them.
> 
> I'd like to look at your patches but getting a git url prevents me to do
> this because replying/commenting is not possible. Can you please send
> patches to the list instead ?
> 

Yes, I will tune some commits and then send the patches out.
thanks very much for your reply :-)

> >
> > I have tested it with gcc 4.3 on fuloong(2e), fuloong(2f), yeeloong(2f),
> > both 32bit and 64bit kernel works well, if you want to try it with gcc
> > 4.4, please use the patch from attachment.
> 
> I have some questions/comments :
> 
> - Why this patch is not merged in your patchset ?

this patch is not ready yet for several reasons:

1. under gcc 4.4(I'm using the version 4.4.0 20090313, not update to the
latest one yet), there are tons of problems when compiling
linux-loongson in 32bit. basically, 64bit is okay, but also some
problems there(i just found the reboot command of fuloong2f not work
under gcc4.4, but works well under gcc 4.3).

2. -march=loongson2* only goes into gcc >= 4.4, so, there is a need to
consider gcc >= 4.4 and gcc <= 4.3 differently, beside this compile
option, some extra source code should be treated differently too. for
example, this fix for gcc 4.4 will not work under gcc 4.3.

diff --git a/arch/mips/include/asm/delay.h
b/arch/mips/include/asm/delay.h
index b0bccd2..db054ec 100644
--- a/arch/mips/include/asm/delay.h
+++ b/arch/mips/include/asm/delay.h
@@ -82,12 +82,10 @@ static inline void __udelay(unsigned long usecs,
unsigned long lpj)
                : "=h" (usecs), "=l" (lo)
                : "r" (usecs), "r" (lpj)
                : GCC_REG_ACCUM);
-       else if (sizeof(long) == 8 && !R4000_WAR)
-               __asm__("dmultu\t%2, %3"
-               : "=h" (usecs), "=l" (lo)
-               : "r" (usecs), "r" (lpj)
-               : GCC_REG_ACCUM);
-       else if (sizeof(long) == 8 && R4000_WAR)
+       else if (sizeof(long) == 8 && !R4000_WAR) {
+               typedef unsigned int uint128_t
__attribute__((mode(TI)));
+               usecs = ((uint128_t) usecs * lpj) >> 64;
+       } else if (sizeof(long) == 8 && R4000_WAR)
                __asm__("dmultu\t%3, %4\n\tmfhi\t%0"
                : "=r" (usecs), "=h" (hi), "=l" (lo)
                : "r" (usecs), "r" (lpj

> - even if it should not affect the kernel, compiling with
>   -march=loongson2f even for 2e (you're matching on loongson2 so 2e and
>   2f) looks weird.

sorry, this is really a very obvious error, in 2e, -march=loongson2e
should be used.

to fix this problem, perhaps we can add two new kernel options:

config CPU_LOONGSON2E
	bool

config CPU_LOONGSON2F
	bool

and then use this solution:

config FULOONG2E
	...
	select CPU_LOONGSON2E
	...

config YEELOONG2F
	...
	select CPU_LOONGSON2F
	...

cflags-$(CONFIG_CPU_LOONGSON2E)  += -march=loongson2e -Wa,--trap
cflags-$(CONFIG_CPU_LOONGSON2F)  += -march=loongson2f -Wa,--trap

is this solution okay?

> - you're using the -mfix-ls2f-kernel binutils flag but afaik upstream
>   binutils doesn't know it. I really don't know how such a thing should
>   be handled but it seems strange to use this flag before binutils has
>   been patched for it. (the previous comment about -march=loongson2f
>   applies here too)
> 

so, it is better not use -mfix-ls2f-kernel before this option goes to
the upstream binutils, i will remove it later.

but for the above reasons, i really do not want to focus on gcc 4.4
support currently, is it okay?

thanks!
Wu Zhangjin
