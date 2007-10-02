Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Oct 2007 17:08:20 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:18146 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20024340AbXJBQIM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 Oct 2007 17:08:12 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id CB9594010F;
	Tue,  2 Oct 2007 18:08:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id Imiqcdi56dWo; Tue,  2 Oct 2007 18:08:06 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id C473640040;
	Tue,  2 Oct 2007 18:08:06 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l92G8Bpd007977;
	Tue, 2 Oct 2007 18:08:11 +0200
Date:	Tue, 2 Oct 2007 17:08:05 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
In-Reply-To: <20071002154918.GA11312@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0710021651490.32726@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl>
 <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4453/Tue Oct  2 13:38:38 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 2 Oct 2007, Ralf Baechle wrote:

> I have a patch which makes the generated code accessible through a
> procfs file.  That can easily be converted back into a .o file and then
> be disassembled.  So it's now a question of which variant is preferable.

 There is no need to go through such hassle even:

$ objdump -b binary -m mips:4000 -d /proc/foo

or suchlike should work (the program seems to be sensitive to the file 
size though, so it better be non-zero).

> I don't mind - it's just that I've never been a friend of leaving much
> debugging code or features around.  99% of the time it is just make the
> code harder to read and maintain.

 In this case I would let these bits stay in though.  The bootstrap log 
always works and can be captured with the serial console or read from the 
screen, and if there is a subtle breakage in these generated bits then the 
system may never get far enough for procfs to be accessible.  It is these 
moments it matters the most.

  Maciej
