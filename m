Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1KCDQn10765
	for linux-mips-outgoing; Wed, 20 Feb 2002 04:13:26 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1KCDN910762
	for <linux-mips@oss.sgi.com>; Wed, 20 Feb 2002 04:13:23 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id DAA12341;
	Wed, 20 Feb 2002 03:13:16 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id DAA19202;
	Wed, 20 Feb 2002 03:13:13 -0800 (PST)
Message-ID: <008001c1b9ff$bffe5600$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>,
   "Greg Lindahl" <lindahl@conservativecomputer.com>
Cc: "Linux/MIPS Development" <linux-mips@oss.sgi.com>
References: <Pine.GSO.4.21.0202201055260.29685-100000@vervain.sonytel.be>
Subject: Re: FPU emulator unsafe for SMP?
Date: Wed, 20 Feb 2002 12:14:07 +0100
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

Geert wrote:
> On Tue, 19 Feb 2002, Greg Lindahl wrote:
> > On Tue, Feb 19, 2002 at 05:12:38PM -0800, Jun Sun wrote:
>
> > What you propose, locking the fpu owner to the current cpu, will not
> > result in a fair solution. Imagine a 2 cpu machine with 2 processes
> > using integer math and 1 using floating point... how much cpu time
> > will each process get? Imagine all the funky effects. Now add in a
> > MIPS design in which interrupts are not delivered uniformly to all the
> > cpus... I don't know if there are any or will ever be any, but...
>
> What if you have 2 processes who are running at the same CPU when they
start
> using the FPU? Won't they be locked to that CPU, while all other's stay
idle
> (if no other processes are to be run)?

What would bind a thread to a CPU would not be
having FPU state, but owning the *current* FPU
state.   Only one such process has that characteristic.
Any others who might or might not have used the
FPU in the past have their FPU state in the thread
context structure, and can be freely migrated.

            Kevin K.
