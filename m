Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1FAtfr13393
	for linux-mips-outgoing; Fri, 15 Feb 2002 02:55:41 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1FAtX913378;
	Fri, 15 Feb 2002 02:55:33 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id BAA09559;
	Fri, 15 Feb 2002 01:55:27 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA08131;
	Fri, 15 Feb 2002 01:55:22 -0800 (PST)
Message-ID: <002b01c1b607$6afbd5c0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Jun Sun" <jsun@mvista.com>, "Ralf Baechle" <ralf@oss.sgi.com>
Cc: <linux-mips@oss.sgi.com>
References: <3C6C6ACF.CAD2FFC@mvista.com> <20020215031118.B21011@dea.linux-mips.net> <20020214232030.A3601@mvista.com> <20020215003037.A3670@mvista.com>
Subject: Re: FPU emulator unsafe for SMP?
Date: Fri, 15 Feb 2002 10:59:09 +0100
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

> > > > I have been chasing a FPU register corruption problem on a SMP box.  The
> > > > curruption seems to be caused by FPU emulator code.  Is that code SMP safe? 
> > > > If not, what are the volunerable spots?
> > > 
> > > In theory the fp emulation code should be MP safe as the full emulation
> > > is only accessing it's context in the fp register set of struct
> > > task_struct.  The 32-bit kernel's fp register switching is entirely broken
> > > (read: close to non-existant).  Lots of brownie points for somebody to
> > > backport that from the 64-bit kernel to the 32-bit kernel and forward
> > > port all the FPU emu bits to the 64-bit kernel ...
> > > 
> > 
> > Brownie sounds good. :-)  So what is the "fp register switching" you are 
> > referring to?  There is set of code related to lazy fpu context switch,
> > which seems to be working fine now.
> >
> 
> Hmm, I see. The lazy fpu context switch code is not SMP safe.
> I see fishy things like "last_task_used_math" etc...

What, you mean "last_task_used_math" isn't allocated in a
processor-specific page of kseg3???    ;-)

            Kevin K.
