Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jul 2004 19:50:12 +0100 (BST)
Received: from bay2-f21.bay2.hotmail.com ([IPv6:::ffff:65.54.247.21]:24582
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225302AbUGISuI>; Fri, 9 Jul 2004 19:50:08 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Fri, 9 Jul 2004 11:50:00 -0700
Received: from 209.243.128.191 by by2fd.bay2.hotmail.msn.com with HTTP;
	Fri, 09 Jul 2004 18:50:00 GMT
X-Originating-IP: [209.243.128.191]
X-Originating-Email: [theansweriz42@hotmail.com]
X-Sender: theansweriz42@hotmail.com
From: "S C" <theansweriz42@hotmail.com>
To: linux-mips@linux-mips.org
Subject: Strange, strange occurence
Date: Fri, 09 Jul 2004 18:50:00 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY2-F21njXXBARdkfw0003b0c8@hotmail.com>
X-OriginalArrivalTime: 09 Jul 2004 18:50:00.0703 (UTC) FILETIME=[89CCC0F0:01C465E5]
Return-Path: <theansweriz42@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: theansweriz42@hotmail.com
Precedence: bulk
X-list: linux-mips

Well I'm hoping it isn't so strange to some of you folks and you'll be able 
to tell what's going on :)

Here's my problem:

Using MontaVista Linux 3.1 on a Toshiba RBTx4938 board. Using YAMON, when I 
download the kernel via the debug ethernet port it runs fine. If I download 
the kernel via the Tx4938 inbuilt ethernet controller, it crashes!

Memory checksumming and a quick manual memory dump inspection reveals that 
the kernel download went perfectly ok, and the image is completely and 
correctly downloaded to RAM.

The crash is occuring inside the function r4k_flush_icache_range().

I tried 'flush -i' and 'flush -d' on YAMON after the download but before the 
'go', but that didn't help. I also tried completely disabling caches and 
loading/running uncached, but it gave the same error.

Now, the final twist! Using an ICE, I set a breakpoint at the 
r4k_flush_icache_range function. Then I loaded the kernel as usual, ran it 
with the ICE, stepped through a few instructions inside the 
r4k_flush_icache_range function and then did a 'cont'. The kernel now booted 
fine!

If I don't set the breakpoint inside that function though, and just try to 
run with the ICE the same
error (Inst fetch/Load error) occurs.

I'm at a loss trying to figure out what's going on. I suspect it has 
something to do with caches perhaps (duh!), but have no clue what!  Anybody 
out there face a similar kind of a situation before?

Thanks in advance for any help offered.

Regards,
-Steve

_________________________________________________________________
MSN 9 Dial-up Internet Access helps fight spam and pop-ups – now 2 months 
FREE! http://join.msn.click-url.com/go/onm00200361ave/direct/01/
