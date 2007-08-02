Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2007 10:21:38 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:37269 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021983AbXHBJVg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Aug 2007 10:21:36 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l729LZko023100;
	Thu, 2 Aug 2007 10:21:35 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l729LYDC023099;
	Thu, 2 Aug 2007 10:21:34 +0100
Date:	Thu, 2 Aug 2007 10:21:34 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] fix au1xxx_gpio_direction_* return value
Message-ID: <20070802092134.GB22697@linux-mips.org>
References: <200708020348.l723m0jQ001528@po-mbox300.hop.2iij.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200708020348.l723m0jQ001528@po-mbox300.hop.2iij.net>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Aug 02, 2007 at 12:48:00PM +0900, Yoichi Yuasa wrote:

> Fix au1xxx_gpio_direction_* return value.

Thanks, applied.

   Ralf
