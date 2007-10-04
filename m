Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2007 15:13:15 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:23207 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20024713AbXJDONG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Oct 2007 15:13:06 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id B85184012E;
	Thu,  4 Oct 2007 16:13:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id jB5i+qmguZ+u; Thu,  4 Oct 2007 16:13:02 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 5C8E140095;
	Thu,  4 Oct 2007 16:13:02 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l94ED5YL018017;
	Thu, 4 Oct 2007 16:13:05 +0200
Date:	Thu, 4 Oct 2007 15:13:01 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] enable PCI bridges in MIPS ip32
In-Reply-To: <20071004130318.GC28928@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0710041459270.10573@blysk.ds.pg.gda.pl>
References: <E1IdO0a-0000n7-Cg@eppesuigoccas.homedns.org>
 <Pine.LNX.4.64N.0710041316000.10573@blysk.ds.pg.gda.pl>
 <20071004130318.GC28928@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4471/Thu Oct  4 15:22:27 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 4 Oct 2007, Ralf Baechle wrote:

> I think historically we had something like chkslot() first in the code
> for the Galileo/Marvell bridges where it's needed due the brainddead
> abuse of device 31 - any access to that will crash the system.  From that
> point on chkslot checking spread across the PCI code like the measles in
> a kindergarden.

 Does the Galileo/Marvell do anything else with the device #31 than what 
is recommended by the PCI spec as a way to issue special cycles?  We need 
to be careful about the device #31 in general; it is seldom used anyway as 
there are only 20 IDSEL lines defined by the standard and they are usually 
mapped starting from the device #0.

> Another stylistic comment is about the return statement in the macro.
> That sort of construct should be avoided, it's quite unobvious to the
> reader who isn't familiar with the macro definition.

[etc... about macros]

 Very true indeed -- I sort of slipped over the issue unconsciously as it 
is outside the scope of the fix itself.  It is usually a good idea to 
separate clean-ups from changes to the semantics.

> Ah, one final formality - when sending a patch please add a
> Signed-off-by: line.  See Documentation/SubmittingPatches in the kernel
> tree for what this means.

 Well, there was one actually in the submission. :-)  And `checkpatch.pl' 
would remind about it otherwise.

  Maciej
