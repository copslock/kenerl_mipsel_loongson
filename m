Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8JASrv23230
	for linux-mips-outgoing; Wed, 19 Sep 2001 03:28:53 -0700
Received: from animal.pace.co.uk (gateway.pace.co.uk [195.44.197.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8JASke23225
	for <linux-mips@oss.sgi.com>; Wed, 19 Sep 2001 03:28:49 -0700
Received: from exchange1.cam.pace.co.uk (exchange1.cam.pace.co.uk [136.170.131.80])
	by animal.pace.co.uk (8.10.2/8.10.2) with ESMTP id f8JAS3722337;
	Wed, 19 Sep 2001 11:28:03 +0100
Received: by exchange1.cam.pace.co.uk with Internet Mail Service (5.5.2650.21)
	id <S2BF9B9H>; Wed, 19 Sep 2001 11:27:22 +0100
Message-ID: <54045BFDAD47D5118A850002A5095CC30AC596@exchange1.cam.pace.co.uk>
From: Phil Thompson <Phil.Thompson@pace.co.uk>
To: "'Zhang Fuxin'" <fxzhang@ict.ac.cn>, linux-mips@oss.sgi.com
Subject: RE: Re: 8259 spurious interrupt (IRQ1,IRQ7,IRQ12..)
Date: Wed, 19 Sep 2001 11:27:14 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f8JASne23228
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> -----Original Message-----
> From: Zhang Fuxin [mailto:fxzhang@ict.ac.cn]
> Sent: 19 September 2001 09:38
> To: linux-mips@oss.sgi.com
> Subject: Re: Re: 8259 spurious interrupt (IRQ1,IRQ7,IRQ12..)
> 
> 
> hi,Jun Sun£¬
> ÔÚ 2001-09-18 10:09:00 you wrote£º
> >Zhang Fuxin wrote:
> >> 
> >> hi,all
> >>   I have finally been able to get a copy of sgi cvs 
> code:).Now I have
> >> changed my p6032 code to use new[time,pci,irq] code and it seems a
> >> lot cleaner.But still problems.
> >
> >Cool.  Very glad to hear that.
> Thank you for encourage:). I am new to mips and kernel 
> programming,the code 
> may still look very dirty for your eyes.But i will try my best.
> >
> >>   I keep seeing spurious interrupt when starting xwindows.And
> >> sometimes without x. If the machine is doing heavy io(e.g.,unzip &
> >> untar mozilla source) when I startx,it will probably enter an
> >> endless loop of spurious interrupt or lead to unaligned instruction
> >> access shortly after(with epc=0x1,ra=0x1) and die.
> >>   I have seen spurious IRQ1,IRQ7 and IRQ12,and the endless 
> loop case
> >> is IRQ12--ps2 mouse interrupt.
> >>   Can somebody give me a clue? What I know is that 8259 
> may generate
> >> spurious IRQ7 & IRQ15. But how can the others happen,buggy hw?And
> >> what may cause a kernel unaligned instruction access?
> >
> >Are you using arch/mips/i8259.c file?
> Yes.
> >
> >One possibility is your irq dispatching code.  If it loops 
> to deliver all
> >pending interrupts, what you described may happen (assuming 
> there is a real
> >hardware connecting to those irq sources).
> I have checked the p6032 manual.It says it has an intel 
> FW82371AB("PIIX 4") 
> south bridge chip,a National Semiconductor PC97307-ICE/VUL multi I/O 
> controller which includes dual serial ports and rtc,PC 
> mouse/keyb etc,connect 
> to the PIIX 4.

Make sure you read the section in the P6032 manual "Tips on programming
south bridge interrupt controller(s)" - page 31. I don't see how the 8259
code that's part of the MIPS tree can ever be used without changes.

Phil
