Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Mar 2009 19:30:14 +0000 (GMT)
Received: from sitar.i-cable.com ([203.83.115.100]:40184 "HELO
	sitar.i-cable.com") by ftp.linux-mips.org with SMTP
	id S21369896AbZCTTaH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Mar 2009 19:30:07 +0000
Received: (qmail 24083 invoked by uid 508); 20 Mar 2009 19:29:59 -0000
Received: from 203.83.114.122 by sitar (envelope-from <robert.zhangle@gmail.com>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/8786.  
 Clear:RC:1(203.83.114.122):. 
 Processed in 0.096849 secs); 20 Mar 2009 19:29:59 -0000
Received: from ip114122.hkicable.com (HELO xenon.i-cable.com) (203.83.114.122)
  by 0 with SMTP; 20 Mar 2009 19:29:59 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by xenon.i-cable.com (8.13.5/8.13.5) with ESMTP id n2KJTwn1029021
	for <linux-mips@linux-mips.org>; Sat, 21 Mar 2009 03:29:59 +0800 (CST)
Date:	Sat, 21 Mar 2009 03:29:55 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: rename CPU_LOONGSON2 to CPU_LOONGSON2E
Message-ID: <20090320192954.GB14445@adriano.hkcable.com.hk>
Mail-Followup-To: linux-mips@linux-mips.org
References: <1237576220-4479-1-git-send-email-r0bertz@gentoo.org> <20090320192419.GA14445@adriano.hkcable.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090320192419.GA14445@adriano.hkcable.com.hk>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

On 03:24 Sat 21 Mar     , Zhang Le wrote:
> On 03:10 Sat 21 Mar     , Zhang Le wrote:
> > This is for future inclusion of Loongson 2F patches. Because Gcc 4.4 (not
> > released yet) has different -march argument for these two CPUs, we should
> > be able to distinguish them.
> 
> Sorry, please hold on. It seems I missed something.
> I will send another soon.

Oops, this requires much more changes than I originally thought.
I will see what I can come up with.
Sorry.

> 
> > 
> > Signed-off-by: Zhang Le <r0bertz@gentoo.org>
> > ---
> >  arch/mips/Kconfig  |    4 ++--
> >  arch/mips/Makefile |    2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > index 206cb79..dcb675d 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -1014,8 +1014,8 @@ choice
> >  	prompt "CPU type"
> >  	default CPU_R4X00
> >  
> > -config CPU_LOONGSON2
> > -	bool "Loongson 2"
> > +config CPU_LOONGSON2E
> > +	bool "Loongson 2E"
> >  	depends on SYS_HAS_CPU_LOONGSON2
> >  	select CPU_SUPPORTS_32BIT_KERNEL
> >  	select CPU_SUPPORTS_64BIT_KERNEL
> > diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> > index 22dab2e..097a7fa 100644
> > --- a/arch/mips/Makefile
> > +++ b/arch/mips/Makefile
> > @@ -119,7 +119,7 @@ cflags-$(CONFIG_CPU_R4300)	+= -march=r4300 -Wa,--trap
> >  cflags-$(CONFIG_CPU_VR41XX)	+= -march=r4100 -Wa,--trap
> >  cflags-$(CONFIG_CPU_R4X00)	+= -march=r4600 -Wa,--trap
> >  cflags-$(CONFIG_CPU_TX49XX)	+= -march=r4600 -Wa,--trap
> > -cflags-$(CONFIG_CPU_LOONGSON2)	+= -march=r4600 -Wa,--trap
> > +cflags-$(CONFIG_CPU_LOONGSON2E)	+= -march=r4600 -Wa,--trap
> >  cflags-$(CONFIG_CPU_MIPS32_R1)	+= $(call cc-option,-march=mips32,-mips32 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
> >  			-Wa,-mips32 -Wa,--trap
> >  cflags-$(CONFIG_CPU_MIPS32_R2)	+= $(call cc-option,-march=mips32r2,-mips32r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
> > -- 
> > 1.6.2
> > 
> 
