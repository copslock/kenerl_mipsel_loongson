Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jul 2005 10:50:33 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:62732 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224908AbVGTJuR>; Wed, 20 Jul 2005 10:50:17 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 03568E1CB1; Wed, 20 Jul 2005 11:52:04 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 31910-08; Wed, 20 Jul 2005 11:52:04 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id B2A4AE1CAC; Wed, 20 Jul 2005 11:52:04 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j6K9q6Ze008241;
	Wed, 20 Jul 2005 11:52:06 +0200
Date:	Wed, 20 Jul 2005 10:52:11 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Kishore K <hellokishore@gmail.com>
Cc:	Pete Popov <ppopov@embeddedalley.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: bal instruction in gcc 3.x
In-Reply-To: <f07e6e05072002197b529b72@mail.gmail.com>
Message-ID: <Pine.LNX.4.61L.0507201047100.30702@blysk.ds.pg.gda.pl>
References: <f07e6e05071909301c212ab4@mail.gmail.com>  <20050719164427.GB8758@linux-mips.org>
  <f07e6e05071910194bab9b16@mail.gmail.com>  <1121802786.7285.88.camel@localhost.localdomain>
  <Pine.LNX.4.61L.0507200955390.30702@blysk.ds.pg.gda.pl>
 <f07e6e05072002197b529b72@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/984/Tue Jul 19 11:16:09 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8575
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 20 Jul 2005, Kishore K wrote:

> On the other hand, if I replace 
> 
> bal jump_to_label   
> 
> by 
> 
> la t9, jump_to_label
> jalr t9
> 
> I don't see any warning. What could be the reason ?

 Implicit assumptions in the "jal" macro.

> Can you suggest, what should be done to make the code safe for
> building on 64 bit processor.

 In this case:

	dla	t9, jump_to_label
	jalr	t9

Though we actually have auxiliary macros to make the resulting code 
readable.  So in the end you should really use something like this:

#include <asm/asm.h>

	PTR_LA	t9, jump_to_label
	jalr	t9

letting the whole mess be hidden in headers.

  Maciej
