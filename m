Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2003 22:48:26 +0100 (BST)
Received: from p508B6792.dip.t-dialin.net ([IPv6:::ffff:80.139.103.146]:48358
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225072AbTDHVsZ>; Tue, 8 Apr 2003 22:48:25 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h38LmEc09060;
	Tue, 8 Apr 2003 23:48:14 +0200
Date: Tue, 8 Apr 2003 23:48:14 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: Hartvig Ekner <hartvig@ekner.info>,
	Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: Aliasing in pgtable-bits.h (CONFIG_64BIT_PHYS_ADDR)
Message-ID: <20030408234814.B7363@linux-mips.org>
References: <3E9274F0.227008F7@ekner.info> <868yul2sa5.fsf@trasno.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <868yul2sa5.fsf@trasno.mitica>; from quintela@mandrakesoft.com on Tue, Apr 08, 2003 at 12:32:50PM +0200
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 08, 2003 at 12:32:50PM +0200, Juan Quintela wrote:

> I will bet that this is related to the comment in
> arch/mips/mm/tlb-r4k.c workaround that is unimplemented:

Correct.

  Ralf
