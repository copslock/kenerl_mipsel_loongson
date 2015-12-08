Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 22:21:43 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:57059 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013391AbbLHVVmDjB2A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2015 22:21:42 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1a6Pha-00044a-2J; Tue, 08 Dec 2015 22:21:38 +0100
Date:   Tue, 8 Dec 2015 22:20:50 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@imgtec.com>
cc:     linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, jiang.liu@linux.intel.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org,
        lisa.parratt@imgtec.com
Subject: Re: [PATCH v4 00/19] Implement generic IPI support mechanism
In-Reply-To: <1449580830-23652-1-git-send-email-qais.yousef@imgtec.com>
Message-ID: <alpine.DEB.2.11.1512081451570.3595@nanos>
References: <1449580830-23652-1-git-send-email-qais.yousef@imgtec.com>
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
X-archive-position: 50450
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

Qais,

On Tue, 8 Dec 2015, Qais Yousef wrote:
> This series adds support for a generic IPI mechanism that can be used by both
> arch and drivers to send IPIs to other CPUs.

This looks really reasonable now. There are a few things which can be
improved once its applied, but I don't want to defer that
further. Thanks Qais for following through with that.

So now the question is, how to merge that stuff.

What I really need is Ack/Review tags from the MIPS folks. Probably
some testing confirmation as well.

Ralf?

Thanks,

	tglx
