Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Nov 2002 04:24:03 +0100 (CET)
Received: from p508B726C.dip.t-dialin.net ([80.139.114.108]:20155 "EHLO
	p508B726C.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S1123984AbSKFDYC>; Wed, 6 Nov 2002 04:24:02 +0100
Received: from sccrmhc03.attbi.com ([IPv6:::ffff:204.127.202.63]:40117 "EHLO
	sccrmhc03.attbi.com") by ralf.linux-mips.org with ESMTP
	id <S867057AbSKFDXt>; Wed, 6 Nov 2002 04:23:49 +0100
Received: from lucon.org ([12.234.88.146]) by sccrmhc03.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20021106032331.RFIH24285.sccrmhc03.attbi.com@lucon.org>;
          Wed, 6 Nov 2002 03:23:31 +0000
Received: by lucon.org (Postfix, from userid 1000)
	id C37B62C57C; Tue,  5 Nov 2002 19:23:28 -0800 (PST)
Date: Tue, 5 Nov 2002 19:23:28 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: Roland McGrath <roland@redhat.com>
Cc: Daniel Jacobowitz <dan@debian.org>,
	GNU C Library <libc-alpha@sources.redhat.com>,
	linux-mips@linux-mips.org
Subject: Re: PATCH: Fix errlist for mips
Message-ID: <20021105192328.A2230@lucon.org>
References: <20021026181431.GA11105@nevyn.them.org> <200211060253.gA62rH817728@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200211060253.gA62rH817728@magilla.sf.frob.com>; from roland@redhat.com on Tue, Nov 05, 2002 at 06:53:17PM -0800
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 05, 2002 at 06:53:17PM -0800, Roland McGrath wrote:
> > Here's what my MIPS glibc has:
> > 0019df30 g    DO .data  000001ec (GLIBC_2.0)  sys_errlist
> > 0019df30 g    DO .data  000011b8  GLIBC_2.2   sys_errlist
> > 0019df30 g    DO .data  000001ec (GLIBC_2.0)  _sys_errlist
> > 0019df30 g    DO .data  000011b8  GLIBC_2.2   _sys_errlist
> 
> Ok, that says sys_nerr=123 in 2.0 and sys_nerr=1134 in 2.2.
> I have changed the map to have just those.

Please keep in mind that the next version is GLIBC_2.1, not
GLIBC_2.2. The reason you see GLIBC_2.2 is GLIBC_2.2 is the
first versioned ABI for MIPS.


H.J.
