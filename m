Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2016 13:53:55 +0200 (CEST)
Received: from ozlabs.org ([103.22.144.67]:36191 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990519AbcJSLxr0oyGB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Oct 2016 13:53:47 +0200
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 3szVhR5fW1z9t15;
        Wed, 19 Oct 2016 22:53:43 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        monstr@monstr.eu, ralf@linux-mips.org, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com, alistair@popple.id.au,
        mporter@kernel.crashing.org
Cc:     soren.brinkmann@xilinx.com, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, michal.simek@xilinx.com,
        linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
        benh@kernel.crashing.org
Subject: Re: [Patch v5 06/12] powerpc/virtex: Use generic xilinx irqchip driver
In-Reply-To: <1476723176-39891-7-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1476723176-39891-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1476723176-39891-7-git-send-email-Zubair.Kakakhel@imgtec.com>
User-Agent: Notmuch/0.21 (https://notmuchmail.org)
Date:   Wed, 19 Oct 2016 22:53:43 +1100
Message-ID: <87funs4ks8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <mpe@ellerman.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpe@ellerman.id.au
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

Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com> writes:

> The Xilinx interrupt controller driver is now available in drivers/irqchip.
> Switch to using that driver.
>
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
>
> ---
> V5 New patch
>
> Tested on virtex440-ml507 using qemu

I don't have one of these to test on, and the patch looks sane, so
that's good enough for me.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
