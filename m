Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Oct 2002 20:21:19 +0200 (CEST)
Received: from p508B5F86.dip.t-dialin.net ([80.139.95.134]:33683 "EHLO
	p508B5F86.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S1123891AbSJZSVS>; Sat, 26 Oct 2002 20:21:18 +0200
Received: from sccrmhc01.attbi.com ([IPv6:::ffff:204.127.202.61]:65259 "EHLO
	sccrmhc01.attbi.com") by ralf.linux-mips.org with ESMTP
	id <S867025AbSJZSVL>; Sat, 26 Oct 2002 20:21:11 +0200
Received: from lucon.org ([12.234.88.146]) by sccrmhc01.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20021026182032.NYCZ27756.sccrmhc01.attbi.com@lucon.org>;
          Sat, 26 Oct 2002 18:20:32 +0000
Received: by lucon.org (Postfix, from userid 1000)
	id 5414A2C4EC; Sat, 26 Oct 2002 11:20:31 -0700 (PDT)
Date: Sat, 26 Oct 2002 11:20:31 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Roland McGrath <roland@redhat.com>,
	GNU C Library <libc-alpha@sources.redhat.com>,
	linux-mips@linux-mips.org
Subject: Re: PATCH: Fix errlist for mips
Message-ID: <20021026112031.B23214@lucon.org>
References: <20021020172331.A26834@lucon.org> <200210252336.g9PNaww03056@magilla.sf.frob.com> <20021025164132.A23230@lucon.org> <20021026044549.GA15461@nevyn.them.org> <20021025215543.A26333@lucon.org> <20021026181431.GA11105@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021026181431.GA11105@nevyn.them.org>; from dan@debian.org on Sat, Oct 26, 2002 at 02:14:31PM -0400
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 26, 2002 at 02:14:31PM -0400, Daniel Jacobowitz wrote:
> On Fri, Oct 25, 2002 at 09:55:43PM -0700, H. J. Lu wrote:
> > On Sat, Oct 26, 2002 at 12:45:49AM -0400, Daniel Jacobowitz wrote:
> > > Not everyone uses your MIPS patches; I have a completely functional
> > > MIPS system with:
> > > 0019df30 l     O .data  000011b8              _new_sys_errlist
> > > 0019df30 l     O .data  000001ec              _old_sys_errlist
> > 
> > It doesn't tell anything. Please, please show size of sys_errlist in
> > glibc 2.0 for mips. I am not even sure if you can run mips binaries
> > compiled against glibc 2.0 with glibc 2.2/2.3.
> 
> I didn't use 2.0 for MIPS either.  And I got the wrong impression from
> your last message; sorry!
> 
> Here's what my MIPS glibc has:
> 0019df30 g    DO .data  000001ec (GLIBC_2.0)  sys_errlist
> 0019df30 g    DO .data  000011b8  GLIBC_2.2   sys_errlist
> 0019df30 g    DO .data  000001ec (GLIBC_2.0)  _sys_errlist
> 0019df30 g    DO .data  000011b8  GLIBC_2.2   _sys_errlist
> 
> So: I don't know where the GLIBC_2.1 version came from, or why we need
> a GLIBC_2.3 version, or why we should change the size of the GLIBC_2.0
> version.  Your patch looks good; should you wipe the GLIBC_2.1 version
> also?

sys_errlist in glibc 2.0 is naked. We gave it a version of GLIBC_2.0
when versioning was implemented and we had to increase the size of
sys_errlist. We gave it a new version, GLIBC_2.1. Now sys_errlist is
changed again for some arches. That is where GLIBC_2.3 came from. For
mips, the first supported glibc version after 2.0 is 2.2. That turns
GLIBC_2.1 into GLIBC_2.2 for mips. Since mips's sys_errlist is huge in 
2.2, there is no need to change it in 2.3.



H.J.
