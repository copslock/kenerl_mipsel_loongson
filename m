Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Dec 2006 14:12:59 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:2452 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038843AbWLDOM6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 4 Dec 2006 14:12:58 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kB4ECwIN015070;
	Mon, 4 Dec 2006 14:12:58 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kB4ECwIu015069;
	Mon, 4 Dec 2006 14:12:58 GMT
Date:	Mon, 4 Dec 2006 14:12:58 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/5] MIPS: remove unused resources for cobalt
Message-ID: <20061204141258.GB7231@linux-mips.org>
References: <20061201221242.261f57b0.yoichi_yuasa@tripeaks.co.jp> <20061201221601.3aa34024.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061201221601.3aa34024.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Dec 01, 2006 at 10:16:01PM +0900, Yoichi Yuasa wrote:

> This patch has removed unused resources for cobalt.

The VIA PCI-to-ISA bridge used in Cobalts contains the DMA controller, so
these resources should be reserved even though nothing is actually using
them.

  Ralf
