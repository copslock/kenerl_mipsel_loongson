Received:  by oss.sgi.com id <S553828AbQJNOuE>;
	Sat, 14 Oct 2000 07:50:04 -0700
Received: from chmls06.mediaone.net ([24.147.1.144]:29105 "EHLO
        chmls06.mediaone.net") by oss.sgi.com with ESMTP id <S553815AbQJNOtm>;
	Sat, 14 Oct 2000 07:49:42 -0700
Received: from decoy (h00a0cc39f081.ne.mediaone.net [24.218.248.129])
	by chmls06.mediaone.net (8.8.7/8.8.7) with SMTP id KAA22970;
	Sat, 14 Oct 2000 10:49:40 -0400 (EDT)
From:   "Jay Carlson" <nop@nop.com>
To:     "Ralf Baechle" <ralf@oss.sgi.com>, "Jun Sun" <jsun@mvista.com>
Cc:     <linux-mips@fnet.fr>, <linux-mips@oss.sgi.com>
Subject: RE: stable binutils, gcc, glibc ...
Date:   Sat, 14 Oct 2000 10:51:37 -0400
Message-ID: <KEEOIBGCMINLAHMMNDJNKECACAAA.nop@nop.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20001014055550.B3816@bacchus.dhis.org>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle writes:

> > d) glibc v2.0.7 from linux-vr project by Jay
> >
> > ftp://ftp.place.org/pub/nop/linuxce/
> > ftp://ftp.place.org/pub/nop/linuxce/rpms/glibc-2.0.7-20.src.rpm
>
> 2.0.7 has resulted in so many bug reports that I consider to
> plain dump any
> related reports in the future.

Hey, don't blame me for the 2.0.6->2.0.7 version bump.  I just grabbed the
biggest version number on oss.sgi.com at the time and made my *trivial*
patches to add softfloat to the build.

Let me say that again: 2.0.7 is NOT MY FAULT.

:-)

Seriously, I think the best thing we can do in this situation is start
assigning our own linux-mips version numbers to combinations of upstream
sources and our patches.  So, we'd have something like:

  glibc 2.0.6 + 05lm patches (whatever) == glibc2.0.6 delta 1.0
  glibc 2.0.6 + 06lm patches (whatever) == glibc2.0.6 delta 1.1

  egcs 1.0.3a + ralf's current patches == egcs 1.0.3a delta 1.0
  egcs 1.0.3a + ralf's patches tomorrow == egcs 1.0.3a delta 2.0

  binutils 2.8.1 + standard patches == binutils 2.8.1 delta 1.0
  binutils 2.10.x on 20001014 == binutils 2.10.x delta 1.0
  binutils 2.10.x on 20001015 == binutils 2.10.x delta 2.1

We need to give *names* to the versions of the software we're testing
against.  I haven't bothered trying a world rebuild against gcc 2.96.x
because telling people it worked wouldn't mean anything.  Other people would
not know that they could reproduce my success by getting the same bits as
me.

What I really want to hear is: "I rebuilt gcc, binutils, the kernel,
modutils, and GNU fileutils using gcc 2.96 delta 7.3, binutils 2.10.x delta
5.2, and glibc 2.1.95 delta 1.0", and then know EXACTLY how to reproduce
that at home.  Just saying "current CVS with patches" doesn't help with
reproducibility.

Jay
