Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Oct 2002 06:56:16 +0200 (CEST)
Received: from p508B5F86.dip.t-dialin.net ([80.139.95.134]:60817 "EHLO
	p508B5F86.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S1123891AbSJZE4P>; Sat, 26 Oct 2002 06:56:15 +0200
Received: from sccrmhc03.attbi.com ([IPv6:::ffff:204.127.202.63]:19944 "EHLO
	sccrmhc03.attbi.com") by ralf.linux-mips.org with ESMTP
	id <S867025AbSJZE4J>; Sat, 26 Oct 2002 06:56:09 +0200
Received: from lucon.org ([12.234.88.146]) by sccrmhc03.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20021026045550.BWYE18734.sccrmhc03.attbi.com@lucon.org>;
          Sat, 26 Oct 2002 04:55:50 +0000
Received: by lucon.org (Postfix, from userid 1000)
	id 3F6E02C4F5; Fri, 25 Oct 2002 21:55:43 -0700 (PDT)
Date: Fri, 25 Oct 2002 21:55:43 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Roland McGrath <roland@redhat.com>,
	GNU C Library <libc-alpha@sources.redhat.com>,
	linux-mips@linux-mips.org
Subject: Re: PATCH: Fix errlist for mips
Message-ID: <20021025215543.A26333@lucon.org>
References: <20021020172331.A26834@lucon.org> <200210252336.g9PNaww03056@magilla.sf.frob.com> <20021025164132.A23230@lucon.org> <20021026044549.GA15461@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021026044549.GA15461@nevyn.them.org>; from dan@debian.org on Sat, Oct 26, 2002 at 12:45:49AM -0400
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 26, 2002 at 12:45:49AM -0400, Daniel Jacobowitz wrote:
> Not everyone uses your MIPS patches; I have a completely functional
> MIPS system with:
> 0019df30 l     O .data  000011b8              _new_sys_errlist
> 0019df30 l     O .data  000001ec              _old_sys_errlist

It doesn't tell anything. Please, please show size of sys_errlist in
glibc 2.0 for mips. I am not even sure if you can run mips binaries
compiled against glibc 2.0 with glibc 2.2/2.3.


H.J.
