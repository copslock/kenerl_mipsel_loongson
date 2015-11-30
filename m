Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 12:21:04 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:51791 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007140AbbK3LVCGdSoE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 12:21:02 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1a3MVs-0003Bf-Eo; Mon, 30 Nov 2015 12:20:56 +0100
Date:   Mon, 30 Nov 2015 12:20:13 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@imgtec.com>
cc:     linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, jiang.liu@linux.intel.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 04/19] genirq: Add new struct ipi_mask and helper
 functions
In-Reply-To: <1448453217-3874-5-git-send-email-qais.yousef@imgtec.com>
Message-ID: <alpine.DEB.2.11.1511301158100.3572@nanos>
References: <1448453217-3874-1-git-send-email-qais.yousef@imgtec.com> <1448453217-3874-5-git-send-email-qais.yousef@imgtec.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Wed, 25 Nov 2015, Qais Yousef wrote:
> cpumask is limited to NR_CPUS. Introduce ipi_mask which allows us to address
> cpu range that is higher than NR_CPUS which is required for drivers to send
> IPIs for coprocessor that are outside Linux CPU range.

I have second thoughts on this.

cpumask is indeed limited to NR_CPUS or in case of CPUMASK_ON_STACK
limited to nr_cpu_ids.

But, that's not an issue for that coprocessor case. Let's assume you
have 16 Linux CPUs and 4 coprocessors. So you set the number of
possible cpus (NR_CPUS) to 20. That makes the cpumask sizeof 20.

The boot-process sets the number of available cpus to 16. So the
Linux side will never try to access anything beyond cpu15.

But you can spare that extra mask magic and simply use cpumask. Sorry
that I did not think about that earlier.

Thanks,

	tglx
