Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA2DalN08138
	for linux-mips-outgoing; Fri, 2 Nov 2001 05:36:47 -0800
Received: from mail.ivivity.com (user-vc8ftn3.biz.mindspring.com [216.135.246.227])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA2Dae008135
	for <linux-mips@oss.sgi.com>; Fri, 2 Nov 2001 05:36:43 -0800
Received: from [192.168.1.170] (192.168.1.170 [192.168.1.170]) by mail.ivivity.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2448.0)
	id QMJCNXXF; Fri, 2 Nov 2001 08:36:31 -0500
Subject: BE Toolchain
From: Marc Karasek <marc_karasek@ivivity.com>
To: Linux MIPS <linux-mips@oss.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.18.15.19 (Preview Release)
Date: 02 Nov 2001 08:37:28 -0500
Message-Id: <1004708261.31067.6.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Has anyone got the toolchain (binutils, gcc, glibc) to compile under
BE?  I followed the instructions at Bradley D. LaRonde has put together
and got the LE to work w/o a prolem.  I then proceeded to try the BE. 
Binutils compiled ok, gcc says that mipseb-linux is not a valid target. 
Looking in config.sub I saw a mips-linux, is this the BE option?  

Thanks,

-- 
/*************************
Marc Karasek
Sr. Firmware Engineer
iVivity Inc.
marc_karasek@ivivity.com
(770) 986-8925
(770) 986-8926 Fax
*************************/
