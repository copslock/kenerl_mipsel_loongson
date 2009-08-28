Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Aug 2009 10:53:55 +0200 (CEST)
Received: from mail-bw0-f208.google.com ([209.85.218.208]:60042 "EHLO
	mail-bw0-f208.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492499AbZH1Ixt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Aug 2009 10:53:49 +0200
Received: by bwz4 with SMTP id 4so1710402bwz.0
        for <multiple recipients>; Fri, 28 Aug 2009 01:53:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :organization:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=vcuyUxjUaqDqwd9cfczWKXlav7BluMAy/F4xk7REW7U=;
        b=JBvi22lhChA5F6PbW/bEaiSj7svkdbbRY602itLbAo+PRh5TUzuPfogvtkPTV3f7Y8
         CL4ZSyBp0gqHnNPKUY1aAf/lO0J+CqoaHu6KagqDs+M+4Ka6HqKZ4h+qLKGf6W7Ly7BG
         RBaSOe9q7bkUEwVC62mI8oaSr/PMb0OkmTLGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=fyPoqhauH8d4rPO1gXeldY0ZyNOc5gZTAGHegSwGHYauFRhTZ1ThCg+azuCOqXRxtw
         XqNJxMsDyr71X4Ta/tRq0SmezDZV8fQDK7/L/c1AZO0dWM8bIQHmPLKOW1WBS5vBVcBD
         RsiV6huws4CF9gRzL+y+dtlbztzQkujkOvYDo=
Received: by 10.103.126.33 with SMTP id d33mr135887mun.109.1251449622927;
        Fri, 28 Aug 2009 01:53:42 -0700 (PDT)
Received: from ?0.0.0.0? (p5496FC4A.dip.t-dialin.net [84.150.252.74])
        by mx.google.com with ESMTPS id j9sm4237134mue.52.2009.08.28.01.53.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Aug 2009 01:53:42 -0700 (PDT)
Message-ID: <4A979B0E.106@gmail.com>
Date:	Fri, 28 Aug 2009 10:53:34 +0200
From:	Manuel Lauss <manuel.lauss@googlemail.com>
Organization: Private
User-Agent: Thunderbird 2.0.0.22 (X11/20090825)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>,
	Florian Fainelli <florian@openwrt.org>
CC:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: MTX build failure
References: <20090828074709.GA11637@linux-mips.org>
In-Reply-To: <20090828074709.GA11637@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
>   CC      drivers/input/keyboard/gpio_keys.o
> /home/ralf/src/linux/linux-mips/drivers/input/keyboard/gpio_keys.c: In function ‘gpio_keys_probe’:
> /home/ralf/src/linux/linux-mips/drivers/input/keyboard/gpio_keys.c:123: error: implicit declaration of function ‘gpio_request’
> /home/ralf/src/linux/linux-mips/drivers/input/keyboard/gpio_keys.c:135: error: implicit declaration of function ‘gpio_free’
> make[5]: *** [drivers/input/keyboard/gpio_keys.o] Error 1
> make[4]: *** [drivers/input/keyboard] Error 2
> make[3]: *** [drivers/input] Error 2
> make[2]: *** [drivers] Error 2
> make[1]: *** [sub-make] Error 2

Either something like the patch below, or adding stubs for
gpio_request/gpio_free to asm/mach-au1x00/gpio-au1000.h in the
CONFIG_GPIOLIB=n case should fix it.

diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
index 1e0a6df..f0c930a 100644
--- a/arch/mips/alchemy/Kconfig
+++ b/arch/mips/alchemy/Kconfig
@@ -20,6 +20,7 @@ config MIPS_MTX1
 	select HW_HAS_PCI
 	select SOC_AU1500
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select GPIOLIB

 config MIPS_BOSPORUS
 	bool "Alchemy Bosporus board"


	Manuel Lauss
