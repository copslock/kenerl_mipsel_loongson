Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA1EVXF10499
	for linux-mips-outgoing; Thu, 1 Nov 2001 06:31:33 -0800
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA1EVK010495
	for <linux-mips@oss.sgi.com>; Thu, 1 Nov 2001 06:31:20 -0800
Received: from dsl73.cedar-rapids.net ([208.242.241.39] helo=cotw.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 15zIsD-0003dc-00
	for <linux-mips@oss.sgi.com>; Thu, 01 Nov 2001 08:31:13 -0600
Message-ID: <3BE15781.73CE64DD@cotw.com>
Date: Thu, 01 Nov 2001 09:09:05 -0500
From: Scott A McConnell <samcconn@cotw.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-xfs-1.0.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: [Fwd: Kernel panic: Caught reserved exception - should not happen.]
Content-Type: multipart/mixed;
 boundary="------------ADB0632E565DF3CC166F4D23"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------ADB0632E565DF3CC166F4D23
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


-- 
Scott A. McConnell
--------------ADB0632E565DF3CC166F4D23
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

X-Mozilla-Status2: 00000000
Message-ID: <3BE156C0.BD98845D@cotw.com>
Date: Thu, 01 Nov 2001 09:05:52 -0500
From: Scott A McConnell <samcconn@cotw.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-xfs-1.0.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
Subject: Re: Kernel panic: Caught reserved exception - should not happen.
References: <3BE07787.5FF7DB8A@cotw.com> <3BE08194.35FBCB82@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Jun Sun wrote:
> 
> Scott A McConnell wrote:
> >
> > I have been getting a fair amount of the above type of errors when
> > compiling on a mipsel box.
> >
> > 2.4.5 kernel on a NEC VR5432 box. Anyone aware of known problems?
> >
> 
> What is the exception vector?  Is it the "watch exception"?

No it is not a watch exception it appears to always be an Interrupt
exception.

I am running the ltp tests.

Status is always 9001f003 and the cause is always 00002000.

epc always points to 80014570 which is in:

ffffffff8001451c T pgd_init
ffffffff80014560 T update_mmu_cache     <------------
ffffffff800146d0 T show_regs

Sometimes my kernel reboots and sometimes it continues on. I get the
error when compiling and also when doing make clean. So just about
anything will make it happen

make[4]: Entering directory `/opt/ltp/testcases/kernel/syscalls/getpgrp'
cc -o getpgrp01 getpgrp01.c -I../../../../include -L../../../../lib
-lltpGot reserved at 80014570.

$0 : 00000000 2ab042cc 81f83ca0 81f83ca0
$4 : 81a23720 2aaae734 2aaae734 00000000
$8 : 802a3510 1000001f 6ffffdff 70000053
$12: 6fffffff 00000063 2ab04268 7fff7510
$16: 8107d6c0 ffffffff 81a23720 81f86260
$20: 81e23ab8 2aaae734 81f83ca0 00000000
$24: 00000000 2aaae734
$28: 812f6000 812f7df8 7fff7420 8002a19c
epc   : 80014570
Status: 9001f003
Cause : 00002000
Kernel panic: Caught reserved exception - should not happen.
Rebooting in 180 seconds..


make[4]: Entering directory `/opt/ltp/testcases/kernel/syscalls/select'
cc -o select01 select01.c -I.Unhandled kernel unaligned access or
invalid instruction:$0 : 00000000 7fff7784 81f94da0 81f94da0
$4 : 813493e0 2aab59bc 2aab59bc 00000000
$8 : 802a3510 1000001f 7fff7720 2aaa84ac
$12: 7fff79f8 7fff79fc ffffffff 00000003
$16: 8107d940 ffffffff 813493e0 81f97260
$20: 81f7dad4 2aab59bc 81f94da0 00000000
$24: 7fff7a10 2aab59bc
$28: 812da000 812dbdf8 7fff76d8 8002a19c
epc   : 80014574
Status: 9001f003
Cause : 00002000
Process cc (pid: 5022, stackpage=812da000)
Stack: 813493e0 00000000 00000000 00000000 2ab041a8 1000001f 7fff7720
7fff7a9c
       01f65603 812dbe68 00000000 81f94da0 00000000 813493e0 2aab59bc
00000000
       00000000 00000097 8002a364 00000097 7fff7a10 2aaa9bc0 812dbe68
8001dd94
       81f7dad4 812dbe80 7fff5b98 8000fd98 812da000 81f94da0 81f94dbc
2aab59bc
       812dbf30 80012f8c 00000000 00000000 8118ab60 00000000 8001dc3c
00030002
       00000000 ...
Call Trace: [<8002a364>] [<8001dd94>] [<8000fd98>] [<80012f8c>]
[<8001dc3c>] [<8001da]Code: 14620055  00a03021  40025000 <00000000>
304700ff  40086000  00000000  35010001  ./../../../include
-L../../../../lib -lltp
make[4]: *** [select01] Segmentation fault

cc -o write01 write01.c -I../../../../include -L../../../../lib -lltp
Unhandled kernel unaligned access or invalid instruction in
unaligned.c:emulate_load_:$0 : 00000000 81ac1000 81f94e20 81f94e20
$4 : 819fc660 2ae55000 2ae55000 00000001
$8 : 1fffffff 1000001f 00000000 00000020
$12: 0000007e 2adfe0cc 00007000 10003b7c
$16: 8106b000 81f94e20 819fc660 81854954
$20: 2ae55000 2ae55000 81f94e20 00000001
$24: 00000000 2ace1c90
$28: 812e2000 812e3dc0 7fff7530 8002a03c
epc   : 80014574
Status: b001f003
Cause : 00008010
Process as (pid: 6081, stackpage=812e2000)
Stack: 00000000 00419cd0 81f9f460 00000089 01083603 01ac0717 01ac0613
8002a140
       00000000 81f94e20 819fc660 00000000 81854954 8002a230 819fc420
00008000
       00000000 806778c0 2ae55000 10002b7c 812e3eb0 80851ad8 0155f603
8002e184
       00000000 81f94e20 00000001 819fc660 2ae55000 00000001 100029ec
00000020
       8002a364 00989680 00000048 1000a3d0 14003fff 00000001 81854954
0007f000
       2ae07000 ...
Call Trace: [<8002a140>] [<8002a230>] [<8002e184>] [<8002a364>]
[<8002b6d8>] [<80012f]Code: 14620055  00a03021  40025000 <00000000>
304700ff  40086000  00000000  35010001  cc: Internal error: Segmentation
fault (program as)
Please submit a full bug report.
See <URL:http://bugzilla.redhat.com/bugzilla/> for instructions.
make[4]: *** [write01] Error 1


-- 
Scott A. McConnell

--------------ADB0632E565DF3CC166F4D23--
