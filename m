Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9QIswS03351
	for linux-mips-outgoing; Fri, 26 Oct 2001 11:54:58 -0700
Received: from web10804.mail.yahoo.com (web10804.mail.yahoo.com [216.136.130.246])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9QIsr003347
	for <linux-mips@oss.sgi.com>; Fri, 26 Oct 2001 11:54:53 -0700
Message-ID: <20011026185452.88972.qmail@web10804.mail.yahoo.com>
Received: from [12.146.133.130] by web10804.mail.yahoo.com via HTTP; Fri, 26 Oct 2001 11:54:52 PDT
Date: Fri, 26 Oct 2001 11:54:52 -0700 (PDT)
From: han han <piggie111000@yahoo.com>
Subject: Re: MIPS 32bit and 64bit mode
To: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
In-Reply-To: <038401c15e47$50331ae0$0deca8c0@Ulysses>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--- "Kevin D. Kissell" <kevink@mips.com> wrote:
> > Does Anybody help me to clear some concepts about
> MIPS
> > 5kc?
> > How to detect and set a MIPS 5kc chip working in
> 32bit
> > or 64bit mode? or the chip can automatically enter
> > proper mode when it fetchs an MIPS 32/64
> instruction?
> > 
> > Also, does MIPS 5kc have some 64bit instructions? 
> 
> I guess somebody (probably me) need to write a
> MIPS32/MIPS64 FAQ one of these days.
> 
> To answer your last question first, yes, the MIPS5Kc
> has the full compliment of 64-bit integer
> instructions.
> It does not have the integrated FPU of the 5Kf,
> however,
> so you have neither 32-bit nor 64-bit FP
> instructions.
> 
> There are two kinds of "64-bit-ness" to consider:
> 64-bit data types and 64-bit addresses.   In kernel
> mode, a MIPS64 CPU always has access to 64-bit
> data types, but to have 64-bit instructions in user
> mode, one needs to explicitly enable them in the
> CP0.Status register.

But, how does MIPS 5kc work with 32bit Linux kernel?
Do you means there is no difference between 32 bit
mode and 64 bit mode for MIPS 5kc in kernel mode? 

> 
> In pre-MIPS64 64-bit MIPS CPUs such as the
> R4000 and R5000, user mode access to 64-bit
> data types was only possible if 64-bit addressing
> was also enabled for user mode by setting the
> CP0.Status.UX bit.  Kernel mode 64-bit addressing
> is independently enabled by setting the
> CP0.Status.KX
> bit.  In MIPS64 (e.g. the 5Kc), it is also possible
> to enable 
> 64-bit data types in user mode *without* 64-bit
> addressing
> by setting the CP0.Status.PX bit (bit 23).
> 
>             Regards,
> 
>             Kevin K.
> 


__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com
