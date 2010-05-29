Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 May 2010 14:06:36 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:57779 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492023Ab0E2MGd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 29 May 2010 14:06:33 +0200
Received: by pwi2 with SMTP id 2so1021789pwi.36
        for <multiple recipients>; Sat, 29 May 2010 05:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=i6yX3ylK11EmwIcCodVAeBeyswFiSnz4dies1a1jmV8=;
        b=fSw5Q2MIe5++h9UNBLV0HCxAp+4fMuhfGPrwlCim9LRiS9Tup97Ccno1GLJfzN+cSM
         F57jCHfBlKpsJJwWLUZtLt9m2wvIdeZ2eykCCuj1AHidIRCepeugQZtcODdaPZxYnGTK
         Vuo3Tse7cRqeDp0u3tf5uKTa3M53+8o7rNpHY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=e0guhY0HQMddENjWvoj/eq/XUlM3PqcWGZ13WlbFjfln6zwjAta1MF6OJ5RYrUfjcy
         4RWIZgLqos0DaetqUt8wICkv1rDyBNwqgbVVMHJ4fZggFOecfc1ibEys9GD8VT+OlEdy
         PDuL5DICWUEXZ/5YQCl1jhkyp0A+8MYLKLpZI=
Received: by 10.114.187.17 with SMTP id k17mr1405376waf.31.1275134786003;
        Sat, 29 May 2010 05:06:26 -0700 (PDT)
Received: from [192.168.2.218] ([202.201.14.140])
        by mx.google.com with ESMTPS id d20sm28904272waa.3.2010.05.29.05.06.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 29 May 2010 05:06:25 -0700 (PDT)
Subject: Re: [PATCH] mips: drop CLEAN_FILES from arch/mips/Makefile
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20100529111713.GA31550@merkur.ravnborg.org>
References: <20100529111713.GA31550@merkur.ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Sat, 29 May 2010 20:06:18 +0800
Message-ID: <1275134778.11949.21.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Sam

With your patch, It really drops the specified files in the root
directory of Linux source code but can not remove the files under
arch/mips/boot/compressed/.

I have kept some temp files (.bin, .lzo...) under
arch/mips/boot/compressed/, 

> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> index 790ddd3..80f6de5 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -100,6 +100,4 @@ OBJCOPYFLAGS_vmlinuz.srec := $(OBJCOPYFLAGS) -S -O srec
>  vmlinuz.srec: vmlinuz
>  	$(call if_changed,objcopy)
>  
> -clean:
> -clean-files += *.o \
> -	       vmlinu*
> +clean-files := $(objtree)/vmlinu*

So, perhaps we need to reserve the vmlinux*, then we get

+ clean-files := vmlinu* \
                 $(objtree)/vmlinu*

Best Regards,
	Wu Zhangjin
