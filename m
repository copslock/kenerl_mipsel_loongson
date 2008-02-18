Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Feb 2008 21:22:29 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:3806 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28574398AbYBRVW1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 18 Feb 2008 21:22:27 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m1ILMQeF010417;
	Mon, 18 Feb 2008 21:22:26 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m1ILMPUr010416;
	Mon, 18 Feb 2008 21:22:25 GMT
Date:	Mon, 18 Feb 2008 21:22:25 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix build failure for 64-bit SB-1 kernels
Message-ID: <20080218212225.GA4133@linux-mips.org>
References: <20080214165825.GE29497@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080214165825.GE29497@networkno.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18259
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 14, 2008 at 04:58:25PM +0000, Thiemo Seufer wrote:

> Fix type mismatch warnings for 64-bit kernel builds which trigger -Werror.
> The problem affects only SB-1 kernels with CONFIG_SIBYTE_DMA_PAGEOPS enabled.

Applied to 2.6.23 and newer.

Thanks,

  Ralf
