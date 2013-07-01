Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jul 2013 09:49:23 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:54465 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823690Ab3GAHtLB0MOd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Jul 2013 09:49:11 +0200
Received: from localhost ([127.0.0.1] helo=[172.123.10.21])
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <bigeasy@linutronix.de>)
        id 1UtYqr-0000Vs-UZ; Mon, 01 Jul 2013 09:48:46 +0200
Message-ID: <51D1345B.8020509@linutronix.de>
Date:   Mon, 01 Jul 2013 09:48:43 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130518 Icedove/17.0.5
MIME-Version: 1.0
To:     Santosh Shilimkar <santosh.shilimkar@ti.com>
CC:     Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
        Grant Likely <grant.likely@linaro.org>,
        Rob Herring <robherring2@gmail.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Aurelien Jacquiot <a-jacquiot@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Jonas Bonn <jonas@southpole.se>,
        Russell King <linux@arm.linux.org.uk>,
        linux-c6x-dev@linux-c6x.org, x86@kernel.org, arm@kernel.org,
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
References: <1371775956-16453-1-git-send-email-santosh.shilimkar@ti.com> <51C4171C.9050908@linutronix.de> <51C48B5A.2040404@ti.com> <51CCA67C.2010803@gmail.com> <CACxGe6vOH0sCFVVXrYqD3dbYdOvithVu7-d1cvy5885i8x_Myw@mail.gmail.com> <20130628134931.GD21034@game.jcrosoft.org> <51CE1F92.3070802@ti.com>
In-Reply-To: <51CE1F92.3070802@ti.com>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <bigeasy@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37234
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

On 06/29/2013 01:43 AM, Santosh Shilimkar wrote:
> 
> Sebastian,
> 
> Apart from waste of 32bit, what is the other concern you
> have ?

You pass a u64 as a physical address which is represented in other
parts of the kernel (for a good reason) by phys_addr_t.

> I really want to converge on this patch because it
> has been a open ended discussion for quite some time. Does
> that really break any thing on x86 or your concern is more
> from semantics of the physical address.
You want to have your code in so you can continue with your work, that
is okay. The other two arguments why u64 here is a good thing was "due
to what I said earlier" and "+1" and I don't have the time to look
that up.

There should be no problems on x86 if this goes in as it is now.

But think about this: What happens if you boot your ARM device without
PAE and your initrd is in the upper region? If you are lucky the kernel
looks at a different place where it also has a read permission, notices
nothing sane is there, writes a message and continues. And if it is not
allowed to read? It is clearly the user's fault for booting a non-PAE
kernel.

> 
> Thanks for help.
> 
> Regards,
> Santosh

Sebastian
