Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Nov 2002 05:06:07 +0100 (CET)
Received: from adsl-64-163-212-31.dsl.snfc21.pacbell.net ([64.163.212.31]:22269
	"EHLO gateway.sf.frob.com") by linux-mips.org with ESMTP
	id <S1123984AbSKFEGH>; Wed, 6 Nov 2002 05:06:07 +0100
Received: from magilla.sf.frob.com (magilla.sf.frob.com [198.49.250.228])
	by gateway.sf.frob.com (Postfix) with ESMTP
	id 953D6357E; Tue,  5 Nov 2002 20:05:58 -0800 (PST)
Received: (from roland@localhost)
	by magilla.sf.frob.com (8.11.6/8.11.6) id gA645vX18303;
	Tue, 5 Nov 2002 20:05:57 -0800
Date: Tue, 5 Nov 2002 20:05:57 -0800
Message-Id: <200211060405.gA645vX18303@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: "H. J. Lu" <hjl@lucon.org>
Cc: Daniel Jacobowitz <dan@debian.org>,
	GNU C Library <libc-alpha@sources.redhat.com>,
	linux-mips@linux-mips.org
Subject: Re: PATCH: Fix errlist for mips
In-Reply-To: H. J. Lu's message of  Tuesday, 5 November 2002 19:53:16 -0800 <20021105195316.A2671@lucon.org>
X-Zippy-Says: ..  I feel..  JUGULAR..
Return-Path: <roland@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: roland@redhat.com
Precedence: bulk
X-list: linux-mips

> But you will only see sys_errlist in GLIBC_2.1 in Versions in glibc 2.2.

That is indeed a bit confusing as well.  But what really matters is what
binaries historically contained, and that the current source code produces
that result.
