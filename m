Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jun 2010 16:14:57 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:51963 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491092Ab0FJOOy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Jun 2010 16:14:54 +0200
Received: by pwj6 with SMTP id 6so1269397pwj.36
        for <multiple recipients>; Thu, 10 Jun 2010 07:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=rh2a/jwdihJidlQzbNOIJMFKWjx0TdvL5QECMwWex7Y=;
        b=C1TSlserR1R+yCriCB+YWxJ3907qJkLZ2qDOElFX862bacxglwln/8cqh0FOpTf2z7
         I16AQiQTZlATaEuD/bZAi+3ujub7AqSRfhDjYmRN/YoeG3TuWUsc2kIprAHfbYy1nYgK
         wbe5TAq70H2LQVSWYOXc1CQ6jv8nNnGD8pJ9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=k3WoKuqUnDKbWbdXxuTHtOT3jUDe2GC8eE0y8m3RzSvN0S1dO9QWXLQY6emAE44jqS
         0Qs4GxHJTVGJQpi/6hBy7qffvJpbBUCu03v4u7KDnGcgwTqbKtcU02WkrlSl1o3xIjQA
         HXY8tXIyXTaraZDOsopxB3d5MEIlhWVAyffRg=
Received: by 10.114.117.19 with SMTP id p19mr188111wac.152.1276179285170;
        Thu, 10 Jun 2010 07:14:45 -0700 (PDT)
Received: from [192.168.1.105] ([123.113.111.57])
        by mx.google.com with ESMTPS id c1sm425467wam.19.2010.06.10.07.14.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Jun 2010 07:14:44 -0700 (PDT)
Subject: Re: zboot for brcm
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Waldemar Brodkorb <mail@waldemar-brodkorb.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20100609172438.GA23116@waldemar-brodkorb.de>
References: <20100609153831.GA27461@waldemar-brodkorb.de>
         <1276099374.4510.13.camel@localhost>
         <20100609172438.GA23116@waldemar-brodkorb.de>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Thu, 10 Jun 2010 22:14:38 +0800
Message-ID: <1276179278.21482.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
X-archive-position: 27114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 7314

Hi,

On Wed, 2010-06-09 at 19:24 +0200, Waldemar Brodkorb wrote:
[...]
> 
> I know this is not correct, it should just illustrate, that only if
> I use this VMLINUX_LOAD_ADDRESS, the decompressor code get executed.
> The bootloader CFE just loads every code to 0x80001000 and executes
> it. 

oh, it is really bad, that's why it always boot at 0x80001000 and will
overwrite the decompressor, than it fail on booting. we need to do
something for it, can you change the source code of CFE? If yes, we need
to let the CFE load the code to the entry point of the elf file, but
anyway, it is not a good idea, we need to modify the current zboot
support to avoid touching the bootloader.

Here should be a solution:

We use VMLINUX_LOAD_ADDRESS as VMLINUZ_LOAD_ADDRESS, but decompress the
kernel to VMLINUX_LOAD_ADDRESS + VMLINUZ_SIZE, it will not depends on
the bootloader, I think this will be a good idea and will solve your
problem ;) I will finish this patch asap, maybe tomorrow.

> 
> > 
> > And you just need to select "SYS_SUPPORTS_ZBOOT_UART16550" for it will
> > select SYS_SUPPORTS_ZBOOT itself. and please do not remove "ifdef
> > CONFIG_DEBUG_ZBOOT" and the related "#endif" but enable
> > "CONFIG_DEBUG_ZBOOT" in the .config(via make menuconfig) instead.
> 
> Okay, but CONFIG_DEBUG_ZBOOT is not defined anywhere.
>  

I have added this stuff to arch/mips/Kconfig.debug, you can find it via:

$ make menuconfig ARCH=mips

>> kernel hacking
   >> kernel debugging (DEBUG_KERNEL)
   >> Enable compressed kernel support debugging

Regards,
Wu Zhangjin
