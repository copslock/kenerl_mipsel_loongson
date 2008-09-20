Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Sep 2008 06:09:19 +0100 (BST)
Received: from ns1.siteground150.com ([67.15.243.6]:5021 "EHLO
	serv01.siteground150.com") by ftp.linux-mips.org with ESMTP
	id S29589047AbYITFJM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 20 Sep 2008 06:09:12 +0100
Received: from ns1.siteground150.com ([67.15.243.6]:33094 helo=siteground150.com)
	by serv01.siteground150.com with esmtpa (Exim 4.69)
	(envelope-from <linux-mips@reliableembeddedsystems.com>)
	id 1KguiS-0007zC-GN; Sat, 20 Sep 2008 00:09:08 -0500
MIME-Version: 1.0
Date:	Sat, 20 Sep 2008 00:09:08 -0500
From:	<linux-mips@reliableembeddedsystems.com>
To:	linux-mips@linux-mips.org
Cc:	linux-mips@reliabeembeddedsystems.com
Subject: SMP8634 DRAM memory issue
Message-ID: <4e9ae533d87732773b7ad0f1a33b54f9@reliableembeddedsystems.com>
X-Sender: linux-mips@reliableembeddedsystems.com
User-Agent: RoundCube Webmail/0.1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground150.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - reliableembeddedsystems.com
Return-Path: <linux-mips@reliableembeddedsystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20570
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux-mips@reliableembeddedsystems.com
Precedence: bulk
X-list: linux-mips

Hi,

We've got an SMP8634 based set-top box from a 3rd party and are trying to
port some middleware to it.
Everything seems to work out fine, except for one thing ... the amount of
memory for kernel space.

The box physically has two 64MB chips and two 32MB chips.  
The kernel is only seeing the two 32MB chips, apparently attached to DRAM0.

The problem is the following:

1) The middleware requires more memory in kernel space to allocalte big
graphical surfaces.
2) Whatever runs before the kernel is also from a 3rd party and we don't
have access to it.
3) We can't change anything on the box hardware.

This means, we would only be able to patch starting from the Linux kernel.

Do you see any way to swap what the kernel sees to be 128MB instead of 64MB
and the user space 64MB minus whatever is allocated for the initial RAM
disc?
The 64MB for user space are sufficient, we just need more then 64 MB on
kernel space.

Regards,

Robert

-- 
Robert Berger
Embedded Software Specialist

Reliable Embedded Systems
Consulting Training Engineering
Tel.: (+30) 697 593 3428
Fax.:(+30 210) 684 7881
URL: http://www.reliableembeddedsystems.com
--
...This above all: to thine own self be true.-- Shakespeare
