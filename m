Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4UIdaD12700
	for linux-mips-outgoing; Wed, 30 May 2001 11:39:36 -0700
Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4UIdWh12697
	for <linux-mips@oss.sgi.com>; Wed, 30 May 2001 11:39:32 -0700
Received: from thor ([207.246.91.243]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via SMTP id LAA09986
	for <linux-mips@oss.sgi.com>; Wed, 30 May 2001 11:39:30 -0700 (PDT)
	mail_from (jsk@tetracon-eng.net)
Received: from localhost (localhost [127.0.0.1]) by thor (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id OAA11379; Wed, 30 May 2001 14:34:41 -0400
Date: Wed, 30 May 2001 14:34:41 -0400
From: "J. Scott Kasten" <jsk@tetracon-eng.net>
To: Jun Sun <jsun@mvista.com>
cc: <linux-mips@oss.sgi.com>
Subject: Re: Pthreads.
In-Reply-To: <3B152E51.ACF145BE@mvista.com>
Message-ID: <Pine.SGI.4.33.0105301431160.11351-100000@thor.tetracon-eng.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On Wed, 30 May 2001, Jun Sun wrote:

> "J. Scott Kasten" wrote:
> >
> > If I recall correctly, some time ago, Jun Sun was looking at pthreads.
> > What is the status of threads in glibc-2.0.6/.7 and glibc-2.2.x for mips?
> > I.E. works, broken, how bad, to do???
> >
>
> I found a bug in the kernel that causes register corruption, which causes
> pthread to fail.  The bug has been fixed for a while in the CVS tree.  I don't
> recall any glibc specific patches.

If I recall correctly, that was S0 not being preserved under certain
system calls.  Which I have taken care of.

>
> Yes, it runs fine on my machines.
>
> Jun
>

When you say runs fine, do you mean the 2.0.x, the 2.2.x or both?

Thanks for your response.
