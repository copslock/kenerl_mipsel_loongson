Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jan 2004 16:50:20 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:24805 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225342AbUAWQuT>; Fri, 23 Jan 2004 16:50:19 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id EBF8D4BE10; Fri, 23 Jan 2004 17:50:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id DC9C6478A8; Fri, 23 Jan 2004 17:50:17 +0100 (CET)
Date: Fri, 23 Jan 2004 17:50:17 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: sjhill@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux 
In-Reply-To: <20040123142002Z8225342-9616+728@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0401231747490.3223@jurand.ds.pg.gda.pl>
References: <20040123142002Z8225342-9616+728@linux-mips.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 23 Jan 2004 sjhill@linux-mips.org wrote:

> Modified files:
> 	include/asm-mips64: Tag: linux_2_4 cpu.h 

 The difference was deliberate.

> 	arch/mips64/kernel: Tag: linux_2_4 proc.c 

 You've downgraded ISO C initializers.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
