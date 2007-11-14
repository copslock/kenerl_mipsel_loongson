Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Nov 2007 08:45:17 +0000 (GMT)
Received: from wa-out-1112.google.com ([209.85.146.180]:24374 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20024951AbXKNIpJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Nov 2007 08:45:09 +0000
Received: by wa-out-1112.google.com with SMTP id m16so116879waf
        for <linux-mips@linux-mips.org>; Wed, 14 Nov 2007 00:44:51 -0800 (PST)
Received: by 10.114.166.1 with SMTP id o1mr510380wae.1195029891869;
        Wed, 14 Nov 2007 00:44:51 -0800 (PST)
Received: from ?192.168.1.154? ( [203.198.58.230])
        by mx.google.com with ESMTPS id k24sm916182waf.2007.11.14.00.44.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Nov 2007 00:44:50 -0800 (PST)
Message-ID: <473AB56B.2070107@entone.com>
Date:	Wed, 14 Nov 2007 16:44:27 +0800
From:	David Kuk <david.kuk@entone.com>
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: smp8634 add memory at dram1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.kuk@entone.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.kuk@entone.com
Precedence: bulk
X-list: linux-mips

After study about the memory configuration of sigma smp8634, i found 
some difficult to accomplish the task.

so my question is if have two 128MB ram separately under dram0 and dram1 
controller, where dram0 for linux and dram1 for video decoding. Now the 
situation is the memory for linux is not enough and video decoding can 
not use all of it's 128MB at dram1, what we plan to do is to share 64MB 
at dram1 to the linux kernel as high memory, and only reserved 64MB at 
dram1 for the video decoding.

first, in MIPS architecture, we found that the kseg0 and kseg1 are 
mapped to 0x00000000-0x20000000, which include only dram0 controller, so 
we wish to add the dram1 memory manually to the kernel using function 
add_memory_region at setup.c , after booting up result the warning that 
the memory larger than 512 need to configured the kernel support high 
memory.

then when we configure the kernel to support high memory at menu 
configure, the kernel when booting up will remind us our CPU do not 
support high memory due to cache aliases.

Both way will lead the linux can not boot up normally, so what should we 
do, is there any mis-understanding about the hardware implementation or 
MIPS design? \
