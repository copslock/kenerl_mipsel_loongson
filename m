Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Feb 2003 09:11:19 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:6414 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225193AbTB1JLS>;
	Fri, 28 Feb 2003 09:11:18 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.algor.co.uk)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 18ogeZ-0004zY-00; Fri, 28 Feb 2003 09:18:03 +0000
Received: from arsenal.algor.co.uk
	([192.168.192.197] helo=arsenal.mips.com ident=mail)
	by olympia.algor.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 18ogXd-000776-00; Fri, 28 Feb 2003 09:10:53 +0000
Received: from dom by arsenal.mips.com with local (Exim 3.35 #1 (Debian))
	id 18ogXd-0000EV-00; Fri, 28 Feb 2003 09:10:53 +0000
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15967.10141.166760.373070@arsenal.mips.com>
Date: Fri, 28 Feb 2003 09:10:53 +0000
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Linux-MIPS <linux-mips@linux-mips.org>
Cc: Mike Uhler <uhler@mips.com>, "Kevin D. Kissell" <kevink@mips.com>,
	Nigel Stephens <nigel@mips.com>,
	Dominic Sweetman <dom@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: The MIPS' statement on R_MIPS_PC16 relocations
In-Reply-To: <Pine.GSO.3.96.1030227130833.19733D-100000@delta.ds2.pg.gda.pl>
References: <Pine.GSO.3.96.1030227130833.19733D-100000@delta.ds2.pg.gda.pl>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-2.4, required 4.5, AWL,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES,
	SIGNATURE_SHORT_DENSE, SPAM_PHRASE_00_01)
Return-Path: <dom@algor.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Maciej W. Rozycki (macro@ds2.pg.gda.pl) writes:

> Thiemo wants to reimplement R_MIPS_PC16 relocations to be useful for
> branches which requires a relocation's addend to be shifted left by two
> before processing and then shifting a calculated value right by two before
> applying to the relocated field (similarly to what is done for R_MIPS_26
> relocations).  The ABI currently defines these relocations to be handled
> without any shifts rendering them useless for branches and probably
> anything else.  I suspect that may actually be a typo or a
> misunderstanding that happened when working on the document. 

The existing definition is nonsense - I won't guess how it happened,
but there's no reason to keep it.  Thiemo has MIPS Technologies'
thanks and blessing in making this change.  Please let our Nigel
Stephens know when it's done (mailto:nigel@mips.com) and he'll
double-check it.

I'm sure you'll put comments in the code noting that this is different
from the document.

There's a more tricky question, which is how we're going to document
this.  I'm currently trying to create a more user-friendly (and
accurate) ABI document, but had not yet got to the relocation types...

-- 
Dominic Sweetman, 
MIPS Technologies (UK)
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone: +44 1223 706205 / fax: +44 1223 706250 / swbrd: +44 1223 706200
http://www.mips.com
