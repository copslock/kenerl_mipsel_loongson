Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7GNY1C14388
	for linux-mips-outgoing; Thu, 16 Aug 2001 16:34:01 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7GNY0j14384
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 16:34:00 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id QAA08048;
	Thu, 16 Aug 2001 16:33:44 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id QAA03090;
	Thu, 16 Aug 2001 16:33:46 -0700 (PDT)
Message-ID: <01fc01c126ac$866ceb40$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Daniel Jacobowitz" <dan@debian.org>, "Jun Sun" <jsun@mvista.com>
Cc: "MIPS/Linux List \(SGI\)" <linux-mips@oss.sgi.com>
References: <018201c12680$8f13e680$0deca8c0@Ulysses> <20010816115349.A12153@nevyn.them.org> <3B7C1BB9.7011790E@mvista.com> <01b001c12693$b4920140$0deca8c0@Ulysses> <3B7C3C75.4AB05B13@mvista.com> <20010816153702.A21978@nevyn.them.org>
Subject: Re: FP emulator patch
Date: Fri, 17 Aug 2001 01:38:06 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> >         if (current->used_math) {               /* Using the FPU again.
*/
> >                 lazy_fpu_switch(last_task_used_math);
> >         } else {                                /* First time FPU user.
*/
> >                 init_fpu();
> >                 current->used_math = 1;
> >         }
> >         last_task_used_math = current;
> >
...
> > BTW, do I see another bug here in do_cpu()?  It seems that before we
call
> > init_fpu(), we should check last_task_used_math.  If it is not NULL, we
should
> > save the FP state to the last_task_used_math.  Hmm, strange ...
>
> I thought I got all of these... <sigh>

Looks like that should be:

           } else {
                if (last_task_used_math != NULL)
save_fp(last_task_used_math);
                init_fpu()
                current->used_math = 1;
            }

And things will be OK.  What's wierd is that I could have sworn
that I looked at this code long ago, and that there was a save
there.  But even in the 2.2.12-based tree, there is none.

It's quite late here in France.  If one (or more) of you guys could
sketch a code fragment that would copy FP context back and
forth between a thread structure and a sigcontext without passing
through the FPU while I'm sleeping, I'll put together an integrated
patch tomorrow.

            Regards,

            Kevin K.
