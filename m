Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2003 18:08:53 +0100 (BST)
Received: from mms1.broadcom.com ([IPv6:::ffff:63.70.210.58]:24335 "EHLO
	mms1.broadcom.com") by linux-mips.org with ESMTP
	id <S8225377AbTIERIu>; Fri, 5 Sep 2003 18:08:50 +0100
Received: from 63.70.210.1 by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (MMS v5.5.3)); Fri, 05 Sep 2003 10:08:47 -0700
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id KAA02557; Fri, 5 Sep 2003 10:08:17 -0700 (PDT)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.9/8.12.9/SSF) with ESMTP id
 h85H8eov003600; Fri, 5 Sep 2003 10:08:42 -0700 (PDT)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id KAA20141; Fri, 5
 Sep 2003 10:08:40 -0700
Message-ID: <3F58C318.1CCAB218@broadcom.com>
Date: Fri, 05 Sep 2003 10:08:40 -0700
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] sibyte patch for 2.6 ide.h
References: <Pine.GSO.3.96.1030905185304.1692G-100000@delta.ds2.pg.gda.pl>
X-WSS-ID: 13461C95864132-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips

"Maciej W. Rozycki" wrote:
> 
> On Wed, 3 Sep 2003, Kip Walker wrote:
> 
> > Any objection to the following patch, which lets IDE work on 2.6 for
> > SiByte platforms?  Before getting it checked in, I'm willing to hear
> > style comments.  I need extra work to happen in ide_init_default_hwifs,
> > but that code doesn't fit well in <asm/ide.h> because most of the useful
> > declarations in <linux/ide.h> haven't been made yet.  With this patch, I
> > hoist the code into a C file, but can call back into the existing code
> > (avoiding maintaining a duplicate).
> 
>  Hmm, dumb question -- can't your extra work be done in code specific to
> the host-adapter?  The ide_init_default_hwifs() function looks like ISA
> legacy.

Well, I'm not sure.  First, the only "special" host adaptor is the
so-called Generic Bus IDE, which is probed in drivers/ide/mips/swarm.c. 
And I used to simply setup the ops in there.  But on my platform,
PCI-IDE adaptors need my special non-swapping ops too.  If I wait until
my host adaptor is setup, it's too late because in 2.6 the pci-ide code
has already tried to identify the drive using the swapping ops (my
experiments indicated that this was NOT the case in 2.4).

This routine is conveniently called AFTER default ops are setup for all
hwifs and before the PCI probing is done.  It seemed like a nice place
fix things up.

I'm happy to hear any alternatives that I can make work.  All that IDE
code gives me chills.

Kip
