Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Dec 2004 14:38:41 +0000 (GMT)
Received: from mo00.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:25334 "EHLO
	mo00.iij4u.or.jp") by linux-mips.org with ESMTP id <S8224844AbULLOig>;
	Sun, 12 Dec 2004 14:38:36 +0000
Received: MO(mo00)id iBCEcKQ4026554; Sun, 12 Dec 2004 23:38:20 +0900 (JST)
Received: MDO(mdo00) id iBCEcJjQ023915; Sun, 12 Dec 2004 23:38:20 +0900 (JST)
Received: 4UMRO01 id iBCEcJiH024090; Sun, 12 Dec 2004 23:38:19 +0900 (JST)
	from stratos (localhost [127.0.0.1]) (authenticated)
Date: Sun, 12 Dec 2004 23:38:17 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: linux-mips <linux-mips@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, ralf@linux-mips.org, cobalt@colonel-panic.org
Subject: Re: [PATCH] add iomap functions
Message-Id: <20041212233817.00d6d9fd.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20041211203406.6021.qmail@web25810.mail.ukl.yahoo.com>
References: <20041211203406.6021.qmail@web25810.mail.ukl.yahoo.com>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi,

On Sat, 11 Dec 2004 21:34:06 +0100 (CET)

> Dear all,
> 
> I tried compiling CVS from 3~4 days ago for a Cobalt
> Qube2. This box has two tulip NIC. The tulip driver
> has been changed in the 2.6.10-rcx timeframe. It now
> uses iowrite32, ioread32 and assorted functions.
> 
> Those are currently not implemented in linux-mips.
> 
> In Novemember, Yoichi Yuasa submitted a patch for
> iomap functions. On this submission Ralf Baechle asked
> why not use the generic iomap implementation instead?

Some MIPS systems are unable to define PIO space by PIO_MASK/PIO_RESERVED.
This is the reason I didn't use the general iomap implementation.

Yoichi
