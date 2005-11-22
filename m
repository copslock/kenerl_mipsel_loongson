Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2005 11:35:44 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:25630 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3466285AbVKVLf0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 Nov 2005 11:35:26 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jAMBc10q007901;
	Tue, 22 Nov 2005 11:38:01 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jAMBc1qf007900;
	Tue, 22 Nov 2005 11:38:01 GMT
Date:	Tue, 22 Nov 2005 11:38:01 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Knittel, Brian" <Brian.Knittel@powertv.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Saving arguments on the stack
Message-ID: <20051122113801.GC2706@linux-mips.org>
References: <762C0A863A7674478671627FEAF5848105AF92D2@hqmail01.powertv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <762C0A863A7674478671627FEAF5848105AF92D2@hqmail01.powertv.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 21, 2005 at 06:59:20PM -0800, Knittel, Brian wrote:

> I'd like to force the compiler to store arguments on the stack with otherwise optimized code.
> 
> I found a refernce in the archives (form 2001) for using -0 (no optimization). Has anyone found another way to do this?

-O is optimization - same as -O1.

Gcc will save all arguments to the stack for variadic functions (like:
int printf(const char *fmt, ...)) when using somewhat older compiler - I
think before gcc 3.2 or so.  Newer compilers will only save argument
one and up.  Maybe that's good enough?

  Ralf
