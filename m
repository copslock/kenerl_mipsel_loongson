Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Feb 2003 20:22:01 +0000 (GMT)
Received: from p508B7A94.dip.t-dialin.net ([IPv6:::ffff:80.139.122.148]:43743
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224939AbTBXUWA>; Mon, 24 Feb 2003 20:22:00 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h1OKLkh01229;
	Mon, 24 Feb 2003 21:21:46 +0100
Date: Mon, 24 Feb 2003 21:21:46 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: Change -mcpu option for VR41xx
Message-ID: <20030224212146.A764@linux-mips.org>
References: <20030224210755.1f5fac0a.yoichi_yuasa@montavista.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030224210755.1f5fac0a.yoichi_yuasa@montavista.co.jp>; from yoichi_yuasa@montavista.co.jp on Mon, Feb 24, 2003 at 09:07:55PM +0900
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 24, 2003 at 09:07:55PM +0900, Yoichi Yuasa wrote:

> We need to change -mcpu in order to use an instruction peculiar to VR4100.
> The option of -mcpu changes with versions of binutils.
> 
> If it is limited to some versions, I can be corresponded using check_gcc.
> Can you tell me some versions of binutils?

Binutils starting with about 2.10 should support -mcpu=4100.

  Ralf
