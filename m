Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jun 2008 15:45:09 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:57773 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20039940AbYFPOpG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Jun 2008 15:45:06 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5GEijqG032380;
	Mon, 16 Jun 2008 15:44:46 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5GEijH8032379;
	Mon, 16 Jun 2008 15:44:45 +0100
Date:	Mon, 16 Jun 2008 15:44:45 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] update TANBAC boards defconfig
Message-ID: <20080616144445.GB31915@linux-mips.org>
References: <20080616225416.f4c6be4b.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080616225416.f4c6be4b.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19570
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 16, 2008 at 10:54:16PM +0900, Yoichi Yuasa wrote:

> Update TANBAC boards defconfig.
> These boards need cca setup on CMDLINE.

Applied as well - though I think passing a CCA value on the command line
is nothing a user should ever, ever have to do, so there should be a
better mechanism.

  Ralf
