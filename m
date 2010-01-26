Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2010 17:04:24 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:42386 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493383Ab0AZQEU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2010 17:04:20 +0100
Received: by pzk35 with SMTP id 35so681376pzk.22
        for <multiple recipients>; Tue, 26 Jan 2010 08:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=nPcRkB9V1RiARBXcr2kvj6qoV2679oe11Kz7ZtPz2dE=;
        b=jKMe+jNpqreUGkriIRsW2A9T4MLixnEqncXfnN61W6wWRJqC/NTB8v2rh6YpGoG+Ge
         UOvsd/IX4osYJWHiVd4w1J1KlC1vZsbrd/SzAyT34Pmi8eGHlqU8ZRLIoMYDLZF+fLgn
         5aTzMGyNs1efeUmisYHBdkxIzoKatrXtMQzTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=CZOYBG4N9KH+hh4pAiKVtytBWHMsXjfx+7N9Z4O9d94b6ZR4ubj2O8WfgrZIc4C24U
         bbNUNkrkiXG6YNxCNBcgqZvagSuz9yKNvrWvzn251oDgpD/3ktkv3FcT0cyAzsEBZA1d
         x7XDQB+PLE1AzLAlR0Qg2WPPyYrkJDcYT7tp8=
Received: by 10.142.66.6 with SMTP id o6mr3518420wfa.226.1264521852032;
        Tue, 26 Jan 2010 08:04:12 -0800 (PST)
Received: from ?192.168.2.212? ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm5874006pzk.7.2010.01.26.08.04.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 08:04:11 -0800 (PST)
Subject: Re: [PATCH -queue v2] MIPS: Cleanup the debugging of compressed 
 kernel support
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <f861ec6f1001260728x64c54ec7m65bc6ebc0ee64a80@mail.gmail.com>
References: <8c337354c30ac911207df81abd13197c897b2380.1264517495.git.wuzhangjin@gmail.com>
         <f861ec6f1001260728x64c54ec7m65bc6ebc0ee64a80@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Tue, 26 Jan 2010 23:58:13 +0800
Message-ID: <1264521494.24895.28.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 7bit
X-archive-position: 25677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16777

On Tue, 2010-01-26 at 16:28 +0100, Manuel Lauss wrote:
> Hi,
> 
> On Tue, Jan 26, 2010 at 4:02 PM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> > Changes from v1 (feedbacks from Ralf):
> >
> >  o make DEBUG_ZBOOT also depend on DEBUG_KERNEL
> >
> >  o DEBUG_ZBOOT already depends on SYS_SUPPORTS_ZBOOT_UART16550 so simplify the
> 
> Not every chip has a standard 16550, unfortunately.  I liked your
> first iteration better:
> DEBUG_ZBOOT visible at all times (or depend on DEBUG_KERNEL)  another
> (invisible)
> config symbol selecting the code to build (i.e. SYS_SUPPORTS_ZBOOT_UART16550
> for your loongson boxes, MACH_ALCHEMY for alchemy, and nothing for unsupported
> chips).
> 

Yes, It will be not convenient for a new serial port debugging support
with the current modification, for example, if you add UARTXXXX, we need
to select it for the new board and also add it under the "depends" of
DEBUG_ZBOOT. how about this?

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index 5e556f7..6fccbf0 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -104,7 +104,7 @@ config RUNTIME_DEBUG
 
 config DEBUG_ZBOOT
        bool "Enable compressed kernel support debugging"
-       depends on DEBUG_KERNEL && SYS_SUPPORTS_ZBOOT_UART16550
+       depends on DEBUG_KERNEL

and we keep the old:

ifdef CONFIG_DEBUG_ZBOOT
obj-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
endif

If a new serial port is needed, we just need to add the following lines
to arch/mips/Kconfig

config SYS_SUPPORTS_ZBOOT_UARTXXX
	bool
	select SYS_SUPPORTS_ZBOOT

config MACH_XXXX
	[...]
	select SYS_SUPPORTS_ZBOOT_UARTXXX
	[...]

and in arch/mips/boot/compressed/Makfefile

ifdef CONFIG_DEBUG_ZBOOT
obj-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
+obj-$(CONFIG_SYS_SUPPORTS_ZBOOT_UARTXXX) += $(obj)/uart-xxx.o
endif

and also a new arch/mips/boot/compressed/uar-xxx.c is needed.

If this is okay, I will send a new revision asap.

Regards,
	Wu Zhangjin
