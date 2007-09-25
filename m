Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2007 14:10:41 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:62688 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20023042AbXIYNKi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Sep 2007 14:10:38 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 17333400B6;
	Tue, 25 Sep 2007 15:10:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id DKWYPRvDHZuK; Tue, 25 Sep 2007 15:10:34 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 0984D400A9;
	Tue, 25 Sep 2007 15:10:34 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l8PDAaLu025845;
	Tue, 25 Sep 2007 15:10:37 +0200
Date:	Tue, 25 Sep 2007 14:10:31 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Fuxin Zhang <zhangfx@lemote.com>
cc:	debian-mips@lists.debian.org, linux-mips@linux-mips.org
Subject: Re: About openoffice linux/mips porting 
In-Reply-To: <46F90261.1000003@lemote.com>
Message-ID: <Pine.LNX.4.64N.0709251406220.23669@blysk.ds.pg.gda.pl>
References: <46F90261.1000003@lemote.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4388/Tue Sep 25 04:51:32 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 25 Sep 2007, Fuxin Zhang wrote:

> It is available at
> http://qa.openoffice.org/issues/show_bug.cgi?id=81482, any comments are
> welcome.
> Have an official openoffice for linux/mips might be a good thing.

 Hmm, why would anyone need to have asm snippets in a document processing 
suite?  And it looks like the bits are ABI-dependent, so at least three 
variations (if the changes are endianness-safe) would be required to 
handle all the ABIs that we support.

 It smells like OpenOffice is doing something outrageously wrong here...

  Maciej
