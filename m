Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Apr 2010 15:09:44 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:41020 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491195Ab0DGNJk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Apr 2010 15:09:40 +0200
Received: by pwj3 with SMTP id 3so904939pwj.36
        for <multiple recipients>; Wed, 07 Apr 2010 06:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=Cu18Q4/gYo4sQE0+/O4bPSe9E1gakvr0bT+nonnmhSI=;
        b=w4ADRzN1XimoDkYeT3CZZB99ubm2jYt2DtE6vVbkMe2LwjrADpe89c8ZHehiqV7Zco
         MQnj5+d7IAZaJMGkEdNE7GNHMbLdyzn2v7Xy1YmNjbHdLPIq297+VgG9l8Vxduz10VWO
         ZrTeKpdIVHF39uTVcgYRA6EUIyIZqQGdU2uWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=h+hfCMs6S8VjmuM3L0w+1rmk+kHMAKqS9oxeiL+QidIMyoj+lCOt6jUP/nByAhmNA5
         5OH82gFOcHJZy6IfohUgPHW5EV927+9Lj9TBJpe4P7KRM/+Jy4IpbPqUnUdIDgTqZxC3
         zXa5c3hiNU5qooGaFr6ERpyKW8l84Ya+5fwr0=
Received: by 10.141.23.16 with SMTP id a16mr7068670rvj.239.1270645771353;
        Wed, 07 Apr 2010 06:09:31 -0700 (PDT)
Received: from [192.168.2.212] ([202.201.14.140])
        by mx.google.com with ESMTPS id 4sm3968641ywg.9.2010.04.07.06.09.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 06:09:30 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] Loongson-2F: Enable fixups of binutils 2.20.1
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        Shinya Kuribayashi <shinya.kuribayashi@necel.com>,
        Zhang Le <r0bertz@gentoo.org>
In-Reply-To: <20100317135223.GA4554@linux-mips.org>
References: <cover.1268453720.git.wuzhangjin@gmail.com>
         <ecc51ee134ab84c95b6b02534544df3731bb9562.1268453720.git.wuzhangjin@gmail.com>
         <20100317135223.GA4554@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Wed, 07 Apr 2010 21:02:30 +0800
Message-ID: <1270645350.22802.7.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2010-03-17 at 14:52 +0100, Ralf Baechle wrote:
> On Sat, Mar 13, 2010 at 12:34:16PM +0800, Wu Zhangjin wrote:
> 
> > diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> > index 2f2eac2..5ae342e 100644
> > --- a/arch/mips/Makefile
> > +++ b/arch/mips/Makefile
> > @@ -135,7 +135,9 @@ cflags-$(CONFIG_CPU_LOONGSON2)	+= -Wa,--trap
> >  cflags-$(CONFIG_CPU_LOONGSON2E) += \
> >  	$(call cc-option,-march=loongson2e,-march=r4600)
> >  cflags-$(CONFIG_CPU_LOONGSON2F) += \
> > -	$(call cc-option,-march=loongson2f,-march=r4600)
> > +	$(call cc-option,-march=loongson2f,-march=r4600) \
> > +	$(call as-option,-Wa$(comma)-mfix-loongson2f-nop,) \
> > +	$(call as-option,-Wa$(comma)-mfix-loongson2f-jump,)
> 
> Shouldn't these options be used unconditionally?  It seems a kernel build
> should rather fail than a possibly unreliable kernel be built - possibly
> even without the user noticing the problem.

Thanks for your good suggestion!

Just added a new kernel config option: CPU_LOONGSON2F_WORKAROUNDS to
allow the users to enable the workarounds for the necessary loongson2f
batches and it is enabled by default. And to force the users to use the
right binutils with the workarounds, errors will be printed on the
standard output with the following stuff:

  ifeq ($(call as-option,-Wa$(comma)-mfix-loongson2f-nop,),)
    $(error gcc does not support needed option -mfix-loongson2f-nop)
  else
    cflags-$(CONFIG_CPU_NOP_WORKAROUNDS) += -Wa
$(comma)-mfix-loongson2f-nop
  endif

Will resend the new patchset with your feedbacks asap.

Regards,
	Wu Zhangjin
