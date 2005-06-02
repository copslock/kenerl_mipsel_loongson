Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2005 15:33:53 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:47898 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226087AbVFBOdi>; Thu, 2 Jun 2005 15:33:38 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j52EVx57018020;
	Thu, 2 Jun 2005 15:31:59 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j52EVxqt018019;
	Thu, 2 Jun 2005 15:31:59 +0100
Date:	Thu, 2 Jun 2005 15:31:58 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2.6] vr41xx: update IRQ handling
Message-ID: <20050602143158.GC16551@linux-mips.org>
References: <20050530000546.5b7da65d.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050530000546.5b7da65d.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 30, 2005 at 12:05:46AM +0900, Yoichi Yuasa wrote:

> This patch had updated IRQ handling for vr41xx.
> o added common IRQ dispatch
> o changed IRQ number in int-handler.S
> o added resource management to icu.c

Thanks, applied.

  Ralf
