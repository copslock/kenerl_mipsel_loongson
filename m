Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Nov 2002 04:53:27 +0100 (CET)
Received: from sccrmhc02.attbi.com ([204.127.202.62]:32480 "EHLO
	sccrmhc02.attbi.com") by linux-mips.org with ESMTP
	id <S1123984AbSKFDx0>; Wed, 6 Nov 2002 04:53:26 +0100
Received: from lucon.org ([12.234.88.146]) by sccrmhc02.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20021106035318.SJXJ1928.sccrmhc02.attbi.com@lucon.org>;
          Wed, 6 Nov 2002 03:53:18 +0000
Received: by lucon.org (Postfix, from userid 1000)
	id 058AB2C57C; Tue,  5 Nov 2002 19:53:16 -0800 (PST)
Date: Tue, 5 Nov 2002 19:53:16 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: Roland McGrath <roland@redhat.com>
Cc: Daniel Jacobowitz <dan@debian.org>,
	GNU C Library <libc-alpha@sources.redhat.com>,
	linux-mips@linux-mips.org
Subject: Re: PATCH: Fix errlist for mips
Message-ID: <20021105195316.A2671@lucon.org>
References: <20021105192328.A2230@lucon.org> <200211060344.gA63ikk18094@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200211060344.gA63ikk18094@magilla.sf.frob.com>; from roland@redhat.com on Tue, Nov 05, 2002 at 07:44:46PM -0800
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 581
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 05, 2002 at 07:44:46PM -0800, Roland McGrath wrote:
> > On Tue, Nov 05, 2002 at 06:53:17PM -0800, Roland McGrath wrote:
> > > > Here's what my MIPS glibc has:
> > > > 0019df30 g    DO .data  000001ec (GLIBC_2.0)  sys_errlist
> > > > 0019df30 g    DO .data  000011b8  GLIBC_2.2   sys_errlist
> > > > 0019df30 g    DO .data  000001ec (GLIBC_2.0)  _sys_errlist
> > > > 0019df30 g    DO .data  000011b8  GLIBC_2.2   _sys_errlist
> > > 
> > > Ok, that says sys_nerr=123 in 2.0 and sys_nerr=1134 in 2.2.
> > > I have changed the map to have just those.
> > 
> > Please keep in mind that the next version is GLIBC_2.1, not
> > GLIBC_2.2. The reason you see GLIBC_2.2 is GLIBC_2.2 is the
> > first versioned ABI for MIPS.
> 
> I don't think it's meaningful to make the distinction.  If we wrote
> GLIBC_2.1, shlib-versions causes it to be GLIBC_2.2, but that's more
> confusing.  Now it says GLIBC_2.2, and that's what you get.  There was
> never a "sys_errlist@GLIBC_2.1" symbol in any binary, so it doesn't make
> sense to have that version set.  

But you will only see sys_errlist in GLIBC_2.1 in Versions in glibc
2.2.


H.J.
