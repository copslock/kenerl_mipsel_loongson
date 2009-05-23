Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 May 2009 10:17:59 +0100 (BST)
Received: from smtp.nokia.com ([192.100.105.134]:41584 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20022151AbZEWJRx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 23 May 2009 10:17:53 +0100
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n4N9HVPv008153;
	Sat, 23 May 2009 04:17:34 -0500
Received: from vaebh104.NOE.Nokia.com ([10.160.244.30]) by vaebh105.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 23 May 2009 12:17:29 +0300
Received: from mgw-sa01.ext.nokia.com ([147.243.1.47]) by vaebh104.NOE.Nokia.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 23 May 2009 12:17:29 +0300
Received: from [172.21.42.232] (esdhcp042232.research.nokia.com [172.21.42.232])
	by mgw-sa01.ext.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n4N9HQZJ002486;
	Sat, 23 May 2009 12:17:26 +0300
Subject: Re: [PATCH] MTD: Remove pmcmsp-ramroot.c
From:	Artem Bityutskiy <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To:	Shane McDonald <mcdonald.shane@gmail.com>
Cc:	linux-mtd@lists.infradead.org, linux-mips@linux-mips.org,
	dwmw2@infradead.org, hch@lst.de, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org,
	Marc St-Jean <stjeanma@pmc-sierra.com>
In-Reply-To: <E1M0HJu-0007HN-7j@localhost>
References: <E1M0HJu-0007HN-7j@localhost>
Content-Type: text/plain; charset="UTF-8"
Date:	Sat, 23 May 2009 12:17:26 +0300
Message-Id: <1243070246.21646.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.5 (2.24.5-1.fc10) 
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 May 2009 09:17:29.0255 (UTC) FILETIME=[4B9F0370:01C9DB87]
X-Nokia-AV: Clean
Return-Path: <dedekind@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind@infradead.org
Precedence: bulk
X-list: linux-mips

On Sat, 2009-05-02 at 09:40 -0600, Shane McDonald wrote:
> The RAMROOT function was a successful but non-portable attempt to append
> the root filesystem to the end of the kernel image.  The preferred and
> portable solution is to use an initramfs instead.
> 
> The only user of this function was the msp71xx configuration
> in the MIPS architecture; as the use of the RAMROOT has been removed
> from that configuration, there are no more users, so this code
> can be removed.

I've taken this patch to l2-mtd-2.6.git.

-- 
Best regards,
Artem Bityutskiy (Битюцкий Артём)
