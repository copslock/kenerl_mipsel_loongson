Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Aug 2004 07:19:50 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:14099 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8224791AbUHTGTp>;
	Fri, 20 Aug 2004 07:19:45 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1By2vT-0000Jz-00; Fri, 20 Aug 2004 07:30:59 +0100
Received: from olympia.mips.com ([192.168.192.128] helo=doms-laptop.algor.co.uk)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1By2kF-0003a7-00; Fri, 20 Aug 2004 07:19:24 +0100
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16677.38895.779836.353523@doms-laptop.algor.co.uk>
Date: Thu, 19 Aug 2004 23:19:27 -0700
To: David Daney <ddaney@avtrex.com>
Cc: Dominic Sweetman <dom@mips.com>, Jun Sun <jsun@mvista.com>,
	linux-mips@linux-mips.org, Nigel Stephens <nigel@mips.com>
Subject: Re: anybody tried NPTL?
In-Reply-To: <4124CED5.1020608@avtrex.com>
References: <20040804152936.D6269@mvista.com>
	<16676.46694.564448.344602@arsenal.mips.com>
	<4124CED5.1020608@avtrex.com>
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence (RC5 Windows)" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.847, required 4, AWL,
	BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


David Daney (ddaney@avtrex.com) writes:

> All of this sounds good to me.  However my current concerns are how to
> make my code run on a mips32[r2] core with no floating point.  We are
> using several different systems with variations of this cpu type.
> 
> So for me, making sure that a soft-float variant of the ABI is well
> specified is also important.  I suppose it would be to treat
> float/double values as appropriate encoding of 32/64 bit integer values.

Exactly - that's certainly what we do with o32 -msoft-float.  I don't
think there are even any corner cases to worry about.

We've recently made some major improvements to our soft maths library
to make it many times faster, but still IEEE-compliant.  It was
originally written by Algorithmics - a GPL'd version is used in the
Linux/MIPS kernel to handle FPU exceptions.  I should probably check
before saying for certain, but I think we will distribute this under
straight GPL conditions.

If we had the time to do it, I guess we should put it on one of the OS
project sites... but I'll cc: Nigel Stephens (who wrote it).  If it
might be of use to you (which seems quite likely) perhaps we could do
a deal to get it on a site somewhere?  Let me know if you'd like sight
of it.

--
Dominic
