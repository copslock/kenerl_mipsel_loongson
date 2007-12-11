Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Dec 2007 12:20:28 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:32741 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026963AbXLKMUV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Dec 2007 12:20:21 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lBBCJpYV011364;
	Tue, 11 Dec 2007 12:19:51 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lBBCJor6011363;
	Tue, 11 Dec 2007 12:19:50 GMT
Date:	Tue, 11 Dec 2007 12:19:50 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Alchemy: fix off by two error in __fixup_bigphys_addr()
Message-ID: <20071211121950.GB11039@linux-mips.org>
References: <200712102036.50247.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200712102036.50247.sshtylyov@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 10, 2007 at 08:36:50PM +0300, Sergei Shtylyov wrote:

> he PCI specific code in this function doesn't check for the address range being
> under the upper bound of the PCI memory window correctly -- fix this, somewhat
> beautifying the code around the check, while at it...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Applied, too.

Thanks,

  Ralf
