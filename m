Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2007 14:32:22 +0000 (GMT)
Received: from father.pmc-sierra.com ([216.241.224.13]:5048 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20041122AbXAPOcR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jan 2007 14:32:17 +0000
Received: (qmail 9533 invoked by uid 101); 16 Jan 2007 14:32:10 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by father.pmc-sierra.com with SMTP; 16 Jan 2007 14:32:10 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l0GEW0Oh003632
	for <linux-mips@linux-mips.org>; Tue, 16 Jan 2007 06:32:08 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <C6N4DJQF>; Mon, 15 Jan 2007 12:21:38 -0800
Message-ID: <5C1FD43E5F1B824E83985A74F396286E03AD7608@bby1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Questions on new platform submission
Date:	Mon, 15 Jan 2007 12:21:32 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Hi all,

I am about to submit a new platform and have a few questions to attempt the reduce the number of iterations:

1. Should I prepare the patches against the linux.git master?

2. Form previous posts I'm assuming patches for the serial driver (drivers/serial/8250.c) should not go to this list but the serial maintainer. Is this correct?

3. Same question for USB driver (mostly drivers/usb/host and gadget), should I send to a usb maintainer?

Advanced thanks,
Marc
