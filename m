Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Oct 2009 17:13:17 +0200 (CEST)
Received: from www.tglx.de ([62.245.132.106]:41457 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493208AbZJHPNK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Oct 2009 17:13:10 +0200
Received: from localhost (www.tglx.de [127.0.0.1])
	by www.tglx.de (8.13.8/8.13.8/TGLX-2007100201) with ESMTP id n98FD0cj013867
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 8 Oct 2009 17:13:02 +0200
Date:	Thu, 8 Oct 2009 17:13:00 +0200 (CEST)
From:	Thomas Gleixner <tglx@linutronix.de>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
cc:	linux-mips@linux-mips.org,
	pm list <linux-pm@lists.linux-foundation.org>,
	linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Yoichi Yuasa <yuasa@linux-mips.org>
Subject: Re: [PATCH] MIPS: add IRQF_TIMER flag for Timer Interrupts
In-Reply-To: <1255007874-19574-1-git-send-email-wuzhangjin@gmail.com>
Message-ID: <alpine.LFD.2.00.0910081712390.9428@localhost.localdomain>
References: <1255007874-19574-1-git-send-email-wuzhangjin@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: clamav-milter 0.95.1 at www.tglx.de
X-Virus-Status:	Clean
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

On Thu, 8 Oct 2009, Wu Zhangjin wrote:

> This patch add IRQF_TIMER flag for all Timer interrupts in linux-MIPS,
> which will help to not disable the Timer IRQ when suspending to ensure
> resuming normally(d6c585a4342a2ff627a29f9aea77c5ed4cd76023) and not
> thread them when enabled PREEMPT_RT.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
