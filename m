Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8K8kJa16738
	for linux-mips-outgoing; Thu, 20 Sep 2001 01:46:19 -0700
Received: from animal.pace.co.uk (gateway.pace.co.uk [195.44.197.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8K8k3e16734;
	Thu, 20 Sep 2001 01:46:04 -0700
Received: from exchange1.cam.pace.co.uk (exchange1.cam.pace.co.uk [136.170.131.80])
	by animal.pace.co.uk (8.10.2/8.10.2) with ESMTP id f8K8jv724278;
	Thu, 20 Sep 2001 09:45:57 +0100
Received: by exchange1.cam.pace.co.uk with Internet Mail Service (5.5.2650.21)
	id <S2BF9FZ3>; Thu, 20 Sep 2001 09:45:14 +0100
Message-ID: <54045BFDAD47D5118A850002A5095CC30AC599@exchange1.cam.pace.co.uk>
From: Phil Thompson <Phil.Thompson@pace.co.uk>
To: "'Ralf Baechle'" <ralf@oss.sgi.com>
Cc: "'Zhang Fuxin'" <fxzhang@ict.ac.cn>, linux-mips@oss.sgi.com
Subject: RE: Re: 8259 spurious interrupt (IRQ1,IRQ7,IRQ12..)
Date: Thu, 20 Sep 2001 09:45:14 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> -----Original Message-----
> From: Ralf Baechle [mailto:ralf@oss.sgi.com]
> Sent: 19 September 2001 17:41
> To: Phil Thompson
> Cc: 'Zhang Fuxin'; linux-mips@oss.sgi.com
> Subject: Re: Re: 8259 spurious interrupt (IRQ1,IRQ7,IRQ12..)
> 
> 
> On Wed, Sep 19, 2001 at 11:27:14AM +0100, Phil Thompson wrote:
> 
> > Make sure you read the section in the P6032 manual "Tips on 
> programming
> > south bridge interrupt controller(s)" - page 31. I don't 
> see how the 8259
> > code that's part of the MIPS tree can ever be used without changes.
> 
> Can you elaborate?  It's actually being used without problems.

The P6032 documentation recommends using Special Mask Mode to disable the
8259's priority logic so that reading the ISR register gives you the set of
pending interrupts. I took that at face value, so you need to program the
mode and need a function to return the set of pending interrupts (although
you could use i8259A_irq_pending() in loop).

Phil
