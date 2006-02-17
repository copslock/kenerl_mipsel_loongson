Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2006 15:24:05 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:18181 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133657AbWBQPX4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 17 Feb 2006 15:23:56 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1HFUcvL024668;
	Fri, 17 Feb 2006 15:30:38 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1HFUbgc024667;
	Fri, 17 Feb 2006 15:30:37 GMT
Date:	Fri, 17 Feb 2006 15:30:37 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] use __raw access function for fb
Message-ID: <20060217153037.GA23432@linux-mips.org>
References: <20060209.005655.96684595.anemo@mba.ocn.ne.jp> <20060218.002049.75184722.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218.002049.75184722.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Feb 18, 2006 at 12:20:49AM +0900, Atsushi Nemoto wrote:

> I just sent another non-intrusive fix (add __force tag to fb_readb,
> etc) to LKML.
> 
> BTW, current fb_readw(), etc. are really appropriate for IP22/IP32?
> It seems they have funny __swizzle_addr_w ...

Ignoring the theoretical possibility of using an EISA graphics card in an
IP22 (more exactly Indigo 2) system, IP22 simply doesn't have a framebuffer.

I'm not sure what the effect of the patch on IP32 would be so I was
waiting to apply your patch in the hope somebody is going to test it
No reports so far ...

  Ralf
