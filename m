Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2008 00:04:13 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:48563 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20035100AbYANAEL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Jan 2008 00:04:11 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0E047dF020476;
	Mon, 14 Jan 2008 00:04:07 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0E046hR020475;
	Mon, 14 Jan 2008 00:04:06 GMT
Date:	Mon, 14 Jan 2008 00:04:06 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Cobalt Qube1 has no serial port so don't use it
Message-ID: <20080114000406.GB20115@linux-mips.org>
References: <20080111232517.C7B9FC2F2B@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080111232517.C7B9FC2F2B@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jan 12, 2008 at 12:25:17AM +0100, Thomas Bogendoerfer wrote:

> Because Qube1 doesn't have a serial chip waiting for transmit fifo empty
> takes forever, which isn't a good idea. No prom_putchar/early console
> for Qube1 fixes this.

Applied, too.

  Ralf
