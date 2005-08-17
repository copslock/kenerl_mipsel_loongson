Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Aug 2005 11:04:07 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:11034 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225005AbVHQKDw>; Wed, 17 Aug 2005 11:03:52 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j7HA8V15004584;
	Wed, 17 Aug 2005 11:08:31 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j7HA8Uma004583;
	Wed, 17 Aug 2005 11:08:30 +0100
Date:	Wed, 17 Aug 2005 11:08:30 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Isaacson <adi@broadcom.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] casts in TLB macros
Message-ID: <20050817100830.GA2667@linux-mips.org>
References: <20050817030608.GM24444@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050817030608.GM24444@broadcom.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 16, 2005 at 08:06:08PM -0700, Andrew Isaacson wrote:

> Fix three cases where macro arguments are not parenthesized, leading to
> incorrect operator precedence when called with an expression as the
> argument.  This causes incorrect evaluation of
>     write_c0_entrylo0(pte_val(*ptep++) >> 6)
> when pte_t is 64 bits - the pte value is cast to (unsigned int) first,
> then the shift is done, losing the top 32 bits.
> 
> Also, this does not add an extra set of parentheses surrounding the
> (cast)(value) pair, as there's no danger of precedence problems to avoid
> given the high precedence of the cast operator and that this is the
> terminal macro in this macro trail.

Thanks, applied,

  Ralf
