Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7GMsU113146
	for linux-mips-outgoing; Thu, 16 Aug 2001 15:54:30 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7GMsSj13142
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 15:54:28 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id PAA07597;
	Thu, 16 Aug 2001 15:53:39 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id PAA02054;
	Thu, 16 Aug 2001 15:53:40 -0700 (PDT)
Message-ID: <01e801c126a6$ec2a3420$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Jun Sun" <jsun@mvista.com>
Cc: "MIPS/Linux List \(SGI\)" <linux-mips@oss.sgi.com>,
   "Daniel Jacobowitz" <dan@debian.org>
Subject: Re: FP emulator patch
Date: Fri, 17 Aug 2001 00:58:01 +0200
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

> >
> >         if (current->used_math) {               /* Using the FPU again.
> */
> >                 lazy_fpu_switch(last_task_used_math);
> >         } else {                                /* First time FPU user.
> */
> >                 init_fpu();
> >                 current->used_math = 1;
> >         }
> >         last_task_used_math = current;
> >
> > Clearly the second path is logically the correct one.
>
> Not really.  See below.
>
> > BTW, do I see another bug here in do_cpu()?  It seems that before we
call
> > init_fpu(), we should check last_task_used_math.  If it is not NULL, we
> should
> > save the FP state to the last_task_used_math.  Hmm, strange ...
>
> Strange indeed.  And note that if the code were correct, your
> surmise about the init_fpu() path being "logically the correct"
> one would no longer be true - we'd be saving the FPU state of
> the current process for no good reason.

And note further that, by forcing current->used_math to
zero, the old code was in fact driving the signal handler
needlessly into the broken code...

            Kevin K.
