Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6JMjjRw030767
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 19 Jul 2002 15:45:45 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6JMjj3s030766
	for linux-mips-outgoing; Fri, 19 Jul 2002 15:45:45 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6JMjdRw030757
	for <linux-mips@oss.sgi.com>; Fri, 19 Jul 2002 15:45:39 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id PAA05399;
	Fri, 19 Jul 2002 15:46:14 -0700
Message-ID: <3D3894CD.5000609@mvista.com>
Date: Fri, 19 Jul 2002 15:38:05 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: CoreHI interrupts on Malta
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

After shuffling some lines of printk(), etc, I suddenly get the following 
panics.  Anybody knows what they are?  They seems to be recursive, BTW.

If the interrupts really shouldn't happen, we probably should just disable IP5.

Jun

Loading modules:
modprobe: Can't open dependencies file /lib/modules/2.4.19-rc1/modules.dep (No )
CoreHI interrupt, shouldn't happen, so we die here!!!
epc   : 80108a00
Status: 1000fc03
Cause : 00802000
badVaddr : 00000000
GT_INTRCAUSE = 43e00009
GT_CPU_ERR_ADDR = 0204000028
CoreHi interrupt in malta_int.c::corehi_irqdispatch, line 285:
$0 : 00000000 7fff62e8 00000000 7fff63e8 7fff6308 83ffff28 00000000 83f3c364
$8 : 00000000 00000000 00000000 00000000 00000000 7fff62c8 00000000 00000000
$16: 7fff63c0 00000018 00000000 10013a88 00000000 ffffffff 00000000 10015188
$24: 00000000 00000018                   83ffe000 83ffff30 00000008 801089e8
Hi : 00000000
Lo : 00000020
epc  : 80108a00    Not tainted
Status: 1000fc03
Cause : 00802000
Process rcS (pid: 32, stackpage=83ffe000)
Stack: ffffffff 7fff6498 7fff6518 00000000 00000001 00000000 00000000 802c0000
        00001062 00000000 00000018 7fff62c8 7fff62e8 00000000 0000fc00 2ad44404
        00000000 00000000 00000000 7fff64a0 00000000 00000000 00000000 00000020
        00000000 10013a88 00000000 ffffffff 00000000 10015188 00000000 2acb0870
        00000010 00000000 2ae22db0 7fff62b0 00000008 2acaec84 00000020 00000000
        2acb0884 ...
Call Trace:
Code: afa80034  00021023  afa20018 <afa20020> 40086000  00000000  35080001  390
CoreHI interrupt, shouldn't happen, so we die here!!!
....
