Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Sep 2009 22:17:13 +0200 (CEST)
Received: from chipmunk.wormnet.eu ([195.195.131.226]:54011 "EHLO
	chipmunk.wormnet.eu" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493564AbZI1URF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 28 Sep 2009 22:17:05 +0200
Received: by chipmunk.wormnet.eu (Postfix, from userid 1000)
	id D9A808314F; Mon, 28 Sep 2009 21:17:03 +0100 (BST)
Date:	Mon, 28 Sep 2009 21:17:03 +0100
From:	Alexander Clouter <alex@digriz.org.uk>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	manuel.lauss@googlemail.com
Subject: Re: [PATCH -v1] MIPS: add support for gzip/bzip2/lzma compressed
	kernel images
Message-ID: <20090928201703.GX6085@chipmunk>
References: <1249894154-10982-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1249894154-10982-1-git-send-email-wuzhangjin@gmail.com>
Organization: diGriz
X-URL:	http://www.digriz.org.uk/
X-JabberID: alex@digriz.org.uk
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <alex@digriz.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips

Hi,

* Wu Zhangjin <wuzhangjin@gmail.com> [2009-08-10 16:49:14+0800]:
>
> This patch will help to generate smaller kernel images for linux-MIPS,
> 
> [snipped]
> 
> NOTE: this should work for the other MIPS-based machines, but I have
> used the command bc in the Makefile to calculate the load address of the
> compressed kernel. I'm not sure this is suitable.  perhaps I need to
> rewrite this part in C program or somebody help to simplify the current
> implementation.
> 
Remembered you wanted a nicer way to work out the load address so this 
is my best attempt so far....I think it's fine to leave it as shell code 
personally; but I'm not a maintainer :)

> + [snipped]
>
> +# The load address of the compressed kernel, VMLINUZ_LOAD_ADDRESS > VMLINUX_LOAD_ADDRESS + VMLINUX_SIZE
> +VMLINUX_SIZE := $(shell wc -c $(objtree)/$(KBUILD_IMAGE) 2>/dev/null | cut -d' ' -f1)
> +VMLINUX_SIZE := $(shell echo "obase=16;ibase=10;(($(VMLINUX_SIZE)/65536 + 1) * 65536)" | bc | cut -d'.' -f1)
> +VMLINUX_LOAD_ADDRESS = $(shell echo $(LOADADDR) | sed -e "s/0xffffffff//g")
> +VMLINUZ_LOAD_ADDRESS := $(shell echo "obase=16; ibase=16; ($(VMLINUX_LOAD_ADDRESS) + $(VMLINUX_SIZE))" | bc)
> +VMLINUZ_LOAD_ADDRESS := 0x$(if $(CONFIG_64BIT),ffffffff,)$(VMLINUZ_LOAD_ADDRESS)
> +LOADADDR := 0x$(if $(CONFIG_64BIT),ffffffff,)$(VMLINUX_LOAD_ADDRESS)
> +
Slightly prettier is to get rid of the 'bc' dependency, a divide and a 
'cut' here and there.

Cheers

--
Alexander Clouter
.sigmonster says: Nice guys finish last.
                                -- Leo Durocher

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index f9ccd97..e531b28 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -12,11 +12,11 @@
 # Author: Wu Zhangjin <wuzj@lemote.com>
 #
 
-# The load address of the compressed kernel, VMLINUZ_LOAD_ADDRESS > VMLINUX_LOAD_ADDRESS + VMLINUX_SIZE
-VMLINUX_SIZE := $(shell wc -c $(objtree)/$(KBUILD_IMAGE) 2>/dev/null | cut -d' ' -f1)
-VMLINUX_SIZE := $(shell echo "obase=16;ibase=10;(($(VMLINUX_SIZE)/65536 + 1) * 65536)" | bc | cut -d'.' -f1)
-VMLINUX_LOAD_ADDRESS = $(shell echo $(LOADADDR) | sed -e "s/0xffffffff//g")
-VMLINUZ_LOAD_ADDRESS := $(shell echo "obase=16; ibase=16; ($(VMLINUX_LOAD_ADDRESS) + $(VMLINUX_SIZE))" | bc)
+# compressed kernel load addr: VMLINUZ_LOAD_ADDRESS > VMLINUX_LOAD_ADDRESS + VMLINUX_SIZE
+VMLINUX_SIZE := $(shell wc -c $(objtree)/$(KBUILD_IMAGE) | cut -d' ' -f1)
+VMLINUX_SIZE := $(shell echo $$(($(VMLINUX_SIZE) + (65536 - $(VMLINUX_SIZE) % 65536))))
+VMLINUX_LOAD_ADDRESS = $(shell echo $(LOADADDR) | sed -e 's/0xffffffff//')
+VMLINUZ_LOAD_ADDRESS := $(shell printf %x $$((0x$(VMLINUX_LOAD_ADDRESS) + $(VMLINUX_SIZE))))
 VMLINUZ_LOAD_ADDRESS := 0x$(if $(CONFIG_64BIT),ffffffff,)$(VMLINUZ_LOAD_ADDRESS)
 LOADADDR := 0x$(if $(CONFIG_64BIT),ffffffff,)$(VMLINUX_LOAD_ADDRESS)
