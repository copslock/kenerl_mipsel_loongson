Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2004 12:58:26 +0000 (GMT)
Received: from p508B617B.dip.t-dialin.net ([IPv6:::ffff:80.139.97.123]:30473
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225531AbUASM60>; Mon, 19 Jan 2004 12:58:26 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0JCwKex007180;
	Mon, 19 Jan 2004 13:58:20 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0JCwIr4007179;
	Mon, 19 Jan 2004 13:58:18 +0100
Date: Mon, 19 Jan 2004 13:58:18 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][2.6] Update NEC VRC4171 PCMCIA driver
Message-ID: <20040119125818.GD6312@linux-mips.org>
References: <20040116083821.6b65c69f.yuasa@hh.iij4u.or.jp> <20040116123352.GA13006@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040116123352.GA13006@lst.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 16, 2004 at 01:33:52PM +0100, Christoph Hellwig wrote:

> This is most certainly wrong.  Module refcounting handling has moved one
> layer up in 2.6.

To be fair with Yoichi - MIPS has no module support yet in 2.6, it'll need
to be rewritten from scratch so Yoichi didn't have a chance to really
test this ...

  Ralf
