Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2015 15:50:16 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:51105 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009769AbbJMNuO3Y2kj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2015 15:50:14 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1Zlzxx-00089e-H3; Tue, 13 Oct 2015 15:50:09 +0200
Date:   Tue, 13 Oct 2015 15:49:33 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@imgtec.com>
cc:     linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, jiang.liu@linux.intel.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [RFC v2 PATCH 10/14] MIPS: make smp CMP, CPS and MT use the new
 generic IPI functions
In-Reply-To: <1444731382-19313-11-git-send-email-qais.yousef@imgtec.com>
Message-ID: <alpine.DEB.2.11.1510131548530.25029@nanos>
References: <1444731382-19313-1-git-send-email-qais.yousef@imgtec.com> <1444731382-19313-11-git-send-email-qais.yousef@imgtec.com>
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
X-archive-position: 49523
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

On Tue, 13 Oct 2015, Qais Yousef wrote:

> Only the SMP variants that use GIC were converted as it's the only irqchip that
> will have the support for generic IPI for now which will be introduced in
> the following patches.

You break bisectability. Introduce the new gic magic first and then
switch it over.

Thanks,

	tglx
