Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Mar 2004 12:45:03 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:12253 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225525AbUCWMoy>; Tue, 23 Mar 2004 12:44:54 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 8A0E54AC6E; Tue, 23 Mar 2004 13:44:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 7B4C3478CD; Tue, 23 Mar 2004 13:44:48 +0100 (CET)
Date: Tue, 23 Mar 2004 13:44:48 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux 
In-Reply-To: <20040322200826Z8225300-9616+4225@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0403231341110.16819@jurand.ds.pg.gda.pl>
References: <20040322200826Z8225300-9616+4225@linux-mips.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 22 Mar 2004 ralf@linux-mips.org wrote:

> Log message:
> 	Move check_gcc; it was being used before defined.

 And you've moved it down further?  What's the sense?  Also I feel 
check_gas and check_gcc should be kept together.  I'm checking in an 
update to match what the 32-bit port does.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
