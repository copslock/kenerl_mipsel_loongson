Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2007 12:13:12 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:45441 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022570AbXG3LNK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Jul 2007 12:13:10 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6UBD9rv012144;
	Mon, 30 Jul 2007 12:13:09 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6UBD8ha012143;
	Mon, 30 Jul 2007 12:13:08 +0100
Date:	Mon, 30 Jul 2007 12:13:08 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] remove unused GROUP_TOSHIBA_NAMES
Message-ID: <20070730111308.GC11436@linux-mips.org>
References: <20070729211718.4a2b52e2.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070729211718.4a2b52e2.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jul 29, 2007 at 09:17:18PM +0900, Yoichi Yuasa wrote:

> Remove unused GROUP_TOSHIBA_NAMES.

The whole machtype / machgroup stuff should probably be ripped out; I
think DECstation is the only to use it.  Ages ago it was intended for
something which platform_devices are doing a much better job at
anyway.

So with that comment, applied.

  Ralf
