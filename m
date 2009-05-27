Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 May 2009 19:28:43 +0100 (BST)
Received: from mail-pz0-f134.google.com ([209.85.222.134]:35454 "EHLO
	mail-pz0-f134.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024302AbZE0S2g (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 27 May 2009 19:28:36 +0100
Received: by pzk40 with SMTP id 40so4329699pzk.22
        for <multiple recipients>; Wed, 27 May 2009 11:28:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=5C7xPyh216s7yZLxIo97yDbXtjFlhmNSqIU7J3DL7EI=;
        b=NYQqUTget+wHvxYsW3EkjAtNzoa0iuYivgEBCA68yJTXwu2Lw/n8Yj57tk920/YBCL
         pcetLn3WhpzwZcSI26Z03eQ4vGg7T5b7ZGSiPb2zhlR8MVLQyJ1eUm2Fx7Dmxo5O0byl
         s3nEz+bPx8FgzT8LA4mlBW+PDzKOmiUaSNZGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=UdRYva6BaRp/s7izejRUHE6IHPCTSiuzzKkHdzhJkvSO5nFe64ShAvrjDcItztQDHJ
         rUXRqMNfuDdLVnHTep9aBj4Xv4GzKQEv7YNLmg1yvKaZ5Uy/QhQmOgziv9mxuQivbu5B
         2IazpTINVddFXxzG9S25/nMI5pV3rrhkRHUgM=
Received: by 10.114.145.17 with SMTP id s17mr516403wad.120.1243448908596;
        Wed, 27 May 2009 11:28:28 -0700 (PDT)
Received: from ?192.168.1.100? ([219.246.59.144])
        by mx.google.com with ESMTPS id k35sm11449132waf.57.2009.05.27.11.28.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 11:28:28 -0700 (PDT)
Subject: Re: [loongson-PATCH-v2 19/23] Loongson2F cpufreq support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
In-Reply-To: <20090527100156.GA11145@roarinelk.homelinux.net>
References: <cover.1243362545.git.wuzj@lemote.com>
	 <1a75bd9d59ff0c92250ddb7238509a7a4b154505.1243362545.git.wuzj@lemote.com>
	 <20090527100156.GA11145@roarinelk.homelinux.net>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Thu, 28 May 2009 02:28:21 +0800
Message-Id: <1243448901.11263.117.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2009-05-27 at 12:01 +0200, Manuel Lauss wrote:
> Hi,
> 
> On Wed, May 27, 2009 at 03:08:55AM +0800, wuzhangjin@gmail.com wrote:
> > From: Wu Zhangjin <wuzj@lemote.com>
> > --- /dev/null
> > +++ b/arch/mips/include/asm/clock.h
> > @@ -0,0 +1,64 @@
> > +#ifndef __ASM_MIPS_CLOCK_H
> > +#define __ASM_MIPS_CLOCK_H
> 
> [...]
> 
> > +
> > +#endif				/* __ASM_MIPS_CLOCK_H */
> 
> 
> Please move this to your mach-loongson subdirectory since it is
> currently specific to lemote cpus.
> 

moved to arch/mips/include/asm/mach-loongson/.

thx!
Wu Zhangjin

> (I have a similar clock framework for Alchemy, also based on the sh port,
>  but with a few extensions specific to the nature of the alchemy clock
>  generators.  Maybe we could merge some aspects in the future).
> 
> 	Manuel Lauss
