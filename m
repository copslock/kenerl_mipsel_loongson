Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3N5wln07787
	for linux-mips-outgoing; Sun, 22 Apr 2001 22:58:47 -0700
Received: from mail.kdt.de (mail.kdt.de [195.8.224.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3N5wkM07784
	for <linux-mips@oss.sgi.com>; Sun, 22 Apr 2001 22:58:46 -0700
Received: from arthur.inka.de (arthur.kdt.de [195.8.250.5])
	by mail.kdt.de (8.11.1/8.11.0) with ESMTP id f3N5wD816748;
	Mon, 23 Apr 2001 07:58:13 +0200
Received: from gromit.rhein-neckar.de ([192.168.27.3] ident=postfix)
	by arthur.inka.de with esmtp (Exim 3.14 #1)
	id 14rZJA-0000aW-00; Mon, 23 Apr 2001 07:54:48 +0200
Received: by gromit.rhein-neckar.de (Postfix, from userid 207)
	id 4631C1EA2E; Mon, 23 Apr 2001 07:54:47 +0200 (CEST)
Mail-Copies-To: never
To: Daniel Jacobowitz <dan@debian.org>
Cc: Keith M Wesolowski <wesolows@foobazco.org>, linux-mips@oss.sgi.com
Subject: Re: Question on the binutils tradlittlemips patch
References: <20010418141959.A24473@nevyn.them.org>
	<3ADDFD6A.AD0DDE4A@cotw.com> <20010418163727.A29531@nevyn.them.org>
	<20010422180718.A6180@foobazco.org>
	<20010422221953.A9097@nevyn.them.org>
	<20010422212301.B6180@foobazco.org>
	<20010423003440.A20179@nevyn.them.org>
From: Andreas Jaeger <aj@suse.de>
Date: 23 Apr 2001 07:54:47 +0200
In-Reply-To: <20010423003440.A20179@nevyn.them.org> (Daniel Jacobowitz's message of "Mon, 23 Apr 2001 00:34:40 -0400")
Message-ID: <u81yqkqhy0.fsf@gromit.rhein-neckar.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Daniel Jacobowitz <dan@debian.org> writes:

> On Sun, Apr 22, 2001 at 09:23:01PM -0700, Keith M Wesolowski wrote:
> > On Sun, Apr 22, 2001 at 10:19:53PM -0400, Daniel Jacobowitz wrote:
> > 
> > > I have them working in the case I care about - no backwards
> > > compatibility at all.  We (Monta Vista) can get away with this :)
> > > I've attached the patches.
> > 
> > This looks like what I have come up with as well.  I don't care about
> > backward compatibility either.  If someone else wants to support
> > broken crap that's their problem; in an age where we have scripts and
> > makefiles to rebuild entire systems from source I can't see the point
> > of binary compatibility.
> 
> Don't you wish?  My other hat is Debian, which can't just ditch
> existing MIPS installations like that.

And that's the problem I have with glibc.  What should I put in?  We
can require newer binutils to build glibc - no problem.  But losing
backward compatibility is a big deal.

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
