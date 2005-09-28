Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Sep 2005 16:23:13 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:1292 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133397AbVI1PWw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Sep 2005 16:22:52 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id DD93EF5A6F
	for <linux-mips@linux-mips.org>; Wed, 28 Sep 2005 17:22:46 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 05468-09 for <linux-mips@linux-mips.org>;
 Wed, 28 Sep 2005 17:22:46 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 99F01F5A6E
	for <linux-mips@linux-mips.org>; Wed, 28 Sep 2005 17:22:46 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j8SFMo2S030961
	for <linux-mips@linux-mips.org>; Wed, 28 Sep 2005 17:22:50 +0200
Date:	Wed, 28 Sep 2005 16:22:59 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: TURBOchannel patches for drivers available for 2.6
Message-ID: <Pine.LNX.4.61L.0509281606370.18267@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9066
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hello folks,

 It looks like development of the new generic TURBOchannel layer is a bit 
slow, but it's definitely meant to be the first significant change to be 
done for Linux 2.6 for systems supporting the bus.  Meanwhile, to 
encourage moving forward to 2.6, I have implemented changes necessary to 
the two drivers for PCI devices that are currently of use for TURBOchannel 
variations of the respective hardware.  They are available from my site 
and include support for the following devices:

1. The DEC FDDIcontroller/TURBOchannel family of FDDI network interfaces 
   (based on the PDQ/CAMEL chipset), comprising: DEFTA-FA, DEFTA-AA, 
   DEFTA-DA and DEFTA-UA.  The patch is available from: 
   "ftp://ftp3.ds.pg.gda.pl/people/macro/drivers/defxx/patch-mips-2.6.12-rc4-20050526-defta-25.gz".

2. The DEC ZLX-E1/2/3 family of graphics smart frame buffers (based on the 
   SFB+ ASIC, a functional equivalent of the 21030 or TGA), comprising: 
   PMAGD-A, PMAGD-B and PMAGD-C.  The patch is available from: 
   "ftp://ftp3.ds.pg.gda.pl/people/macro/drivers/tgafb/patch-mips-2.6.12-rc4-20050526-hx+-37.gz".

I have to regret these patches have only been tested with a kernel 
snapshot as denoted in the patch file names, but my intent is to keep them 
reasonably up to date as I update what I use for my development systems.  
I do hope there will not be many updates for these patches as they will be 
merged as soon as the generic TURBOchannel layer is implemented.

  Maciej
