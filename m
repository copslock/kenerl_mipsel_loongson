Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 May 2004 18:17:19 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:5526 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226050AbUEZRRH>; Wed, 26 May 2004 18:17:07 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 261F84B8DA; Wed, 26 May 2004 19:16:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id A04744ADBD; Wed, 26 May 2004 19:16:52 +0200 (CEST)
Date: Wed, 26 May 2004 19:16:49 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Emmanuel Michon <em@realmagic.fr>
Cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: down_trylock() implementation for MIPS 4KEc CPU implies
 64bitarithmetics?
In-Reply-To: <1085591018.2306.82.camel@avalon.france.sdesigns.com>
Message-ID: <Pine.LNX.4.55.0405261914480.1025@jurand.ds.pg.gda.pl>
References: <1085589315.2306.49.camel@avalon.france.sdesigns.com> 
 <012b01c44342$c3ec91e0$10eca8c0@grendel> <1085591018.2306.82.camel@avalon.france.sdesigns.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 26 May 2004, Emmanuel Michon wrote:

> No, because this choice of CPU CONFIG_MIPS32
> is exclusive with CONFIG_CPU_R3000 and CONFIG_CPU_R4X00
> 
> I do use CONFIG_CPU_R4X00 so that appropriate cache routines are used

 Well, the cache routines for both CONFIG_CPU_R4X00 and CONFIG_MIPS32 are 
the same.

> I'd prefer to find the appropriate combination of flags to get things
> right though...

 The defaults for CONFIG_MIPS32 should be OK.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
