Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA21247 for <linux-archive@neteng.engr.sgi.com>; Wed, 11 Nov 1998 15:39:15 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA04142
	for linux-list;
	Wed, 11 Nov 1998 15:38:18 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA95605
	for <linux@engr.sgi.com>;
	Wed, 11 Nov 1998 15:37:33 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA00489
	for <linux@engr.sgi.com>; Wed, 11 Nov 1998 15:37:27 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-11.uni-koblenz.de [141.26.249.11])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA29533
	for <linux@engr.sgi.com>; Thu, 12 Nov 1998 00:37:23 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id AAA23083;
	Thu, 12 Nov 1998 00:31:03 +0100
Message-ID: <19981112003103.B22798@uni-koblenz.de>
Date: Thu, 12 Nov 1998 00:31:03 +0100
From: ralf@uni-koblenz.de
To: Philip Blundell <pb@nexus.co.uk>, linux-mips@fnet.fr
Cc: linux@cthulhu.engr.sgi.com, linux-mips@vger.rutgers.edu
Subject: Re: Binutils 2.9.x
References: <19981109140341.D541@uni-koblenz.de> <E0zdX1R-0003xm-00@fountain.nexus.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <E0zdX1R-0003xm-00@fountain.nexus.co.uk>; from Philip Blundell on Wed, Nov 11, 1998 at 09:57:09AM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Nov 11, 1998 at 09:57:09AM +0100, Philip Blundell wrote:

> Does this happen even without versioning?  My experience with the ARM was that 
> when we tried to start using symbol versioning it showed up various problems 
> in our ELF backend (basically various invalid assumptions).  All were easy to 
> fix but gave symptoms like yours initially.

It's several bugs all in one.  First of all somebody broke the special
handling for the .reginfo sections.  We actually only have them to satisfy
the ABI, otherwise they're toxic waste since nothing uses them.  Then we
have the missing support for symbol versioning.  All the assert messages
I examined were caused by the dynindx field of symbol hash being set to -1
in order to force them to local symbols.  Finally we have a other bugs
which account for the core dumps.  So far I only have the .reginfo thing
fixed and since my knowledge about BFD internals has mostly decayed of the
long time getting the symbol versioning bugs right has proven to be quite
some work.

  Ralf
