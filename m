Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Nov 2004 22:43:07 +0000 (GMT)
Received: from mo00.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:29664 "EHLO
	mo00.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225347AbUKIWnC>;
	Tue, 9 Nov 2004 22:43:02 +0000
Received: MO(mo00)id iA9MgxDR017839; Wed, 10 Nov 2004 07:42:59 +0900 (JST)
Received: MDO(mdo01) id iA9MgxiL028871; Wed, 10 Nov 2004 07:42:59 +0900 (JST)
Received: 4UMRO00 id iA9Mgwmb016785; Wed, 10 Nov 2004 07:42:58 +0900 (JST)
	from stratos (localhost [127.0.0.1]) (authenticated)
Date: Wed, 10 Nov 2004 07:42:53 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: Re: [PATCH] add iomap funtions
Message-Id: <20041110074253.231ffa42.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20041109214343.GA28260@linux-mips.org>
References: <20041105011317.012b10ad.yuasa@hh.iij4u.or.jp>
	<20041109214343.GA28260@linux-mips.org>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

On Tue, 9 Nov 2004 22:43:43 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Fri, Nov 05, 2004 at 01:13:17AM +0900, Yoichi Yuasa wrote:
> 
> > This patch adds iomap functions to MIPS system.
> > Please apply this patch to v2.6.
> 
> Any reason you're not simply setting CONFIG_GENERIC_IOMAP?

PIO and MMIO cannot be judged from an address.
I thought that PIO_MASK/PIO_RESERVED/PIO_OFFSET was not suitable for MIPS.

Yoichi
