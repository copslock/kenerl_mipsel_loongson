Received:  by oss.sgi.com id <S42199AbQFHXVT>;
	Thu, 8 Jun 2000 16:21:19 -0700
Received: from mailhost.uni-koblenz.de ([141.26.64.1]:30629 "EHLO
        mailhost.uni-koblenz.de") by oss.sgi.com with ESMTP
	id <S42198AbQFHXVC>; Thu, 8 Jun 2000 16:21:02 -0700
Received: from cacc-23.uni-koblenz.de (cacc-23.uni-koblenz.de [141.26.131.23])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id BAA07040;
	Fri, 9 Jun 2000 01:20:57 +0200 (MET DST)
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S1403827AbQFHXU3>;
        Fri, 9 Jun 2000 01:20:29 +0200
Date:   Fri, 9 Jun 2000 01:20:29 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "J. Scott Kasten" <jsk@tetracon-eng.net>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Linux on Indy w/ XL question.
Message-ID: <20000609012029.B19237@uni-koblenz.de>
References: <Pine.SGI.4.10.10006081616200.28739-100000@thor.tetracon-eng.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.SGI.4.10.10006081616200.28739-100000@thor.tetracon-eng.net>; from jsk@tetracon-eng.net on Thu, Jun 08, 2000 at 04:23:26PM -0300
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Jun 08, 2000 at 04:23:26PM -0300, J. Scott Kasten wrote:

> I need to puchase an Indy and install Linux on it as a
> development/reference platform for some embedded MIPS development I'm
> involved with.  I've read the FAQ, HOWTO, etc... and need one minor
> clarification.
> 
> In the documentation it claims support for XL video only.  That's fine,
> however, do I want the 8 bit or the 24 bit variety?  Do they both work?

For text console, yes.

> If I understand correctly, emulation is in place to the extent that the
> IRIX Xsgi can be used under Linux to provide an X display as well?  X is
> not critical to my needs, but would of course be a definite advantage.

Nobody has worked on the binary compatibility for X in a long, long time
so everything I can guarantee is that it compiles.  It's never reached
the point where Xsgi was running properly.

There is now another X server based on XFree 4.0.  It's just the first
public release but you may want to try it anyway, it's available from
oss.sgi.com in /pub/linux/mips/mips-linux/X.

  Ralf
