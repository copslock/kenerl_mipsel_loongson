Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Aug 2005 17:57:52 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:54036 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225411AbVHXQ5f>; Wed, 24 Aug 2005 17:57:35 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j7OH30K5007721;
	Wed, 24 Aug 2005 18:03:00 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j7OH2xmY007720;
	Wed, 24 Aug 2005 18:02:59 +0100
Date:	Wed, 24 Aug 2005 18:02:59 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kumar Gala <galak@freescale.com>
Cc:	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 06/15] mips: remove use of asm/segment.h
Message-ID: <20050824170259.GF2783@linux-mips.org>
References: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net> <Pine.LNX.4.61.0508241153260.23956@nylon.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508241153260.23956@nylon.am.freescale.net>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8796
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 24, 2005 at 11:54:27AM -0500, Kumar Gala wrote:

> Removed MIPS architecture specific users of asm/segment.h and
> asm-mips/segment.h itself

Thanks, applied.

  Ralf
