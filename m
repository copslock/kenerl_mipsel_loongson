Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9QHse630324
	for linux-mips-outgoing; Fri, 26 Oct 2001 10:54:40 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9QHsb030318
	for <linux-mips@oss.sgi.com>; Fri, 26 Oct 2001 10:54:37 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id KAA12163;
	Fri, 26 Oct 2001 10:54:25 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id KAA14156;
	Fri, 26 Oct 2001 10:54:26 -0700 (PDT)
Message-ID: <038401c15e47$50331ae0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "han han" <piggie111000@yahoo.com>, <linux-mips@oss.sgi.com>
References: <20011026173004.78642.qmail@web10802.mail.yahoo.com>
Subject: Re: MIPS 32bit and 64bit mode
Date: Fri, 26 Oct 2001 19:54:37 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Does Anybody help me to clear some concepts about MIPS
> 5kc?
> How to detect and set a MIPS 5kc chip working in 32bit
> or 64bit mode? or the chip can automatically enter
> proper mode when it fetchs an MIPS 32/64 instruction?
> 
> Also, does MIPS 5kc have some 64bit instructions? 

I guess somebody (probably me) need to write a
MIPS32/MIPS64 FAQ one of these days.

To answer your last question first, yes, the MIPS5Kc
has the full compliment of 64-bit integer instructions.
It does not have the integrated FPU of the 5Kf, however,
so you have neither 32-bit nor 64-bit FP instructions.

There are two kinds of "64-bit-ness" to consider:
64-bit data types and 64-bit addresses.   In kernel
mode, a MIPS64 CPU always has access to 64-bit
data types, but to have 64-bit instructions in user
mode, one needs to explicitly enable them in the
CP0.Status register.

In pre-MIPS64 64-bit MIPS CPUs such as the
R4000 and R5000, user mode access to 64-bit
data types was only possible if 64-bit addressing
was also enabled for user mode by setting the
CP0.Status.UX bit.  Kernel mode 64-bit addressing
is independently enabled by setting the CP0.Status.KX
bit.  In MIPS64 (e.g. the 5Kc), it is also possible to enable 
64-bit data types in user mode *without* 64-bit addressing
by setting the CP0.Status.PX bit (bit 23).

            Regards,

            Kevin K.
