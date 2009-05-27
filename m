Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 May 2009 15:23:34 +0100 (BST)
Received: from mail-pz0-f134.google.com ([209.85.222.134]:35234 "EHLO
	mail-pz0-f134.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024142AbZE0OX2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 27 May 2009 15:23:28 +0100
Received: by pzk40 with SMTP id 40so4199343pzk.22
        for <multiple recipients>; Wed, 27 May 2009 07:23:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=HoEu1taRZHBJ8CCxba4dVNDkVKfSz6by0LL6kX6VMZo=;
        b=we3n8cq5EwR37dL2PVwMWShnaW7V6ivXe6CcXtlh6atgDfPdBxlPkuwytB8onq0mFa
         SKsMTrF61/4gv77jPV+oU+/D4wYmCb+EIERkGQRuShkINj6hYQHp/6NGumF1oJ8qjXDB
         HGaR7xaRGnTA0AzOF6sU2bNhQRfpF3p5extXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=EJz/PC9BdwVfIx8dYdr4tgdNZZYJz86Fb0RXi77Xre2NceeJy9WU9EqMNHVeJpyqMP
         UHby3SVZeueh1oJ57nuMpjunUuwT80X7/505Xpy0DOfSyrQ/OQ2JXW3Z2ni0I0+iB14o
         qIv/GGt02ocHe2JzI6izUKCbla98eNUlDxQpE=
Received: by 10.114.174.2 with SMTP id w2mr26785wae.195.1243434201525;
        Wed, 27 May 2009 07:23:21 -0700 (PDT)
Received: from ?192.168.2.239? ([202.201.14.140])
        by mx.google.com with ESMTPS id j31sm2315329waf.61.2009.05.27.07.23.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 07:23:19 -0700 (PDT)
Subject: Re: [loongson-PATCH-v2 20/23] add gcc 4.4 support for MIPS and
 loongson
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Arnaud Patard <apatard@mandriva.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
In-Reply-To: <m33aaqq4ro.fsf@anduin.mandriva.com>
References: <cover.1243362545.git.wuzj@lemote.com>
	 <afda033feccfe0946c308eddc86b2049f4919be2.1243362545.git.wuzj@lemote.com>
	 <m33aaqq4ro.fsf@anduin.mandriva.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Wed, 27 May 2009 22:23:02 +0800
Message-Id: <1243434182.11263.3.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2009-05-27 at 11:22 +0200, Arnaud Patard wrote:
> wuzhangjin@gmail.com writes:
> Hi,
> 
> > From: Wu Zhangjin <wuzj@lemote.com>
> >
> > the gcc 4.4 support for MIPS mostly refer to this PATCH:
> > http://www.nabble.com/-PATCH--MIPS:-Handle-removal-of-%27h%27-constraint-in-GCC-4.4-td22192768.html
> > but have been tuned a little.
> >
> > because only gcc 4.4 have loongson-specific support, so, we need to
> > choose the suitable -march argument for gcc <= 4.3 and gcc >= 4.4, and
> > we also need to consider use -march=loongson2e and -march=loongson2f for
> > loongson2e and loongson2f respectively. this is handled by adding two
> > new kernel options: CPU_LOONGSON2E and CPU_LOONGSON2F(thanks for the
> > solutin provided by ZhangLe).
> >
> > I have tested it on FuLoong(2f) in 32bit and 64bit with gcc-4.4 and
> > gcc-4.3. so, basically, it works.
> >
> > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> > ---
> >  arch/mips/Makefile               |    9 +++++-
> >  arch/mips/include/asm/compiler.h |   10 ++++++
> >  arch/mips/include/asm/delay.h    |   58 +++++++++++++++++++++++++------------
> >  3 files changed, 57 insertions(+), 20 deletions(-)
> >
> > diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> > index a25c2e5..1ee5504 100644
> > --- a/arch/mips/Makefile
> > +++ b/arch/mips/Makefile
> > @@ -120,7 +120,14 @@ cflags-$(CONFIG_CPU_R4300)	+= -march=r4300 -Wa,--trap
> >  cflags-$(CONFIG_CPU_VR41XX)	+= -march=r4100 -Wa,--trap
> >  cflags-$(CONFIG_CPU_R4X00)	+= -march=r4600 -Wa,--trap
> >  cflags-$(CONFIG_CPU_TX49XX)	+= -march=r4600 -Wa,--trap
> > -cflags-$(CONFIG_CPU_LOONGSON2)	+= -march=r4600 -Wa,--trap
> > +
> > +# only gcc >= 4.4 have the loongson-specific support
> > +cflags-$(CONFIG_CPU_LOONGSON2)	+= -Wa,--trap
> > +cflags-$(CONFIG_CPU_LOONGSON2E)	+= $(shell if [ $(call cc-version) -lt 0440 ] ; then \
> > +	echo $(call cc-option,-march=r4600); else echo $(call cc-option,-march=loongson2e); fi ;)
> > +cflags-$(CONFIG_CPU_LOONGSON2F)	+= $(shell if [ $(call cc-version) -lt 0440 ] ; then \
> > +	echo $(call cc-option,-march=r4600); else echo $(call cc-option,-march=loongson2f); fi ;)
> > +
> 
> why not using something like that ? :
>         cflags-$(CONFIG_LOONGSON2E) += \
>                 $(call cc-option,-march=loongson2e,$(call cc-option,-march=r4600))
>         cflags-$(CONFIG_LOONGSON2F) += \
>                 $(call cc-option,-march=loongson2f,$(call cc-option,-march=r4600))
> 

applied.

Documentation/kbuild/makefiles.txt:

  cc-option is used to check if $(CC) supports a given option, and not
  supported to use an optional second option.

thx!
Wu Zhangjin
