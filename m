Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7GNh6114712
	for linux-mips-outgoing; Thu, 16 Aug 2001 16:43:06 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7GNh5j14709
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 16:43:05 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id QAA08168;
	Thu, 16 Aug 2001 16:42:22 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id QAA03284;
	Thu, 16 Aug 2001 16:42:24 -0700 (PDT)
Message-ID: <020001c126ad$bad05e20$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Jun Sun" <jsun@mvista.com>
Cc: "MIPS/Linux List \(SGI\)" <linux-mips@oss.sgi.com>,
   "Daniel Jacobowitz" <dan@debian.org>
References: <01e801c126a6$ec2a3420$0deca8c0@Ulysses> <3B7C53BA.24B75620@mvista.com>
Subject: Re: FP emulator patch
Date: Fri, 17 Aug 2001 01:46:40 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> > > Strange indeed.  And note that if the code were correct, your
> > > surmise about the init_fpu() path being "logically the correct"
> > > one would no longer be true - we'd be saving the FPU state of
> > > the current process for no good reason.
> > 
> > And note further that, by forcing current->used_math to
> > zero, the old code was in fact driving the signal handler
> > needlessly into the broken code...
> > 
> 
> By not clearing current->used_math bit, you are in fact restoring an FPU
> context unnecessarily.

And by clearing it, you are destroying an FPU context unnecessarily.
I'll take the overhead, thanks! ;-)  Seriously, if that optimization
is really that important, let's find some other mechanism for communicating
to do_cpu() the fact that we're doing a signal.

            Regards,

            Kevin K.
