Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jul 2008 17:41:02 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:63414
	"EHLO vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20025262AbYGIQk7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 9 Jul 2008 17:40:59 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m69GesgW025421;
	Wed, 9 Jul 2008 17:40:55 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m69GerHL025414;
	Wed, 9 Jul 2008 17:40:53 +0100
Date:	Wed, 9 Jul 2008 17:40:53 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Make gpio_txx9 entirely spinlock-safe
Message-ID: <20080709164053.GA5672@linux-mips.org>
References: <20080710.010208.39154926.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080710.010208.39154926.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 10, 2008 at 01:02:08AM +0900, Atsushi Nemoto wrote:

> TXx9 GPIO set/get routines are spinlock-safe.  This patch make
> gpio_direction_{input,output} routines also spinlock-safe so that they
> can be used during early board setup.

Thanks, queued for 2.6.27.

  Ralf
