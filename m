Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 14:36:21 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:52056 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492465AbZLANgR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Dec 2009 14:36:17 +0100
Received: by pwi15 with SMTP id 15so2663388pwi.24
        for <multiple recipients>; Tue, 01 Dec 2009 05:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=MT3c1Z04QHV4tHP/BL4MvzmLoLlsx7EBrdhI+ltI5F8=;
        b=JNkx+lkQSZAYpvEiYtSaQCnPnogQJK47gIr7h2zlG9LrnSPBW+6qNdeK6L08INev4D
         jrJz3r9GAZqWnIz1LBxCjHRbLUxqkZnLvGPCrjuEMVyyF7vckPioTJEFmVjhJfBVz4ls
         bG/eo74pvAkSTMGKp1RnFaWVRxnN2sOu/zfwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=F4GWKVHVTcRpi+DdzmDIbaN/OJVp9riPY/cDoFRGZuhLKWW5JBzi8mVL8as4V6l8U5
         n2Sh8N+XCDmZsGNL/3pqMffBA9HdpySFitfjhXy4PoMfxvOCvw8Nf5ySBZDQuCa9AIIY
         0sNZdr9wyWVPziP5epzXS8CgChI4rI1Vflwgw=
Received: by 10.115.61.16 with SMTP id o16mr10970902wak.15.1259674570440;
        Tue, 01 Dec 2009 05:36:10 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm556492pxi.5.2009.12.01.05.36.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 05:36:09 -0800 (PST)
Subject: Re: [PATCH v6 1/8] Loongson: Lemote-2F: add platform specific
 submenu
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, zhangfx@lemote.com
In-Reply-To: <20091201133223.GA14064@linux-mips.org>
References: <cover.1259664573.git.wuzhangjin@gmail.com>
         <a67a4a2ab32fc0e3281845479f07adf69dbf0bb2.1259664573.git.wuzhangjin@gmail.com>
         <20091201133223.GA14064@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Tue, 01 Dec 2009 21:35:38 +0800
Message-ID: <1259674538.11106.2.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, 2009-12-01 at 13:32 +0000, Ralf Baechle wrote:
> On Tue, Dec 01, 2009 at 07:07:23PM +0800, Wu Zhangin wrote:
> 
> >  arch/mips/loongson/Kconfig |   20 ++++++++++++++++++++
> >  1 files changed, 20 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
> > index 3df1967..a34dfcc 100644
> > --- a/arch/mips/loongson/Kconfig
> > +++ b/arch/mips/loongson/Kconfig
> > @@ -83,3 +83,23 @@ config LOONGSON_UART_BASE
> >  	bool
> >  	default y
> >  	depends on EARLY_PRINTK || SERIAL_8250
> > +
> > +#
> > +# Loongson Platform Specific Drivers
> > +#
> > +
> > +menuconfig LOONGSON_PLATFORM_DEVICES
> > +	bool "Loongson Platform Drivers"
> > +	default y
> > +	help
> > +	  Say Y here to get to see options for device drivers of various
> > +	  loongson platforms, including vendor-specific laptop/pc extension
> > +	  drivers.  This option alone does not add any kernel code.
> > +
> > +	  If you say N, all options in this submenu will be skipped and disabled.
> > +
> > +if LOONGSON_PLATFORM_DEVICES
> > +# Put platform specific stuff here
> 
> Useless comment.  LOONGSON_PLATFORM_DEVICES already says exactly that.
> 

Yep, Need to remove it  ;)

Thanks!
	Wu Zhangjin
