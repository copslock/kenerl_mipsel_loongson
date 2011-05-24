Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2011 16:01:51 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:33559 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491162Ab1EXOBp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 May 2011 16:01:45 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1QOsB6-0002in-IQ; Tue, 24 May 2011 16:01:44 +0200
Date:   Tue, 24 May 2011 16:01:43 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Pengfei Zhang <zoppof.zhang@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS:i8259.c remove resume and shutdown to syscore_ops
In-Reply-To: <20110524135940.GA30117@linux-mips.org>
Message-ID: <alpine.LFD.2.02.1105241600180.3078@ionos>
References: <1306239558-4997-1-git-send-email-zoppof.zhang@gmail.com> <20110524135940.GA30117@linux-mips.org>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

On Tue, 24 May 2011, Ralf Baechle wrote:

> On Tue, May 24, 2011 at 08:19:18PM +0800, Pengfei Zhang wrote:
> 
> > Remove the resume and shutdown of i8259A from the sysdev_class
> > to the syscore_ops since these members had removed from the
> > structure sysdev_class.
> 
> I don't see why one would want to want to first call register_syscore_ops
> then sysdev_class_register and sysdev_register?

The whole point of syscore_ops is to get rid of the sysdev which had
only one purpose: handing the suspend/resume ops in. The resulting
sysfs entry is completely useless.

Thanks,

	tglx
