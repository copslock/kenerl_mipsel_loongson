Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6CNx5h29277
	for linux-mips-outgoing; Thu, 12 Jul 2001 16:59:05 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6CNx0V29259;
	Thu, 12 Jul 2001 16:59:00 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f6CMwrW24220;
	Thu, 12 Jul 2001 15:58:53 -0700
Message-ID: <3B4E38EF.3D3FF73E@mvista.com>
Date: Thu, 12 Jul 2001 16:55:27 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: Phil Thompson <Phil.Thompson@pace.co.uk>,
   "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: Moving from old-irq.c
References: <54045BFDAD47D5118A850002A5095CC30AC548@exchange1.cam.pace.co.uk> <20010713013054.A24695@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> On Wed, Jul 11, 2001 at 01:16:56PM +0100, Phil Thompson wrote:
> 
> > Is there any documentation around that describes how to move from interrupt
> > code based on old-irq.c to the new code? Or any other hints or suggestions.
> 
> Take a look at arch/mips/sgi/indy_int.c but there are more examples.
> 

Under ddb5xxx/ directory there is an example of doing cascading portable IRQ
controllers.  The irq_cpu.c file really should be shared by all common r4k
style CPUs.

> You'll have to provide
> an init_IRQ()

Ralf, I think we should have a common init_IRQ() in arch/mips/kernel, which
will then call (*setup_irq)().  This way it is easier to build a kernel for
multiple boards.  It is also more compatible with the current arrangment. 
What do you think?

Jun
