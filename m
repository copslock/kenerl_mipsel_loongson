Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Nov 2002 04:44:56 +0100 (CET)
Received: from adsl-64-163-212-31.dsl.snfc21.pacbell.net ([64.163.212.31]:24317
	"EHLO gateway.sf.frob.com") by linux-mips.org with ESMTP
	id <S1123984AbSKFDoz>; Wed, 6 Nov 2002 04:44:55 +0100
Received: from magilla.sf.frob.com (magilla.sf.frob.com [198.49.250.228])
	by gateway.sf.frob.com (Postfix) with ESMTP
	id C716D357E; Tue,  5 Nov 2002 19:44:47 -0800 (PST)
Received: (from roland@localhost)
	by magilla.sf.frob.com (8.11.6/8.11.6) id gA63ikk18094;
	Tue, 5 Nov 2002 19:44:46 -0800
Date: Tue, 5 Nov 2002 19:44:46 -0800
Message-Id: <200211060344.gA63ikk18094@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: "H. J. Lu" <hjl@lucon.org>
Cc: Daniel Jacobowitz <dan@debian.org>,
	GNU C Library <libc-alpha@sources.redhat.com>,
	linux-mips@linux-mips.org
Subject: Re: PATCH: Fix errlist for mips
In-Reply-To: H. J. Lu's message of  Tuesday, 5 November 2002 19:23:28 -0800 <20021105192328.A2230@lucon.org>
Emacs: impress your (remaining) friends and neighbors.
Return-Path: <roland@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: roland@redhat.com
Precedence: bulk
X-list: linux-mips

> On Tue, Nov 05, 2002 at 06:53:17PM -0800, Roland McGrath wrote:
> > > Here's what my MIPS glibc has:
> > > 0019df30 g    DO .data  000001ec (GLIBC_2.0)  sys_errlist
> > > 0019df30 g    DO .data  000011b8  GLIBC_2.2   sys_errlist
> > > 0019df30 g    DO .data  000001ec (GLIBC_2.0)  _sys_errlist
> > > 0019df30 g    DO .data  000011b8  GLIBC_2.2   _sys_errlist
> > 
> > Ok, that says sys_nerr=123 in 2.0 and sys_nerr=1134 in 2.2.
> > I have changed the map to have just those.
> 
> Please keep in mind that the next version is GLIBC_2.1, not
> GLIBC_2.2. The reason you see GLIBC_2.2 is GLIBC_2.2 is the
> first versioned ABI for MIPS.

I don't think it's meaningful to make the distinction.  If we wrote
GLIBC_2.1, shlib-versions causes it to be GLIBC_2.2, but that's more
confusing.  Now it says GLIBC_2.2, and that's what you get.  There was
never a "sys_errlist@GLIBC_2.1" symbol in any binary, so it doesn't make
sense to have that version set.  
