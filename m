Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f85A8eZ18392
	for linux-mips-outgoing; Wed, 5 Sep 2001 03:08:40 -0700
Received: from animal.pace.co.uk (gateway.pace.co.uk [195.44.197.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f85A8bd18389
	for <linux-mips@oss.sgi.com>; Wed, 5 Sep 2001 03:08:37 -0700
Received: from exchange1.cam.pace.co.uk (exchange1.cam.pace.co.uk [136.170.131.80])
	by animal.pace.co.uk (8.10.2/8.10.2) with ESMTP id f85A8Q708896;
	Wed, 5 Sep 2001 11:08:26 +0100
Received: by exchange1.cam.pace.co.uk with Internet Mail Service (5.5.2650.21)
	id <S2BF7TSP>; Wed, 5 Sep 2001 11:07:58 +0100
Message-ID: <54045BFDAD47D5118A850002A5095CC30AC577@exchange1.cam.pace.co.uk>
From: Phil Thompson <Phil.Thompson@pace.co.uk>
To: "'Atsushi Nemoto'" <nemoto@toshiba-tops.co.jp>
Cc: linux-mips@oss.sgi.com
Subject: RE: Signal 11 on Process Termination - Update
Date: Wed, 5 Sep 2001 11:07:58 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This fixed the problem - many thanks.

Ralf - is this patch going to be applied (the current CVS seems unusable
without it)?

Phil

> -----Original Message-----
> From: Atsushi Nemoto [mailto:nemoto@toshiba-tops.co.jp]
> Sent: 05 September 2001 01:30
> To: Phil.Thompson@pace.co.uk
> Cc: linux-mips@oss.sgi.com
> Subject: Re: Signal 11 on Process Termination - Update
> 
> 
> >>>>> On Tue, 4 Sep 2001 18:48:33 +0100 , Phil Thompson 
> <Phil.Thompson@pace.co.uk> said:
> Phil> The SIGSEGV is being raised because the access_ok() in
> Phil> setup_frame() in kernel/signal.c is failing when trying to
> Phil> deliver another signal (SIGALRM or SIGCHLD in my cases).
> 
> At setup_frame(), sp (regs->regs[29]) is in the kernel kernel stack,
> isn't it?
> 
> If so, please try a patch for entry.S I posted a couple days ago.
> 
> > Subject: Re: segfaults with 2.4.8
> 
> Hope this helps.
> ---
> Atsushi Nemoto
> 
