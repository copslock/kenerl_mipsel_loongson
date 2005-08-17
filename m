Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Aug 2005 11:12:38 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:4614 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8224982AbVHQKMU>; Wed, 17 Aug 2005 11:12:20 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j7HAGrLR004894;
	Wed, 17 Aug 2005 11:16:53 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j7HAGrgV004893;
	Wed, 17 Aug 2005 11:16:53 +0100
Date:	Wed, 17 Aug 2005 11:16:53 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Isaacson <adi@broadcom.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix pfn_pte for 64BIT_PHYS_ADDR
Message-ID: <20050817101653.GB2667@linux-mips.org>
References: <20050817061232.GN24444@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050817061232.GN24444@broadcom.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 16, 2005 at 11:12:32PM -0700, Andrew Isaacson wrote:

> On CONFIG_64BIT_PHYS_ADDR, pfn always fits in 'unsigned long', but
> pfn<<PAGE_SHIFT sometimes extends beyond.  The pte is big enough to hold
> 'long long', but the shift in pfn_pte() needs to do its calculation with
> enough bits to hold the result.

Thanks, applied also.

  Ralf
