Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Oct 2009 05:51:56 +0200 (CEST)
Received: from mail-gx0-f227.google.com ([209.85.217.227]:36435 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492004AbZJIDvt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 9 Oct 2009 05:51:49 +0200
Received: by gxk27 with SMTP id 27so6644953gxk.7
        for <linux-mips@linux-mips.org>; Thu, 08 Oct 2009 20:51:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=pRaMycGiXbss7pbyqGSjaEvQgcpgegytGtbd4chDNbU=;
        b=EDmeNTja9isC59cxlnxUy2hYDKlPDQ/ccYj+3WSLZHmg1DsNRqeEb9otVmRWiuRNmP
         H/A+OyWE0KnMM78QDqI529CjDAJgcDdP1xEZ5czs3LJa4yVQpgpxJi3lC9I7YAfK5Rho
         4qS+flFSE2M+Y2OPSkgae14IHMpKFkef6q/So=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=rHG7YZoRhnwfg/P9Qm3Ven4MlE659WmrpU8HT6ZbZARHRHSa1w1Wi8KHvyoSH0ad5y
         w/KUnjsMiQEA/GkAkb72KiCpy+X6sJpGh69EtXh2q6wBabXjBuhYeTi1xl/k3Blex/sB
         sNOIMxMBGq6uXeX8rggLwM45mneGS3kG7TMLM=
Received: by 10.101.164.9 with SMTP id r9mr2412645ano.125.1255060303728;
        Thu, 08 Oct 2009 20:51:43 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm344356yxe.2.2009.10.08.20.51.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Oct 2009 20:51:43 -0700 (PDT)
Subject: Re: [PATCH] CS5535: Remove the X86 platform dependence of
 SND_CS5535AUDIO
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:	linux-mips <linux-mips@linux-mips.org>,
	Andres Salomon <dilinger@debian.org>,
	Jaya Kumar <jayakumar.lkml@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, loongson-dev@googlegroups.com
In-Reply-To: <1255059842-12160-1-git-send-email-wuzhangjin@gmail.com>
References: <1255059842-12160-1-git-send-email-wuzhangjin@gmail.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Fri, 09 Oct 2009 11:51:27 +0800
Message-Id: <1255060287.16819.1.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2009-10-09 at 11:44 +0800, Wu Zhangjin wrote:
> There is no platform dependence of SND_CS5535AUDIO before 2.6.31, Not
> sure who have touched this part, but SND_CS5535AUDIO is at least
> available on Loongson family machines, so, Remove the platform
> dependence directly.
> 
> Reported-by: rixed@happyleptic.org
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  sound/pci/Kconfig |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
> index fb5ee3c..75c602b 100644
> --- a/sound/pci/Kconfig
> +++ b/sound/pci/Kconfig
> @@ -259,7 +259,6 @@ config SND_CS5530
>  
>  config SND_CS5535AUDIO
>  	tristate "CS5535/CS5536 Audio"
> -	depends on X86 && !X86_64

or use this?

	depends on (X86 && !X86_64) || MIPS

Regards,
	Wu Zhangjin
