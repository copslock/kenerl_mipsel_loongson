Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3N4YUQ04899
	for linux-mips-outgoing; Sun, 22 Apr 2001 21:34:30 -0700
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.225])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3N4YSM04895
	for <linux-mips@oss.sgi.com>; Sun, 22 Apr 2001 21:34:29 -0700
Received: from drow by nevyn.them.org with local (Exim 3.22 #1 (Debian))
	id 14rY3c-0005yw-00; Mon, 23 Apr 2001 00:34:40 -0400
Date: Mon, 23 Apr 2001 00:34:40 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Keith M Wesolowski <wesolows@foobazco.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: Question on the binutils tradlittlemips patch
Message-ID: <20010423003440.A20179@nevyn.them.org>
References: <20010418141959.A24473@nevyn.them.org> <3ADDFD6A.AD0DDE4A@cotw.com> <20010418163727.A29531@nevyn.them.org> <20010422180718.A6180@foobazco.org> <20010422221953.A9097@nevyn.them.org> <20010422212301.B6180@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20010422212301.B6180@foobazco.org>; from wesolows@foobazco.org on Sun, Apr 22, 2001 at 09:23:01PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Apr 22, 2001 at 09:23:01PM -0700, Keith M Wesolowski wrote:
> On Sun, Apr 22, 2001 at 10:19:53PM -0400, Daniel Jacobowitz wrote:
> 
> > I have them working in the case I care about - no backwards
> > compatibility at all.  We (Monta Vista) can get away with this :)
> > I've attached the patches.
> 
> This looks like what I have come up with as well.  I don't care about
> backward compatibility either.  If someone else wants to support
> broken crap that's their problem; in an age where we have scripts and
> makefiles to rebuild entire systems from source I can't see the point
> of binary compatibility.

Don't you wish?  My other hat is Debian, which can't just ditch
existing MIPS installations like that.

-- 
Daniel Jacobowitz                           Debian GNU/Linux Developer
Monta Vista Software                              Debian Security Team
