Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Apr 2004 23:53:40 +0100 (BST)
Received: from purplechoc.demon.co.uk ([IPv6:::ffff:80.176.224.106]:32385 "EHLO
	skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8225738AbUDNWxj>; Wed, 14 Apr 2004 23:53:39 +0100
Received: from pdh by skeleton-jack.localnet with local (Exim 3.36 #1 (Debian))
	id 1BDtG5-0001M0-00
	for <linux-mips@linux-mips.org>; Wed, 14 Apr 2004 23:53:29 +0100
Date: Wed, 14 Apr 2004 23:53:29 +0100
To: linux-mips@linux-mips.org
Subject: BUG() in sys_swapon
Message-ID: <20040414225329.GA4842@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4784
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

The current 2.6.x tree running on a Cobalt Qube throws an OOPS from
sys_swapon().

It looks like this is because line 1257 in r1.89 of mm/swapfile.c
(2.6.x) compiles to a BUG().

    ... swp_type(pte_to_swp_entry(swp_entry_to_pte(swp_entry(~0UL,0)))))

swp_entry(~0UL,0)			--> f800_0000
swp_entry_to_pte(f800_0000)
    __swp_entry(1f, 0000_0000)		--> 0000_003e
    pte_file(0000_003e)			--> 0000_0010
    BUG_ON(0000_0010)

P.
