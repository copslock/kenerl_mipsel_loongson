Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Oct 2005 11:34:24 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:6684 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133447AbVJCKeI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Oct 2005 11:34:08 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j93AXxwX005574;
	Mon, 3 Oct 2005 11:33:59 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j93AXwC0005573;
	Mon, 3 Oct 2005 11:33:58 +0100
Date:	Mon, 3 Oct 2005 11:33:58 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] vr41xx: update defconfig
Message-ID: <20051003103358.GA2624@linux-mips.org>
References: <20051002023213.61de0f26.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051002023213.61de0f26.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Oct 02, 2005 at 02:32:13AM +0900, Yoichi Yuasa wrote:

> I had updated vr41xx machine's defconfig.
> Please apply.

Your patch had rejects on the date header of the defconfig files; I dropped
those segments and applied the remainder.

  Ralf
