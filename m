Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Nov 2006 11:31:46 +0000 (GMT)
Received: from rex.snapgear.com ([203.143.235.140]:13700 "EHLO
	cyberguard.com.au") by ftp.linux-mips.org with ESMTP
	id S20037841AbWKTLbm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Nov 2006 11:31:42 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by hex.internal.moreton.com.au (Postfix) with ESMTP id 331B5EBA59
	for <linux-mips@linux-mips.org>; Mon, 20 Nov 2006 21:31:33 +1000 (EST)
Received: from hex.internal.moreton.com.au ([127.0.0.1])
	by localhost (bne.snapgear.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 22815-10 for <linux-mips@linux-mips.org>;
	Mon, 20 Nov 2006 21:31:31 +1000 (EST)
Received: from beast (davidm0.sw.moreton.com.au [10.46.1.20])
	by hex.internal.moreton.com.au (Postfix) with ESMTP
	for <linux-mips@linux-mips.org>; Mon, 20 Nov 2006 21:31:31 +1000 (EST)
Received: by beast (Postfix, from userid 1012)
	id C9731161C056; Mon, 20 Nov 2006 21:31:50 +1000 (EST)
Date:	Mon, 20 Nov 2006 21:31:50 +1000
From:	David McCullough <david_mccullough@au.securecomputing.com>
To:	linux-mips@linux-mips.org
Subject: a1500 Performance query ?
Message-ID: <20061120113150.GA15277@au.securecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-Virus-Scanned: amavisd-new at snapgear.com
Return-Path: <david_mccullough@au.securecomputing.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david_mccullough@au.securecomputing.com
Precedence: bulk
X-list: linux-mips


Hi all,

I just put together a 2.6.18 image on an older Bosporus board (400MHz
au1500) and I am a bit disappointed with the networking performance.
The few stats I have seen suggest that it should easily be doing 100Mbps
of networking throughput, but I am seeing less than 60Mbps using either
the onboard NIC's or a dual Intel e1000.

I am running a fairly stock 2.6.18 compiled with mipsel-linux-gcc version 3.4.6.
Full netfilter firewall setup doing a through box (all kernel mode) test.

The original BSP came with 2.4.21 and gcc 3.2.1 (mips_fp_le-gcc?) if that
is significant.

Linux reports CPU of 396MHz,  CPUPLL and POWERCTRL registers are set for full
speed and the RAM is running at the right speed (checked with an analyser).

I expected the board to perform much better and figured something obvious
must be wrong. Hopefully someone who knows these boards better has some
ideas :-)

Thanks,
Davidm

-- 
David McCullough,  david_mccullough@securecomputing.com,   Ph:+61 734352815
Secure Computing - SnapGear  http://www.uCdot.org http://www.cyberguard.com
