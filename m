Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Dec 2004 21:04:58 +0000 (GMT)
Received: from sorrow.cyrius.com ([IPv6:::ffff:65.19.161.204]:52231 "EHLO
	sorrow.cyrius.com") by linux-mips.org with ESMTP
	id <S8225250AbULWVEx>; Thu, 23 Dec 2004 21:04:53 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id E046E64D40; Thu, 23 Dec 2004 21:04:39 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 35A614FA17; Thu, 23 Dec 2004 21:03:41 +0000 (GMT)
Date: Thu, 23 Dec 2004 21:03:40 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: linux-mips@linux-mips.org
Subject: 2.6.10rc3: swarm only configures eth0, not eth1
Message-ID: <20041223210340.GA27255@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6750
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

I just booted a 2.6.10rc3 kernel on my SWARM and noticed that only
eth0 is configured, but eth1 isn't (even though I booted via eth1):

sbmac: configuring MAC at 10064000
eth0: enabling TCP rcv checksum
eth0: SiByte Ethernet at 0x10064000, address: 00:02:4C:FE:0D:08
sbmac: not configuring MAC at 10066000

On a 2.4.x kernel, both network interfaces are configured and I get:

eth0: SiByte Ethernet at 0x10064000, address: 00-02-4C-FE-0D-08
eth0: enabling TCP rcv checksum
eth1: SiByte Ethernet at 0x10065000, address: 00-02-4C-FE-0D-09
eth1: enabling TCP rcv checksum

Note the difference for eth1 between 10066000 (2.6) and 10065000 (2.4).

Thiemo suggested that this might be because the 2.4 kernel is 32 bit
while the 2.6 kernel is 64 bit and that 2.6 might get the address
wrong.
-- 
Martin Michlmayr
http://www.cyrius.com/
