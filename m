Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Sep 2013 22:17:12 +0200 (CEST)
Received: from mail-lb0-f176.google.com ([209.85.217.176]:60871 "EHLO
        mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823127Ab3I1URHwrJNd convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 28 Sep 2013 22:17:07 +0200
Received: by mail-lb0-f176.google.com with SMTP id y6so3306147lbh.35
        for <multiple recipients>; Sat, 28 Sep 2013 13:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9yS8uKcZdMD24TgSr94z1yL7IrCBWpxocAeGhopBzqo=;
        b=PQqXj0Ba1YgCVUJUKQFv1wQx3i/rDZRBebckepqHH2Vgvg0zz+Y67CuWW6B9r8Phxy
         pN3mVeST7uXQUyghpjkvohZ+EwIGwZZAvKBUjkzkVARBMnW4TCWwlZyx7UOZsP6YTY/L
         rIaZaV2kvFnIXUpfnO47OwKjLEubarhAjA03acBAAtsxuSSZAX55Bmr98Do+R6cbnz2N
         U1RiipoOoOqWMx0yPy3mQXrtDEVA1aGXSkrDQg+Bz/h7QQmLOEgV/180pgpSm07uGGoc
         CE7XtU5VanAxf+nKs30WQTQUx8uqPf+1w0DvvbtoT6L6REg5kQK0qq6TremkowgZb9Yi
         k1QA==
X-Received: by 10.112.126.37 with SMTP id mv5mr14587778lbb.20.1380399422250;
        Sat, 28 Sep 2013 13:17:02 -0700 (PDT)
Received: from quiet (ppp37-190-57-6.pppoe.spdop.ru. [37.190.57.6])
        by mx.google.com with ESMTPSA id ua4sm10192343lbb.17.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 13:17:01 -0700 (PDT)
Date:   Sun, 29 Sep 2013 00:14:21 +0400
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: vmlinuz: gather some string functions into
 string.c
Message-Id: <20130929001421.cc255b12705c2f7036c418e9@gmail.com>
In-Reply-To: <524712A7.7060402@gmail.com>
References: <1380382974-27884-1-git-send-email-antonynpavlov@gmail.com>
        <524712A7.7060402@gmail.com>
X-Mailer: Sylpheed 3.4.0beta4 (GTK+ 2.24.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Sat, 28 Sep 2013 19:32:23 +0200
Florian Fainelli <f.fainelli@gmail.com> wrote:

> Hello,
> 
> Le 28/09/2013 17:42, Antony Pavlov a écrit :
> > This patch fixes linker error:
> >
> >      LD    vmlinuz
> >    arch/mips/boot/compressed/decompress.o: In function `decompress_kernel':
> >    decompress.c:(.text+0x754): undefined reference to `memcpy'
> >    make[1]: *** [vmlinuz] Error 1
> >
> > Which appears when compiling vmlinuz image with CONFIG_KERNEL_LZO=y.
> 
> You would have to rebase this on top of mips-for-linux-next which 
> contains a bit more ifdef for supporting LZ4 and XZ otherwise the first 
> hunk of the patch does not apply.

My bad, I found your "[PATCH v2] MIPS: ZBOOT: support LZ4 compression scheme" patch
__after__ sending my patches.

Unfortunately I can't get access to the mips-for-linux-next branch:

* the git://git.linux-mips.org/pub/scm/ralf/linux.git repo contain only the *-stable
branches;
* I can't clone linux-queue.git (see below).

$ git clone git://git.linux-mips.org/pub/scm/ralf/linux-queue.git
Cloning into 'linux-queue'...
fatal: remote error: access denied or repository not exported: /pub/scm/ralf/linux-queue.git

How can I obtain the mips-for-linux-next branch?

> Regarding the contents of the patch, you are somehow changing the 
> existing compressor code by unconditionnaly providing a memset and 
> memcpy implementation, which is fine per se but should be mentioned at 
> least.
> 
> >
> > Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> > ---
> >   arch/mips/boot/compressed/Makefile     |  4 ++--
> >   arch/mips/boot/compressed/decompress.c | 19 -------------------
> >   arch/mips/boot/compressed/string.c     | 28 ++++++++++++++++++++++++++++
> >   3 files changed, 30 insertions(+), 21 deletions(-)
> >   create mode 100644 arch/mips/boot/compressed/string.c
> >
> > diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> > index 0048c08..30e30d4 100644
> > --- a/arch/mips/boot/compressed/Makefile
> > +++ b/arch/mips/boot/compressed/Makefile
> > @@ -27,10 +27,10 @@ KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
> >   	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) \
> >   	-DKERNEL_ENTRY=$(VMLINUX_ENTRY_ADDRESS)
> >
> > -targets := head.o decompress.o dbg.o uart-16550.o uart-alchemy.o
> > +targets := head.o decompress.o string.o dbg.o uart-16550.o uart-alchemy.o
> >
> >   # decompressor objects (linked with vmlinuz)
> > -vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/dbg.o
> > +vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/string.o $(obj)/dbg.o
> >
> >   ifdef CONFIG_DEBUG_ZBOOT
> >   vmlinuzobjs-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
> > diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
> > index 2c95730..fc1f294 100644
> > --- a/arch/mips/boot/compressed/decompress.c
> > +++ b/arch/mips/boot/compressed/decompress.c
> > @@ -44,29 +44,10 @@ void error(char *x)
> >   #define STATIC static
> >
> >   #ifdef CONFIG_KERNEL_GZIP
> > -void *memcpy(void *dest, const void *src, size_t n)
> > -{
> > -	int i;
> > -	const char *s = src;
> > -	char *d = dest;
> > -
> > -	for (i = 0; i < n; i++)
> > -		d[i] = s[i];
> > -	return dest;
> > -}
> >   #include "../../../../lib/decompress_inflate.c"
> >   #endif
> >
> >   #ifdef CONFIG_KERNEL_BZIP2
> > -void *memset(void *s, int c, size_t n)
> > -{
> > -	int i;
> > -	char *ss = s;
> > -
> > -	for (i = 0; i < n; i++)
> > -		ss[i] = c;
> > -	return s;
> > -}
> >   #include "../../../../lib/decompress_bunzip2.c"
> >   #endif
> >
> > diff --git a/arch/mips/boot/compressed/string.c b/arch/mips/boot/compressed/string.c
> > new file mode 100644
> > index 0000000..49e6db0
> > --- /dev/null
> > +++ b/arch/mips/boot/compressed/string.c
> > @@ -0,0 +1,28 @@
> > +/*
> > + * arch/mips/boot/compressed/string.c
> > + *
> > + * Very small subset of simple string routines
> > + */
> > +
> > +#include <linux/string.h>
> > +
> > +void *memcpy(void *dest, const void *src, size_t n)
> > +{
> > +	int i;
> > +	const char *s = src;
> > +	char *d = dest;
> > +
> > +	for (i = 0; i < n; i++)
> > +		d[i] = s[i];
> > +	return dest;
> > +}
> > +
> > +void *memset(void *s, int c, size_t n)
> > +{
> > +	int i;
> > +	char *ss = s;
> > +
> > +	for (i = 0; i < n; i++)
> > +		ss[i] = c;
> > +	return s;
> > +}
> >
> 


-- 
-- 
Best regards,
  Antony Pavlov
