Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Feb 2005 00:01:08 +0000 (GMT)
Received: from mo00.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:27599 "EHLO
	mo00.iij4u.or.jp") by linux-mips.org with ESMTP id <S8224933AbVBDAAw>;
	Fri, 4 Feb 2005 00:00:52 +0000
Received: MO(mo00)id j1400nd4015120; Fri, 4 Feb 2005 09:00:49 +0900 (JST)
Received: MDO(mdo00) id j1400mkZ013538; Fri, 4 Feb 2005 09:00:48 +0900 (JST)
Received: 4UMRO00 id j1400k3q010539; Fri, 4 Feb 2005 09:00:47 +0900 (JST)
	from stratos (localhost [127.0.0.1]) (authenticated)
Date:	Fri, 4 Feb 2005 09:00:40 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, akpm@osdl.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6.11-rc2-mm2] mips: iomap
Message-Id: <20050204090040.61ce25d2.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20050203123715.GB8509@linux-mips.org>
References: <20050131074618.09e65a6b.yuasa@hh.iij4u.or.jp>
	<20050203123715.GB8509@linux-mips.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

On Thu, 3 Feb 2005 13:37:15 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Mon, Jan 31, 2005 at 07:46:18AM +0900, Yoichi Yuasa wrote:
> 
> > This patch adds iomap functions to MIPS system.
> 
> And it still only works for a single PCI bus.

Which boards are there a problem?
ocelot-c and ocelot-g?

Yoichi
