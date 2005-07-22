Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2005 14:22:54 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:18702 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225296AbVGVNWj>; Fri, 22 Jul 2005 14:22:39 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 2E076F59D5; Fri, 22 Jul 2005 15:24:38 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 09097-10; Fri, 22 Jul 2005 15:24:38 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id D591BE1CC8; Fri, 22 Jul 2005 15:24:37 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j6MDOev1024190;
	Fri, 22 Jul 2005 15:24:40 +0200
Date:	Fri, 22 Jul 2005 14:24:48 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <20050722130655.GD3803@linux-mips.org>
Message-ID: <Pine.LNX.4.61L.0507221417340.7324@blysk.ds.pg.gda.pl>
References: <20050721153359Z8225218-3678+3745@linux-mips.org>
 <20050722043057.GA3803@linux-mips.org> <20050722121030.GD1692@hattusa.textio>
 <20050722130655.GD3803@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/987/Thu Jul 21 16:57:41 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8601
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 22 Jul 2005, Ralf Baechle wrote:

> >  - the in-kernel use seems to be limited to the ELF binary object
> >    loader and probably third party modules loaders
> > I found moving to a consistent definition to be more useful than
> > keeping the old inconsistent one.
> 
> I think you're confusing binutils's internal definitions with the use
> everywhere else.

 In particular when in doubt please refer to ELF standards which state 
"EF_" is the prefix for processor-specific flags in "e_flags" in the ELF 
file header; similarly with "EM_" for "e_machine" and "ET_" for "e_type" 
-- you should see the pattern.  There is no mention of the "E_" prefix in 
the standards.

  Maciej
