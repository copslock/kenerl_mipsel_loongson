Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Dec 2003 12:34:03 +0000 (GMT)
Received: from p508B6A83.dip.t-dialin.net ([IPv6:::ffff:80.139.106.131]:27042
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225357AbTLTMeC>; Sat, 20 Dec 2003 12:34:02 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hBKCXuoK005583;
	Sat, 20 Dec 2003 13:33:56 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hBKCXtUi005582;
	Sat, 20 Dec 2003 13:33:55 +0100
Date: Sat, 20 Dec 2003 13:33:55 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][2.4] New key map for IBM WorkPad z50
Message-ID: <20031220123354.GA5392@linux-mips.org>
References: <20031220142315.38264f62.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031220142315.38264f62.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Yoichia-san,

Please keep keymaps in drivers/char.

Speaking more generally, device drivers should not be kept below arch/

  Ralf
