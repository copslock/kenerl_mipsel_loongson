Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Oct 2016 12:52:20 +0200 (CEST)
Received: from Galois.linutronix.de ([146.0.238.70]:55410 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991977AbcJYKwMwTnN5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Oct 2016 12:52:12 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1byzJZ-00037n-BI; Tue, 25 Oct 2016 12:50:41 +0200
Date:   Tue, 25 Oct 2016 12:49:33 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
cc:     Marc Zyngier <marc.zyngier@arm.com>, monstr@monstr.eu,
        ralf@linux-mips.org, jason@lakedaemon.net, alistair@popple.id.au,
        mporter@kernel.crashing.org, soren.brinkmann@xilinx.com,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        michal.simek@xilinx.com, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, paulus@samba.org, benh@kernel.crashing.org
Subject: Re: [Patch v5 04/12] irqchip: xilinx: Add support for parent intc
In-Reply-To: <581adf44-388c-f8e5-8437-59d7ace2fa8f@imgtec.com>
Message-ID: <alpine.DEB.2.20.1610251246020.4990@nanos>
References: <1476723176-39891-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1476723176-39891-5-git-send-email-Zubair.Kakakhel@imgtec.com> <32f5f17d-7864-c782-7a6f-03660b7ab055@arm.com> <581adf44-388c-f8e5-8437-59d7ace2fa8f@imgtec.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55568
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

On Tue, 25 Oct 2016, Zubair Lutfullah Kakakhel wrote:
> On 10/21/2016 10:48 AM, Marc Zyngier wrote:
> > Shouldn't you return an error if irq is zero?
> > 
> 
> I'll add the following for the error case
> 
> 	pr_err("%s: Parent exists but interrupts property not defined\n" ,
> __func__);

Please do not use this silly __func__ stuff. It's not giving any value to
the printout.

Set a proper prefix for your pr_* stuff, so the string is prefixed with
'irq-xilinx:' or whatever you think is appropriate. Then the string itself
is good enough to find from which place this printk comes.

Thanks,

	tglx
