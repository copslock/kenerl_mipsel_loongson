Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jun 2013 16:24:34 +0200 (CEST)
Received: from ns.iliad.fr ([212.27.33.1]:54437 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835141Ab3FMOYIrqNlq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Jun 2013 16:24:08 +0200
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 4785D4F8EF;
        Thu, 13 Jun 2013 16:24:07 +0200 (CEST)
Received: from [192.168.108.17] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 314214F8E8;
        Thu, 13 Jun 2013 16:24:07 +0200 (CEST)
Message-ID: <1371133447.3032.37.camel@sakura.staff.proxad.net>
Subject: Re: [PATCH net-next] bcm63xx_enet: add support Broadcom BCM6345
 Ethernet
From:   Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:     Florian Fainelli <florian@openwrt.org>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        ralf@linux-mips.org, John Crispin <blogic@openwrt.org>,
        Linux-MIPS <linux-mips@linux-mips.org>, jogo@openwrt.org,
        Kevin Cernekee <cernekee@gmail.com>
Date:   Thu, 13 Jun 2013 16:24:07 +0200
In-Reply-To: <CAGVrzcaqbdLPcuL0m56aBLuG9ruaQ1p4JfTWZV9DJ4zSrNcXtg@mail.gmail.com>
References: <1371066785-17168-1-git-send-email-florian@openwrt.org>
         <20130613.014450.1434692343011842828.davem@davemloft.net>
         <CAGVrzcYE4VDWtL_Uj1DrkZ6GqX6ghqPAXPpyLptc6PGwReixSQ@mail.gmail.com>
         <20130613.022524.568792627006552244.davem@davemloft.net>
         <CAGVrzcaqbdLPcuL0m56aBLuG9ruaQ1p4JfTWZV9DJ4zSrNcXtg@mail.gmail.com>
Organization: Freebox
Content-Type: text/plain; charset="ANSI_X3.4-1968"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Jun 13 16:24:07 2013 +0200 (CEST)
Return-Path: <mbizon@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
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


On Thu, 2013-06-13 at 10:49 +0100, Florian Fainelli wrote:

> We are in the slow process to switch to Device Tree to precisely
> eliminate all of this (although not everyone agrees yet on the
> details). Hopefully you should not see such things in the future.

I don't see how DT help here (hint: it never does)

if the driver knows at compile time how registers are shuffled, it can
remove the indirection

if you use runtime cpu detection or DT, it cannot

in fact, this patch already adds another layer of indirection with that
"dma_chan_width" thing that the compiler has no way to optimize out,
defeating the purpose of single SOC optimization.

so we might as well force multi SOC support

-- 
Maxime
