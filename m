Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Sep 2015 18:16:36 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:44584 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008895AbbI2QQe4SqqG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Sep 2015 18:16:34 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZgxZp-0003tO-Bg; Tue, 29 Sep 2015 18:16:25 +0200
Date:   Tue, 29 Sep 2015 18:15:49 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@imgtec.com>
cc:     Jiang Liu <jiang.liu@linux.intel.com>,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        jason@lakedaemon.net, linux-mips@linux-mips.org
Subject: Re: [PATCH 4/6] irq: add a new generic IPI handling code to irq
 core
In-Reply-To: <5603B3D1.3000405@imgtec.com>
Message-ID: <alpine.DEB.2.11.1509291811520.4500@nanos>
References: <1443019758-20620-1-git-send-email-qais.yousef@imgtec.com> <1443019758-20620-5-git-send-email-qais.yousef@imgtec.com> <5602D863.4040503@linux.intel.com> <5603B3D1.3000405@imgtec.com>
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
X-archive-position: 49401
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

On Thu, 24 Sep 2015, Qais Yousef wrote:
> The CPUs we want to send the IPI to are not Linux CPUs only. My use case is
> about sending IPI to audio coprocessor.
> So "dest" doesn't have to be part of Linux online CPUs, hence we need to
> specify it so that the underlying controller will know how to map to that CPU.
> I should have put more info in the cover letter, not just the link to the
> discussion, apologies for that.
> 
> I'm not sure about cpu hotplug. We could call irq_destroy_ipi() when a cpu is
> hot unplugged, but the current behaviour is to statically reserve the IPI and
> keep them reserved. I think it makes sense to keep it this way for SMP IPIs or
> things will get complicated.

Right. For general IPIs which are destined to all Linux CPUs we keep
them reserved unless the facility which needs them is shut down.

CPU hotplug is just disabling the IPI reception on the particular
core, but does not change the reservation for e.g. the resched IPI.
 
> For a coprocessor, if we the 'module is unloaded', I'd expect the
> irq_destroy_ipi() to be called returning the reserved IPI to the pool.

For any case which shuts down a IPI based facility (coprocessor or
general) we want to return the IPI. Otherwise we leak the IPI on
module removal and allocate a new one on reload.

Thanks,

	tglx
