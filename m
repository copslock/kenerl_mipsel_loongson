Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Feb 2007 18:41:17 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:4000 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037728AbXBSSlP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Feb 2007 18:41:15 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1JIfFcB010702;
	Mon, 19 Feb 2007 18:41:15 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1JIfDUE010701;
	Mon, 19 Feb 2007 18:41:13 GMT
Date:	Mon, 19 Feb 2007 18:41:13 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] Fixed Cobalt UART I/O type
Message-ID: <20070219184113.GB10244@linux-mips.org>
References: <20070209121624.074ab2cd.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070209121624.074ab2cd.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 09, 2007 at 12:16:24PM +0900, Yoichi Yuasa wrote:

> This patch has fixed UART I/O type.
> The cobalt UART device is actually connected to memory resource area.

Thanks, applied.

  Ralf
