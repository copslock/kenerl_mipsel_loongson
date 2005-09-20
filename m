Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2005 12:01:30 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:39443 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225348AbVITLBK>; Tue, 20 Sep 2005 12:01:10 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j8KB12iU005125;
	Tue, 20 Sep 2005 12:01:02 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j8KB12i2005114;
	Tue, 20 Sep 2005 12:01:02 +0100
Date:	Tue, 20 Sep 2005 12:01:02 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix TCP/UDP checksums on the Broadcom SB-1
Message-ID: <20050920110101.GA3159@linux-mips.org>
References: <20050920032818.GA7199@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050920032818.GA7199@nevyn.them.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 19, 2005 at 11:28:18PM -0400, Daniel Jacobowitz wrote:

> The type of sum in csum_tcpudp_nofold is "unsigned int", so when we assign
> to it in an asm() block, and we're running on a system with 64-bit
> registers, it is vitally important that we sign extend it correctly before
> returning to C.  Otherwise the stray high bits will be preserved into
> csum_fold, and on the SB-1 processor, 32-bit arithmetic on a non
> sign-extended register will yield surprising results.
> 
> This caused incorrect checksums in some UDP packets for NFS root.  The
> problem was mild when using a 10.0.1.x IP address, but severe when
> using 192.168.1.x.

Good catch.  And just to increase the func factor this bug did also apply
to 2.4.  Applied,

  Ralf
