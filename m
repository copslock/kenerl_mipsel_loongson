Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Mar 2004 10:12:32 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:1550 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8224985AbUCEKMb>;
	Fri, 5 Mar 2004 10:12:31 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1AzCDF-0006vk-00; Fri, 05 Mar 2004 10:05:49 +0000
Received: from arsenal.mips.com ([192.168.192.197])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1AzCJN-0007Fg-00; Fri, 05 Mar 2004 10:12:09 +0000
Received: from dom by arsenal.mips.com with local (Exim 3.35 #1 (Debian))
	id 1AzCJM-0006xJ-00; Fri, 05 Mar 2004 10:12:08 +0000
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16456.21112.570245.1011@arsenal.mips.com>
Date: Fri, 5 Mar 2004 10:12:08 +0000
To: Eric Christopher <echristo@redhat.com>
Cc: Long Li <long21st@yahoo.com>, linux-mips@linux-mips.org
cc: David Ung <davidu@mips.com>, Nigel Stephens <nigel@mips.com>
Subject: Re: gcc support of mips32 release 2
In-Reply-To: <1078478086.4308.14.camel@dzur.sfbay.redhat.com>
References: <20040305075517.42647.qmail@web40404.mail.yahoo.com>
	<1078478086.4308.14.camel@dzur.sfbay.redhat.com>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.846, required 4, AWL,
	BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


> > Seems to me, this mips32 release 2 is an extension of
> > mips32, added some new instructions, eg. EHB, etc. So
> > would it be necessary that gcc be updated, like what
> > gnu as has done, in the future to reflect this
> > extension?
> 
> It will be in the soon to be released 3.4. Contributed by Chris
> Demetriou of Broadcom.

We added patterns to let our (old) GCC use the new rotates and
bit-insert/extracts, at least in simple cases.  I'm not sure whether
we've put those in our 3.4 evolution tree yet, but if we have we
should push those out.

--
Dominic Sweetman
MIPS Technologies.
