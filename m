Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Aug 2004 19:08:13 +0100 (BST)
Received: from p508B75A1.dip.t-dialin.net ([IPv6:::ffff:80.139.117.161]:24908
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225201AbUHQSIJ>; Tue, 17 Aug 2004 19:08:09 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i7HI864L014923;
	Tue, 17 Aug 2004 20:08:06 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i7HI86Un014920;
	Tue, 17 Aug 2004 20:08:06 +0200
Date: Tue, 17 Aug 2004 20:08:06 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Marcus Gustafsson <marcus.gustafsson@kreatel.se>
Cc: linux-mips@linux-mips.org
Subject: Re: Busybox v0.60.2 insmod gives segmentation fault without any m essages when trying to load a loadable module
Message-ID: <20040817180806.GA14578@linux-mips.org>
References: <5BB336130A66D7119DEF009027463C2C0F2CDA@BERNTSSON>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5BB336130A66D7119DEF009027463C2C0F2CDA@BERNTSSON>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 17, 2004 at 09:24:49AM +0200, Marcus Gustafsson wrote:

> Im using gcc-3.3.3 and busybox-0.60.5 and insmod works if I strip the debug
> symbols from the module.

Seems that insmod is derived from an awfully old version from kernel.org;
this bug was fixed years ago.

  Ralf
