Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Jan 2005 00:03:07 +0000 (GMT)
Received: from p3EE07947.dip.t-dialin.net ([IPv6:::ffff:62.224.121.71]:26215
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224923AbVA2ACw>; Sat, 29 Jan 2005 00:02:52 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j0T02jE5011800;
	Sat, 29 Jan 2005 01:02:45 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id j0T02Zpi011799;
	Sat, 29 Jan 2005 01:02:35 +0100
Date:	Sat, 29 Jan 2005 01:02:35 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	zhan rongkai <zhanrk@gmail.com>, linux-mips@linux-mips.org
Subject: Re: Why does MIPS/Linux always reserve 32 bytes in the top of each process's kernel stack space
Message-ID: <20050129000235.GA11602@linux-mips.org>
References: <69397FFCADEFD94F8D5A0FC0FDBCBBDEF53B@avtrex-server.hq.avtrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69397FFCADEFD94F8D5A0FC0FDBCBBDEF53B@avtrex-server.hq.avtrex.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 27, 2005 at 08:54:48PM -0800, David Daney wrote:

> >Why does MIPS/Linux always reserve 32 bytes in the top of each
> >process's kernel stack space.
> 
> Perhaps because the  kernel's ABI requires it?   I beleive that o64 requires stack space for a0 - a3 to be stored there.

Except we don't use o64.

  Ralf
