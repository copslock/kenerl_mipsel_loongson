Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Aug 2007 13:28:40 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:57541 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023771AbXHWM2Q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Aug 2007 13:28:16 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l7NCSE8Y012232;
	Thu, 23 Aug 2007 13:28:16 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l7MNO6g2011993;
	Thu, 23 Aug 2007 00:24:06 +0100
Date:	Thu, 23 Aug 2007 00:24:06 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>, brm <brm@murphy.dk>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Add back support for LASAT platforms
Message-ID: <20070822232406.GA11920@linux-mips.org>
References: <200708212034.l7LKYGiD011023@potty.localnet> <20070822101425.430da249.yoichi_yuasa@tripeaks.co.jp> <Pine.LNX.4.64.0708220858290.9716@anakin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708220858290.9716@anakin>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 22, 2007 at 08:59:55AM +0200, Geert Uytterhoeven wrote:

> > If you add new RTC driver, it should go to drivers/rtc.
> 
> Nice! So the way to review existing code, is to remove it (accidentally? ;-)
> and add it back later? ;-)

Yoichi raised several valid points - but since this is only code being
resurrected I'm not going to look too hard.  Let's chainsaw it into
shape later.

  Ralf
