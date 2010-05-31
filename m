Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 May 2010 10:45:51 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:61157 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492018Ab0EaIpr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 May 2010 10:45:47 +0200
Received: by pxi1 with SMTP id 1so1538055pxi.36
        for <multiple recipients>; Mon, 31 May 2010 01:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:x-priority:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=jxkrc/IOqqgOGyVGZqecqJEM6v4t6+E+TyEb7VTrc1c=;
        b=aGuwz2x5z7yglSwLim+JZ1cAs1FLh+4bIUDJcGOLkyH2QhyR6+BcSQwh3GhKlqZKBS
         nQNImSvgnFPZIGw9II1yjcCbMMB21lJhlrSNC3n9ki1ZYy7Pr0PcA4s1FepXgxgFbci5
         XjgvPXJaGK5R076zTDcgWRljzYrGk1+kpY5+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:x-priority
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=xa78KhR28xasUm6vOZ2YzomLAwv2OzFp8tZcKduRFYH/LvA39IgcL52lG9lQCIQfbM
         ytVx7XDODtM5rukI9hFX+XUz+0hJ0aScheAqcA5ReD/XLYljKPBXykksG7vClK9tH1mW
         fXoJnMxvTY1k1a0gYkRhQQ0s3jKOUJknioIDg=
Received: by 10.115.98.12 with SMTP id a12mr3272353wam.55.1275295537775;
        Mon, 31 May 2010 01:45:37 -0700 (PDT)
Received: from [192.168.2.226] ([202.201.14.140])
        by mx.google.com with ESMTPS id c1sm47734045wam.19.2010.05.31.01.45.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 31 May 2010 01:45:37 -0700 (PDT)
Subject: Re: [PATCH 0/6] mips: diverse Makefile updates
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: <20100530141939.GA22153@merkur.ravnborg.org>
References: <20100530141939.GA22153@merkur.ravnborg.org>
X-Priority: 1
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Mon, 31 May 2010 16:45:31 +0800
Message-ID: <1275295531.24461.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Sam & Ralf

Perhaps we also need to fix the following stuff:

...
  LD      vmlinux
  SYSMAP  System.map
  SYSMAP  .tmp_System.map
mips64el-unknown-linux-gnu-objcopy -O elf32-tradlittlemips  --remove-section=.reginfo vmlinux vmlinux.32
  AS      arch/mips/boot/compressed/head.o
  CC      arch/mips/boot/compressed/decompress.o
  CC      arch/mips/boot/compressed/dbg.o
...

The related Makefile is arch/mips/Makefile:

> 721 #
> 722 # Some machines like the Indy need 32-bit ELF binaries for booting purposes.
> 723 # Other need ECOFF, so we build a 32-bit ELF binary for them which we then
> 724 # convert to ECOFF using elf2ecoff.
> 725 #
> 726 vmlinux.32: vmlinux
> 727         $(OBJCOPY) -O $(32bit-bfd) $(OBJCOPYFLAGS) $< $@
> 728 
> 729 #
> 730 # The 64-bit ELF tools are pretty broken so at this time we generate 64-bit
> 731 # ELF files from 32-bit files by conversion.
> 732 #
> 733 vmlinux.64: vmlinux
> 734         $(OBJCOPY) -O $(64bit-bfd) $(OBJCOPYFLAGS) $< $@

Best Regards,
	Wu Zhangjin

On Sun, 2010-05-30 at 16:19 +0200, Sam Ravnborg wrote:
> This patchset does the following:
> - introduce arch/mips/Kbuild
> - use -Werror on all core-y files of the mips kernel
> - introduce a distributed way to specify platform definitions
> - refactor a few Makefiles
> - clean up cleaning 
> 
> Ralf asked in private mail if I could try to implement
> a working varient of a suggestion I made some time ago.
> The idea was to move platform specific definitions to
> dedicated platfrom files.
> 
> This is implmented in the third patch.
> 
> The idea is to move the platform definitions from arch/mips/Makefile
> to arch/mips/<platform>/Platfrom
> 
> The content of this file is used in arch/mips/Makefile
> and arch/mips/Kbuild.
> 
> On top of this is a few patches that refactor the
> boot and boot/compressed Makefiles so they are more
> kbuild conformant.
> This beautify the output when we build a kernel.
> 
> Wu Zhangjin have pointed out a few bugs in the first
> variants of the patches that hit the mailing list - thanks!
> 
> 
> Patches will follow.
> 
> Note: I tried to test a little with bigsur_defconfig
> but get_user() is buggy. Or at least my gcc thinks that
> first argument may be used uninitialized.
> I think mips needs to fix the 64 bit variant of get_user().
> I took a quick look but ran away.
> 
> 	Sam
> 
> 
> Sam Ravnborg (6):
>       mips: introduce arch/mips/Kbuild
>       mips: add -Werror to arch/mips/Kbuild
>       mips: introduce support for Platform definitions
>       mips: refactor arch/mips/boot/Makefile
>       mips: refactor arch/mips/boot/compressed/Makefile
>       mips: clean up arch/mips/Makefile
> 
>  arch/mips/Kbuild                   |   15 +++++++++
>  arch/mips/Kbuild.platforms         |    6 ++++
>  arch/mips/Makefile                 |   57 +++++++++---------------------------
>  arch/mips/ar7/Platform             |    7 ++++
>  arch/mips/boot/Makefile            |   49 ++++++++++++++----------------
>  arch/mips/boot/compressed/Makefile |   54 ++++++++++++++++++----------------
>  arch/mips/kernel/Makefile          |    2 -
>  arch/mips/math-emu/Makefile        |    1 -
>  arch/mips/mm/Makefile              |    2 -
>  9 files changed, 94 insertions(+), 99 deletions(-)
