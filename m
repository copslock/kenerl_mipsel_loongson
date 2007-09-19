Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Sep 2007 18:47:23 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:48528 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20023859AbXISRrN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 19 Sep 2007 18:47:13 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id A62D740094;
	Wed, 19 Sep 2007 19:46:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id tciXMRt0nk79; Wed, 19 Sep 2007 19:46:36 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id BC6F8400E7;
	Wed, 19 Sep 2007 19:46:11 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l8JHkGlw027331;
	Wed, 19 Sep 2007 19:46:16 +0200
Date:	Wed, 19 Sep 2007 18:46:10 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	Richard Sandiford <rsandifo@nildram.co.uk>,
	GCC Mailing List <gcc@gcc.gnu.org>, linux-mips@linux-mips.org
Subject: Re: MIPS atomic memory operations (A.K.A PR 33479).
In-Reply-To: <46F15BB3.50107@avtrex.com>
Message-ID: <Pine.LNX.4.64N.0709191836140.24627@blysk.ds.pg.gda.pl>
References: <46F06980.4080500@avtrex.com> <20070919165809.GA14767@linux-mips.org>
 <Pine.LNX.4.64N.0709191759361.24627@blysk.ds.pg.gda.pl> <46F15BB3.50107@avtrex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4337/Wed Sep 19 12:28:02 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 19 Sep 2007, David Daney wrote:

> Currently, I (and thus GCC 4.3) am assuming that Linux emulates 'll', 'sc' and
> 'sync', If sync is not emulated, we would need to adjust the code generation
> so that it is not emitted on ISAs that don't support it.

 While adding "sync" is trivial enough I may have a patch ready by 
tomorrow, that will not change the existing userbase and I am not entirely 
sure forcing such a hasty upgrade on people would be reasonable; likely 
not.

> > A workaround for a CPU erratum fits within the "-mfix-*" option family quite
> > well though.
> 
> Do we know which CPUs require branch-likely?

 The R10000; there is a note about it in <asm-mips/war.h> at 
R10000_LLSC_WAR.

> I would be inclined to agree with adding a "-mfix-??" option.
> 
> The only place where GCC's __sync_* primitives are generated without
> explicitly writing them into your program is in GCJ compiled java code that
> uses volatile fields.
> 
> If we expect the use of the __sync_* primitives on CPUs that require
> branch-likely to be rare, we shouldn't penalize those trying to rid themselves
> of the beasts.

 Another option is to depend on the setting of -mbranch-likely.  By 
default it is on only for the processors which implement it and do not 
discourage it, i.e. these of the MIPS II, MIPS III and MIPS IV ISAs.

  Maciej
