Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f33Flw006621
	for linux-mips-outgoing; Tue, 3 Apr 2001 08:47:58 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f33FlvM06618
	for <linux-mips@oss.sgi.com>; Tue, 3 Apr 2001 08:47:57 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 991317F7; Tue,  3 Apr 2001 17:47:55 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 71A3EF035; Tue,  3 Apr 2001 17:47:49 +0200 (CEST)
Date: Tue, 3 Apr 2001 17:47:49 +0200
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Subject: sgiwd93 multiple disk problem
Message-ID: <20010403174749.B4135@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi,
i guess Ryan Murray has stumbled over the multiple disk problem
on one of my machines again - I would like to fix that bug if i am able to.

My first suspicion was garbled DMA transfers which might happen if starting
a new DMA transfer when thge last is still running. So i tried
to add this to 

drivers/scsi/sgiwd93.c:dma_setup

    105 
    106         if (hregs->ctrl & HPC3_SCTRL_ACTIVE)
    107                 BUG();
    108 

This doesnt seem to get triggered. 

Does anyone have another idea what happens ?

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
