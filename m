Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6D17uu04627
	for linux-mips-outgoing; Thu, 12 Jul 2001 18:07:56 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6D17oV04609;
	Thu, 12 Jul 2001 18:07:50 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f6D07iW28283;
	Thu, 12 Jul 2001 17:07:44 -0700
Message-ID: <3B4E4911.25616E3@mvista.com>
Date: Thu, 12 Jul 2001 18:04:17 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: Phil Thompson <Phil.Thompson@pace.co.uk>,
   "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: Moving from old-irq.c
References: <54045BFDAD47D5118A850002A5095CC30AC548@exchange1.cam.pace.co.uk> <20010713013054.A24695@bacchus.dhis.org> <3B4E38EF.3D3FF73E@mvista.com> <20010713024108.A26493@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> On Thu, Jul 12, 2001 at 04:55:27PM -0700, Jun Sun wrote:
> 
> > Ralf, I think we should have a common init_IRQ() in arch/mips/kernel, which
> > will then call (*setup_irq)().  This way it is easier to build a kernel for
> > multiple boards.  It is also more compatible with the current arrangment.
> > What do you think?
> 
> Well, do you actually build kernels for multiple boards that need this?  

The answer is actually yes.  

What is happening in embedded world is people often derive their boards from
another board (probably reference board).  Sometimes the difference between
those two boards are very small (but still have difference such as in
interrupt routing).  It will then become interesting to share most of the code
and leave some other code hookable.

Another scenario is sometimes vendors builds a base board which can plug in
multiple different daughter boards.  In many cases it is desirable to build
one kernel for the same "base board".

That is the need I have seen so far. 

Jun
