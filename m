Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2003 01:52:16 +0100 (BST)
Received: from vopmail.sfo.interquest.net ([IPv6:::ffff:66.135.128.69]:14353
	"EHLO micaiah.rwc.iqcicom.com") by linux-mips.org with ESMTP
	id <S8225192AbTDAAwP>; Tue, 1 Apr 2003 01:52:15 +0100
Received: from Muruga.localdomain (unverified [66.135.134.50]) by micaiah.rwc.iqcicom.com
 (Vircom SMTPRS 2.0.244) with ESMTP id <B0005113722@micaiah.rwc.iqcicom.com>;
 Mon, 31 Mar 2003 16:52:10 -0800
Received: from localhost (muthu@localhost)
	by Muruga.localdomain (8.11.6/8.11.2) with ESMTP id h310bCN16365;
	Mon, 31 Mar 2003 16:37:13 -0800
X-Authentication-Warning: Muruga.localdomain: muthu owned process doing -bs
Date: Mon, 31 Mar 2003 16:37:12 -0800 (PST)
From: Muthukumar Ratty <muthu@iqmail.net>
X-X-Sender: <muthu@Muruga.localdomain>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: <Amit.Lubovsky@infineon.com>, <linux-mips@linux-mips.org>
Subject: Re: mips5kc - cpu registers
In-Reply-To: <009401c2f7aa$0137f2a0$10eca8c0@grendel>
Message-ID: <Pine.LNX.4.33.0303311634180.16351-100000@Muruga.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <muthu@iqmail.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1881
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: muthu@iqmail.net
Precedence: bulk
X-list: linux-mips


> In general, gcc (and most other compilers)
> will do this for you automatically if you enable
> any reasonable level of optimization.  There
> is no need to designate the variable as "FAST",
> one simply needs to avoid having it be global,
> static, or volatile.

just to add to that... you shouldnt have referred to the address of the
variable. Even if you do, say &tmp, and never assigned it to any ptr,
gcc will not use register for that var.







>
> ----- Original Message -----
> From: <Amit.Lubovsky@infineon.com>
> To: <linux-mips@linux-mips.org>
> Sent: Monday, March 31, 2003 6:45 PM
> Subject: mips5kc - cpu registers
>
>
> > Hi,
> > is there a possibility to use cpu registers in the code (temporarily)
> > instead of allocating
> > automatic variables something like:
> > func a()
> > {
> > FAST int, i, tmp;
> > tmp = ...
> > ...
> > }
> >
> > as in vxWorks ?
> >
> > Thanks,
> > Amit.
> >
> >
>
