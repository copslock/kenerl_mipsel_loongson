Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2004 06:24:18 +0000 (GMT)
Received: from p508B617B.dip.t-dialin.net ([IPv6:::ffff:80.139.97.123]:35682
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225200AbUASGYS>; Mon, 19 Jan 2004 06:24:18 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0J6OH4P010336;
	Mon, 19 Jan 2004 07:24:17 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0J6OGJf010335;
	Mon, 19 Jan 2004 07:24:16 +0100
Date: Mon, 19 Jan 2004 07:24:16 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Gilad Benjamini <yaelgilad@myrealbox.com>
Cc: linux-mips@linux-mips.org
Subject: Re: "-G" optimizations
Message-ID: <20040119062416.GB31919@linux-mips.org>
References: <1074467780.c913e0a0yaelgilad@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074467780.c913e0a0yaelgilad@myrealbox.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4030
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jan 18, 2004 at 11:16:20PM +0000, Gilad Benjamini wrote:

> was compiled with "-G0" while a module was compiled
> with "-G8".
> Is this a legal combination ?
> If it isn't, what could the implications be ?

It's never legal.  The -G option addresses data relative to $28 but Linux
uses it already to store the current pointer.

  Ralf
