Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Mar 2004 02:33:10 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:12023 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225305AbUCJCdJ>;
	Wed, 10 Mar 2004 02:33:09 +0000
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i2A2X8x6013588;
	Tue, 9 Mar 2004 18:33:08 -0800
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i2A2X8P8013586;
	Tue, 9 Mar 2004 18:33:08 -0800
Date: Tue, 9 Mar 2004 18:33:08 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: "eth%d" - net dev name in 2.6?
Message-ID: <20040310023308.GU31326@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


With swarm running on 2.6 I just saw the net dev names are
not set correctly.  See below.

eth%d: SiByte Ethernet at 0x10064000, address: 00-02-4C-FE-0C-B2                
eth%d: enabling TCP rcv checksum                                                

It appears alloc_netdev() assigns this initial name and nobody
later resets it to a more meaningful name.  

Any body has a clue here?  I don't think it is driver's job though ...

Thanks.

Jun
