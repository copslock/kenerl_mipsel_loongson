Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g08K86t25885
	for linux-mips-outgoing; Tue, 8 Jan 2002 12:08:06 -0800
Received: from ayrnetworks.com (earth.ayrnetworks.com [64.166.72.139])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g08K82g25877
	for <linux-mips@oss.sgi.com>; Tue, 8 Jan 2002 12:08:03 -0800
Received: from [192.168.1.5] (IDENT:root@localhost.localdomain [127.0.0.1])
	by  ayrnetworks.com (8.11.6/8.11.2) with ESMTP id g08J5Ne12745
	for <linux-mips@oss.sgi.com>; Tue, 8 Jan 2002 11:05:23 -0800
Mime-Version: 1.0
X-Sender: kph@127.0.0.1
Message-Id: <a05100303b860f1fff2dd@[192.168.1.5]>
Date: Tue, 8 Jan 2002 11:07:53 -0800
To: linux-mips@oss.sgi.com
From: Kevin Paul Herbert <kph@ayrnetworks.com>
Subject: Support for physical memory above 0x20000000
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I'm working with a somewhat dated kernel (2.4.2+patches) and have 
discovered that there are problems with physical memory that does not 
map into KSEG0/KSEG1. I looked over the list archives (manually, I 
couldn't find a search interface) and it appears that this is still 
the case for current kernels (at least as of a note from last summer, 
the last time the issue seems to have come up.)

Obviously, phys_to_virt() is going to be a problem but besides this 
I'm wondering what anybody may have done to support physical memory 
that is not always mapped into the virtual address space, so that I 
don't have to reinvent the wheel.

When I tell the kernel about the memory above 0x20000000, userland 
fails to start; the kernel gets as far as execve()'ing init, but 
nothing happens (interrupts are enabled; I get echo on the console, 
but nothing from userland).

Thanks,
Kevin
-- 
