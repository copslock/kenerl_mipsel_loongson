Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jul 2009 03:10:11 +0200 (CEST)
Received: from mail-pz0-f173.google.com ([209.85.222.173]:39043 "EHLO
	mail-pz0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491827AbZGBBKE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Jul 2009 03:10:04 +0200
Received: by pzk3 with SMTP id 3so1174409pzk.22
        for <multiple recipients>; Wed, 01 Jul 2009 18:04:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=RrPGQz9qgBMKhapgSx/vhoOKEgRPEbAeS1ED2A/H7Z0=;
        b=Cz72FvicexAy7xbEOm19V7ghrCEAPazM9qh4h4PPabwDnTC8rybZhmzx+fNfGgMI1S
         OMDO9f7k4CyRihpTTVRT//XU9abtpaCOYBlpHCVn5wdMNFBfY/ZmoFC2pwcsYcEhLvim
         tXsjhCRl8LtQjbFPEzxRfrhh2pJLOE8PjiBAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=Fe4akczbiOVs5KgfUQS2DF/z8ZVvTVuGkuSPwkxufTof9tSvUknb7F2ELv64O0839r
         UPx4e7Jyzfat+OLpHuWRXPDbgVBNCWotedr4skM7SBx7TBMaHKMGPCKzQmAotXFRq7nn
         WE5pl3IBq5TPmDq7VASXb89qEoIpd7sXuNyFY=
Received: by 10.115.107.5 with SMTP id j5mr16281321wam.105.1246496660985;
        Wed, 01 Jul 2009 18:04:20 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id v9sm3094307wah.1.2009.07.01.18.04.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Jul 2009 18:04:20 -0700 (PDT)
Subject: Re: [BUG] MIPS: Hibernation in the latest linux-mips:master branch
 not work
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org,
	Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20090701180715.GA23121@linux-mips.org>
References: <1246372868.19049.17.camel@falcon>
	 <20090630144540.GA18212@linux-mips.org> <1246374687.20482.10.camel@falcon>
	 <20090701180715.GA23121@linux-mips.org>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Thu, 02 Jul 2009 09:04:07 +0800
Message-Id: <1246496647.9660.46.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23588
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2009-07-01 at 19:07 +0100, Ralf Baechle wrote:
> On Tue, Jun 30, 2009 at 11:11:27PM +0800, Wu Zhangjin wrote:
> 
> > hi, ralf, in the latest master branch of linux-mips git repo, seems
> > there is a need to select the SYS_SUPPORTS_HOTPLUG_CPU option in every
> > uni-processor board, otherwise, the suspend/hibernation can not be used,
> > because you have set:
> > 
> > config ARCH_HIBERNATION_POSSIBLE
> >     def_bool y
> >     depends on SYS_SUPPORTS_HOTPLUG_CPU
> > 
> > config ARCH_SUSPEND_POSSIBLE
> >     def_bool y
> >     depends on SYS_SUPPORTS_HOTPLUG_CPU
> > 
> > so, the board-specific patch must be pushed by the maintainers of
> > boards. and if the board support SMP, they must implement the
> > mips-specific hotplug support, is this right? I have selected
> > SYS_SUPPORTS_HOTPLUG_CPU in LEMOTE_FULONG and will push a relative patch
> > later.
> 
> I think below patch should take care of this problem.  It simply assumes
> that all uniprocessor systems support suspend and hibernate.  That's an
> assumption that I'm not to unhappy with though it may force us to fix a
> few systems.
> 

This patch is better.

Thanks!
Wu Zhangjin

>   Ralf
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
>  arch/mips/Kconfig |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index df1a92a..3ca0fe1 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2168,11 +2168,11 @@ menu "Power management options"
>  
>  config ARCH_HIBERNATION_POSSIBLE
>  	def_bool y
> -	depends on SYS_SUPPORTS_HOTPLUG_CPU
> +	depends on SYS_SUPPORTS_HOTPLUG_CPU || !SMP
>  
>  config ARCH_SUSPEND_POSSIBLE
>  	def_bool y
> -	depends on SYS_SUPPORTS_HOTPLUG_CPU
> +	depends on SYS_SUPPORTS_HOTPLUG_CPU || !SMP
>  
>  source "kernel/power/Kconfig"
>  
