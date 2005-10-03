Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Oct 2005 14:35:19 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:32274 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S3465651AbVJCNfA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Oct 2005 14:35:00 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 45D4EF5991; Mon,  3 Oct 2005 15:34:55 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24570-04; Mon,  3 Oct 2005 15:34:55 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id D27A8F597F; Mon,  3 Oct 2005 15:34:54 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j93DYvVE018436;
	Mon, 3 Oct 2005 15:34:57 +0200
Date:	Mon, 3 Oct 2005 14:35:04 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Andrew Isaacson <adi@broadcom.com>, linux-mips@linux-mips.org
Subject: Re: [patch 1/5] SiByte fixes for 2.6.12
In-Reply-To: <20051003131551.GA19075@nevyn.them.org>
Message-ID: <Pine.LNX.4.61L.0510031432410.8056@blysk.ds.pg.gda.pl>
References: <20050622230042.GA17919@broadcom.com>
 <Pine.LNX.4.61L.0506231153080.17155@blysk.ds.pg.gda.pl>
 <20051001092807.GD14463@linux-mips.org> <20051003131551.GA19075@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.86.2/1107/Sun Oct  2 10:09:39 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 3 Oct 2005, Daniel Jacobowitz wrote:

> FYI, all I have is a piece of hard evidence: this patch was the
> difference between not booting and booting for a Sentosa with CFE. 
> Which isn't firmwareless and isn't a tiny bit of extra performance
> issue.

 Actually workarounds have been floating around for some time. ;-)  But 
I'm glad this has now been fixed properly.

  Maciej
