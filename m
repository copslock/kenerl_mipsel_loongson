Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Mar 2003 11:28:10 +0000 (GMT)
Received: from msg2p.netvision.net.il ([IPv6:::ffff:194.90.9.4]:59789 "EHLO
	msg2p.netvision.net.il") by linux-mips.org with ESMTP
	id <S8225199AbTCLL2J>; Wed, 12 Mar 2003 11:28:09 +0000
Received: from netvision.net.il ([194.90.9.5]) by msg2s.netvision.net.il
 (iPlanet Messaging Server 5.2 Patch 1 (built Aug 19 2002))
 with ESMTP id <0HBM00DQMVUQ79@msg2s.netvision.net.il> for
 linux-mips@linux-mips.org; Wed, 12 Mar 2003 13:28:02 +0200 (IST)
Received: from [194.90.9.13] by msg2s.netvision.net.il (mshttpd); Wed,
 12 Mar 2003 13:28:02 +0200
Date: Wed, 12 Mar 2003 13:28:02 +0200
From: Hilik Stein <hilik@netvision.net.il>
Subject: allocating a large memory area
To: linux-mips@linux-mips.org
Message-id: <438113fe62.3fe6243811@netvision.net.il>
MIME-version: 1.0
X-Mailer: iPlanet Messenger Express 5.2 Patch 1 (built Aug 19 2002)
Content-type: text/plain; charset=us-ascii
Content-language: he
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Accept-Language: he
Priority: normal
Return-Path: <hilik@netvision.net.il>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1701
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hilik@netvision.net.il
Precedence: bulk
X-list: linux-mips

Hi All 
i am building a kernel based fast packet handler which runs on kernel 
2.4.20. 
my code resides inside the kernel, which is running on sb1 core. 
i need to allocate a large memory region for my data (32MB), which is far 
beyond what kmalloc can provide for me. 
i do not want to use vmalloc, since it will allocate the memory out of 
KSEG2, which is too slow and will generate too many exceptions when i 
have to access my data randomly. 
i was thinking of limiting the linux from accessing the highest physical 
32MB by using "mem=224M" kernel command line parameter. this was i 
can access my data using 0x8e000000 through KSEG1. 
is this safe ? anything i need to consider before moving forward with that 
approach ? 
thanks 
Hilik
