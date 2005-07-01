Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 09:58:02 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:19464 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226129AbVGAI5o>; Fri, 1 Jul 2005 09:57:44 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 4F636F5964; Fri,  1 Jul 2005 10:57:32 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 19277-03; Fri,  1 Jul 2005 10:57:32 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 1B29CE1C8A; Fri,  1 Jul 2005 10:57:32 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j618vXlc009175;
	Fri, 1 Jul 2005 10:57:33 +0200
Date:	Fri, 1 Jul 2005 09:57:37 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	Michael Stickel <michael@cubic.org>, linux-mips@linux-mips.org
Subject: RE: Problems with Intel e100 driver on new MIPS port, was: Advice
 needed WRT very slow nfs in new port...
In-Reply-To: <01049E563C8ECC43AD6B53A5AF419B38098BD1@avtrex-server2.hq2.avtrex.com>
Message-ID: <Pine.LNX.4.61L.0507010953420.30138@blysk.ds.pg.gda.pl>
References: <01049E563C8ECC43AD6B53A5AF419B38098BD1@avtrex-server2.hq2.avtrex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/962/Fri Jul  1 07:19:05 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 30 Jun 2005, David Daney wrote:

> It seems that it is a memory consistancy problem of some sort.  By 
> placing wbflush() after all writes to NIC registers it works.  This 
> leads me to think that either the driver is buggy WRT processors that 
> have write-back queues or my implementation (the default implementation) 
> of writeb() and friends is buggy on this processor.  Now it could be 
> that all that is needed is wmb() before some of the register writes, but 
> since on my processor they both do the same thing (sync) it is hard to 
> tell.

 Most likely that code has only been ever used on i386 systems (who'd want 
to use such a weird Ethernet chip elsewhere?), so don't expect it to be 
terribly sane.

  Maciej
