Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4I6aLnC026863
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 17 May 2002 23:36:21 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4I6aLuI026862
	for linux-mips-outgoing; Fri, 17 May 2002 23:36:21 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from kraid.nerim.net (kraid.nerim.net [62.4.16.95])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4I6aDnC026859
	for <linux-mips@oss.sgi.com>; Fri, 17 May 2002 23:36:13 -0700
Received: from free.fr (aboukir-101-1-18-ericleboeuf.adsl.nerim.net [62.212.106.189])
	by kraid.nerim.net (Postfix) with ESMTP id AF71540EF3
	for <linux-mips@oss.sgi.com>; Fri, 17 May 2002 22:09:18 +0200 (CEST)
Message-ID: <3CE5649A.5080206@free.fr>
Date: Fri, 17 May 2002 22:14:18 +0200
From: Eric LEBOEUF <eric.leboeuf@free.fr>
Reply-To: eric.leboeuf@free.fr
Organization: MDS Forever
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: French [fr],en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Kernel snapshot ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello everybody,

I'm trying to get my indy to boot linux, but I've got some problem.

When I do compile my own kernel, it crash with this message:

----------------------------------------------------------------------

sda:<1>Unable to handle kernel paging request at virtual address 
00000000, epc == 880e7f3c, ra == 880e8120
Oops in fault.c:do_page_fault, line 205:
$0 : 00000000 1004cc00 bfbc0007 0000000b bfbc0003 bfbc0007 00000025 00000019
$8 : 88674a00 88596c80 00000001 886c25a0 00001000 00000001 00000050 00000000
$16: 00000000 bfbc0007 00000400 00000001 00000049 0000003a 1004cc00 88596c00
$24: 00000004 88596e18                   881a2000 881a3c88 00000001 880e8120
Hi : 00000000
Lo : 00000500
epc  : 880e7f3c    Not tainted
Status: 1004cc02
Cause : 0000000c
Proccess swapper (pid: 0, stackpage=881a2000)
Stack: bfbc0003 bfbc0007 00000001 88019c74 bfbc0003 bfbc0007 4748494a 
4b4c4d4e
        bfbc0003 bfbc0007 00000be0 0000003e bfbc0003 bfbc0007 881d654a 
00000002
        bfbc0007 88674a00 88596c80 00000001 880e8120 880e80f0 bfbc0003 
bfbc0007
        0000000c 0000003e 00000001 88596c80 bfbc0003 bfbc0007 88596c80 
00000080
        00000016 00000060 1004cc00 88596c80 00000001 8800b114 00000000 
00000000
        bfbc0003 ...
Call Trace: [<88019c74>] [<880e8120>] [<880e80f0>] [<8800b114>] 
[<880dee54>] [<880e86a4>]
[<880e9584>] [<8802386c>] [<880ddfe8>] [<880e7150>] [<880df1b4>] 
[<880def28>]
[<88018c90>] [<8800a48c>] [<88000d30>] [<880bd6fc>] [<8800b810>] 
[<880be218>]
[<880be200>] [<8800c024>] [<88005208>] [<880051dc>] [<8800280c>] 
[<88165480>]
[<88166dac>] [<880027d8>]

Code 00000000 0fa20034 90430000 <a2030000> 26100001 30c20080 1040ffe9 
8fbf0050 0a039ff8
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

-----------------------------------------------------------------------

I did get a 2.4.1 kernel, which works, but do not have good support for 
scsi disks. How can I do to compile my how kernel ?

I've got the toolchain-20020423-1.i386.rpm on a RedHat 7.3

Thanks a lot !


Eric LEBOEUF
