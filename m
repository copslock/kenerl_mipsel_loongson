Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2010 14:52:48 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:53109 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493326Ab0AZNwo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2010 14:52:44 +0100
Received: by pwj1 with SMTP id 1so3041367pwj.24
        for <multiple recipients>; Tue, 26 Jan 2010 05:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=jVTT1+AMdPAUuF58tflBlvz9+KQd1AmvnO8taqgZkVY=;
        b=Com8AmxOcfIufRmzG02UnlYSeHCIQME9wAJbJJdHVzfhKJBKpExwgUxX0wcR8VO8Ba
         OcesCcq7hhgUR+k+y2iZydU/38JfEfzhAcChWloko0szKa1Q6xwlrpIUI91K1HFafwdD
         POHDpj/lR/kmvk6Beb7owU5e0b0GfildtrvqI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=h6in0dZUmEdMXiON+ux++3KTFAhspcnXYmymcJ1Bqwi8Too/iKXbt+BW+Q8AltvSDQ
         wNi2n2b/ipipvwPWPq8sms28YVgSJcseurtVQ2f6w151X7sGl/XJXtDPCInoRPmh+m68
         ZUOpKFYOt4f1VPlGyY7X2+m5GjXOZ6im3LieM=
Received: by 10.140.82.25 with SMTP id f25mr5645786rvb.106.1264513957830;
        Tue, 26 Jan 2010 05:52:37 -0800 (PST)
Received: from ?192.168.2.212? ([202.201.14.140])
        by mx.google.com with ESMTPS id 20sm4654713pzk.13.2010.01.26.05.52.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 05:52:36 -0800 (PST)
Subject: Re: [PATCH -queue 2/2] MIPS: Cleanup the debugging of compressed
 kernel support
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
In-Reply-To: <20100126105155.GC30098@linux-mips.org>
References: <979633248ed16f2724296fd90f4b824f601809e1.1264496568.git.wuzhangjin@gmail.com>
         <cbf30435132e35087c6c6b8ca172c7d9cb0cbc37.1264496568.git.wuzhangjin@gmail.com>
         <20100126105155.GC30098@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Tue, 26 Jan 2010 21:46:39 +0800
Message-ID: <1264513599.24895.12.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 7bit
X-archive-position: 25671
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16698

On Tue, 2010-01-26 at 11:51 +0100, Ralf Baechle wrote:
[...]
> >  
> > +config DEBUG_ZBOOT
> > +	bool "Enable compressed kernel support debugging"
> > +	depends on SYS_SUPPORTS_ZBOOT_UART16550
> 
> This should probably depend on DEBUG_KERNEL also.
> 

ok, will add it.

[...]
> > diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> > index 91a57a6..68e5db8 100644
> > --- a/arch/mips/boot/compressed/Makefile
> > +++ b/arch/mips/boot/compressed/Makefile
> > @@ -32,7 +32,9 @@ KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
> >  
> >  obj-y := $(obj)/head.o $(obj)/decompress.o $(obj)/dbg.o
> >  
> > +ifdef CONFIG_DEBUG_ZBOOT
> >  obj-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
> > +endif
> 
> DEBUG_ZBOOT already depends on SYS_SUPPORTS_ZBOOT_UART16550 so this can be
> simplified into just obj-$(CONFIG_DEBUG_ZBOOT) and no ifdef.
> 

Yes, currently, we can simplify it, but the ifdef can make people be
easier to add new debugging supports, for example:

ifdef CONFIG_DEBUG_ZBOOT
obj-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
+obj-$(CONFIG_SYS_SUPPORTS_ZBOOT_UARTXXXX) += $(obj)/uart-xxxx.o
+obj-$(CONFIG_SYS_SUPPORTS_ZBOOT_VGA) += $(obj)/vga.o
endif

otherwise, we need:

obj-$(CONFIG_SYS_SUPPORTS_ZBOOT) += $(obj)/uart-16550.o  \ 
                                    $(obj)/uart-xxxx.o \
                                    $(obj)/vga.o

and then wrap the $(obj)/uart-16550.c, $(obj)/uart-xxxx.c, $(obj)/vga.c
internally with related ifdefs.

So, which method we choose?

Best Regards,
	Wu Zhangjin
