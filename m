Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6FGJDRw004607
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 15 Jul 2002 09:19:13 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6FGJDTF004606
	for linux-mips-outgoing; Mon, 15 Jul 2002 09:19:13 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6FGJ6Rw004596
	for <linux-mips@oss.sgi.com>; Mon, 15 Jul 2002 09:19:07 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6FGNoXb023388;
	Mon, 15 Jul 2002 09:23:50 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id JAA06805;
	Mon, 15 Jul 2002 09:23:50 -0700 (PDT)
Message-ID: <01c401c22c1c$1973a170$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Ryan Martindale" <ryan@qsicorp.com>, <linux-mips@oss.sgi.com>
References: <3D3300A3.FD50EDEA@qsicorp.com>
Subject: Re: fpu woes (TX3912)
Date: Mon, 15 Jul 2002 18:24:16 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
X-Spam-Status: No, hits=0.1 required=5.0 tests=PORN_10 version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> I'm using the tx3912 processor for an embedded device and since it
> doesn't have an fpu, I don't have coprocessor #1.  Recently, I remember
> seeing a fix in process.c for exit_thread and flush_thread, and did
> apply it - but there still is a problem (at least for me). In traps.c,
> the save_fp_context and restore_fp_context are set to _save_fp_context
> (in r2300_fpu.S) which don't check to see if I have a coprocessor
> available. As I am rather new to the linux/linux-mips development world,
> I thought I'd give a heads up (it is causing my embedded system to
> crash). Any direction on fixing it would be welcome, but I'm not sure
> I'll get to the point where I will submit any patches any time soon.

People break things from time to time, but at least at one point
in history, R3xxx platforms were correctly supported by the
FPU emulator code.  Looking at the source code on my 
system, it looks like traps.c has been "cleaned up" in a
somewhat wierd manner, such that the test for whether
there is an FPU happens redundantly, once in the specific
case of a 4K family CPU (which you would not hit on your
TX39), and again just after the switch on the CPU type.
Did someone screw up the setting of mips_cpu.options
for a TX39xx or something?  Is that code missing from
the sources that you're using?  Are you sure that it isn't
something else blowing up on you?  There have been
mods made locally here and there that might have
broken the FPU emulator for R3xxx platforms, but
I didn't think that any of them were up on OSS.sgi.com
or kernel.org.

            Regards,

            Kevin K.
