Received:  by oss.sgi.com id <S42248AbQI2CgA>;
	Thu, 28 Sep 2000 19:36:00 -0700
Received: from [206.207.108.63] ([206.207.108.63]:46438 "HELO
        ridgerun-lx.ridgerun.cxm") by oss.sgi.com with SMTP
	id <S42190AbQI2Cf2>; Thu, 28 Sep 2000 19:35:28 -0700
Received: (qmail 23506 invoked from network); 28 Sep 2000 20:35:17 -0600
Received: from glonnon-lx.ridgerun.cxm (HELO ridgerun.com) (glonnon@192.168.1.16)
  by ridgerun-lx.ridgerun.cxm with SMTP; 28 Sep 2000 20:35:17 -0600
Message-ID: <39D3FFE4.35E83599@ridgerun.com>
Date:   Thu, 28 Sep 2000 20:35:16 -0600
From:   Greg Lonnon <glonnon@ridgerun.com>
Reply-To: glonnon@ridgerun.com
Organization: RidgeRun, Inc
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: problems execve("/sbin/init",...)
Content-Type: multipart/mixed;
 boundary="------------3E5CEB9855DD8FC5A1452D82"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------3E5CEB9855DD8FC5A1452D82
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

I am trying to port linux-2.2.14/MIPS to a new board containing a QED
R5271 MIPS processor.  I am having problems with execve("/sbin/init,...)
in init/main.c.  The "/sbin/init" is not being called by the kernel.  I
am nfs root mounting the "simple" filesystem during the kernel boot, and
the network and nfs mount seem to be working (I have read and printk'ed
/etc/rc at the end of main.c::init()).

Things I have tried to debug with:
1) Have written a small tcp/ip server to accept a socket connection,
have execve this instead of "/sbin/init".  The server will not accept
connections.  Thus, I believe it's not running.
2) Have statically linked the server and have instrumented binfmt_elf.c
and fs/exec.c with debug.  The loader seems be working correctly, and
arch/mips/kernel/process.c::start_thread(...) is called with the
corrected pc and sp. The pc is the entry point in the elf file and the
sp is 0x7ffff90.

Some printk debug from binfmt_elf.c:
(start_brk) 10004e04
(end_code) 4782a0
(start_code) 400000
(end_data) 10003dbc
(start_stack) 7fffff90
(brk) 10004e04
start theard pc 400140 sp 7fffff90

3) Have been trying to get printk support into system calls by rewriting
read_write.c::sys_write (and friends) to do a printk() at the start of
the call.  I have written a statically linked program that calls
write(0,"here",4).  This didn't result in printk output.  I would
suspect that the program is not being correctly execve.

So, my questions are:
1) Does anyone have a good way to debug in this small window going
between kernel mode and user mode for the first time?
2) Is there anything else I could try to prove out that the kernel is
going into user mode?
3) Has anyone else had these issues?

My command_line is: 
console=ttyS0,115200 root=/dev/nfs
nfsroot=192.168.1.12:/projects/mips/fs ip=192.168.1.211:192.168.1.1:::::

Also, My /dev/console is pointing to /dev/ttyS0 and it seems to be dead,
I can't printf() to stdout.

Thanks,
Greg
-- 
Greg Lonnon                     mailto:glonnon@ridgerun.com
--------------3E5CEB9855DD8FC5A1452D82
Content-Type: text/x-vcard; charset=us-ascii;
 name="glonnon.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Greg Lonnon
Content-Disposition: attachment;
 filename="glonnon.vcf"

begin:vcard 
n:Lonnon;Greg
tel;fax:208-331-2227
tel;home:208-323-1724
tel;work:208-331-2226 ext 18
x-mozilla-html:FALSE
url:www.ridgerun.com
org:RidgeRun, Inc
version:2.1
email;internet:glonnon@ridgerun.com
title:Senior Kernel Developer
adr;quoted-printable:;;200 N. 4th Street	=0D=0ASuite 101;Boise;ID;83702;USA
x-mozilla-cpt:;-7104
fn:Greg Lonnon
end:vcard

--------------3E5CEB9855DD8FC5A1452D82--
