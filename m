Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Aug 2006 17:51:08 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:1687 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S20039747AbWHGQvG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 7 Aug 2006 17:51:06 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.7/8.13.4) with ESMTP id k77Gp7SB004234
	for <linux-mips@linux-mips.org>; Mon, 7 Aug 2006 17:51:07 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k77Gp72J004233
	for linux-mips@linux-mips.org; Mon, 7 Aug 2006 17:51:07 +0100
Resent-Message-Id: <200608071651.k77Gp72J004233@denk.linux-mips.net>
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.7/8.13.4) with ESMTP id k77FqliC002818;
	Mon, 7 Aug 2006 16:52:47 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k77FqjmP002817;
	Mon, 7 Aug 2006 16:52:45 +0100
Date:	Mon, 7 Aug 2006 16:52:45 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	Kishore K <hellokishore@gmail.com>, linux-mips@linux-mips.org
Subject: Re: Problem booting malta with 2.4.33-rc1
Message-ID: <20060807155245.GA7737@linux-mips.org>
References: <f07e6e0608062331p4ef621afn67764067f5b822c2@mail.gmail.com> <20060807181020.37d94241.yoichi_yuasa@tripeaks.co.jp> <20060807100936.GD4383@networkno.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807100936.GD4383@networkno.de>
User-Agent: Mutt/1.4.2.1i
Resent-From: ralf@linux-mips.org
Resent-Date: Mon, 7 Aug 2006 17:51:07 +0100
Resent-To: linux-mips@linux-mips.org
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 07, 2006 at 11:09:36AM +0100, Thiemo Seufer wrote:

> Linux 2.4 has known issues with gcc 3.4 and higher, gcc 3.3 is the last
> recommended version. The Malta configuration was fixed at some point to
> work with 3.4, other configurations weren't.

Last I checked IP22 defconfig for example didn't even build with gcc 3.4.

  Ralf
