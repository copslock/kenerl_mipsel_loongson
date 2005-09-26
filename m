Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Sep 2005 12:56:21 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:12062 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133525AbVIZL4C (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Sep 2005 12:56:02 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j8QBteSp006251;
	Mon, 26 Sep 2005 13:55:40 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j8QBtdbr006250;
	Mon, 26 Sep 2005 13:55:39 +0200
Date:	Mon, 26 Sep 2005 13:55:39 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] minor fix in asm-mips/module.h
Message-ID: <20050926115539.GB3175@linux-mips.org>
References: <cda58cb8050926000665f843dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb8050926000665f843dc@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 26, 2005 at 09:06:50AM +0200, Franck wrote:

> This patch replaces an empty preprocessor condition #elif by #else. It
> adds 4ksc and 4ksd as well.

You forgot to include the patch ...

  Ralf
