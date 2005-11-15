Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Nov 2005 15:51:49 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:12813 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133563AbVKOPvc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Nov 2005 15:51:32 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jAFFrPOC025333;
	Tue, 15 Nov 2005 15:53:26 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jAFFrPb0025332;
	Tue, 15 Nov 2005 15:53:25 GMT
Date:	Tue, 15 Nov 2005 15:53:25 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix build in ide-dma.c
Message-ID: <20051115155325.GC15733@linux-mips.org>
References: <17273.5861.51238.726136@dl2.hq2.avtrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17273.5861.51238.726136@dl2.hq2.avtrex.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 14, 2005 at 02:59:49PM -0800, David Daney wrote:

> When in_drive_list was renamed to ide_in_drive_list, several
> occurrences were missed.  This patch allows me to build.

Thanks, applied.

The ide-dma stuff is part of the work on polishing the remaining drivers
for merging to kernel.org.  I hope I can get rid of that kind of stuff
soon ...

  Ralf
