Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0LAd0p18785
	for linux-mips-outgoing; Mon, 21 Jan 2002 02:39:00 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0LAcqP18774
	for <linux-mips@oss.sgi.com>; Mon, 21 Jan 2002 02:38:52 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id BAA14260;
	Mon, 21 Jan 2002 01:38:42 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA19610;
	Mon, 21 Jan 2002 01:38:31 -0800 (PST)
Message-ID: <003701c1a25f$8abfc120$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: "Machida Hiroyuki" <machida@sm.sony.co.jp>, <drepper@redhat.com>,
   "GNU C Library" <libc-alpha@sources.redhat.com>, <linux-mips@oss.sgi.com>
References: <20020118101908.C23887@lucon.org><01b801c1a081$3f6518e0$0deca8c0@Ulysses><20020118201139.A847@lucon.org> <20020120193843M.machida@sm.sony.co.jp> <002c01c1a1a9$b9f0de40$0deca8c0@Ulysses> <20020120111912.A6918@lucon.org>
Subject: Re: thread-ready ABIs
Date: Mon, 21 Jan 2002 10:39:14 +0100
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

> > > > I like the read-only k0 idea. We just need to make a system call to
> > > > tell kernel what value to put in k0 before returning to the user
space.
> > > > It shouldn't be too hard to implement. I will try it next week.
> > > >
> > > > H.J.
> > >
> > > Please don't use k1, we already use k1 to implement fast
> > > test-and-set method for MIPS1 machine.  We plan to merge
> > > the method into main glibc and kernel tree.
[snip]
> >
> > This situation... behooves us to verify that
> > k0/k1 are really and truly the only candidates
> > for a thread register in MIPS.  I haven't been
> > involved in any of the earlier discussions,
> > and am not on the libc-hacker mailing list
> > (and thus cannot post to it, by the way), but
> > was it considered to simply use one of the
> > static registers (say, s7/$23) in the existing
> > ABI?  Assuming it was set up correctly at
> > process startup, it would be preserved by
> > pre-thread library and .o modules, and could
> > be exploited by newly generated code.  Losing
> > a static register would be a hit on code generation
> > efficiency and performance, at least in principle.
> > Was this the reason why the idea was rejected,
> > or is there a more fundamental technical problem?
>
> We never considered it since it is an invasive ABI change. Besides
> the performance issue, it may break exist codes. I prefer k1 if all
> possible.

If anything, assuming that k0 or k1 are sane in
compiler-generated code is more of a violation
of the ABI than imposing an optional use of s7.
Sony's use in libraries is somewhat less intrusive.

Please explain how the use of a static register as
described above would break existing codes.
It's a common technique to bind a static register
to a global variable.  Linking to libraries with no
knowledge of this variable breaks nothing, since
by the ABI, all use of "s" registers requires that
they be preserved and returned intact to the caller.
It seems to me to be quite straightforward to apply
this technique to the thread register.  The *only*
issue I see is that of performance, and it is by
no means clear how severe this would be.
In the compiled code that I have examined
for compiler efficiency in the past, it's pretty
rare that *all* static registers are actually used.

I consider this to be a fairly serious issue, and
will take it up with the people who own the ABI
within MIPS.  I hope to be able to make an
"official" recommendation shortly.

            Regards,

            Kevin K.
