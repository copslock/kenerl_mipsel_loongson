Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Oct 2002 01:37:12 +0200 (CEST)
Received: from adsl-64-163-212-31.dsl.snfc21.pacbell.net ([64.163.212.31]:54013
	"EHLO gateway.sf.frob.com") by linux-mips.org with ESMTP
	id <S1124126AbSJYXhL>; Sat, 26 Oct 2002 01:37:11 +0200
Received: from magilla.sf.frob.com (magilla.sf.frob.com [198.49.250.228])
	by gateway.sf.frob.com (Postfix) with ESMTP
	id 0F352357E; Fri, 25 Oct 2002 16:37:01 -0700 (PDT)
Received: (from roland@localhost)
	by magilla.sf.frob.com (8.11.6/8.11.6) id g9PNaww03056;
	Fri, 25 Oct 2002 16:36:58 -0700
Date: Fri, 25 Oct 2002 16:36:58 -0700
Message-Id: <200210252336.g9PNaww03056@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: "H. J. Lu" <hjl@lucon.org>
Cc: GNU C Library <libc-alpha@sources.redhat.com>,
	linux-mips@linux-mips.org
Subject: Re: PATCH: Fix errlist for mips
In-Reply-To: H. J. Lu's message of  Sunday, 20 October 2002 17:23:31 -0700 <20021020172331.A26834@lucon.org>
X-Antipastobozoticataclysm: Bariumenemanilow
Return-Path: <roland@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: roland@redhat.com
Precedence: bulk
X-list: linux-mips

You know better than I what existing mips libc.so.6 ABIs have for the size
of sys_errlist.  But for the current version, 123 omits many of the errno
values I see in asm-mips/errno.h, and EDQUOT really is 1133.  So I don't
see how your change can be right.
