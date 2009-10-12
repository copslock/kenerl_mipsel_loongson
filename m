Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Oct 2009 05:32:19 +0200 (CEST)
Received: from mail-yx0-f193.google.com ([209.85.210.193]:54441 "EHLO
	mail-yx0-f193.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492007AbZJLDcM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 12 Oct 2009 05:32:12 +0200
Received: by yxe31 with SMTP id 31so5097476yxe.21
        for <multiple recipients>; Sun, 11 Oct 2009 20:32:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=Co5SQNM0JaIzhiUixCIQbCHEI6EnyGHzQmlG1tmVAlw=;
        b=uP6RTjP5/6S+HlYl+ezVc7oIgp3OEfaFOwhRg3TE4KGb+bfI6f+UDOvrAe3FaUgkaA
         +K685JO5WTbtWhv9RrckVuSnCwEg4s0CTZhXmjpTYI6koMDQubbbTAp5/oPV7r8XJxa+
         FjSNlR6nNhtYoA35UV+4dM9ddJ2TX+7AYusfo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=p0mzzFhAuTRbblWmp6Q/Ffvt0DOSdH5g/ueNog70W2C46/Mvfq/zV1F5pLYbtQ/R6T
         8pf5YJI5+HKfmg91v+jjHJNkSFFTkdUoOv3j+kFNRe9Kq66UuQTUni5natEHm4oRx6kd
         agDGUstKcuXJE2COChMg9mn5nofS/1AZSfTic=
Received: by 10.150.45.3 with SMTP id s3mr4981713ybs.330.1255318325494;
        Sun, 11 Oct 2009 20:32:05 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm1901875ywh.5.2009.10.11.20.32.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 20:32:04 -0700 (PDT)
Subject: Re: [PATCH -v1] MIPS: add support for gzip/bzip2/lzma compressed
 kernel images
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Alexander Clouter <alex@digriz.org.uk>
In-Reply-To: <20091012023442.GA7438@linux-mips.org>
References: <1249894154-10982-1-git-send-email-wuzhangjin@gmail.com>
	 <20091012023442.GA7438@linux-mips.org>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Mon, 12 Oct 2009 11:31:58 +0800
Message-Id: <1255318318.5744.82.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Mon, 2009-10-12 at 04:34 +0200, Ralf Baechle wrote:
> On Mon, Aug 10, 2009 at 04:49:14PM +0800, Wu Zhangjin wrote:
> 
> > This patch will help to generate smaller kernel images for linux-MIPS,
> > 
> > Here is the effect when using lzma:
> > 
> > $ ls -sh vmlinux
> > 7.1M vmlinux
> > $ ls -sh arch/mips/boot/compressed/vmlinuz
> > 1.5M arch/mips/boot/compressed/vmlinuz
> > 
> > Have tested the 32bit kernel on Qemu/Malta and 64bit kernel on FuLoong
> > Mini PC. both of them work well.
> 
>   ip27_defconfig:
> 
>   CHK     include/linux/compile.h
> (standard_in) 1: parse error
> (standard_in) 1: parse error
>   AS      arch/mips/boot/compressed/head.o
> arch/mips/boot/compressed/head.S: Assembler messages:
> arch/mips/boot/compressed/head.S:78: Error: Number (0xa800000000021bf0) larger than 32 bits
> make[1]: *** [arch/mips/boot/compressed/head.o] Error 1
> 

Seems something wrong in the Makefile, will fix it later, here it is:

[...]
/bin/sh: 0x0xa80000000001c000: value too great for base (error token is
"0x0xa80000000001c000")
  Building modules, stage 2.
  AS      arch/mips/boot/compressed/head.o
  CC      arch/mips/boot/compressed/decompress.o
  GZIP    arch/mips/boot/compressed/vmlinux.gz
  CC      arch/mips/boot/compressed/dbg.o
  MODPOST 137 modules
  CC      arch/mips/boot/compressed/dummy.o
arch/mips/boot/compressed/head.S: Assembler messages:
arch/mips/boot/compressed/head.S:47: Error: Number (0xa800000000021bf0)
larger than 32 bits
[...]

>   rm200_defconfig:
> 
> $ make
> [...]
>   IHEX2FW firmware/whiteheat.fw
>   IHEX2FW firmware/keyspan_pda/keyspan_pda.fw
>   IHEX2FW firmware/keyspan_pda/xircom_pgs.fw
> [ralf@h5 linux-queue]$ ll vmlinuz 
> lrwxrwxrwx 1 ralf ralf 33 2009-10-12 03:30 vmlinuz -> arch/mips/boot/compressed/vmlinuz*
> [ralf@h5 linux-queue]$ ll arch/mips/boot/compressed/vmlinuz 
> -rwxrwxr-x 1 ralf ralf 1675346 2009-10-12 03:30 arch/mips/boot/compressed/vmlinuz*
> [ralf@h5 linux-queue]$ make distclean
>   CLEAN   arch/mips/boot
> (standard_in) 1: parse error
> [...]
> 
> For rm200 we need an ECOFF zimage.
> 

Okay, will fix it later.

> malta_defconfig:
> 
> $ mkdir ../build-malta
> $ make O=../build-malta malta_defconfig
> [...]
> $ cd ../build-malta
> $ make
> [...]
> $ make distclean
> make -C /home/ralf/src/linux/linux-queue O=/home/ralf/src/linux/build-malta/. distclean
>   CLEAN   arch/mips/boot
> (standard_in) 1: parse error

This "parse error" will be fixed by tuning the Makefile via adding
something like " blabla 2>/dev/null".

> $
> 
> By default we generate a binary that is not ELF file for malta, so a
> compressed kernel should be in that format also.
> 
> $ make help
> [...]
> Architecture specific targets (mips):
>   install              - install kernel into /boot
>   vmlinux.ecoff        - ECOFF boot image
>   vmlinux.bin          - Raw binary boot image
>   vmlinux.srec         - SREC boot image
>   vmlinuz              - Compressed boot image
> [...]
> $ make vmlinuz
> make: *** No rule to make target `vmlinuz'.  Stop.
> $
> 

it should be

$ make zImage

will replace "vmlinuz - Compressed boot image" to "zImage - Compressed
boot image", or, fix "make vmlinuz" itself.

> > diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> > index 861da51..300b996 100644
> > --- a/arch/mips/Makefile
> > +++ b/arch/mips/Makefile
> > @@ -709,7 +709,10 @@ vmlinux.64: vmlinux
> >  
> >  makeboot =$(Q)$(MAKE) $(build)=arch/mips/boot VMLINUX=$(vmlinux-32) $(1)
> >  
> > -all:	$(all-y)
> > +all:	$(all-y) zImage
> > +
> > +zImage: vmlinux
> > +	$(Q)$(MAKE) $(build)=arch/mips/boot/compressed $@ LOADADDR=$(load-y)
> 
> Several systems rely on the firmware for memory usage information.  With
> a compressed kernel this information will be inaccurate.  This is a
> somewhat hard problem to solve so I suggest to only enable compressed
> kernels on systems where they're known to work.

Okay, I will add a new kernel option for this, and also, the
DEBUG(dbg.[hc]) part will be selectable with a new kernel option too.

Thanks & Regards,
	Wu Zhangjin
