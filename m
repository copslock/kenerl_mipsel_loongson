Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jul 2005 13:52:32 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:47877 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224922AbVGTMwH>; Wed, 20 Jul 2005 13:52:07 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 01E4FE1CA8; Wed, 20 Jul 2005 14:53:52 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 22610-05; Wed, 20 Jul 2005 14:53:52 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id C86F1E1C98; Wed, 20 Jul 2005 14:53:52 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j6KCrtCv013148;
	Wed, 20 Jul 2005 14:53:55 +0200
Date:	Wed, 20 Jul 2005 13:54:02 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Alexander Voropay <alec@artcoms.ru>
Cc:	Kishore K <hellokishore@gmail.com>, linux-mips@linux-mips.org
Subject: Re: bal instruction in gcc 3.x
In-Reply-To: <010901c58d28$15e2a3b0$6cf9a8c0@ALEC>
Message-ID: <Pine.LNX.4.61L.0507201347350.30702@blysk.ds.pg.gda.pl>
References: <f07e6e05071909301c212ab4@mail.gmail.com> <20050719164427.GB8758@linux-mips.org>
 <f07e6e05071910194bab9b16@mail.gmail.com> <1121802786.7285.88.camel@localhost.localdomain>
 <Pine.LNX.4.61L.0507200955390.30702@blysk.ds.pg.gda.pl>
 <f07e6e05072002197b529b72@mail.gmail.com> <010901c58d28$15e2a3b0$6cf9a8c0@ALEC>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/984/Tue Jul 19 11:16:09 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 20 Jul 2005, Alexander Voropay wrote:

> 3) AFAIK (correct me), there is no MIPS-specific RELOC type for
> the "branch"  instruction format in the BFD, so "bal" to the *external*
> symbols is impossible.

 There is a reloc called BFD_RELOC_16_PCREL_S2 which is used for branches 
by BFD internally, but unfortunately the original SysV ELF supplement for 
MIPS failed to define an appropriate relocation for this purpose (there is 
useless R_MIPS_PC16, though), so there is nothing to map this internal 
relocation to.  There were discussions as to whether reuse R_MIPS_PC16 for 
branches or not.  Unfortunately I don't remember the conclusion -- you'd 
have to find it out yourself.

  Maciej
