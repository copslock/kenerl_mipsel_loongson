Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0MJHe027749
	for linux-mips-outgoing; Tue, 22 Jan 2002 11:17:40 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0MJHVP27746;
	Tue, 22 Jan 2002 11:17:31 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id KAA04922;
	Tue, 22 Jan 2002 10:17:20 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id KAA24186;
	Tue, 22 Jan 2002 10:17:17 -0800 (PST)
Message-ID: <00e401c1a371$28a023a0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Daniel Jacobowitz" <dan@debian.org>
Cc: "Dominic Sweetman" <dom@algor.co.uk>, "Ralf Baechle" <ralf@oss.sgi.com>,
   "Ulrich Drepper" <drepper@redhat.com>, "Mike Uhler" <uhler@mips.com>,
   "MIPS/Linux List \(SGI\)" <linux-mips@oss.sgi.com>,
   "H . J . Lu" <hjl@lucon.org>
References: <15437.14361.918255.115877@gladsmuir.algor.co.uk> <002001c1a33e$d9936560$0deca8c0@Ulysses> <20020122102128.A11455@nevyn.them.org> <007601c1a35e$b3e3f940$0deca8c0@Ulysses> <20020122113420.A14284@nevyn.them.org> <00c001c1a367$69c10160$0deca8c0@Ulysses> <20020122121330.A16110@nevyn.them.org> <00cc01c1a36b$15cbf200$0deca8c0@Ulysses> <20020122123743.A17232@nevyn.them.org> <00d801c1a36c$ef0719e0$0deca8c0@Ulysses> <20020122125747.A18040@nevyn.them.org>
Subject: Re: thread-ready ABIs
Date: Tue, 22 Jan 2002 19:18:07 +0100
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

> No, you didn't read my manpage quote, Kevin.  Or we're just talking
> past each other.  The problem is not that existing mappings are shared,
> but that "any memory mapping or unmapping performed with mmap(2)
> or munmap(2) by the child or calling process also affects the other
> process".  That is, if the child maps some private storage, the parent
> will see it too.  Thus we can not use the private storage as a
> thread-local storage unless we already have some thread-local way to
> say where it is for this particular thread, and we're back where we
> started.
> 
> Does that make sense, or am I missing your objection?

It doen't necessarily make *sense*, in that it seems to
be a pretty crippled memory model ;-) but I do see your
objection.  Sorry to have seemed dense, I'm doing several
things at once on a couple of screens this evening and
reading too quickly.  I had misread that as underscoring
that the effects of mmaps() *prior* to the clone() were
inherited.  Feh.  Well, we aren't likely to have the luxury
of fixing the underlying design of pthreads for Linux
to use a fork()-based model with explicit sharing
(which has its own problems, of course), so we may well 
be looking at ABI abuse.  I was really, really, hoping 
to avoid that, in that gcc/Linux is far from the only user 
(and commercially speaking, far from being the most 
important user) of the ABI, and any change that breaks 
backward compatibility and cross-platform compatibility 
would be a Very Bad Thing.

More on this later, and thanks for your (civil) comments,

            Kevin K.
