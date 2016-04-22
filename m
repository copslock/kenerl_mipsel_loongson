Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Apr 2016 17:37:23 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:50074 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025160AbcDVPhWeVIWy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Apr 2016 17:37:22 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1atd8u-0005Fw-7Z; Fri, 22 Apr 2016 17:37:16 +0200
Date:   Fri, 22 Apr 2016 17:35:46 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
cc:     lisa.parratt@imgtec.com, jason@lakedaemon.net, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, jiang.liu@linux.intel.com,
        marc.zyngier@arm.com, linux-mips@linux-mips.org,
        Qais Yousef <qsyousef@gmail.com>
Subject: Re: [PATCH 2/2] genirq: Add error code reporting to
 irq_{reserve,destroy}_ipi
In-Reply-To: <1461338809-10590-2-git-send-email-matt.redfearn@imgtec.com>
Message-ID: <alpine.DEB.2.11.1604221735250.3941@nanos>
References: <1461338809-10590-1-git-send-email-matt.redfearn@imgtec.com> <1461338809-10590-2-git-send-email-matt.redfearn@imgtec.com>
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
X-archive-position: 53207
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

On Fri, 22 Apr 2016, Matt Redfearn wrote:

> Make these functions return appropriate error codes when something goes
> wrong.

And the reason for this change is?
