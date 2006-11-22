Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Nov 2006 13:17:27 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:24815 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038553AbWKVNRV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 22 Nov 2006 13:17:21 +0000
Received: from localhost (p8044-ipad210funabasi.chiba.ocn.ne.jp [58.88.127.44])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6968CB7F7; Wed, 22 Nov 2006 22:17:16 +0900 (JST)
Date:	Wed, 22 Nov 2006 22:19:57 +0900 (JST)
Message-Id: <20061122.221957.74752404.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] use generic_handle_irq, handle_level_irq,
 handle_percpu_irq
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <45631BD2.4090509@ru.mvista.com>
References: <20061114.011318.99611303.anemo@mba.ocn.ne.jp>
	<45631BD2.4090509@ru.mvista.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 21 Nov 2006 18:31:30 +0300, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > diff --git a/arch/mips/kernel/irq-msc01.c b/arch/mips/kernel/irq-msc01.c
> > index e1880b2..bcaad66 100644
> > --- a/arch/mips/kernel/irq-msc01.c
> > +++ b/arch/mips/kernel/irq-msc01.c
> > @@ -117,6 +117,7 @@ struct irq_chip msc_levelirq_type = {
> >  	.mask = mask_msc_irq,
> >  	.mask_ack = level_mask_and_ack_msc_irq,
> >  	.unmask = unmask_msc_irq,
> > +	.eoi = unmask_msc_irq,
> >  	.end = end_msc_irq,
> >  };
> 
>     You don't have to define eoi() method for the level flow. And you don't 
> need end() method anymore.

Yes, .eoi is not used level flow handler, but I thought this irq chip
is possibly used with handle_percpu_irq flow handler.  And I kept .end
method for old __do_IRQ users.

---
Atsushi Nemoto
