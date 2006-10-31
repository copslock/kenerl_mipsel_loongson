Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Oct 2006 13:50:50 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:28589 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038552AbWJaNus (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Oct 2006 13:50:48 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id k9VDpJOw009800;
	Tue, 31 Oct 2006 13:51:19 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id k9VDpHO5009799;
	Tue, 31 Oct 2006 13:51:17 GMT
Date:	Tue, 31 Oct 2006 13:51:17 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] fix uninitialized variable in titan_i2c_xfer()
Message-ID: <20061031135117.GB7795@linux-mips.org>
References: <200610310445.k9V4jEPa009920@mbox30.po.2iij.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610310445.k9V4jEPa009920@mbox30.po.2iij.net>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13124
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 31, 2006 at 01:38:44PM +0900, Yoichi Yuasa wrote:

> This patch has fixed the problem of the initialization of variable.
> The bytes is used uninitialized in titan_i2c_xfer().

Applied,

  Ralf
