Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Oct 2002 01:41:54 +0200 (CEST)
Received: from p508B69CC.dip.t-dialin.net ([80.139.105.204]:19857 "EHLO
	p508B69CC.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S1124126AbSJYXlx>; Sat, 26 Oct 2002 01:41:53 +0200
Received: from sccrmhc01.attbi.com ([IPv6:::ffff:204.127.202.61]:51080 "EHLO
	sccrmhc01.attbi.com") by ralf.linux-mips.org with ESMTP
	id <S867025AbSJYXlr>; Sat, 26 Oct 2002 01:41:47 +0200
Received: from lucon.org ([12.234.88.146]) by sccrmhc01.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20021025234132.TDAH27756.sccrmhc01.attbi.com@lucon.org>;
          Fri, 25 Oct 2002 23:41:32 +0000
Received: by lucon.org (Postfix, from userid 1000)
	id 5756F2C4EC; Fri, 25 Oct 2002 16:41:32 -0700 (PDT)
Date: Fri, 25 Oct 2002 16:41:32 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Roland McGrath <roland@redhat.com>
Cc: GNU C Library <libc-alpha@sources.redhat.com>,
	linux-mips@linux-mips.org
Subject: Re: PATCH: Fix errlist for mips
Message-ID: <20021025164132.A23230@lucon.org>
References: <20021020172331.A26834@lucon.org> <200210252336.g9PNaww03056@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210252336.g9PNaww03056@magilla.sf.frob.com>; from roland@redhat.com on Fri, Oct 25, 2002 at 04:36:58PM -0700
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 25, 2002 at 04:36:58PM -0700, Roland McGrath wrote:
> You know better than I what existing mips libc.so.6 ABIs have for the size
> of sys_errlist.  But for the current version, 123 omits many of the errno
> values I see in asm-mips/errno.h, and EDQUOT really is 1133.  So I don't
> see how your change can be right.

That is what was in glibc 2.0 for mips. However, glibc 2.2 is the first
glibc version I worked on. I don't have any mips binaries compiled
against glibc 2.0. As far as I know, none of glibc prior to the one
with all my mips patches applied ever worked 100% correct on mips.


H.J.
