Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 16:47:36 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.170]:21748 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20038433AbWLAQrb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 1 Dec 2006 16:47:31 +0000
Received: by ug-out-1314.google.com with SMTP id 40so2675671uga
        for <linux-mips@linux-mips.org>; Fri, 01 Dec 2006 08:47:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NH1SF9V5GKquyDMv8ezQ7c0252CBQr4a8h7LSO6bh2vVR85NP0hR9fqFSVLsN4j/E6m0qeb008v/M4A1/J+lkvxJm0aVPx+Uxy2ikMr6QrFEsheTkRUcICf/ylAv3OQgRbJyfwB/hNZ6SD/pF01QeNEEerkLpdcBteiGvwPfa4Y=
Received: by 10.78.17.1 with SMTP id 1mr4967232huq.1164991649926;
        Fri, 01 Dec 2006 08:47:29 -0800 (PST)
Received: by 10.78.124.19 with HTTP; Fri, 1 Dec 2006 08:47:29 -0800 (PST)
Message-ID: <cda58cb80612010847g30213daau80c636b9dfc7dce3@mail.gmail.com>
Date:	Fri, 1 Dec 2006 17:47:29 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] Compile __do_IRQ() when really needed
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <20061202.004527.52131670.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <457042FF.2060908@innova-card.com>
	 <20061202.004527.52131670.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 12/1/06, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Fri, 01 Dec 2006 15:58:07 +0100, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> > @@ -216,6 +217,7 @@ config MACH_JAZZ
> >       select SYS_SUPPORTS_32BIT_KERNEL
> >       select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
> >       select SYS_SUPPORTS_100HZ
> > +     select GENERIC_HARDIRQS_NO__DO_IRQ
> >       help
> >        This a family of machines based on the MIPS R4030 chipset which was
> >        used by several vendors to build RISC/os and Windows NT workstations.
>
> JAZZ uses i8259 which is not converted to irq flow handler yet.
>

stupid me, I completely forgot this point ! I'm going to take a cool
shower before updating that...

> > @@ -468,6 +473,7 @@ config DDB5477
> >  config MACH_VR41XX
> >       bool "NEC VR41XX-based machines"
> >       select SYS_HAS_CPU_VR41XX
> > +     select GENERIC_HARDIRQS_NO__DO_IRQ
> >
> >  config PMC_YOSEMITE
> >       bool "PMC-Sierra Yosemite eval board"
>
> Same here.
>

are you sure ? I don't see any traces of i8259 selection.
Moreover, Yoichi's vr41xx boards seem to have no problem

I agree with all the rest.

Thanks
-- 
               Franck
