Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2006 16:18:02 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:30981 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20038850AbWJCPSB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Oct 2006 16:18:01 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 3B49EF62E0;
	Tue,  3 Oct 2006 17:17:56 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nfNNYqXi6Zpm; Tue,  3 Oct 2006 17:17:55 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id C933EF62DF;
	Tue,  3 Oct 2006 17:17:55 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.1) with ESMTP id k93FI2pv004643;
	Tue, 3 Oct 2006 17:18:02 +0200
Date:	Tue, 3 Oct 2006 16:17:57 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Andy Fleming <afleming@freescale.com>
cc:	netdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: [patch 0/6] 2.6.18: sb1250-mac: Driver model & phylib update
Message-ID: <Pine.LNX.4.64N.0610021903490.1359@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.4/1984/Tue Oct  3 12:01:28 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hello,

 Here is a set of patches that update the sb1250-mac driver used for the 
onchip Gigabit Ethernet interfaces of the Broadcom SiByte family of SOCs 
including the BCM1250 and a couple of other members.  These are used, 
among others, on various Broadcom evaluation boards together with Broadcom 
Gigabit Ethernet PHY chips.  Changes include porting the driver to the 
driver model as a platform device, support for phylib, including the 
BCM54xx PHYs in the interrupt mode, proper resource managment and a couple 
of minor clean-ups.

 Apart from changes to networking code, there are a few required in the 
architecture-specific areas and therefore I am sending these changes to 
Ralf and the linux-mips list as well.  It might also involve a few more 
interested parties in the discussion.

 The changes were tested with a Broadcom SWARM board, which includes a 
BCM1250 part which has 3 MAC units on chip, of which 2 are usable, with 
BCM5421 PHY chips attached (both wired to the same interrupt line, which 
made testing whether IRQ sharing works properly in phylib possible).  
Link partners included a 1000base and a 100base interface doing 
autonegotiation as well as a 10base one doing none.

 Other Broadcom boards that I know of may have these or BCM5411 or BCM5461 
chips.  The lack of documentation or at least actual pieces of hardware 
makes the use of interrupts impossible for all but the SWARM, the Sentosa 
and the Shorty (with the latter unsupported by Linux).

  Maciej
