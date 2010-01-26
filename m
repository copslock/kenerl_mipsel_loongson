Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2010 19:13:03 +0100 (CET)
Received: from mail-yw0-f182.google.com ([209.85.211.182]:35859 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493394Ab0AZSM7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2010 19:12:59 +0100
Received: by ywh12 with SMTP id 12so4242592ywh.21
        for <multiple recipients>; Tue, 26 Jan 2010 10:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=hn3v2+NSmQLv8QsG7U9TqfcXd7lBBoFv8emfeJHLLJQ=;
        b=NzDYIz3vhngnH6tG7CWgZRZ8YpTfrXpEbDKMnny8AKCJryAlwQevMNDiYAEgf6opQs
         ZaaS2vNX3iIgrjtKvUqRVC76pbHsbDcJe4xyjf/XzYTasgeSdK5oB85pKJex6YD7iV7s
         X92JoARr89XD0kuMYoyyiJRn5a7425DCniStg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=wdhaEC+UCW/L40iYGNmwSsbWjwrqpXHwAUhPVY575JccnsXTfs/xLGuODLaotphK7O
         ZIn+k+AOd5Veb5MJM+d+7aM4m7BSqNtPjrdooq6/tqnIF4PrFGRR23gP76mSfabeZu/5
         gzeOAoeAZDlCMT3SlwgDarroNTJ0S6Wo8hVMs=
Received: by 10.101.133.34 with SMTP id k34mr2179921ann.213.1264529573279;
        Tue, 26 Jan 2010 10:12:53 -0800 (PST)
Received: from ?192.168.1.236? ([219.246.59.166])
        by mx.google.com with ESMTPS id 4sm2185037ywi.39.2010.01.26.10.12.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 10:12:52 -0800 (PST)
Subject: Re: [PATCH -queue v3] MIPS: Cleanup the debugging of compressed 
 kernel support
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <f861ec6f1001261007k4f71244fqcc92e2b6b1c9234c@mail.gmail.com>
References: <cf2781a56090637044a5ad3837caef468a674ee4.1264524254.git.wuzhangjin@gmail.com>
         <f861ec6f1001261007k4f71244fqcc92e2b6b1c9234c@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Wed, 27 Jan 2010 02:06:48 +0800
Message-ID: <1264529208.11605.3.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 7bit
X-archive-position: 25685
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16844

On Tue, 2010-01-26 at 19:07 +0100, Manuel Lauss wrote:
> Hi!
> 
> On Tue, Jan 26, 2010 at 6:01 PM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> > From: Wu Zhangjin <wuzhangjin@gmail.com>
> >
> > --- a/arch/mips/boot/compressed/Makefile
> > +++ b/arch/mips/boot/compressed/Makefile
> > @@ -32,7 +32,9 @@ KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
> >
> >  obj-y := $(obj)/head.o $(obj)/decompress.o $(obj)/dbg.o
> >
> > +ifdef DEBUG_ZBOOT
> 
> The above doesn't work in my testing, but this does:
> ifeq ($(CONFIG_DEBUG_ZBOOT),y)

oh, my god, I have forgotten the prefix CONFIG_, perhaps Ralf will help to fix it ;)

it should be:

ifdef CONFIG_DEBUG_ZBOOT
...
endif

of course, your ifeq version also works ;)

Thanks & Regards!
	Wu Zhangjin
