Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Oct 2005 14:54:36 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:8206 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S3458576AbVJDNyN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Oct 2005 14:54:13 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id EBC7EF5A24; Tue,  4 Oct 2005 15:54:08 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08045-10; Tue,  4 Oct 2005 15:54:08 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id ABAF6F5A22; Tue,  4 Oct 2005 15:54:08 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j94DsCKg004509;
	Tue, 4 Oct 2005 15:54:12 +0200
Date:	Tue, 4 Oct 2005 14:54:20 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck <vagabon.xyz@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Add support for 4KS cpu.
In-Reply-To: <cda58cb80510040610k1a7f430fn@mail.gmail.com>
Message-ID: <Pine.LNX.4.61L.0510041430120.10696@blysk.ds.pg.gda.pl>
References: <cda58cb80510040149p690397afo@mail.gmail.com> 
 <Pine.LNX.4.61L.0510041219500.10696@blysk.ds.pg.gda.pl>
 <cda58cb80510040610k1a7f430fn@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.86.2/1109/Tue Oct  4 00:06:28 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9133
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 4 Oct 2005, Franck wrote:

> >  Please send patches inline.
> 
> I can see it inlined...what email viewer are you using ?

 Well, inlined means straight in the body rather than as a MIME attachment 
-- even if you use "Content-Disposition: inline", it's still one.

> True, but we may have some differences in future. For example, they
> both implements smart mips instructions. See options passed to GCC in
> mips Makefile, they're different from CPU_MIPS32_R2 ones. They also
> have a couple of instructions very useful for cryptographic

 See my other comment in this thread.  As to the SmartMIPS/crypto 
instructions -- unless they are going to be emitted by GCC for the kernel 
build (which I seriously doubt), there is no point in enabling them.

> algorithms. And have some extra bits in TLB to protect pages from
> being execute for example. These are the main differences that I can

 Now that may be of potential interest of the kernel, but again, that's in 
principle probably not specific to these processors, so that should be a 
separate option; if possible one selected at the run time only (hint, 
hint!).

> remember. Big fat warning: I sent all support I have done for these
> cpu, _not_ more, _not_ less. I agree it's almost nothing but it's a
> start...

 Well, it's probably a bit too early for inclusion, but it's certainly not 
for a review.  By sending changes here for discussion early you may avoid 
a lot of hassle later when you may discover a major update is required for 
them to be accepted.  Good luck!

  Maciej
