Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Aug 2009 11:27:12 +0200 (CEST)
Received: from mail-bw0-f208.google.com ([209.85.218.208]:56639 "EHLO
	mail-bw0-f208.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492470AbZH1J1G (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Aug 2009 11:27:06 +0200
Received: by bwz4 with SMTP id 4so1725693bwz.0
        for <multiple recipients>; Fri, 28 Aug 2009 02:27:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :organization:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=bBi6HY0lajcBiZ2mta3idkn/6A2UVElCPSUrujYSL58=;
        b=vUjIexgOxWO0h2THO1bVcsUU/ZwYYGUHuXsom7+KVqkdtbi79jyBOMrvK9cXQEkROe
         ZeLAxrn18bB1wvASBFINZByT4B1TomtbPXVI2xBY9h2WDdjcjg4Ok2aVVImlesZETHDu
         pe8jL75uDcaoOB79hJuHrfDcildc2nSuhHiSc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=KlPNv9xsHGqXfL57b+F819Poela0+/SFVBI8SF0/guZ4oVYPgPp6AVkwMBa4Rmnqcq
         HBmsjdeNQR+LjYFw79Xhumvluj1YETmeElIChbW1zKrY1AlynyhvVXv5uc60BdWo1DLr
         uAOJLU70rSLHW44l9gUnIYbF0GTqrq+gkNFoA=
Received: by 10.103.125.23 with SMTP id c23mr150016mun.41.1251451621260;
        Fri, 28 Aug 2009 02:27:01 -0700 (PDT)
Received: from ?0.0.0.0? (p5496FC4A.dip.t-dialin.net [84.150.252.74])
        by mx.google.com with ESMTPS id 23sm4265695mum.35.2009.08.28.02.26.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Aug 2009 02:27:00 -0700 (PDT)
Message-ID: <4A97A2E2.2090108@gmail.com>
Date:	Fri, 28 Aug 2009 11:26:58 +0200
From:	Manuel Lauss <manuel.lauss@googlemail.com>
Organization: Private
User-Agent: Thunderbird 2.0.0.22 (X11/20090825)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>,
	Florian Fainelli <florian@openwrt.org>
CC:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: MTX build failure
References: <20090828074709.GA11637@linux-mips.org> <4A979B0E.106@gmail.com>
In-Reply-To: <4A979B0E.106@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

I wrote:
> Ralf Baechle wrote:
>>   CC      drivers/input/keyboard/gpio_keys.o
>> /home/ralf/src/linux/linux-mips/drivers/input/keyboard/gpio_keys.c: In function ‘gpio_keys_probe’:
>> /home/ralf/src/linux/linux-mips/drivers/input/keyboard/gpio_keys.c:123: error: implicit declaration of function ‘gpio_request’
>> /home/ralf/src/linux/linux-mips/drivers/input/keyboard/gpio_keys.c:135: error: implicit declaration of function ‘gpio_free’
>> make[5]: *** [drivers/input/keyboard/gpio_keys.o] Error 1
>> make[4]: *** [drivers/input/keyboard] Error 2
>> make[3]: *** [drivers/input] Error 2
>> make[2]: *** [drivers] Error 2
>> make[1]: *** [sub-make] Error 2
> 
> Either something like the patch below, or adding stubs for
> gpio_request/gpio_free to asm/mach-au1x00/gpio-au1000.h in the
> CONFIG_GPIOLIB=n case should fix it.

Florian, Ralf, I prefer the latter approach;  saves everyone from
having to add #ifdef CONFIG_GPIOLIB around gpio_request() calls.

Here's an untested patch.  What do you think?  If it works for you, please
add it to your patchqueue!

Thanks!

---

From: Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] Alchemy: add gpio_request/gpio_free stubs for CONFIG_GPIOLIB=n

Some drivers use gpio_request/gpio_free regardless of whether
gpiolib is actually built;  add stubs to work around the ensuing
compile failures.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/include/asm/mach-au1x00/gpio-au1000.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
index 127d4ed..feea001 100644
--- a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
@@ -578,6 +578,15 @@ static inline int irq_to_gpio(int irq)
 	return alchemy_irq_to_gpio(irq);
 }

+static inline int gpio_request(unsigned gpio, const char *label)
+{
+	return 0;
+}
+
+static inline void gpio_free(unsigned gpio)
+{
+}
+
 #endif	/* !CONFIG_ALCHEMY_GPIO_INDIRECT */


--
1.6.4.1
