Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Nov 2007 14:16:27 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:43231 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026401AbXK0OQZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Nov 2007 14:16:25 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lAREGNHI019430;
	Tue, 27 Nov 2007 14:16:23 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lAREGNqX019429;
	Tue, 27 Nov 2007 14:16:23 GMT
Date:	Tue, 27 Nov 2007 14:16:23 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Use real cache invalidate
Message-ID: <20071127141623.GA15590@linux-mips.org>
References: <20071126224001.48CF6C2B26@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071126224001.48CF6C2B26@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 26, 2007 at 11:40:01PM +0100, Thomas Bogendoerfer wrote:

> R10k non coherent machines need a real dma cache invalidate to get
> rid of speculative stores in cache.

Wonderful.  This should also deliver a slight performance benefit for
other systems.

  Ralf
