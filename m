Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jan 2005 02:12:10 +0000 (GMT)
Received: from mo00.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:7106 "EHLO
	mo00.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225264AbVARCMF>;
	Tue, 18 Jan 2005 02:12:05 +0000
Received: MO(mo00)id j0I2C2FP020281; Tue, 18 Jan 2005 11:12:02 +0900 (JST)
Received: MDO(mdo01) id j0I2C1sh025077; Tue, 18 Jan 2005 11:12:01 +0900 (JST)
Received: 4UMRO01 id j0I2C0KU023540; Tue, 18 Jan 2005 11:12:01 +0900 (JST)
	from rally (localhost [127.0.0.1]) (authenticated)
Date: Tue, 18 Jan 2005 11:11:59 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: yuasa@hh.iij4u.or.jp, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6.11-rc1] add local_irq_enable() to cpu_idle()
Message-Id: <20050118111159.2b3651aa.yuasa@hh.iij4u.or.jp>
In-Reply-To: <41EBEEFA.6040701@mips.com>
References: <20050118014958.1d9e484e.yuasa@hh.iij4u.or.jp>
	<41EBEEFA.6040701@mips.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

On Mon, 17 Jan 2005 17:59:38 +0100
"Kevin D. Kissell" <kevink@mips.com> wrote:

> There have been times when having local_irq_enable() in my idle loop
> would have prevented a hang in some of my experimental kernels, too,
> but it's always been because I had screwed up somewhere else and
> forgotten to re-enable interrupts.  Is there some good reason why
> the kernel should end up in idle with interrupts turned off?

After call local_irq_disable(), rest_init()(in init/main.c) calls cpu_idle().

Yoichi
