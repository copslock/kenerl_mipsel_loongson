Received:  by oss.sgi.com id <S42349AbQJFV5L>;
	Fri, 6 Oct 2000 14:57:11 -0700
Received: from saturn.mikemac.com ([216.99.199.88]:65294 "EHLO
        saturn.mikemac.com") by oss.sgi.com with ESMTP id <S42347AbQJFV5B>;
	Fri, 6 Oct 2000 14:57:01 -0700
Received: from Saturn (localhost [127.0.0.1])
	by saturn.mikemac.com (8.9.3/8.9.3) with ESMTP id IAA31261;
	Fri, 6 Oct 2000 08:29:35 -0700
Message-Id: <200010061529.IAA31261@saturn.mikemac.com>
To:     Hiroshi Kawashima <kei@sm.sony.co.jp>
cc:     linux-mips@oss.sgi.com
Subject: Re: Linux-VR test7 hangs when execing init 
In-Reply-To: Your message of "Fri, 06 Oct 2000 17:00:41 +0900."
             <200010060755.QAA00127@email.sm.sony.co.jp> 
Date:   Fri, 06 Oct 2000 08:29:35 -0700
From:   Mike McDonald <mikemac@mikemac.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


>To: Mike McDonald <mikemac@mikemac.com>
>Subject: Re: Linux-VR test7 hangs when execing init 
>Date: Fri, 06 Oct 2000 17:00:41 +0900
>From: Hiroshi Kawashima <kei@sm.sony.co.jp>
>
>Hi.
>
>>   Recently the Linux-VR tree synced up with the SGI tree at test7
>> (from test4). As a result of this updating of the Linux-VR tree, my
>> kernels either hang or Oops while execing init. A minimal kernel will
>> hang and a normally config'd kernel will Oops. Does anyone know of any
>> changes in the ELF code or the ext2 filesystem that might be the cause
>> fo this? Any other ideas as to the cause or how to go about tracking
>> it down?
>
>It should be problem around PCMCIA is broken on test7.
>Some are working for fixing this (on linuxce list), but not
>completed yet.

  PCMCIA is not configured in my minimal kernel, so that shouldn't be
it.

  Mike McDonald
  mikemac@mikemac.com

------------------
Uranus=>fgrep "=y" .config | sort 
CONFIG_BINFMT_ELF=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_BLK_DEV_RAM=y
CONFIG_CLASS_DESKTOP=y
CONFIG_CPU_LITTLE_ENDIAN=y
CONFIG_CPU_NO_FPU=y
CONFIG_CPU_VR4122=y
CONFIG_CPU_VR41XX=y
CONFIG_CROSSCOMPILE=y
CONFIG_ELF_KERNEL=y
CONFIG_EXPERIMENTAL=y
CONFIG_EXT2_FS=y
CONFIG_HAVE_IO_PORTS=y
CONFIG_KCORE_ELF=y
CONFIG_MIPS_FPU_EMULATOR=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NEC_HARRIER=y
CONFIG_PROC_FS=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
