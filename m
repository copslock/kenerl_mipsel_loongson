Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jan 2005 02:46:08 +0000 (GMT)
Received: from alg138.algor.co.uk ([IPv6:::ffff:62.254.210.138]:36997 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225226AbVASCpk>; Wed, 19 Jan 2005 02:45:40 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j0J2hUvf014825;
	Wed, 19 Jan 2005 02:43:30 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j0J2hJGb014824;
	Wed, 19 Jan 2005 02:43:19 GMT
Date: Wed, 19 Jan 2005 02:43:19 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6.11-rc1] add local_irq_enable() to cpu_idle()
Message-ID: <20050119024319.GA14539@linux-mips.org>
References: <20050118014958.1d9e484e.yuasa@hh.iij4u.or.jp> <41EBEEFA.6040701@mips.com> <20050118111159.2b3651aa.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118111159.2b3651aa.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 18, 2005 at 11:11:59AM +0900, Yoichi Yuasa wrote:

> "Kevin D. Kissell" <kevink@mips.com> wrote:
> 
> > There have been times when having local_irq_enable() in my idle loop
> > would have prevented a hang in some of my experimental kernels, too,
> > but it's always been because I had screwed up somewhere else and
> > forgotten to re-enable interrupts.  Is there some good reason why
> > the kernel should end up in idle with interrupts turned off?
> 
> After call local_irq_disable(), rest_init()(in init/main.c) calls cpu_idle().

Indeed.  Was looking at a kernel with kdb which removes this line.

  Ralf
