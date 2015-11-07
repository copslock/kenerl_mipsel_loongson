Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Nov 2015 13:15:34 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:36178 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009975AbbKGMP1tSsTA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Nov 2015 13:15:27 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1Zv2GW-00042B-Fd; Sat, 07 Nov 2015 13:06:40 +0100
Date:   Sat, 7 Nov 2015 13:05:58 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@imgtec.com>
cc:     linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, jiang.liu@linux.intel.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 04/14] genirq: Add new struct ipi_mask and helper
 functions
In-Reply-To: <1446549181-31788-5-git-send-email-qais.yousef@imgtec.com>
Message-ID: <alpine.DEB.2.11.1511071305040.4032@nanos>
References: <1446549181-31788-1-git-send-email-qais.yousef@imgtec.com> <1446549181-31788-5-git-send-email-qais.yousef@imgtec.com>
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
X-archive-position: 49862
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

On Tue, 3 Nov 2015, Qais Yousef wrote:
>  /**
> + * struct ipi_mask - IPI mask information
> + * @nbits: number of bits in cpumask
> + * @global: whether the mask is SMP IPI ie: subset of cpu_possible_mask or not
> + * @cpumask: cpumask to be used when the ipi_mask is global
> + * @cpu_bitmap: the cpu bitmap to use when the ipi_mask is not global
> + *
> + * ipi_mask is similar to cpumask, but it provides nbits that's configurable
> + * rather than fixed to NR_CPUS.

Can you please add an explanation why we want that to the comment?

Thanks,

	tglx
