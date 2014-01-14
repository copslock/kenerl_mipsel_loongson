Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jan 2014 06:27:26 +0100 (CET)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:50881 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825491AbaANF1YSyxhE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jan 2014 06:27:24 +0100
Received: by mail-pa0-f41.google.com with SMTP id fb1so7102235pad.0
        for <linux-mips@linux-mips.org>; Mon, 13 Jan 2014 21:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OzOrNyR88XTm+qeZv9NW4/fkd9R0JkLQyzbOCkFidN4=;
        b=ivtop5ZbIblN3iNOBoCuKjoIsFxA2+WZj6tIVQBQ1xQttaKQg/vOQenu4m/5pk4Ivb
         bMYnJt4OpK9yumxgDPb6AYDAYGRFld+ctDopwdnKZ9Cv+a1KrYf1rJLhRlEBY7YWgDYI
         721DEO6dDPHyRvjinqDSyfWat9aSp12Z5jVkYqTcetirijhu+oTH/rL+2lSjKCfNg/TF
         qwGu/E2Im/s243tCnoGJ1vRbs4WlbFM+pLn58MwTTZbWthszJ5AkvQkkJGFbSQIFLC7C
         yk8jEM9TaIXi2dmkWyC7/O65LHhvRE8svBT6V/M9GwyZi2077qVpbxhIg6NLsb+Uy9Jn
         nhSg==
X-Received: by 10.66.146.133 with SMTP id tc5mr34385063pab.58.1389677237029;
 Mon, 13 Jan 2014 21:27:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.68.186.101 with HTTP; Mon, 13 Jan 2014 21:26:36 -0800 (PST)
In-Reply-To: <20140114093107.3ece9b7e0f45df7f8663dd8e@gmail.com>
References: <1389648656-25709-1-git-send-email-antonynpavlov@gmail.com>
 <52D466A5.70704@phrozen.org> <20140114093107.3ece9b7e0f45df7f8663dd8e@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Mon, 13 Jan 2014 21:26:36 -0800
Message-ID: <CAGVrzcaLL+1O15AT5NsONRF7OY2SEW4nLSpbSjF_Z+nfar-4Vw@mail.gmail.com>
Subject: Re: [PATCH v3] MIPS: ZBOOT: gather string functions into string.c
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     John Crispin <john@phrozen.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

2014/1/13 Antony Pavlov <antonynpavlov@gmail.com>:
> On Mon, 13 Jan 2014 23:20:21 +0100
> John Crispin <john@phrozen.org> wrote:
>
>> Hi,
>>
>> whats the difference between v3 and v2 ?
>>
>
> I have planned to make just "PATCH v2 RESEND" (I don't see any reaction
> on PATCH v2 since October 2013),
> but Florian noted that I can use '#include <linux/types.h>' insted of '#
> include <linux/string.h>' in arch/mips/boot/compressed/string.c
> (see http://www.linux-mips.org/archives/linux-mips/2013-09/msg00337.html).
>
> So I have fixed this minor issue in v3.

This final version looks good to me:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

>
>>     John
>>
>> On 13/01/2014 22:30, Antony Pavlov wrote:
>> > In the worst case this adds less then 128 bytes of code
>> > but on the other hand this makes code organization more clear.
>> >
>> > Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
>> > Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>> > Cc: linux-mips@linux-mips.org
>> > Cc: Ralf Baechle <ralf@linux-mips.org>
>> > Cc: John Crispin <blogic@openwrt.org>
>> > Cc: Florian Fainelli <f.fainelli@gmail.com>
>> > ---
>> >  arch/mips/boot/compressed/Makefile     |  4 ++--
>> >  arch/mips/boot/compressed/decompress.c | 22 ----------------------
>> >  arch/mips/boot/compressed/string.c     | 28 ++++++++++++++++++++++++++++
>> >  3 files changed, 30 insertions(+), 24 deletions(-)
>> >  create mode 100644 arch/mips/boot/compressed/string.c
>> >
>> > diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
>> > index ca0c343..61af6b6 100644
>> > --- a/arch/mips/boot/compressed/Makefile
>> > +++ b/arch/mips/boot/compressed/Makefile
>> > @@ -27,10 +27,10 @@ KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
>> >     -DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) \
>> >     -DKERNEL_ENTRY=$(VMLINUX_ENTRY_ADDRESS)
>> >
>> > -targets := head.o decompress.o dbg.o uart-16550.o uart-alchemy.o
>> > +targets := head.o decompress.o string.o dbg.o uart-16550.o uart-alchemy.o
>> >
>> >  # decompressor objects (linked with vmlinuz)
>> > -vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/dbg.o
>> > +vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/string.o $(obj)/dbg.o
>> >
>> >  ifdef CONFIG_DEBUG_ZBOOT
>> >  vmlinuzobjs-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
>> > diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
>> > index a8c6fd6..c00c4dd 100644
>> > --- a/arch/mips/boot/compressed/decompress.c
>> > +++ b/arch/mips/boot/compressed/decompress.c
>> > @@ -43,33 +43,11 @@ void error(char *x)
>> >  /* activate the code for pre-boot environment */
>> >  #define STATIC static
>> >
>> > -#if defined(CONFIG_KERNEL_GZIP) || defined(CONFIG_KERNEL_XZ) || \
>> > -   defined(CONFIG_KERNEL_LZ4)
>> > -void *memcpy(void *dest, const void *src, size_t n)
>> > -{
>> > -   int i;
>> > -   const char *s = src;
>> > -   char *d = dest;
>> > -
>> > -   for (i = 0; i < n; i++)
>> > -           d[i] = s[i];
>> > -   return dest;
>> > -}
>> > -#endif
>> >  #ifdef CONFIG_KERNEL_GZIP
>> >  #include "../../../../lib/decompress_inflate.c"
>> >  #endif
>> >
>> >  #ifdef CONFIG_KERNEL_BZIP2
>> > -void *memset(void *s, int c, size_t n)
>> > -{
>> > -   int i;
>> > -   char *ss = s;
>> > -
>> > -   for (i = 0; i < n; i++)
>> > -           ss[i] = c;
>> > -   return s;
>> > -}
>> >  #include "../../../../lib/decompress_bunzip2.c"
>> >  #endif
>> >
>> > diff --git a/arch/mips/boot/compressed/string.c b/arch/mips/boot/compressed/string.c
>> > new file mode 100644
>> > index 0000000..9de9885
>> > --- /dev/null
>> > +++ b/arch/mips/boot/compressed/string.c
>> > @@ -0,0 +1,28 @@
>> > +/*
>> > + * arch/mips/boot/compressed/string.c
>> > + *
>> > + * Very small subset of simple string routines
>> > + */
>> > +
>> > +#include <linux/types.h>
>> > +
>> > +void *memcpy(void *dest, const void *src, size_t n)
>> > +{
>> > +   int i;
>> > +   const char *s = src;
>> > +   char *d = dest;
>> > +
>> > +   for (i = 0; i < n; i++)
>> > +           d[i] = s[i];
>> > +   return dest;
>> > +}
>> > +
>> > +void *memset(void *s, int c, size_t n)
>> > +{
>> > +   int i;
>> > +   char *ss = s;
>> > +
>> > +   for (i = 0; i < n; i++)
>> > +           ss[i] = c;
>> > +   return s;
>> > +}
>>
>>
>
>
> --
> --
> Best regards,
>   Antony Pavlov
>



-- 
Florian
