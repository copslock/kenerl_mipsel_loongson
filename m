Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Apr 2009 23:30:50 +0100 (BST)
Received: from ugmailsa.ugent.be ([157.193.49.116]:53755 "EHLO
	ugmailsa.ugent.be" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20026805AbZD3Wao (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Apr 2009 23:30:44 +0100
Received: from localhost (localhost [127.0.0.1])
	by ugmailsa.ugent.be (Postfix) with ESMTP id 501AC306D6E
	for <linux-mips@linux-mips.org>; Fri,  1 May 2009 00:30:43 +0200 (CEST)
X-Virus-Scanned: by UGent DICT
Received: from ugmailsa.ugent.be ([127.0.0.1])
	by localhost (ugmailsa.ugent.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X58YcosGktVo for <linux-mips@linux-mips.org>;
	Fri,  1 May 2009 00:30:43 +0200 (CEST)
Received: from cedar.ugent.be (cedar.ugent.be [157.193.49.14])
	by ugmailsa.ugent.be (Postfix) with ESMTP id EDEA8306985
	for <linux-mips@linux-mips.org>; Fri,  1 May 2009 00:30:42 +0200 (CEST)
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AkMCAL/D+UlXkpPu/2dsb2JhbAAI0FCDfwU
Received: from p579293ee.dip.t-dialin.net (HELO [192.168.1.168]) ([87.146.147.238])
  by smtps9.UGent.be with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 May 2009 00:30:30 +0200
Message-ID: <49FA27FA.3070408@debian.org>
Date:	Fri, 01 May 2009 00:36:42 +0200
From:	Luk Claes <luk@debian.org>
Reply-To: luk@debian.org, linux-mips@linux-mips.org
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: kernel for a Broadcom Swarm board
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <luk@debian.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luk@debian.org
Precedence: bulk
X-list: linux-mips

Hi

 > | [    0.000000] Broadcom SiByte BCM1250 B2 @ 800 MHz (SB1 rev 2)
 > | [    0.000000] Board type: SiByte BCM91250A (SWARM)
 > | [    0.000000] This kernel optimized for board runs with CFE
 > | [    0.000000] Determined physical RAM map:
 > | [    0.000000]  memory: 000000000fe47e00 @ 0000000000000000 (usable)
 > | [    0.000000] Initrd not found or empty - disabling initrd
 > | [    0.000000] Zone PFN ranges:
 > | [    0.000000]   DMA32    0x00000000 -> 0x00100000
 > | [    0.000000]   Normal   0x00100000 -> 0x00100000
 > | [    0.000000] Movable zone start PFN for each node
 > | [    0.000000] early_node_map[1] active PFN ranges
 > | [    0.000000]     0: 0x00000000 -> 0x0000fe47
 > | [    0.000000] Detected 1 available secondary CPU(s)
 > | [    0.000000] Built 1 zonelists in Zone order, mobility grouping 
on.  Total
 > pages: 64205
 > | [    0.000000] Kernel command line: root=/dev/hdc1 console=duart0
 > | [    0.000000] Primary instruction cache 32kB, VIVT, 4-way, 
linesize 32 bytes.
 > | [    0.000000] Primary data cache 32kB, 4-way, PIPT, no aliases, 
linesize 32
 > bytes
 > | [    0.000000] PID hash table entries: 1024 (order: 10, 8192 bytes)
 >
 > And then it hangs...

The zeros look like there are no timing interrupts happening. It's a 
pity we don't have hardware to test which kernel version introduced the 
bug (for instance with git-bisect and reboots).

Cheers

Luk
