Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Feb 2007 20:43:08 +0000 (GMT)
Received: from father.pmc-sierra.com ([216.241.224.13]:4312 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20037724AbXBEUnC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Feb 2007 20:43:02 +0000
Received: (qmail 28295 invoked by uid 101); 5 Feb 2007 20:41:42 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by father.pmc-sierra.com with SMTP; 5 Feb 2007 20:41:42 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l15Kfgsw014415
	for <linux-mips@linux-mips.org>; Mon, 5 Feb 2007 12:41:42 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <1CC7PNGC>; Mon, 5 Feb 2007 12:41:41 -0800
Message-ID: <45C7967E.1090505@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	linux-mips@linux-mips.org
Subject: Embedding rootfs with kernel
Date:	Mon, 5 Feb 2007 12:41:34 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 05 Feb 2007 20:41:34.0648 (UTC) FILETIME=[066A7380:01C74966]
user-agent: Thunderbird 1.5.0.9 (X11/20061206)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

What is the MIPS-way of embedding the rootfs with the kernel?

Our method involves modifying the vmlinux.lds.S linker script to pull in our
'romfs' section. I don't see any other platform code doing this so there must
be a more "standard" approach.

Apparently there was support in linux 2.4 (a patch possibly?) which would
look for supported file system magic numbers past the end of the kernel.
So you could just cat the rootfs to the end of the kernel binary and go
on with life.

I've tried this with linux-mips.org code base and it doesn't appear to work.
Any pointers would be appreciated.

Marc
