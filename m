Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1FAn3r13141
	for linux-mips-outgoing; Fri, 15 Feb 2002 02:49:03 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1FAn0913138
	for <linux-mips@oss.sgi.com>; Fri, 15 Feb 2002 02:49:00 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id BAA09495;
	Fri, 15 Feb 2002 01:48:55 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA08010;
	Fri, 15 Feb 2002 01:48:50 -0800 (PST)
Message-ID: <006d01c1b606$21929c80$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Jun Sun" <jsun@mvista.com>, <linux-mips@oss.sgi.com>
References: <3C6C6ACF.CAD2FFC@mvista.com>
Subject: Re: FPU emulator unsafe for SMP?
Date: Fri, 15 Feb 2002 09:14:52 +0100
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

> I have been chasing a FPU register corruption problem on a SMP box.  The
> curruption seems to be caused by FPU emulator code.  Is that code SMP
safe?
> If not, what are the volunerable spots?
>
> Just thought I'd check before I dive into it ....

While the very first prototype was grossly SMP unsafe, the
state associated with the emulated "FPU" was migrated
into the thread context area long ago.  It is just possible,
however, that some internal emulator state persists in
a global variable somewhere, which could create problems
under SMP execution.

> BTW, I think even with the latest fpu emu patch, the classic fpu/signal
> problem is still there.  I will post in a separate email later.

I submitted a series of patches a year or so ago, the
last of which really should have been a comprehensive
fix to the FPU context switch and signal problems.
The last time I looked, that patch had never made it into
the OSS repository, but neither had anyone reported
any holes in it.

            Kevin K.
