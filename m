Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Mar 2004 13:18:20 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:25794 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225362AbUCRNSL>; Thu, 18 Mar 2004 13:18:11 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 4028B47814; Thu, 18 Mar 2004 14:18:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 2EAAF41B95; Thu, 18 Mar 2004 14:18:01 +0100 (CET)
Date: Thu, 18 Mar 2004 14:18:01 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dominic Sweetman <dom@mips.com>
Cc: Eric Christopher <echristo@redhat.com>,
	Long Li <long21st@yahoo.com>, linux-mips@linux-mips.org,
	David Ung <davidu@mips.com>, Nigel Stephens <nigel@mips.com>
Subject: Re: gcc support of mips32 release 2
In-Reply-To: <16456.21112.570245.1011@arsenal.mips.com>
Message-ID: <Pine.LNX.4.55.0403181404210.5750@jurand.ds.pg.gda.pl>
References: <20040305075517.42647.qmail@web40404.mail.yahoo.com>
 <1078478086.4308.14.camel@dzur.sfbay.redhat.com> <16456.21112.570245.1011@arsenal.mips.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 5 Mar 2004, Dominic Sweetman wrote:

> We added patterns to let our (old) GCC use the new rotates and
> bit-insert/extracts, at least in simple cases.  I'm not sure whether
> we've put those in our 3.4 evolution tree yet, but if we have we
> should push those out.

 As a side note, it makes me wonder where the borderline of the RISC
actually is.  Even Intel abandoned support for bit insert/extract
instructions after an initial attempt for the i386.  They figured out the
implementation was too complicated. ;-)

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
