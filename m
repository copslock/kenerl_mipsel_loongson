Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Feb 2005 12:37:44 +0000 (GMT)
Received: from p3EE07C05.dip.t-dialin.net ([IPv6:::ffff:62.224.124.5]:46450
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225003AbVBCMha>; Thu, 3 Feb 2005 12:37:30 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j13CbOhb008783;
	Thu, 3 Feb 2005 13:37:24 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id j13CbFEF008782;
	Thu, 3 Feb 2005 13:37:15 +0100
Date:	Thu, 3 Feb 2005 13:37:15 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc:	Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2.6.11-rc2-mm2] mips: iomap
Message-ID: <20050203123715.GB8509@linux-mips.org>
References: <20050131074618.09e65a6b.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050131074618.09e65a6b.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 31, 2005 at 07:46:18AM +0900, Yoichi Yuasa wrote:

> This patch adds iomap functions to MIPS system.

And it still only works for a single PCI bus.

  Ralf
