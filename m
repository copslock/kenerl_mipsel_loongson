Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jul 2013 10:09:55 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:54602 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817030Ab3GAIJx4ulAh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Jul 2013 10:09:53 +0200
Received: from localhost ([127.0.0.1] helo=[172.123.10.21])
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <bigeasy@linutronix.de>)
        id 1UtZB3-0000gR-68; Mon, 01 Jul 2013 10:09:37 +0200
Message-ID: <51D1393E.6060001@linutronix.de>
Date:   Mon, 01 Jul 2013 10:09:34 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130518 Icedove/17.0.5
MIME-Version: 1.0
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Aurelien Jacquiot <a-jacquiot@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Jonas Bonn <jonas@southpole.se>,
        Russell King <linux@arm.linux.org.uk>,
        linux-c6x-dev@linux-c6x.org,
        the arch/x86 maintainers <x86@kernel.org>,
        "arm@kernel.org" <arm@kernel.org>,
        Rob Herring <robherring2@gmail.com>,
        Grant Likely <grant.likely@linaro.org>,
        Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
        linux-xtensa@linux-xtensa.org,
        James Hogan <james.hogan@imgtec.com>,
        devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
        Rob Herring <rob.herring@calxeda.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] of: Specify initrd location using 64-bit
References: <1371775956-16453-1-git-send-email-santosh.shilimkar@ti.com> <51C4171C.9050908@linutronix.de> <51C48B5A.2040404@ti.com> <51CCA67C.2010803@gmail.com> <CACxGe6vOH0sCFVVXrYqD3dbYdOvithVu7-d1cvy5885i8x_Myw@mail.gmail.com> <20130628134931.GD21034@game.jcrosoft.org> <51CE1F92.3070802@ti.com> <51D1345B.8020509@linutronix.de> <CAMuHMdV6YM3-hASqjxkguEukZjnjK80gBjDNiabxjfQtC=c8ag@mail.gmail.com>
In-Reply-To: <CAMuHMdV6YM3-hASqjxkguEukZjnjK80gBjDNiabxjfQtC=c8ag@mail.gmail.com>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <bigeasy@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bigeasy@linutronix.de
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

On 07/01/2013 09:59 AM, Geert Uytterhoeven wrote:
> That's actual the original reason: DT has it as 64 bit, and passes it to a
> 32 bit kernel when running in 32 bit mode without PAE.

And I think the DT code should check if the u64 fits in phys_addr_t and
if does not it should write an error message and act like no initrd was
specified (instead of passing "something" to the architecture).

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

Sebastian
