Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 May 2004 16:56:02 +0100 (BST)
Received: from uswgco35.uswest.com ([IPv6:::ffff:199.168.32.124]:52464 "EHLO
	uswgco35.uswest.com") by linux-mips.org with ESMTP
	id <S8225474AbUEQP4A>; Mon, 17 May 2004 16:56:00 +0100
Received: from egate-co2.uswc.uswest.com (egate-co2.uswc.uswest.com [151.119.214.10])
	by uswgco35.uswest.com (8/8) with ESMTP id i4HFtvfB009879
	for <linux-mips@linux-mips.org>; Mon, 17 May 2004 09:55:58 -0600 (MDT)
Received: from wopr.qwest.net (localhost [127.0.0.1])
	by egate-co2.uswc.uswest.com (8.12.10/8.12.10) with ESMTP id i4HFtuOR025432
	for <linux-mips@linux-mips.org>; Mon, 17 May 2004 09:55:56 -0600 (MDT)
Received: from cyberMalex.com (igate.qwest.net [10.8.16.41])
	by wopr.qwest.net (8.11.2/8.8.7) with ESMTP id i4HFttH22496
	for <linux-mips@linux-mips.org>; Mon, 17 May 2004 11:55:56 -0400
Message-ID: <40A8E08B.7070203@cyberMalex.com>
Date: Mon, 17 May 2004 11:55:55 -0400
From: Alexander Markley <alex@cyberMalex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031009
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: SGI O2 MIPS R5000 bootp problems
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <alex@cyberMalex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5047
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@cyberMalex.com
Precedence: bulk
X-list: linux-mips

Hi. I just get an SGI O2 with a MIPS R5000 chip in it, and I'd love to 
run linux on it. The machine seems to be in working order, and has been 
known to boot into IRIX in the recent past.

I have gotten the debian tftp boot images and things, and have properly 
set up dhcp and tftp, but I cannot make this machine boot!

...
 > boot f bootp():r5000_boot.img
Setting $netaddr to 192.168.1.235 (from server )
Obtaining r5000_boot.img from server
7536
Cannot load bootp():r5000_boot.img.
Range check failure: text start 0x88802000, size 0x1d70.
Text section would overwrite an already loaded program.Unable to execute 
bootp():r5000_boot.img:  not enough space
Unable to load bootp():r5000_boot.img: not enough space
 >
...

I'm not sure why this doesn't work for me when it works for everyone 
else... Is it because my machine only has 64 MB of ram?

Another strange bit is that this kernel does load and boot fine: 
http://www.linux-mips.org/~glaurung/O2/linux-2.6.1/kernel/vmlinux64

Of course, it can't finish booting since I didn't provide a root FS, but 
I wonder why the PROM doesn't want to jump to the debian image?

I'll keep trying different things, and keep you guys posted. In the 
meantime, and input would be much appriciated. Also, I haven't joined 
the list, so CCing me would also be appriciated.

ttyl
--Alex
