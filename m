Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Jan 2007 15:54:07 +0000 (GMT)
Received: from wf1.mips-uk.com ([194.74.144.154]:32911 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28574073AbXAHPyF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 Jan 2007 15:54:05 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l08Fssjc001647;
	Mon, 8 Jan 2007 15:54:54 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l08Fsrq3001646;
	Mon, 8 Jan 2007 15:54:53 GMT
Date:	Mon, 8 Jan 2007 15:54:53 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] prom_free_prom_memory cleanup
Message-ID: <20070108155453.GA1619@linux-mips.org>
References: <20061230.004359.41198543.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061230.004359.41198543.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Dec 30, 2006 at 12:43:59AM +0900, Atsushi Nemoto wrote:

> Current prom_free_prom_memory() implementations are almost same as
> free_init_pages(), or no-op.  Make free_init_pages() extern (again)
> and make prom_free_prom_memory() use it.

Queued for 2.6.21.  Thanks,

  Ralf
