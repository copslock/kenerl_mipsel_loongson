Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Dec 2007 12:20:04 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:29925 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026959AbXLKMUC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Dec 2007 12:20:02 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lBBCJWRi011357;
	Tue, 11 Dec 2007 12:19:33 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lBBCJV5t011356;
	Tue, 11 Dec 2007 12:19:31 GMT
Date:	Tue, 11 Dec 2007 12:19:31 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Alchemy: fix PCI resource conflict (take 2)
Message-ID: <20071211121931.GA11039@linux-mips.org>
References: <200712102028.51448.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200712102028.51448.sshtylyov@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17769
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 10, 2007 at 08:28:51PM +0300, Sergei Shtylyov wrote:

> ... by getting the PCI resources back into the 32-bit range -- there's no need
> therefore for CONFIG_RESOURCES_64BIT either. This makes Alchemy PCI work again
> while currently the kernel skips the bus scan.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Thanks, applied.

Which -stable branches do these two fixes need to be applied to?

  Ralf
