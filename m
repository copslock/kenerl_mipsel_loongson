Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Nov 2002 05:14:28 +0100 (CET)
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:51606 "EHLO
	rwcrmhc53.attbi.com") by linux-mips.org with ESMTP
	id <S1123984AbSKFEO1>; Wed, 6 Nov 2002 05:14:27 +0100
Received: from lucon.org ([12.234.88.146]) by rwcrmhc53.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20021106041415.QMZQ22218.rwcrmhc53.attbi.com@lucon.org>;
          Wed, 6 Nov 2002 04:14:15 +0000
Received: by lucon.org (Postfix, from userid 1000)
	id 90EFD2C57C; Tue,  5 Nov 2002 20:14:14 -0800 (PST)
Date: Tue, 5 Nov 2002 20:14:14 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: Roland McGrath <roland@redhat.com>
Cc: Daniel Jacobowitz <dan@debian.org>,
	GNU C Library <libc-alpha@sources.redhat.com>,
	linux-mips@linux-mips.org
Subject: Re: PATCH: Fix errlist for mips
Message-ID: <20021105201414.A3088@lucon.org>
References: <20021105195316.A2671@lucon.org> <200211060405.gA645vX18303@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200211060405.gA645vX18303@magilla.sf.frob.com>; from roland@redhat.com on Tue, Nov 05, 2002 at 08:05:57PM -0800
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 05, 2002 at 08:05:57PM -0800, Roland McGrath wrote:
> > But you will only see sys_errlist in GLIBC_2.1 in Versions in glibc 2.2.
> 
> That is indeed a bit confusing as well.  But what really matters is what
> binaries historically contained, and that the current source code produces
> that result.
> 

errlist is not the only one. Most of GLIBC_2.2 for mips come from
GLIBC_2.1.


H.J.
