Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Nov 2002 03:53:33 +0100 (CET)
Received: from adsl-64-163-212-31.dsl.snfc21.pacbell.net ([64.163.212.31]:27133
	"EHLO gateway.sf.frob.com") by linux-mips.org with ESMTP
	id <S1123984AbSKFCxd>; Wed, 6 Nov 2002 03:53:33 +0100
Received: from magilla.sf.frob.com (magilla.sf.frob.com [198.49.250.228])
	by gateway.sf.frob.com (Postfix) with ESMTP
	id 83076357E; Tue,  5 Nov 2002 18:53:19 -0800 (PST)
Received: (from roland@localhost)
	by magilla.sf.frob.com (8.11.6/8.11.6) id gA62rH817728;
	Tue, 5 Nov 2002 18:53:17 -0800
Date: Tue, 5 Nov 2002 18:53:17 -0800
Message-Id: <200211060253.gA62rH817728@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Daniel Jacobowitz <dan@debian.org>
Cc: "H. J. Lu" <hjl@lucon.org>,
	GNU C Library <libc-alpha@sources.redhat.com>,
	linux-mips@linux-mips.org
Subject: Re: PATCH: Fix errlist for mips
In-Reply-To: Daniel Jacobowitz's message of  Saturday, 26 October 2002 14:14:31 -0400 <20021026181431.GA11105@nevyn.them.org>
X-Zippy-Says: I hope something GOOD came in the mail today so I have a REASON to live!!
Return-Path: <roland@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: roland@redhat.com
Precedence: bulk
X-list: linux-mips

> Here's what my MIPS glibc has:
> 0019df30 g    DO .data  000001ec (GLIBC_2.0)  sys_errlist
> 0019df30 g    DO .data  000011b8  GLIBC_2.2   sys_errlist
> 0019df30 g    DO .data  000001ec (GLIBC_2.0)  _sys_errlist
> 0019df30 g    DO .data  000011b8  GLIBC_2.2   _sys_errlist

Ok, that says sys_nerr=123 in 2.0 and sys_nerr=1134 in 2.2.
I have changed the map to have just those.


Thanks,
Roland
