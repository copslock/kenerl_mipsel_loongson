Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jul 2004 18:33:48 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:62177 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225192AbUGSRdU>; Mon, 19 Jul 2004 18:33:20 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 1FE1C47B51; Mon, 19 Jul 2004 19:33:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 1231B477EF; Mon, 19 Jul 2004 19:33:14 +0200 (CEST)
Date: Mon, 19 Jul 2004 19:33:14 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Richard Sandiford <rsandifo@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
Subject: Re: [patch] MIPS/gcc: Revert removal of DImode shifts for 32-bit
 targets
In-Reply-To: <87hds49bmo.fsf@redhat.com>
Message-ID: <Pine.LNX.4.55.0407191907300.3667@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0407191648451.3667@jurand.ds.pg.gda.pl>
 <87hds49bmo.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 19 Jul 2004, Richard Sandiford wrote:

> > Linux relies on simple operations (addition/subtraction and shifts) on
> > "long long" variables being implemented inline without a call to
> > libgcc, which isn't linked in.
> 
> Sorry, but I don't think this is a reasonable expection for 64-bit
> shifts on 32-bit targets.  If linux insists on not using libgcc,

 See e.g: "http://www.ussg.iu.edu/hypermail/linux/kernel/0009.2/0655.html"  
for a rationale behind that.

> it should provide:
> 
> > After your change Linux has unresolved references to external __ashldi3(),
> > __ashrdi3() and __lshrdi3() functions at the final link.
> 
> ...these functions itself.

 Well, other targets, like the i386 (which didn't even have a 64-bit
variation till recently), do not force Linux to go through such
contortions.  I can't see a reason why MIPS should be different -- it's
not any harder to implement shifts for this processor than for an average
other platform.  Anyway, the patch works for me and it has been published
so that others can use it, thus I have no incentive to do anything else,
sorry.

  Maciej
