Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jan 2009 09:24:18 +0000 (GMT)
Received: from mail-ew0-f17.google.com ([209.85.219.17]:56981 "EHLO
	mail-ew0-f17.google.com") by ftp.linux-mips.org with ESMTP
	id S20021569AbZA0JYQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Jan 2009 09:24:16 +0000
Received: by ewy10 with SMTP id 10so6465528ewy.0
        for <linux-mips@linux-mips.org>; Tue, 27 Jan 2009 01:24:10 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=x3hCGYIXCxCOzFPJ5clRuFNsbfXm5XmYQeukHQqCQKg=;
        b=ACEzXvQG9TSgtK8RXkbH4DXyRva/8Fb0rNg+Ozdr0gfc10WcYOEIPkwQszfxztK3xf
         OWcFx2T6la3qTHFbHgTTuWBzipnFB+78yS7u0SX69lDrS/vWPJ54CQaa7yTPV8Wno17d
         dcfF7xM9TJwl/Q6rg4gxZvRd3Vm3StWGRKibA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=fm4q4q9HjpUzYIsrLip9FHtVhzpuMpuFLA84VxTqEIQd2t+Vxxm8oG3DuGDq7FJfZB
         LWv+WSAtUwJhe8xROf+aQ5Dkduh0WRFjyACnomI4de5i+l4Vl25v62Eq7XpRp4XefWAg
         wtE9Hlr29rk0/Zr8OiNbfKndO0W1VmeRsZZNA=
Received: by 10.103.222.1 with SMTP id z1mr3824971muq.100.1233048250711;
        Tue, 27 Jan 2009 01:24:10 -0800 (PST)
Received: from lenovo.mimichou.home (florian.mimichou.net [82.241.112.26])
        by mx.google.com with ESMTPS id w5sm25134498mue.55.2009.01.27.01.24.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jan 2009 01:24:09 -0800 (PST)
From:	Florian Fainelli <florian@openwrt.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: AU1550 Kernel bug detected[#1]  clockevents_register_device
Date:	Tue, 27 Jan 2009 10:23:37 +0100
User-Agent: KMail/1.9.9
Cc:	Frank Neuber <linux-mips@kernelport.de>,
	Linux-MIPS <linux-mips@linux-mips.org>
References: <1233045842.28527.459.camel@t60p> <20090127091107.GA15890@roarinelk.homelinux.net> <200901271018.31863.florian@openwrt.org>
In-Reply-To: <200901271018.31863.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200901271023.38127.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Tuesday 27 January 2009 10:18:30 Florian Fainelli, vous avez écrit :
> Le Tuesday 27 January 2009 10:11:07 Manuel Lauss, vous avez écrit :
> > On Tue, Jan 27, 2009 at 09:44:02AM +0100, Frank Neuber wrote:
> > > Hi,
> > > to find my PCI problem I want to use git to find the last working
> > > version.
> > > I just start with head and found a compile error:
> > > arch/mips/alchemy/common/time.c:93: error: incompatible types in
> > > initialization
> > > I comment this line ".cpumask        = CPU_MASK_ALL,"
> >
> > you need to change it to "CPU_MASK_ALL_PTR".  Commenting it is not a very
> > good idea ;-)
>
> This build failure also happens on linux-queue. Patch below.
> --
> From: Florian Fainelli
> Subject: [PATCH] alchemy: fix build failure on time.c
>
> This patch fixes the following build failure :
>
> arch/mips/alchemy/common/time.c:93: error: incompatible types in
> initialization

Errm sorry, this was not for linux-queue ;)
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
