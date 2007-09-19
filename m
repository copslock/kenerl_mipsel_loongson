Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Sep 2007 18:08:41 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:9184 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20023815AbXISRIc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 19 Sep 2007 18:08:32 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 21A7F4009C;
	Wed, 19 Sep 2007 19:08:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id Q1jnb0i+HDI2; Wed, 19 Sep 2007 19:07:57 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 5FACA40094;
	Wed, 19 Sep 2007 19:07:57 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l8JH81LG022133;
	Wed, 19 Sep 2007 19:08:01 +0200
Date:	Wed, 19 Sep 2007 18:07:56 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	David Daney <ddaney@avtrex.com>,
	Richard Sandiford <rsandifo@nildram.co.uk>,
	GCC Mailing List <gcc@gcc.gnu.org>, linux-mips@linux-mips.org
Subject: Re: MIPS atomic memory operations (A.K.A PR 33479).
In-Reply-To: <20070919165809.GA14767@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0709191759361.24627@blysk.ds.pg.gda.pl>
References: <46F06980.4080500@avtrex.com> <20070919165809.GA14767@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4337/Wed Sep 19 12:28:02 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 19 Sep 2007, Ralf Baechle wrote:

> Please make this loop closure branch a branch-likely.  This is necessary
> as a errata workaround for some processors.

 Do we emulate them for MIPS I?  We do emulate "ll" and "sc" and adding 
"sync" is easy (as a no-op as support for R3000 SMP is unlikely to ever 
happen).  Adding branches-likely, hmm...  Even though we do have logic to 
do that as a part of the FP emulator.

 A workaround for a CPU erratum fits within the "-mfix-*" option family 
quite well though.

  Maciej
