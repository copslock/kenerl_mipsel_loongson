Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2003 22:19:42 +0000 (GMT)
Received: from purplechoc.demon.co.uk ([IPv6:::ffff:80.176.224.106]:8065 "EHLO
	skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8225450AbTLOWTl>; Mon, 15 Dec 2003 22:19:41 +0000
Received: from pdh by skeleton-jack.localnet with local (Exim 3.35 #1 (Debian))
	id 1AW13v-00087f-00
	for <linux-mips@linux-mips.org>; Mon, 15 Dec 2003 22:19:35 +0000
Date: Mon, 15 Dec 2003 22:19:35 +0000
To: linux-mips@linux-mips.org
Subject: Tulip problems on Qube 2
Message-ID: <20031215221935.GA31161@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

Is anyone looking at the problems with the Tulip network driver on the
Cobalt Qube 2 ?

I've started poking around but am not getting very far ...

The card works okay for a few minutes but then something gets very
confused in the receive ring. If the card is being pinged with packets
once a second it generates a receive interrupt for every packet, but the
first receive ring entry is marked busy so the packet's not passed up.
Once we've received 32 packets the NIC wraps round the receive ring and
the entry we've been waiting on gets marked as full. Now the receive
interrupt removes that last packet and the 31 preceding ones in one go.
Then we stall for another 32 seconds.

It looks like we're loosing some of the NIC's writes to the receive ring
status entries in main memory ...

P.
