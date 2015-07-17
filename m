Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jul 2015 11:22:02 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:47349 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009572AbbGQJWBIAGnH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Jul 2015 11:22:01 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZG1qC-00018T-GD; Fri, 17 Jul 2015 11:22:00 +0200
Date:   Fri, 17 Jul 2015 11:21:51 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Markos Chandras <markos.chandras@imgtec.com>
cc:     linux-mips@linux-mips.org, Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH] drivers: irqchip: irq-mips-gic: Print some GIC setup
 information to aid debugging
In-Reply-To: <1437049451-4096-1-git-send-email-markos.chandras@imgtec.com>
Message-ID: <alpine.DEB.2.11.1507171121000.18576@nanos>
References: <1437049451-4096-1-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 48337
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

On Thu, 16 Jul 2015, Markos Chandras wrote:

The proper mailinglist for IRQCHIP DRIVERS is LKML!

Thanks,

	tglx
