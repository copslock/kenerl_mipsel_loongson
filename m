Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4VFTbh16836
	for linux-mips-outgoing; Thu, 31 May 2001 08:29:37 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4VFT3h16778
	for <linux-mips@oss.sgi.com>; Thu, 31 May 2001 08:29:03 -0700
Received: from dea.waldorf-gmbh.de (u-133-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.133]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA08483
	for <linux-mips@oss.sgi.com>; Thu, 31 May 2001 08:28:54 -0700 (PDT)
	mail_from (ralf@dea.waldorf-gmbh.de)
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f4VDm4N31197;
	Thu, 31 May 2001 15:48:04 +0200
Date: Thu, 31 May 2001 15:48:04 +0200
From: Ralf Baechle <ralf@gnu.org>
To: linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: semaphore.c
Message-ID: <20010531154804.A31184@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I've had a number of crashes in semaphore.c of the mips64 kernel; enough to
no longer believe this might be some sort of memory corruption or otherwise
unrelated to semaphore code:

kernel BUG at semaphore.c:235!
Cpu 0 Unable to handle kernel paging request at address 00000000, epc == 800208ac, ra == 800208ac
Oops: 0001
Cpu 0

  Ralf
