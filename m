Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 May 2004 18:28:37 +0100 (BST)
Received: from c2ce9fba.adsl.oleane.fr ([IPv6:::ffff:194.206.159.186]:56194
	"EHLO avalon.france.sdesigns.com") by linux-mips.org with ESMTP
	id <S8226050AbUEZR2Z>; Wed, 26 May 2004 18:28:25 +0100
Received: from avalon.france.sdesigns.com (localhost.localdomain [127.0.0.1])
	by avalon.france.sdesigns.com (8.12.8/8.12.8) with ESMTP id i4QHS2sL026621;
	Wed, 26 May 2004 19:28:02 +0200
Received: (from michon@localhost)
	by avalon.france.sdesigns.com (8.12.8/8.12.8/Submit) id i4QHRvoW026619;
	Wed, 26 May 2004 19:27:57 +0200
X-Authentication-Warning: avalon.france.sdesigns.com: michon set sender to em@realmagic.fr using -f
Subject: Re: down_trylock() implementation for MIPS 4KEc CPU implies
	64bitarithmetics?
From: Emmanuel Michon <em@realmagic.fr>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
In-Reply-To: <Pine.LNX.4.55.0405261914480.1025@jurand.ds.pg.gda.pl>
References: <1085589315.2306.49.camel@avalon.france.sdesigns.com>
	 <012b01c44342$c3ec91e0$10eca8c0@grendel>
	 <1085591018.2306.82.camel@avalon.france.sdesigns.com>
	 <Pine.LNX.4.55.0405261914480.1025@jurand.ds.pg.gda.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: REALmagic France SAS
Message-Id: <1085592477.20233.111.camel@avalon.france.sdesigns.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 26 May 2004 19:27:57 +0200
Return-Path: <em@realmagic.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: em@realmagic.fr
Precedence: bulk
X-list: linux-mips

On Wed, 2004-05-26 at 19:16, Maciej W. Rozycki wrote:
> On Wed, 26 May 2004, Emmanuel Michon wrote:
> 
> > No, because this choice of CPU CONFIG_MIPS32
> > is exclusive with CONFIG_CPU_R3000 and CONFIG_CPU_R4X00
> > 
> > I do use CONFIG_CPU_R4X00 so that appropriate cache routines are used
> 
>  Well, the cache routines for both CONFIG_CPU_R4X00 and CONFIG_MIPS32 are 
> the same.
> 
> > I'd prefer to find the appropriate combination of flags to get things
> > right though...
> 
>  The defaults for CONFIG_MIPS32 should be OK.

What is the difference between CONFIG_CPU_MIPS32 and CONFIG_MIPS32?

If I just set CONFIG_MIPS32 the CPU is still default CONFIG_CPU_R5000.

Sincerely yours,

E.M.
