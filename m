Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2005 17:23:18 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:41483 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8224979AbVHZQXA>; Fri, 26 Aug 2005 17:23:00 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j7QGSX9m015302;
	Fri, 26 Aug 2005 17:28:33 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j7QGSWrR015301;
	Fri, 26 Aug 2005 17:28:32 +0100
Date:	Fri, 26 Aug 2005 17:28:32 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Bryan Althouse <bryan.althouse@3phoenix.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: custom ide driver causes "Badness in smp_call_function"
Message-ID: <20050826162832.GB2712@linux-mips.org>
References: <20050826141047.GA8777@linux-mips.org> <20050826145303Z8224974-3678+7581@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050826145303Z8224974-3678+7581@linux-mips.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Aug 26, 2005 at 10:58:40AM -0400, Bryan Althouse wrote:

> The patch doesn't seem to make any difference. :(

To clarify, the patch wasn't meant to resolve your interrupt problems but
the SMP cacheflush issues only.

  Ralf
