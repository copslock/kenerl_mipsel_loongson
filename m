Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Sep 2003 15:35:57 +0100 (BST)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:1986 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225360AbTIJOfZ>;
	Wed, 10 Sep 2003 15:35:25 +0100
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id XAA10525;
	Wed, 10 Sep 2003 23:35:20 +0900 (JST)
Received: 4UMDO01 id h8AEZKP10333; Wed, 10 Sep 2003 23:35:20 +0900 (JST)
Received: 4UMRO00 id h8AEZIj03413; Wed, 10 Sep 2003 23:35:19 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Wed, 10 Sep 2003 23:35:18 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, yuasa@hh.iij4u.or.jp
Subject: Re: [patch] simulate_llsc in v2.4
Message-Id: <20030910233518.6b945c81.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20030910101035.GA11844@linux-mips.org>
References: <20030910183852.2e8248d5.yuasa@hh.iij4u.or.jp>
	<20030910101035.GA11844@linux-mips.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

On Wed, 10 Sep 2003 12:10:35 +0200
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Wed, Sep 10, 2003 at 06:38:52PM +0900, Yoichi Yuasa wrote:
> 
> > I found a differece between v2.4 and v2.6 in simulate_llsc().
> > 
> > Please apply this patch to v2.4 tree.
> 
> Okay - you missed the same thing also needs to be applied to the 64-bit
> kernel.

Oh, that's right.

Thanks,

Yoichi
