Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jan 2005 19:27:34 +0000 (GMT)
Received: from p508B74E6.dip.t-dialin.net ([IPv6:::ffff:80.139.116.230]:27987
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225337AbVAFT13>; Thu, 6 Jan 2005 19:27:29 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j06JRL9k014038;
	Thu, 6 Jan 2005 20:27:21 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id j06JR1oA014031;
	Thu, 6 Jan 2005 20:27:01 +0100
Date: Thu, 6 Jan 2005 20:27:01 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com,
	Ladislav Michl <ladis@linux-mips.org>,
	linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com,
	linux-mips@linux-mips.org
Subject: Re: [2.6 patch] 2.6.10-mm2: let I2C_ALGO_SGI depend on MIPS
Message-ID: <20050106192701.GA13955@linux-mips.org>
References: <20050106002240.00ac4611.akpm@osdl.org> <20050106181519.GG3096@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106181519.GG3096@stusta.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 06, 2005 at 07:15:20PM +0100, Adrian Bunk wrote:

> There's no reason for offering a MIPS-only driver on other architectures 
> (even though it does compile).
> 
> Even better dependencies on specific MIPS variables might be possible 
> that obsolete this patch, but this patch fixes at least the !MIPS case.

Please make that depend on SGI_IP22 || SGI_IP32 instead; the only machines
actually using it.

Ladis, is VisWS using this algo also?

  Ralf
