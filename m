Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2003 03:11:29 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:54779 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225196AbTEUCL0>;
	Wed, 21 May 2003 03:11:26 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h4L2BOZ04265;
	Tue, 20 May 2003 19:11:24 -0700
Date: Tue, 20 May 2003 19:11:24 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: special include/asm/siginfo.h for MIPS
Message-ID: <20030520191124.N32567@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


MIPS has different values from all other arches in this file.
(such as SIGEV_NONE, etc)  Does anybody know why?

Because of this in 2.5 everybody else now goes to use the 
the generic version of siginfo, while MIPS uses its own special
version.

Even worse the new usage of SIGEV_XXX seems to suggest
sigev_notify is bitwise-or'ed flag instead of enumeration of integers.
This is in a direct conflict with current MIPS values.

Any thoughts?  Can we just use what other arches are using?

Jun
