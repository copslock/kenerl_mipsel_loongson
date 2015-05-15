Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2015 22:48:57 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:44065 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012621AbbEOUsz0KkTj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2015 22:48:55 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1YtMWu-0007BE-QV; Fri, 15 May 2015 22:48:24 +0200
Date:   Fri, 15 May 2015 22:48:36 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jiang Liu <jiang.liu@linux.intel.com>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Yinghai Lu <yinghai@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        =?ISO-8859-15?Q?S=F6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-metag@vger.kernel.org
Subject: Re: [RFC v1 11/11] genirq: Pass irq_data to helper function
 __irq_set_chip_handler_name_locked()
In-Reply-To: <1430709339-29083-12-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <alpine.DEB.2.11.1505152247280.4225@nanos>
References: <1430709339-29083-1-git-send-email-jiang.liu@linux.intel.com> <1430709339-29083-12-git-send-email-jiang.liu@linux.intel.com>
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
X-archive-position: 47419
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

On Mon, 4 May 2015, Jiang Liu wrote:
>  /* caller has locked the irq_desc and both params are valid */
>  static inline void
> -__irq_set_chip_handler_name_locked(unsigned int irq, struct irq_chip *chip,
> +__irq_set_chip_handler_name_locked(struct irq_data *data, struct irq_chip *chip,
>  				   irq_flow_handler_t handler, const char *name)
>  {
>  	struct irq_desc *desc;
>  
> -	desc = irq_to_desc(irq);
> -	irq_desc_get_irq_data(desc)->chip = chip;
> +	desc = irq_to_desc(data->irq);

We should have a irq_data_to_desc() helper and use that instead of
going through a full lookup again.

Thanks,

	tglx
