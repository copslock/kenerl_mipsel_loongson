Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 17:00:09 +0200 (CEST)
Received: from crack.them.org ([65.125.64.184]:23314 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S1122958AbSIEPAI>;
	Thu, 5 Sep 2002 17:00:08 +0200
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 17mz35-000376-00; Thu, 05 Sep 2002 11:00:03 -0500
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 17my6s-0004Wx-00; Thu, 05 Sep 2002 10:59:54 -0400
Date: Thu, 5 Sep 2002 10:59:54 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Hartvig Ekner <hartvige@mips.com>,
	"Kevin D. Kissell" <kevink@mips.com>,
	Tor Arntsen <tor@spacetec.no>,
	Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
Message-ID: <20020905145954.GA17383@nevyn.them.org>
References: <200209051420.QAA26367@copcs01.mips.com> <Pine.GSO.3.96.1020905162433.7444C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020905162433.7444C-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 05, 2002 at 04:54:09PM +0200, Maciej W. Rozycki wrote:
> On Thu, 5 Sep 2002, Hartvig Ekner wrote:
> 
> > I don't know the ultimate reasons why SGI choose ILP32 for n32, but one
> > could certainly be portability.
> 
>  It depends on how you define "portability".  While it might help some
> broken software, it will hurt good one.
> 
> > As defined, n32 provides all the benefits of 64-bit data (yes, you have
> > to use long long to get to it), and 100% backward compatability with 
> 
>  So you can't use long to keep a file position pointer (off_t is quite a
> new invention) and have to go for long long, for example?  Weird and
> definitely doesn't help portability. 
> 
> > o32 sources that assume (sizeof(void *)) = sizeof(long), plus binary data
> 
>  Thay should be fixed, instead.  Using "void *" as a data container
> doesn't work in general and one who does so should be banished.  And the
> other way round, there is no problem -- if one keeps 32-bit pointers in
> 64-bit longs, there is no bit loss. 
> 
> > file compatability with o32 as all structures are exactly identical between
> > o32 and n32.
> 
>  Why don't use o32 as is then, instead of creating a slightly different
> ABI?  If some software needs binary data to be identical, then it has to
> select fixed-size types, e.g. int32_t, explicitly.  While int32_t and
> friends are quite a new standard, other ways were used for years to set up
> such aspects, e.g. autoconf, imake, hand-written system-specific
> preprocessor macros, etc., etc.

No - the point is that all data types have the same size in N32.  It
was created explicitly as a transitional sop for people who didn't want
to fix their code, but wanted a performance increase from their 64-bit
hardware.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
