Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Sep 2002 10:57:45 +0200 (CEST)
Received: from fw-cam.cambridge.arm.com ([193.131.176.3]:26601 "EHLO
	fw-cam.cambridge.arm.com") by linux-mips.org with ESMTP
	id <S1122960AbSITI5o>; Fri, 20 Sep 2002 10:57:44 +0200
Received: by fw-cam.cambridge.arm.com; id JAA08659; Fri, 20 Sep 2002 09:57:19 +0100 (BST)
Received: from unknown(172.16.9.107) by fw-cam.cambridge.arm.com via smap (V5.5)
	id xma007885; Fri, 20 Sep 02 09:56:27 +0100
Date: Fri, 20 Sep 2002 09:56:23 +0100
From: Gareth <g.c.bransby-99@student.lboro.ac.uk>
To: linux-mips@linux-mips.org
Subject: Cycles for certain instructions
Message-Id: <20020920095623.5300295a.g.c.bransby-99@student.lboro.ac.uk>
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <g.c.bransby-99@student.lboro.ac.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 251
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: g.c.bransby-99@student.lboro.ac.uk
Precedence: bulk
X-list: linux-mips

Hi,

I am doing an investigation with a mips malta board that has a 4kc processor on
it. I am trying to find out how many cycles certain instructions take to
execute.

The program I am running loops a small piece of code many times. After a few
loops of the code the caches will have all the instructions in them and so 
accesses to memory will be few and far between. So how many cycles do 
instructions such as load word and store word take? Obviosly if the data is not
in the cache the time take will depend on the speed of the external memory. If
the data is in the cache is the time taken fairly predictable for a given core?

Thanks
Gareth
