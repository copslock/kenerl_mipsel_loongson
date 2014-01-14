Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jan 2014 06:23:13 +0100 (CET)
Received: from mail-la0-f41.google.com ([209.85.215.41]:38611 "EHLO
        mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825752AbaANFXLE358J convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Jan 2014 06:23:11 +0100
Received: by mail-la0-f41.google.com with SMTP id mc6so2142217lab.28
        for <linux-mips@linux-mips.org>; Mon, 13 Jan 2014 21:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4JkQJ8G7Sk+t8nyqi6rjm9YISuTp6271y3oG/76d7ok=;
        b=gfM6j5MyfNCwdiTanavjl3k4ebgipzQ2svAZvqumQ9X9KlxyaLlS2kXsYg76DscKTF
         FX5EW6Bfmr+46aAQ8ljOMUM88YLszghXBWAuvL+EL2XAakLNOkJr/32SROJ//9ZQa2/2
         6PTtgJ8aSOmejBQQP/WaXRzKLX1gh0uDDNLWEy+kZeRt+wsmodB5VJEfF1YP8gVM52SR
         iALutO4yKdbSdY4v+n2s3sxq2IVtwccRgrxKPbYXL8kJXoDOM40aWUfmsa85sQCyHePx
         gZbrASjZ68fn0eWw4/jGJWyLqcWRPczUa/cjtqihtgUYTv3Iz9mmq6wKhnc4uqnk/Bk4
         wPIg==
X-Received: by 10.112.137.138 with SMTP id qi10mr11837773lbb.21.1389676985154;
        Mon, 13 Jan 2014 21:23:05 -0800 (PST)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by mx.google.com with ESMTPSA id j6sm8503374lam.6.2014.01.13.21.23.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jan 2014 21:23:04 -0800 (PST)
Date:   Tue, 14 Jan 2014 09:31:07 +0400
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     John Crispin <john@phrozen.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v3] MIPS: ZBOOT: gather string functions into string.c
Message-Id: <20140114093107.3ece9b7e0f45df7f8663dd8e@gmail.com>
In-Reply-To: <52D466A5.70704@phrozen.org>
References: <1389648656-25709-1-git-send-email-antonynpavlov@gmail.com>
        <52D466A5.70704@phrozen.org>
X-Mailer: Sylpheed 3.4.0beta7 (GTK+ 2.24.22; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38964
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

On Mon, 13 Jan 2014 23:20:21 +0100
John Crispin <john@phrozen.org> wrote:

> Hi,
> 
> whats the difference between v3 and v2 ?
> 

I have planned to make just "PATCH v2 RESEND" (I don't see any reaction
on PATCH v2 since October 2013), 
but Florian noted that I can use '#include <linux/types.h>' insted of '#
include <linux/string.h>' in arch/mips/boot/compressed/string.c
(see http://www.linux-mips.org/archives/linux-mips/2013-09/msg00337.html).

So I have fixed this minor issue in v3.

>     John
> 
> On 13/01/2014 22:30, Antony Pavlov wrote:
> > In the worst case this adds less then 128 bytes of code
> > but on the other hand this makes code organization more clear.
> >
> > Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> > Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> > Cc: linux-mips@linux-mips.org
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: John Crispin <blogic@openwrt.org>
> > Cc: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> >  arch/mips/boot/compressed/Makefile     |  4 ++--
> >  arch/mips/boot/compressed/decompress.c | 22 ----------------------
> >  arch/mips/boot/compressed/string.c     | 28 ++++++++++++++++++++++++++++
> >  3 files changed, 30 insertions(+), 24 deletions(-)
> >  create mode 100644 arch/mips/boot/compressed/string.c
> >
> > diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> > index ca0c343..61af6b6 100644
> > --- a/arch/mips/boot/compressed/Makefile
> > +++ b/arch/mips/boot/compressed/Makefile
> > @@ -27,10 +27,10 @@ KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
> >  	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) \
> >  	-DKERNEL_ENTRY=$(VMLINUX_ENTRY_ADDRESS)
> >  
> > -targets := head.o decompress.o dbg.o uart-16550.o uart-alchemy.o
> > +targets := head.o decompress.o string.o dbg.o uart-16550.o uart-alchemy.o
> >  
> >  # decompressor objects (linked with vmlinuz)
> > -vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/dbg.o
> > +vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/string.o $(obj)/dbg.o
> >  
> >  ifdef CONFIG_DEBUG_ZBOOT
> >  vmlinuzobjs-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
> > diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
> > index a8c6fd6..c00c4dd 100644
> > --- a/arch/mips/boot/compressed/decompress.c
> > +++ b/arch/mips/boot/compressed/decompress.c
> > @@ -43,33 +43,11 @@ void error(char *x)
> >  /* activate the code for pre-boot environment */
> >  #define STATIC static
> >  
> > -#if defined(CONFIG_KERNEL_GZIP) || defined(CONFIG_KERNEL_XZ) || \
> > -	defined(CONFIG_KERNEL_LZ4)
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
> > -#endif
> >  #ifdef CONFIG_KERNEL_GZIP
> >  #include "../../../../lib/decompress_inflate.c"
> >  #endif
> >  
> >  #ifdef CONFIG_KERNEL_BZIP2
> > -void *memset(void *s, int c, size_t n)
> > -{
> > -	int i;
> > -	char *ss = s;
> > -
> > -	for (i = 0; i < n; i++)
> > -		ss[i] = c;
> > -	return s;
> > -}
> >  #include "../../../../lib/decompress_bunzip2.c"
> >  #endif
> >  
> > diff --git a/arch/mips/boot/compressed/string.c b/arch/mips/boot/compressed/string.c
> > new file mode 100644
> > index 0000000..9de9885
> > --- /dev/null
> > +++ b/arch/mips/boot/compressed/string.c
> > @@ -0,0 +1,28 @@
> > +/*
> > + * arch/mips/boot/compressed/string.c
> > + *
> > + * Very small subset of simple string routines
> > + */
> > +
> > +#include <linux/types.h>
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
> 
> 


-- 
-- 
Best regards,
  Antony Pavlov
