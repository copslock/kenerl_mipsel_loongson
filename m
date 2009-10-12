Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Oct 2009 04:33:33 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:41477 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1491851AbZJLCda (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Oct 2009 04:33:30 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9C2YhAo026993;
	Mon, 12 Oct 2009 04:34:43 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9C2YgLA026991;
	Mon, 12 Oct 2009 04:34:42 +0200
Date:	Mon, 12 Oct 2009 04:34:42 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org, Alexander Clouter <alex@digriz.org.uk>
Subject: Re: [PATCH -v1] MIPS: add support for gzip/bzip2/lzma compressed
	kernel images
Message-ID: <20091012023442.GA7438@linux-mips.org>
References: <1249894154-10982-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1249894154-10982-1-git-send-email-wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 10, 2009 at 04:49:14PM +0800, Wu Zhangjin wrote:

> This patch will help to generate smaller kernel images for linux-MIPS,
> 
> Here is the effect when using lzma:
> 
> $ ls -sh vmlinux
> 7.1M vmlinux
> $ ls -sh arch/mips/boot/compressed/vmlinuz
> 1.5M arch/mips/boot/compressed/vmlinuz
> 
> Have tested the 32bit kernel on Qemu/Malta and 64bit kernel on FuLoong
> Mini PC. both of them work well.

  ip27_defconfig:

  CHK     include/linux/compile.h
(standard_in) 1: parse error
(standard_in) 1: parse error
  AS      arch/mips/boot/compressed/head.o
arch/mips/boot/compressed/head.S: Assembler messages:
arch/mips/boot/compressed/head.S:78: Error: Number (0xa800000000021bf0) larger than 32 bits
make[1]: *** [arch/mips/boot/compressed/head.o] Error 1

  rm200_defconfig:

$ make
[...]
  IHEX2FW firmware/whiteheat.fw
  IHEX2FW firmware/keyspan_pda/keyspan_pda.fw
  IHEX2FW firmware/keyspan_pda/xircom_pgs.fw
[ralf@h5 linux-queue]$ ll vmlinuz 
lrwxrwxrwx 1 ralf ralf 33 2009-10-12 03:30 vmlinuz -> arch/mips/boot/compressed/vmlinuz*
[ralf@h5 linux-queue]$ ll arch/mips/boot/compressed/vmlinuz 
-rwxrwxr-x 1 ralf ralf 1675346 2009-10-12 03:30 arch/mips/boot/compressed/vmlinuz*
[ralf@h5 linux-queue]$ make distclean
  CLEAN   arch/mips/boot
(standard_in) 1: parse error
[...]

For rm200 we need an ECOFF zimage.

malta_defconfig:

$ mkdir ../build-malta
$ make O=../build-malta malta_defconfig
[...]
$ cd ../build-malta
$ make
[...]
$ make distclean
make -C /home/ralf/src/linux/linux-queue O=/home/ralf/src/linux/build-malta/. distclean
  CLEAN   arch/mips/boot
(standard_in) 1: parse error
$

By default we generate a binary that is not ELF file for malta, so a
compressed kernel should be in that format also.

$ make help
[...]
Architecture specific targets (mips):
  install              - install kernel into /boot
  vmlinux.ecoff        - ECOFF boot image
  vmlinux.bin          - Raw binary boot image
  vmlinux.srec         - SREC boot image
  vmlinuz              - Compressed boot image
[...]
$ make vmlinuz
make: *** No rule to make target `vmlinuz'.  Stop.
$

> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 861da51..300b996 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -709,7 +709,10 @@ vmlinux.64: vmlinux
>  
>  makeboot =$(Q)$(MAKE) $(build)=arch/mips/boot VMLINUX=$(vmlinux-32) $(1)
>  
> -all:	$(all-y)
> +all:	$(all-y) zImage
> +
> +zImage: vmlinux
> +	$(Q)$(MAKE) $(build)=arch/mips/boot/compressed $@ LOADADDR=$(load-y)

Several systems rely on the firmware for memory usage information.  With
a compressed kernel this information will be inaccurate.  This is a
somewhat hard problem to solve so I suggest to only enable compressed
kernels on systems where they're known to work.

  Ralf
