Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2005 17:36:02 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:34572 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8224984AbVHZQfn>; Fri, 26 Aug 2005 17:35:43 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j7QGfGRT015776;
	Fri, 26 Aug 2005 17:41:16 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j7QGfFHh015775;
	Fri, 26 Aug 2005 17:41:15 +0100
Date:	Fri, 26 Aug 2005 17:41:15 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Bryan Althouse <bryan.althouse@3phoenix.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: custom ide driver causes "Badness in smp_call_function"
Message-ID: <20050826164115.GC2712@linux-mips.org>
References: <20050826162832.GB2712@linux-mips.org> <20050826163050Z8224979-3678+7593@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050826163050Z8224979-3678+7593@linux-mips.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Aug 26, 2005 at 12:36:26PM -0400, Bryan Althouse wrote:

> I still get the SMP badness when hwif->irq is set to 0 in my driver.

Interesting.  That implies smp_call_function is called through a different
path on your system that on mine here.  Doesn't invalidate the patch,
just means some extra debugging work for you ;-)

  Ralf
