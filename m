Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2003 13:50:12 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:35853 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8224821AbTGVMuK>;
	Tue, 22 Jul 2003 13:50:10 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 19ewcN-0004jY-00; Tue, 22 Jul 2003 13:51:47 +0100
Received: from gladsmuir.algor.co.uk ([172.20.192.66] helo=gladsmuir.mips.com)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 19ewaT-0001Qk-00; Tue, 22 Jul 2003 13:49:49 +0100
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16157.13036.787738.445030@gladsmuir.mips.com>
Date: Tue, 22 Jul 2003 13:49:48 +0100
To: David Kesselring <dkesselr@mmc.atmel.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64bit Sead build
In-Reply-To: <Pine.GSO.4.44.0307220836390.16466-100000@ares.mmc.atmel.com>
References: <20030721233649.GA6900@linux-mips.org>
	<Pine.GSO.4.44.0307220836390.16466-100000@ares.mmc.atmel.com>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-8.6, required 4, AWL,
	QUOTED_EMAIL_TEXT, REFERENCES)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


David,

You wrote to Ralf:

> Thanks for the info. I'm trying to build 64bit sead so that it can
> be a basis for a port to our own chip with a MIPS 5kf core.

Interesting.  It's good to know people are looking at the 64-bit
ports.

> Is one of the other supported boards more generic (and thus a better
> start) than Sead?

We use our 'Malta' board for all our in-house Linux work.  See:

  http://www.mips.com/ProductCatalog/P626341476/productView

(I think that link will work for you... let me know if it's
non-portable) 

We maintain a relatively stable 32-bit Linux port for Malta.  64-bit
is still somewhat experimental; but at least you have a board with
ethernet and disk ports, and PCI expansion slots.

I guess you should ask your local MIPS salesperson about Malta.

-- 
Dominic Sweetman
MIPS Technologies
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone +44 1223 706205/fax +44 1223 706250/swbrd +44 1223 706200
http://www.mips.com
