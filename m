Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 15:18:21 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.168]:4822 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20038405AbWLAPSR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 1 Dec 2006 15:18:17 +0000
Received: by ug-out-1314.google.com with SMTP id 40so2648187uga
        for <linux-mips@linux-mips.org>; Fri, 01 Dec 2006 07:18:16 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F9490MT6fG8tJ30xxewsn+EDtTrlZgsw2MEmkowPbkZMOgMnWn4NwlvHw8GvOzBV4Ul3Mb247fT3GV/oM7LOXf6I6EU420zLp4mdo+Yj0PeGgQ1Ta9c5F9296ZPFiSzzWHVeZ66t6O6cgiXi4VREOZ+/3/5gx1dVJ6gto6YKIU8=
Received: by 10.78.138.6 with SMTP id l6mr4884934hud.1164986296194;
        Fri, 01 Dec 2006 07:18:16 -0800 (PST)
Received: by 10.78.124.19 with HTTP; Fri, 1 Dec 2006 07:18:15 -0800 (PST)
Message-ID: <cda58cb80612010718w1290d332j25942fba74d952e8@mail.gmail.com>
Date:	Fri, 1 Dec 2006 16:18:15 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] Compile __do_IRQ() when really needed
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <20061202.001217.108120576.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <457042FF.2060908@innova-card.com>
	 <20061202.001217.108120576.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 12/1/06, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Fri, 01 Dec 2006 15:58:07 +0100, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> > __do_IRQ() is needed only by irq handlers that can't use
> > default handler defined in kernel/irq/chip.c.
> >
> > For others platforms there's no need to compile this function
> > since it won't be used. For those platforms this patch defines
> > GENERIC_HARDIRQS_NO__DO_IRQ symbol which is used exactly for
> > this purpose.
> >
> > Futhermore for platforms which do not use __do_IRQ(), end()
> > method which is part of the 'irq_chip' structure is not used.
> > This patch simply removes this method in this case.
>
> As I wrote in separate mail, I think I had fault on
> ioasic_dma_irq_type.  So please drop some part from your patch.
>

Yes, I just noticed your latest patch which makes this one obsolete
and wrong. I'm going to drop DEC's part.

thanks
-- 
               Franck
