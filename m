Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2005 12:08:58 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:10500 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225477AbVFWLIn>; Thu, 23 Jun 2005 12:08:43 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id ADACDE1CC1; Thu, 23 Jun 2005 13:07:40 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 04230-01; Thu, 23 Jun 2005 13:07:40 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 5A158E1C8F; Thu, 23 Jun 2005 13:07:40 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j5NB7gnw018027;
	Thu, 23 Jun 2005 13:07:42 +0200
Date:	Thu, 23 Jun 2005 12:07:48 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Isaacson <adi@broadcom.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [patch 3/5] SiByte fixes for 2.6.12
In-Reply-To: <20050622230137.GA17954@broadcom.com>
Message-ID: <Pine.LNX.4.61L.0506231202130.17155@blysk.ds.pg.gda.pl>
References: <20050622230137.GA17954@broadcom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/954/Wed Jun 22 21:15:13 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 22 Jun 2005, Andrew Isaacson wrote:

> Toolchain compat fix: gas 2.12.1 doesn't understand two-argument jalr,
> and the $ra is redundant anyways.

 Is it really the case?  Perhaps it doesn't know the symbolic name of the 
register which has only been added recently.  Replacing it with $31 should 
fix the problem, but your patch is obviously correct regardless.

 The code is broken anyway -- I've tried fixing it, but I've hit 
shortcomings of macros in <asm/addrspace.h> (I've got working code, but 
GCC complains loudly), so it may yet take a while.

  Maciej
