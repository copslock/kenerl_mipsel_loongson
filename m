Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jun 2013 15:56:15 +0200 (CEST)
Received: from 15.mo1.mail-out.ovh.net ([188.165.38.232]:47010 "EHLO
        mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6817387Ab3F1N4OLA0j0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Jun 2013 15:56:14 +0200
Received: from mail405.ha.ovh.net (b6.ovh.net [213.186.33.56])
        by mo1.mail-out.ovh.net (Postfix) with SMTP id 62E9EFFA9C5
        for <linux-mips@linux-mips.org>; Fri, 28 Jun 2013 15:56:13 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
        by b0.ovh.net with SMTP; 28 Jun 2013 15:56:37 +0200
Received: from ns32433.ovh.net (HELO localhost) (plagnioj%jcrosoft.com@213.251.161.87)
  by ns0.ovh.net with SMTP; 28 Jun 2013 15:56:35 +0200
Date:   Fri, 28 Jun 2013 15:49:31 +0200
From:   Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
To:     Grant Likely <grant.likely@linaro.org>
Cc:     Rob Herring <robherring2@gmail.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Aurelien Jacquiot <a-jacquiot@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
X-Ovh-Mailout: 178.32.228.1 (mo1.mail-out.ovh.net)
Subject: Re: [PATCH] of: Specify initrd location using 64-bit
Message-ID: <20130628134931.GD21034@game.jcrosoft.org>
References: <1371775956-16453-1-git-send-email-santosh.shilimkar@ti.com>
 <51C4171C.9050908@linutronix.de>
 <51C48B5A.2040404@ti.com>
 <51CCA67C.2010803@gmail.com>
 <CACxGe6vOH0sCFVVXrYqD3dbYdOvithVu7-d1cvy5885i8x_Myw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACxGe6vOH0sCFVVXrYqD3dbYdOvithVu7-d1cvy5885i8x_Myw@mail.gmail.com>
X-PGP-Key: http://uboot.jcrosoft.org/plagnioj.asc
X-PGP-key-fingerprint: 6309 2BBA 16C8 3A07 1772 CC24 DEFC FFA3 279C CE7C
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Ovh-Tracer-Id: 10766136384433990448
X-Ovh-Remote: 213.251.161.87 (ns32433.ovh.net)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiiedrleduucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiiedrleduucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Return-Path: <plagnioj@jcrosoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: plagnioj@jcrosoft.com
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

On 10:59 Fri 28 Jun     , Grant Likely wrote:
> On Thu, Jun 27, 2013 at 9:54 PM, Rob Herring <robherring2@gmail.com> wrote:
> > On 06/21/2013 12:20 PM, Santosh Shilimkar wrote:
> >> On Friday 21 June 2013 05:04 AM, Sebastian Andrzej Siewior wrote:
> >>> On 06/21/2013 02:52 AM, Santosh Shilimkar wrote:
> >>>> diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
> >>>> index 0a2c68f..62e2e8f 100644
> >>>> --- a/arch/microblaze/kernel/prom.c
> >>>> +++ b/arch/microblaze/kernel/prom.c
> >>>> @@ -136,8 +136,7 @@ void __init early_init_devtree(void *params)
> >>>>  }
> >>>>
> >>>>  #ifdef CONFIG_BLK_DEV_INITRD
> >>>> -void __init early_init_dt_setup_initrd_arch(unsigned long start,
> >>>> -           unsigned long end)
> >>>> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
> >>>>  {
> >>>>     initrd_start = (unsigned long)__va(start);
> >>>>     initrd_end = (unsigned long)__va(end);
> >>>
> >>> I think it would better to go here for phys_addr_t instead of u64. This
> >>> would force you in of_flat_dt_match() to check if the value passed from
> >>> DT specifies a memory address outside of 32bit address space and the
> >>> kernel can't deal with this because its phys_addr_t is 32bit only due
> >>> to a Kconfig switch.
> >>>
> >>> For x86, the initrd has to remain in the 32bit address space so passing
> >>> the initrd in the upper range would violate the ABI. Not sure if this
> >>> is true for other archs as well (ARM obviously not).
> >>>
> >> That pretty much means phys_addr_t. It will work for me as well but
> >> in last thread from consistency with memory and reserved node, Rob
> >> insisted to keep it as u64. So before I re-spin another version,
> >> would like to here what Rob has to say considering the x86 requirement.
> >>
> >> Rob,
> >> Are you ok with phys_addr_t since your concern was about rest
> >> of the memory specific bits of the device-tree code use u64 ?
> >
> > No. I still think it should be u64 for same reasons I said originally.
> 
> +1
> 
+1

fix type

Best Regards,
J.
