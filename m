Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 May 2009 16:17:23 +0100 (BST)
Received: from mms1.broadcom.com ([216.31.210.17]:2681 "EHLO mms1.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S28574141AbZEAPRQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 1 May 2009 16:17:16 +0100
Received: from [10.9.200.131] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Fri, 01 May 2009 08:16:55 -0700
X-Server-Uuid: 02CED230-5797-4B57-9875-D5D2FEE4708A
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.1.358.0; Fri, 1 May 2009 08:16:55 -0700
Received: from [10.28.6.13] (lab-mhtb-013.ne.broadcom.com [10.28.6.13])
 by mail-irva-13.broadcom.com (Postfix) with ESMTP id CB6AB74D03; Fri, 1
 May 2009 08:16:54 -0700 (PDT)
Subject: Re: kernel for a Broadcom Swarm board
From:	"Jon Fraser" <jfraser@broadcom.com>
Reply-to: jfraser@broadcom.com
To:	"luk@debian.org" <luk@debian.org>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
cc:	jfraser@broadcom.com
In-Reply-To: <49FA27FA.3070408@debian.org>
References: <49FA27FA.3070408@debian.org>
Organization: Broadcom
Date:	Fri, 1 May 2009 11:16:53 -0400
Message-ID: <1241191013.15448.218.camel@chaos.ne.broadcom.com>
MIME-Version: 1.0
X-Mailer: Evolution 2.12.3 (2.12.3-5.fc8)
X-WSS-ID: 65E5CDED3BW7901537-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jfraser@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jfraser@broadcom.com
Precedence: bulk
X-list: linux-mips


On Thu, 2009-04-30 at 15:36 -0700, Luk Claes wrote:
> Hi
> 
>  > | [    0.000000] Broadcom SiByte BCM1250 B2 @ 800 MHz (SB1 rev 2)
>  > | [    0.000000] Board type: SiByte BCM91250A (SWARM)
>  > | [    0.000000] This kernel optimized for board runs with CFE
>  > | [    0.000000] Determined physical RAM map:
>  > | [    0.000000]  memory: 000000000fe47e00 @ 0000000000000000 (usable)
>  > | [    0.000000] Initrd not found or empty - disabling initrd
>  > | [    0.000000] Zone PFN ranges:
>  > | [    0.000000]   DMA32    0x00000000 -> 0x00100000
>  > | [    0.000000]   Normal   0x00100000 -> 0x00100000
>  > | [    0.000000] Movable zone start PFN for each node
>  > | [    0.000000] early_node_map[1] active PFN ranges
>  > | [    0.000000]     0: 0x00000000 -> 0x0000fe47
>  > | [    0.000000] Detected 1 available secondary CPU(s)
>  > | [    0.000000] Built 1 zonelists in Zone order, mobility grouping 
> on.  Total
>  > pages: 64205
>  > | [    0.000000] Kernel command line: root=/dev/hdc1 console=duart0
>  > | [    0.000000] Primary instruction cache 32kB, VIVT, 4-way, 
> linesize 32 bytes.
>  > | [    0.000000] Primary data cache 32kB, 4-way, PIPT, no aliases, 
> linesize 32
>  > bytes
>  > | [    0.000000] PID hash table entries: 1024 (order: 10, 8192 bytes)
>  >
>  > And then it hangs...
> 
> The zeros look like there are no timing interrupts happening. It's a 
> pity we don't have hardware to test which kernel version introduced the 
> bug (for instance with git-bisect and reboots).
> 
> Cheers
> 
> Luk
> 

Try turning off SMP.  I have a 1480 (big sur) board.  I just tried
2.6.28.9.  This is 32 bit, little endian mode.  With SMP turned on,
it hung in the same place.  With SMP turned off, it booted fine.


Jon Fraser
Broadcom

> 
