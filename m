Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1RM0cr18352
	for linux-mips-outgoing; Wed, 27 Feb 2002 14:00:38 -0800
Received: from ayrnetworks.com (earth.ayrnetworks.com [64.166.72.139])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1RM0a918349
	for <linux-mips@oss.sgi.com>; Wed, 27 Feb 2002 14:00:36 -0800
Received: from [192.168.1.5] (IDENT:root@localhost.localdomain [127.0.0.1])
	by  ayrnetworks.com (8.11.6/8.11.2) with ESMTP id g1RKxGe14556
	for <linux-mips@oss.sgi.com>; Wed, 27 Feb 2002 12:59:17 -0800
Mime-Version: 1.0
X-Sender: kph@127.0.0.1
Message-Id: <a05100303b8a2f8b89aed@[192.168.1.5]>
Date: Wed, 27 Feb 2002 13:00:22 -0800
To: linux-mips@oss.sgi.com
From: Kevin Paul Herbert <kph@ayrnetworks.com>
Subject: CONFIG_CPU_HAS_WB (or to sync or to nop)
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

What is the intention of CONFIG_CPU_HAS_WB? On an RM7000, am I better 
off doing a pipeline flush (the nops in wbflush.h) or a sync 
instruction? Also, any guidance on whether I should go out and ensure 
writes have completed in PCI host adapters and bridges, or whether 
this is excessive paranoia.

Thanks,
Kevin
-- 
