Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3C7T58d029356
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Apr 2002 00:29:05 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3C7T5bp029355
	for linux-mips-outgoing; Fri, 12 Apr 2002 00:29:05 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from libra.seed.net.tw (libra.seed.net.tw [192.72.81.214])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3C7T08d029351
	for <linux-mips@oss.sgi.com>; Fri, 12 Apr 2002 00:29:01 -0700
Received: from sw59-226-127.adsl.seed.net.tw ([61.59.226.127] helo=libra.seed.net.tw)
	by libra.seed.net.tw with esmtp (Seednet MTA build 20010831)
	id 16vvV0-0003az-00
	for linux-mips@oss.sgi.com; Fri, 12 Apr 2002 15:29:34 +0800
Message-ID: <3CB68CC8.1050207@libra.seed.net.tw>
Date: Fri, 12 Apr 2002 15:29:12 +0800
From: Tim Wu <chtimwu@libra.seed.net.tw>
Reply-To: chtimwu@libra.seed.net.tw
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-mips <linux-mips@oss.sgi.com>
Subject: LEXRA MIPS
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi, everybody:
I'm working on porting Linux to a MIPS based processor whose IP is from 
Lexra's LX4189 processor.

I started my work from the linux MIPS port of oss.sgi.com.  Right now 
the kernel can boot and run some user applications well.

But I met a problem that once a process raises any kind of signal, 
kernel will send a SIGILL signal to the process which let the process stop.

I traced the kernel source and found SIGILL is sent by the exception 
handler, do_ri().

The problem is very weird because when I change to another crosscompiler 
or insert some asserting code to functions in signal.c.  The kernel 
become unbootable.  I hope someone can give me directions to solve this 
bug or tell me who already done Linux on Lexra?


kernel version:2.4.17.
toolchain: GCC 3.1 from ftp.cotw.com.
use new IRQ and new timer interface.
