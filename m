Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1RK15F14200
	for linux-mips-outgoing; Wed, 27 Feb 2002 12:01:05 -0800
Received: from gda-server ([202.88.152.146])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1RK10914191
	for <linux-mips@oss.sgi.com>; Wed, 27 Feb 2002 12:01:01 -0800
Received: from [192.168.0.186] by gda-server
  (ArGoSoft Mail Server, Version 1.5 (1.5.0.8)); Thu, 28 Feb 2002 00:33:43 
Message-ID: <3C7DD53B.754E4BCD@gdatech.co.in>
Date: Thu, 28 Feb 2002 12:29:07 +0530
From: santhosh <ps.santhosh@gdatech.co.in>
Organization: gdatech
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Error Linux Krenel for SWARM (SB1250) 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


I have a got a error  when I build  linux kernel for SWARM
board(SB1250).
 send  a query to solve..


[root@gda_Santhosh kernel]# gmake vmlinux

mips-linux-gcc -I /home/revathy/linux/src/kernel/include/asm/gcc
-D__KERNEL__ -I/home/revathy/linux/src/kernel/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -G 0 -mno-abicalls -fno-pic -mcpu=sb1
-mips2 -Wa,--trap -pipe   -c -o init/main.o init/main.c
Assembler messages:
Error: invalid architecture -mcpu=sb1
cc1: bad value (sb1) for -mcpu= switch
init/main.c:198: output pipe has been closed
cpp: output pipe has been closed
gmake: *** [init/main.o] Error 1
