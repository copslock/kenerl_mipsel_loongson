Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jan 2010 10:36:11 +0100 (CET)
Received: from mail-iw0-f196.google.com ([209.85.223.196]:52553 "EHLO
        mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492049Ab0ASJgE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jan 2010 10:36:04 +0100
Received: by iwn34 with SMTP id 34so2642544iwn.21
        for <multiple recipients>; Tue, 19 Jan 2010 01:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=lf1VnIhXtVbWrR/HXKnj6cnIy5rW7YUwDLEb0jPryeY=;
        b=eL+dNsfOwQoWhHCHTMcMxGl/Stu6ZckYzboJL9paTgSVMSqT6iR46Ro03trKJS3Tvf
         M/riiXnf30pbRTCreqAUxYPXTsYIEaTH8s9mXlWtVDU6jrRpG97OKIKgS8RvUCfAyphk
         lET3zO9xLTsu9lhkFgD38k0SARGQ9CBMUZcy8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=rYw3GiHAifwIyc2wxOTk3Hg10lBFlP6fQf4q0LbKPcXNfJo/dWa2od/Go11WX8e9Rp
         Fo2jaLFSMDLR3DS7cLlYlpW1mGkl9KIzEXazBBEFMMxGSAOBXIHqFfNd9ob9H0N5GGH7
         p4fYvPVvO7e0OZO5O7GLcHiQ9CUoAbx/78JEQ=
Received: by 10.231.157.131 with SMTP id b3mr181468ibx.19.1263893756413;
        Tue, 19 Jan 2010 01:35:56 -0800 (PST)
Received: from ?192.168.2.212? ([202.201.14.140])
        by mx.google.com with ESMTPS id 23sm2979590iwn.3.2010.01.19.01.35.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Jan 2010 01:35:54 -0800 (PST)
Subject: Re: [PATCH] MIPS: fix vmlinuz build when only 32bit math shell is
 available
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Alexander Clouter <alex@digriz.org.uk>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
In-Reply-To:  <7p6f27-emk.ln1@chipmunk.wormnet.eu>
References:  <7p6f27-emk.ln1@chipmunk.wormnet.eu>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Tue, 19 Jan 2010 17:35:29 +0800
Message-ID: <1263893729.1840.183.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
X-archive-position: 25607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 12364

On Mon, 2010-01-18 at 23:17 +0000, Alexander Clouter wrote:
> Counter to the documentation for the dash shell, it seems that on my
> x86_64 filth under Debian only does 32bit math.  As I have configured
> my lapdog to use 'dash' for non-interactive tasks I run into problems
> when compiling a compressed kernel.
> 
> I play with the AR7 platform, so VMLINUX_LOAD_ADDRESS is
> 0xffffffff94100000, and for a (for example) 4MiB kernel
> VMLINUZ_LOAD_ADDRESS is made out to be:
> ----
> alex@berk:~$ bash -c 'printf "%x\n" $((0xffffffff94100000 + 0x400000))'
> ffffffff94500000
> alex@berk:~$ dash -c 'printf "%x\n" $((0xffffffff94100000 + 0x400000))'
> 80000000003fffff
> ----
> 
> The former is obviously correct whilst the later breaks things royally.
> 

Just reproduced the above problem on the YeeLoong netbook(loongson-2F
processor), but no problem on my thinkpad SL400 laptop(Intel(R)
Core(TM)2 Duo CPU). so, dash not always support 64bit math, and perhaps
some other shells not support 64bit math either.

> This patch fixes vmlinuz kernel builds on systems where only a 32bit
> math enabled shell is a available.  It does this by bringing 'bc' back
> in as a build dependency (Wu Zhangjin had orginally used 'bc' but I had
> suggested he 'fixes' the original dependency *sigh*) but things now seem
> to work as expected.
> 
> Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
> ---
>  arch/mips/boot/compressed/Makefile |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> index 671d344..65d1adf 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -14,8 +14,10 @@
>  
>  # compressed kernel load addr: VMLINUZ_LOAD_ADDRESS > VMLINUX_LOAD_ADDRESS + VMLINUX_SIZE
>  VMLINUX_SIZE := $(shell wc -c $(objtree)/$(KBUILD_IMAGE) 2>/dev/null | cut -d' ' -f1)
> -VMLINUX_SIZE := $(shell [ -n "$(VMLINUX_SIZE)" ] && echo $$(($(VMLINUX_SIZE) + (65536 - $(VMLINUX_SIZE) % 65536))))
> -VMLINUZ_LOAD_ADDRESS := 0x$(shell [ -n "$(VMLINUX_SIZE)" ] && printf %x $$(($(VMLINUX_LOAD_ADDRESS) + $(VMLINUX_SIZE))))
> +VMLINUX_SIZE := $(shell printf %X $$(($(VMLINUX_SIZE) + (65536 - $(VMLINUX_SIZE) % 65536))))

No, we can not remove this '-n "$(VMLINUX_SIZE)"', otherwise, we will
get the following error when "make clean" or "make distclean":

(standard_in) 1: parse error

> +VMLINUZ_LOAD_ADDRESS := $(shell A=$(VMLINUX_LOAD_ADDRESS); A=$${A\#0xffffffff}; echo $${A\#0x} | tr a-f A-F)
> +VMLINUZ_LOAD_ADDRESS := $(shell echo "obase=16; ibase=16; $(VMLINUZ_LOAD_ADDRESS) + $(VMLINUX_SIZE)" | bc)

The following command(without the prefix 0xffffffff) works well on
yeeloong netbook, what about your machine?

$ dash -c 'printf "%x\n" $((0x94100000 + 0x400000))'
94500000

so, bc is not necessary.

> +VMLINUZ_LOAD_ADDRESS := $(shell A=$(VMLINUX_LOAD_ADDRESS); [ "$${A\#0xffffffff}" = "$${A}" ] && echo 0x$(VMLINUZ_LOAD_ADDRESS) || echo 0xffffffff$(VMLINUZ_LOAD_ADDRESS))

And seems some of the other situations are not covered here:

$ cat arch/mips/Makefile | grep "^load\-" | grep -v 0xffffffff
load-$(CONFIG_MIPS_SIM)		+= 0x80100000
load-$(CONFIG_BASLER_EXCITE)    += 0x80100000
load-$(CONFIG_SGI_IP27)		+= 0xc00000004001c000
load-$(CONFIG_SGI_IP27)		+= 0xa80000000001c000
load-$(CONFIG_SGI_IP28)		+= 0xa800000020004000

so, a general method should be:

1. Get the sum of "the low 32bit of VMLINUX_LOAD_ADDRESS + VMLINUX_SIZE"
with printf "%08x" (08 herein is used to prefix it with 0...)

2. append "the high 32bit of VMLINUX_LOAD_ADDRESS" as the prefix if it
exists.

Will resend a revision of this patch with the above method later.

Thanks & Regards,
	Wu Zhangjin
