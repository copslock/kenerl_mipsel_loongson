Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Dec 2002 16:47:50 +0100 (CET)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:42710 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224847AbSLDPrt>; Wed, 4 Dec 2002 16:47:49 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA06889;
	Wed, 4 Dec 2002 16:48:06 +0100 (MET)
Date: Wed, 4 Dec 2002 16:48:05 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org
Subject: Re: watch exception only for kseg0 addresses..?
In-Reply-To: <20021204013713.D18419@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1021204164558.29982E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 750
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 4 Dec 2002, Ralf Baechle wrote:

> Correct but I don't know of any CPU that actually uses more than 4 of the
> possible 8 sets atm.  So we're both right :)

 Well, software needs to be prepared to handle eight ones.  Actually it's
easy to handle any number. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
