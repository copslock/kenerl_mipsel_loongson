Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jun 2004 15:01:54 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:60357 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225926AbUFKOBu>; Fri, 11 Jun 2004 15:01:50 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 1BBB14787C; Fri, 11 Jun 2004 16:01:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 045EE47833; Fri, 11 Jun 2004 16:01:42 +0200 (CEST)
Date: Fri, 11 Jun 2004 16:01:42 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: David Daney <ddaney@avtrex.com>
Cc: gcc@gcc.gnu.org, linux-mips@linux-mips.org, java@gcc.gnu.org
Subject: Re: [RFC] MIPS division by zero and libgcj...
In-Reply-To: <40C8B29B.3090501@avtrex.com>
Message-ID: <Pine.LNX.4.55.0406111554420.13062@jurand.ds.pg.gda.pl>
References: <40C8B29B.3090501@avtrex.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5284
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 10 Jun 2004, David Daney wrote:

> It appears that gcc configured for mipsel-linux will execute a "break 7" 
> instruction on integer division by zero.
> 
> This causes the kernel (I am using 2.4.25) to send SIGTRAP.

 It looks like you have a problem in your configuration.  A "break 7"  
(or "teq <divisor>,$zero,7" -- but that's currently implemented in gas
only) is indeed emitted and exectuted in the case of division by zero, but
Linux has the ability to recognize this special break code and sends
SIGFPE instead.  There are actually two special codes defined, the other
being "6" for an overflow.  Both are handled by Linux, with si_code in
struct siginfo being set to FPE_INTDIV or FPE_INTOVF, respectively.  You
can handle this appropriately in a signal handler.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
