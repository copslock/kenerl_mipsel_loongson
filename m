Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Sep 2003 09:00:16 +0100 (BST)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:17877 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225349AbTIFH7n>;
	Sat, 6 Sep 2003 08:59:43 +0100
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id QAA01893;
	Sat, 6 Sep 2003 16:59:39 +0900 (JST)
Received: 4UMDO00 id h867xdF14423; Sat, 6 Sep 2003 16:59:39 +0900 (JST)
Received: 4UMRO01 id h867xb711452; Sat, 6 Sep 2003 16:59:38 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Sat, 6 Sep 2003 16:59:37 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: ralf@linux-mips.org
Cc: yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: Re: [patch] NEC VRC4173 CARDU
Message-Id: <20030906165937.06a08c0a.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20030904011019.5c6fe5a0.yuasa@hh.iij4u.or.jp>
References: <20030904011019.5c6fe5a0.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

Do these patches have any problem?

Yoichi

On Thu, 4 Sep 2003 01:10:19 +0900
Yoichi Yuasa <yuasa@hh.iij4u.or.jp> wrote:

> Hello Ralf,
> 
> I made a patch for NEC VRC4173 CARDU(PCMCIA Controller).
> This patch can be prevented from probing the already used slot.
> 
> Please apply this patch.
> 
> Yoichi
> 
