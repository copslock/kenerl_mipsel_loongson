Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0M0vBk19615
	for linux-mips-outgoing; Mon, 21 Jan 2002 16:57:11 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0M0v5P19612;
	Mon, 21 Jan 2002 16:57:05 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id PAA23132;
	Mon, 21 Jan 2002 15:56:54 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id PAA19075;
	Mon, 21 Jan 2002 15:56:52 -0800 (PST)
Message-ID: <01be01c1a2d7$6ec299c0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>, "Ulrich Drepper" <drepper@redhat.com>
Cc: "Mike Uhler" <uhler@mips.com>, <linux-mips@oss.sgi.com>,
   "GNU libc hacker" <libc-hacker@sources.redhat.com>,
   "H . J . Lu" <hjl@lucon.org>
References: <m3elkoa5dw.fsf@myware.mynet> <20020118101908.C23887@lucon.org><01b801c1a081$3f6518e0$0deca8c0@Ulysses><20020119162415.B31028@dea.linux-mips.net> <m3d703thl6.fsf@myware.mynet>
Subject: Re: thread-ready ABIs
Date: Tue, 22 Jan 2002 00:57:46 +0100
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

Ulrich Drepper" <drepper@redhat.com> writes:
>
> Ralf Baechle <ralf@oss.sgi.com> writes:
>
> > Changing the kernel for the small number of threaded applications that
> > exists and taking a performance impact for the kernel itself and
anything
> > that's using threads is an exquisite example for a bad tradeoff.
>
> Well, it seems you haven't read what I wrote.  It's not about a small
> number of threaded applications anymore.  The thread register will be
> part of the ABI and all applications, threaded or not, will use it.

As MIPS "owns" the ABI, whether or not the thread register
becomes a part of it is not something that anyone outside
of MIPS can simply decree.   I'd very much appreciate it if
someone would explain to me just what this register is used
for, and why a register needs to be permantly allocated
for this purpose.  There may still be other ways to solve the
problem without doing violence to the kernel or to the ABI.

            Regards,

            Kevin K.
