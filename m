Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Nov 2002 18:11:45 +0100 (CET)
Received: from p508B7C3B.dip.t-dialin.net ([80.139.124.59]:30387 "EHLO
	p508B7C3B.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S1122121AbSKDRLp>; Mon, 4 Nov 2002 18:11:45 +0100
Received: from sccrmhc01.attbi.com ([IPv6:::ffff:204.127.202.61]:33964 "EHLO
	sccrmhc01.attbi.com") by ralf.linux-mips.org with ESMTP
	id <S867025AbSKDRLc>; Mon, 4 Nov 2002 18:11:32 +0100
Received: from lucon.org ([12.234.88.146]) by sccrmhc01.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20021104171120.PVIK8743.sccrmhc01.attbi.com@lucon.org>;
          Mon, 4 Nov 2002 17:11:20 +0000
Received: by lucon.org (Postfix, from userid 1000)
	id 8D0FC2C4EC; Mon,  4 Nov 2002 09:11:19 -0800 (PST)
Date: Mon, 4 Nov 2002 09:11:19 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Re: Problems generating shared library for MIPS using binutils-2.13...
Message-ID: <20021104091119.A10646@lucon.org>
References: <Pine.GSO.3.96.1021025185639.1121A-100000@delta.ds2.pg.gda.pl> <3DC68907.30708@realitydiluted.com> <20021104070233.C8860@lucon.org> <3DC6A6E7.6000107@realitydiluted.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DC6A6E7.6000107@realitydiluted.com>; from sjhill@realitydiluted.com on Mon, Nov 04, 2002 at 10:57:11AM -0600
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 559
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 04, 2002 at 10:57:11AM -0600, Steven J. Hill wrote:
> H. J. Lu wrote:
> > 
> >>I'm convinced the linker completely ignores '-A' for MIPS. In the 
> > 
> > 
> > -A is for assembler, not linker.
> > 
> Fine. Still, that doesn't solve the problem, or what I perceive to
> be a problem. I'll submit my patch and watch it be ignored or for
> someone to say something.

The Linux binutils works fine for me.


H.J.
