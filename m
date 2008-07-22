Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2008 20:55:36 +0100 (BST)
Received: from idcmail-mo2no.shaw.ca ([64.59.134.9]:61542 "EHLO
	pd5mo1no-dmz.prod.shaw.ca") by ftp.linux-mips.org with ESMTP
	id S28576005AbYGVTze (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 Jul 2008 20:55:34 +0100
Received: from unknown (HELO pd7ml1no-ssvc.prod.shaw.ca) ([10.0.153.161])
  by pd5mo1no-svcs.prod.shaw.ca with ESMTP; 22 Jul 2008 13:55:26 -0600
X-Cloudmark-SP-Filtered: true
X-Cloudmark-SP-Result: v=1.0 c=0 a=k3EDTjLkTGGeHWIs8FYA:9 a=-wLil0PomoLINGMZv2pVd9MzT2oA:4 a=LfNDhWR-7GwA:10
Received: from s0106000d88c2e56e.cg.shawcable.net (HELO localhost.localdomain) ([70.73.70.241])
  by pd7ml1no-dmz.prod.shaw.ca with ESMTP; 22 Jul 2008 13:55:18 -0600
Message-ID: <48863A41.2020303@aksysnetworks.com>
Date:	Tue, 22 Jul 2008 13:51:29 -0600
From:	Mandeep Ahuja <ahuja@aksysnetworks.com>
User-Agent: Thunderbird 2.0.0.6 (X11/20070926)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Load Average >=1, mips kernel 2.6.10
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ahuja@aksysnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ahuja@aksysnetworks.com
Precedence: bulk
X-list: linux-mips

Hi,
I need your guys help.

I have an embedded system thats has mips processor. I recently updated 
to Kernel 2.6.10 from 2.4.17.
I was able to run the kernel and mount the jffs2 file system.

When the system starts the load average is low like 0.02 but, after 
about 2 minutes it becomes 1.00 and as long as the system is idle it 
stays at 1.00. If the system is not idle it would go up to like 1.21 but 
eventually come down  to 1.00 but NEVER goes below 1.

There is no application running on the system. Only the busybox. Top 
shows all processes sleeping.

this is the version of kernel
Linux version 2.6.10_dev-malta-mips2_fp_len (gcc version 3.4.6)

Is there something holding the processor continuously? does anyone have 
any idea whats going on?.

 I need to figure this one out before I start my application on it!.

Thanks a lot

manjee
