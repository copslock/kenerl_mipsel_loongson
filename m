Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jan 2003 19:18:56 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:22251 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226059AbTAHTSz>; Wed, 8 Jan 2003 19:18:55 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA10656;
	Wed, 8 Jan 2003 20:18:50 +0100 (MET)
Date: Wed, 8 Jan 2003 20:18:46 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dominic Sweetman <dom@mips.com>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [patch] Use XKPHYS for 64-bit TLB flushes
In-Reply-To: <15900.30127.646847.937900@arsenal.algor.co.uk>
Message-ID: <Pine.GSO.3.96.1030108200826.7872A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1099
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 8 Jan 2003, Dominic Sweetman wrote:

> It's probably better to use legal kuseg virtual addresses (but with

 I'd wait until there is an implementation that breaks with KSEG0 or
XKPHYS addresses.  Hopefully forever. 

> the invalid bit set) for initialising TLBs.  And to make them all
> different...

 They do are different: KSEG0+entry*0x2000, likewise for XKPHYS -- see the
patch. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
