Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f36FTYh30936
	for linux-mips-outgoing; Fri, 6 Apr 2001 08:29:34 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f36FTXM30933
	for <linux-mips@oss.sgi.com>; Fri, 6 Apr 2001 08:29:33 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id IAA11333;
	Fri, 6 Apr 2001 08:29:35 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id IAA08932;
	Fri, 6 Apr 2001 08:29:33 -0700 (PDT)
Message-ID: <011e01c0beae$f0d12840$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Florian Lohoff" <flo@rfc822.org>
Cc: <debian-mips@lists.debian.org>, <linux-mips@oss.sgi.com>
References: <20010406130958.A14083@paradigm.rfc822.org> <20010406132214.D14083@paradigm.rfc822.org> <00a401c0be8e$cfc065a0$0deca8c0@Ulysses> <20010406135849.E14083@paradigm.rfc822.org> <00cb01c0be94$7744aac0$0deca8c0@Ulysses> <20010406152836.A21459@paradigm.rfc822.org>
Subject: Re: first packages for mipsel
Date: Fri, 6 Apr 2001 17:33:23 +0200
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

> > > If there is a working ll/sc emulation fine - Currently there is none
> > > so the only way to go TODAY is sysmips.
> >
> > I'll work on one in the background.  It should be pretty straightforward
> > for the uniprocessor case, but an SMP version will be messier, and
> > possibly require a platform-dependent hook.  Of course, the same
> > is true of sysmips()...
>
> For SMP versions we could currently just put an "#error" in it. There has
> to be machine dependent support as the older SGI Challenge have. So dont
> worry on that case.

I've just glanced at the unfinished ll emulation code in the 2.4.3 baseline.
It looks like someone was trying to do a full and precise emulation of
the instruction as documented, which is admirable but horribly difficult.
The trick is that one can be aggressive in clearing the lock "flip flop".
In real CPU's for example, the flop is cleared on every exception taken.
Emulating that alone would make for a semi-functional operation,
at least in terms of protecting kernel threads.  One needs to do a bit
more to cover user-level multithreading.  Stricktly speaking, one should
search the entire address space of the executing task and tag all
virtual pages that map to the targeted physical page as being
non-writable, and on a write protect error clear both the ll bit and
the protections.  On a sc, one can either do nothing or proactively
make the pages writable.  I find the notion of the *same* task having
a lock cell virtually aliased to be wildly improbable, and would be
tempted to consider elimitating the reverse translation and only
flagging the page where the ll/sc is taking place.  That would not
be 100% correct emulation, but I would be very surprised to find
any code that would notice.

            Regards,

            Kevin K.
