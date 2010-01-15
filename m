Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jan 2010 13:27:29 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:57639 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492369Ab0AOM1Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jan 2010 13:27:25 +0100
Received: by pzk35 with SMTP id 35so580124pzk.22
        for <multiple recipients>; Fri, 15 Jan 2010 04:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=U6Ncxlgl9QDilK26B5rkuwQAPolraWDMdeHhHAqlNjg=;
        b=muHnLl/598om8icSJiTaDjLvvHOadAim59xQ5EGM2/TZdxmMui4HKcDTojP58yqztS
         t51+RKmTPITLKuuBF9IR9H9EARe1IE38VZpqcpKXaogbUGUSl0jPGieHRCNB9qrfH/Ts
         2b4CpOx16Aq3Gn49E7VQHighASSGzBqmm8dD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=sXgY5qMr5KU4w39cNZekPx4J8xOVOgduM1SBGzjVJPbyBljy65/9N3fEI/hNVdLSXb
         XiUHoUVKUXZ83uxBodJUqEfzKJx0rF9jrTInJDljIzJegSacl77nvIYNjXaSW7vFM4U9
         kGt7oCpBNW6ClMxWWy2j8Zgom1AHrGEfm/pbg=
Received: by 10.142.60.3 with SMTP id i3mr1615376wfa.19.1263558437642;
        Fri, 15 Jan 2010 04:27:17 -0800 (PST)
Received: from ?192.168.2.212? ([202.201.14.140])
        by mx.google.com with ESMTPS id 22sm1372058pzk.6.2010.01.15.04.27.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 04:27:17 -0800 (PST)
Subject: Re: [PATCH] MIPS: Add support of LZO-compressed kernels
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <4B5043B2.5060009@ru.mvista.com>
References: <1263540676-26295-1-git-send-email-wuzhangjin@gmail.com>
         <4B5043B2.5060009@ru.mvista.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Fri, 15 Jan 2010 20:26:00 +0800
Message-ID: <1263558361.12375.0.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
X-archive-position: 25598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 10142

On Fri, 2010-01-15 at 13:30 +0300, Sergei Shtylyov wrote:
> Hello.
> 
> Wu Zhangjin wrote:
> > The commit "lib: add support for LZO-compressed kernels" has been merged
> > into linus' 2.6.33-rc4 tree, so, It is time to add the support for MIPS.
> >
> > NOTE: to enable this support, the lzop application is needed.
> >
> > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> >   
> [...]
> > diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> > index 671d344..e3c93f8 100644
> > --- a/arch/mips/boot/compressed/Makefile
> > +++ b/arch/mips/boot/compressed/Makefile
> > @@ -41,9 +41,11 @@ $(obj)/vmlinux.bin: $(KBUILD_IMAGE)
> >  suffix_$(CONFIG_KERNEL_GZIP)  = gz
> >  suffix_$(CONFIG_KERNEL_BZIP2) = bz2
> >  suffix_$(CONFIG_KERNEL_LZMA)  = lzma
> > +suffix_$(CONFIG_KERNEL_LZO)  = lzo
> >  tool_$(CONFIG_KERNEL_GZIP)    = gzip
> >  tool_$(CONFIG_KERNEL_BZIP2)   = bzip2
> >  tool_$(CONFIG_KERNEL_LZMA)    = lzma
> > +tool_$(CONFIG_KERNEL_LZO)    = lzo
> >   
> 
>    You should align "lzo" with the rest of the suffixes/tool names.
> 

Done, will resend it later.

Thanks!
	Wu Zhangjin
