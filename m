Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6J0XCRw011389
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 18 Jul 2002 17:33:12 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6J0XCCM011388
	for linux-mips-outgoing; Thu, 18 Jul 2002 17:33:12 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6J0X1Rw011379
	for <linux-mips@oss.sgi.com>; Thu, 18 Jul 2002 17:33:01 -0700
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA04332
	for <linux-mips@oss.sgi.com>; Thu, 18 Jul 2002 17:34:06 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id RAA06976;
	Thu, 18 Jul 2002 17:28:31 -0700
Message-ID: <3D375B4C.9000403@mvista.com>
Date: Thu, 18 Jul 2002 17:20:28 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Malta bus error
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I got the following bus error on Malta.  Does anybody know what causes the 
fault?  Is there anyway to disable the error?  Or we should install a malta 
bus_error_handler() to discard this kind of error?

Apparently the error has something to do with the code layout as it only 
happens when I start to modify an unrelated function( do_ri()).

I am using the latest linux_2_4 branch from oss.sgi.com CVS tree.

Jun

----------------

Loading modules:
modprobe: Can't open dependencies file /lib/modules/2.4.19-rc1/modules.dep (No s
uch file or directory)
Mounting local filesystems...
nothing was mounted
Cleaning: /etc/network/ifstate.
Data bus error, epc == 8021b600, ra == 8013ea80
Oops in traps.c::do_be, line 459:
$0 : 00000000 802f601e 802f601e 00000000 83ffffe0 802f6002 0000000c 802f601e
$8 : 00006374 00002e63 00000002 6374652f 66690a0a 00000080 80355d48 2d205b20
$16: 0000001e 83ffffde 00000fde 0000001e 802f6000 0001ffde 00000001 80355ee0
$24: 0000000c 00000080                   80354000 80355d50 00000000 8013ea80
Hi : fffd000c
Lo : 0000fffc
epc  : 8021b600    Not tainted
Status: 1000fc03
Cause : 0080201c
Process rcS (pid: 43, stackpage=80354000)
Stack: 80355e38 00000000 ffffffff 800028a0 80355ee4 10014408 ffffffff 00000080
        802f6000 10014408 10019028 80355f30 00000000 10016da8 00000000 8013eb04
        00000001 00000000 80355db8 802f6000 80355e38 8013fae0 8026d974 8026dbb0
        000001d2 80005260 622f2123 732f6e69 0a230a68 74732023 2f747261 706f7473
        74656e20 6b726f77 20676e69 6d656164 2e736e6f 230a230a 6b686320 666e6f63
        203a6769 ...
Call Trace:
Code: 98a80000  98a90004  24c6fff0 <88a80003> 88a90007  98aa0008  98ab000c  88aa
000b  88ab000f
CoreHI interrupt, shouldn't happen, so we die here!!!



--------------------------

ffffffff8021b5e0 <src_unaligned_dst_aligned>:
ffffffff8021b5e0:       00064102        srl     $t0,$a2,0x4
ffffffff8021b5e4:       cca00060        lwc3    $0,96($a1)
ffffffff8021b5e8:       11000014        beqz    $t0,ffffffff8021b63c <cleanup_sr
c_unaligned>
ffffffff8021b5ec:       30d8000f        andi    $t8,$a2,0xf
ffffffff8021b5f0:       cc810060        lwc3    $1,96($a0)
ffffffff8021b5f4:       98a80000        lwr     $t0,0($a1)
ffffffff8021b5f8:       98a90004        lwr     $t1,4($a1)
ffffffff8021b5fc:       24c6fff0        addiu   $a2,$a2,-16
ffffffff8021b600:       88a80003        lwl     $t0,3($a1)
ffffffff8021b604:       88a90007        lwl     $t1,7($a1)
ffffffff8021b608:       98aa0008        lwr     $t2,8($a1)
ffffffff8021b60c:       98ab000c        lwr     $t3,12($a1)
ffffffff8021b610:       88aa000b        lwl     $t2,11($a1)
ffffffff8021b614:       88ab000f        lwl     $t3,15($a1)
ffffffff8021b618:       cca00120        lwc3    $0,288($a1)
ffffffff8021b61c:       24a50010        addiu   $a1,$a1,16
ffffffff8021b620:       ac880000        sw      $t0,0($a0)
ffffffff8021b624:       ac890004        sw      $t1,4($a0)
ffffffff8021b628:       ac8a0008        sw      $t2,8($a0)
ffffffff8021b62c:       ac8b000c        sw      $t3,12($a0)
ffffffff8021b630:       cc810120        lwc3    $1,288($a0)
