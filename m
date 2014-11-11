Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 23:58:18 +0100 (CET)
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:56657 "EHLO
        mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013109AbaKKW6QY1Ceb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Nov 2014 23:58:16 +0100
Received: from pool-96-249-243-124.nrflva.fios.verizon.net ([96.249.243.124] helo=titan)
        by mho-01-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <jason@lakedaemon.net>)
        id 1XoKNw-000K9J-QG; Tue, 11 Nov 2014 22:58:04 +0000
Received: from titan.lakedaemon.net (localhost [127.0.0.1])
        by titan (Postfix) with ESMTP id 49838618413;
        Tue, 11 Nov 2014 17:58:00 -0500 (EST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Originating-IP: 96.249.243.124
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX18f1R+RtxneLArJnc29pUVIwat/pAPmtjA=
X-DKIM: OpenDKIM Filter v2.0.1 titan 49838618413
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1415746680;
        bh=hgZSsEVZbthvP/fI7rSlrhzSR+VnxK14yXXVqZdsYqs=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=vw/CLXmceVkaNk9xf+LtaW0Jf/p6MNA3tFQd0PpjKh6ekSG/pFDQmMpf/yQ9OAIns
         GwzdN4sqlvbG5azEizySDWIZjO/PI/u8TTK8+1xL5Xey/K69UzluqUmjQoFoxKQvgC
         BVNPIaGPvxyFqRvOXBMHrETkwJkm15nUGEoiyKEhSQdzRMymDlSlzkwSCJNfqoMNjJ
         MYpeQJIGXJZK8s96IN1Lob+O4g3Hh6EA1z0KnqVC9WJz8z424HfY0gL3Gb6gkk4AoA
         s2TV2+wL/Gab2TF8l4lbKp4tq8t7RR0Q7wmi7IxTeWfqH26m5oQoTChoepdzm7hNBQ
         GzFrNaGVUQsWw==
Date:   Tue, 11 Nov 2014 17:58:00 -0500
From:   Jason Cooper <jason@lakedaemon.net>
To:     Boris Brezillon <boris.brezillon@free-electrons.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-sh@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>, linux-mips@linux-mips.org,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] irqchip: atmel-aic: fix irqdomain initialization
Message-ID: <20141111225800.GE3698@titan.lakedaemon.net>
References: <20141110230301.GV4068@piout.net>
 <1415712816-9202-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1415712816-9202-1-git-send-email-boris.brezillon@free-electrons.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason@lakedaemon.net
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

On Tue, Nov 11, 2014 at 02:33:36PM +0100, Boris Brezillon wrote:
> First of all IRQCHIP_SKIP_SET_WAKE is not a valid irq_gc_flags and thus
> should not be passed as the last argument of
> irq_alloc_domain_generic_chips.
> 
> Then pass the correct handler (handle_fasteoi_irq) to
> irq_alloc_domain_generic_chips instead of manually re-setting it in the
> initialization loop.
> 
> And eventually initialize default irq flags to the pseudo standard:
> IRQ_REQUEST | IRQ_PROBE | IRQ_AUTOEN.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
> Hello Kevin,
> 
> This patch has not been tested yet but it should solve the issue you've
> experienced with the IRQ_GC_BE_IO flag and the atmel-aic driver.
> 
> I'll test it tomorrow and let you know if it actually works.
> 
> Regards,
> 
> Boris
> 
>  drivers/irqchip/irq-atmel-aic-common.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied to irqchip/urgent with Kevin's Tested-by.  Also, flagged for
stable, v3.17 and up.

Boris, once this is in mainline, you may want to generate a patch
against older versions (in the arch dir) for the stable team.

thx,

Jason.
