Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Sep 2006 01:24:36 +0100 (BST)
Received: from web31504.mail.mud.yahoo.com ([68.142.198.133]:32110 "HELO
	web31504.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20038771AbWIWAYe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 23 Sep 2006 01:24:34 +0100
Received: (qmail 64161 invoked by uid 60001); 23 Sep 2006 00:24:27 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=HAZGmR89FlCWn1AVdiEmU3jkfL3kKGrRKLAWr2hVqG5loL44MnySUh8/zAfrT2KIkV04ZkclgA00QcPVdIwYtq4/FQaGhYA4u6cuWIN7I3DDH10Nr7t4E+t6erlU2o3Hclz9Yf03TMZ7Ljg7qLq2CblsMT2twRc3VPu6q1bI43M=  ;
Message-ID: <20060923002427.64159.qmail@web31504.mail.mud.yahoo.com>
Received: from [70.103.67.194] by web31504.mail.mud.yahoo.com via HTTP; Fri, 22 Sep 2006 17:24:27 PDT
Date:	Fri, 22 Sep 2006 17:24:27 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: 64K page patch hiccup on SB1
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12633
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi, tried using the 64K page patch with the latest GIT
repository. Everything runs fine. It brings up all the
networking code OK, the bonding driver warning is
perfectly normal, and then it throws a wobbly. Any
ideas?



Ethernet Channel Bonding Driver: v3.0.3 (March 23,
2006)
bonding: Warning: either miimon or arp_interval and
arp_ip_target module parameters must be specified,
otherwise bonding will not detect link failures! see .
Unhandled kernel unaligned access[#1]:
Cpu 1
$ 0   : 0000000000000000 ffffffff80458930
0000000000000000 0000000000000000
$ 4   : 038dffff8012972c ffffffff8cc40004
ffffffff80126dec 0000000000000000
$ 8   : a8000000006efbd0 0000000000000000
0000000000000001 0000000080570108
$12   : 0000000014001fe0 000000001000001e
0000000000100100 a80000000f938900
$16   : 0000000000000000 a8000000006efbd0
0000000000000001 0000000000000000
$20   : 0000000000000000 0000000000000000
0000000000000003 0000000000000000
$24   : 0000000000000000 0000000000000000             
                    
$28   : a8000000006e0000 a8000000006efba0
0000000000000000 ffffffff80102d38
Hi    : 0000000000000000
Lo    : 0000000000000007
epc   : ffffffff8010a11c     Not tainted
ra    : ffffffff80102d38 Status: 14001fe2    KX SX UX
KERNEL EXL 
Cause : 00800010
BadVA : 038dffff8012972c
PrId  : 03040102
Modules linked in:
Process swapper (pid: 1, threadinfo=a8000000006e0000,
task=a8000000006d4438)
Stack : 0000000000000000 a8000000006efd40
0000000000000001 a80000000fe83928
        ffffffff80102d38 0000000000010000
0000000000000000 0000000014001fe0
        038dffff8012972c 0000000000000000
0000000000000000 0000000000000003
        038dffff80129728 0000000000000000
a8000000006efd40 0000000000000000
        0000000000000001 0000000080570108
0000000014001fe0 000000001000001e
        0000000000100100 a80000000f938900
0000000000000000 a8000000006efd40
        0000000000000001 a80000000fe83928
0000000000000000 0000000000000000
        0000000000000003 0000000000000000
0000000000000000 0000000000000000
        a80000000fc540e0 ffffffff80478b98
a8000000006e0000 a8000000006efd00
        0000000000000000 ffffffff8010a020
0000000014001fe2 0000000000000000
        ...
Call
Trace:[<ffffffff80102d38>][<ffffffff8010a020>][<ffffffff80126dec>][<ffffffff8010a020>][<ffffffff80102d38>][<ffffffff801273e0>][<ffffffff8012a7dc>][<fff]

Code: 00431024  14400080  00000000 <88830000> 98830003
 24020000  08042857  00000000  64820002 
Kernel panic - not syncing: Attempted to kill init!


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
