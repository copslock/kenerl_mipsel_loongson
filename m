Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2014 13:13:22 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.187]:59902 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011908AbaKSMNUmHXxR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Nov 2014 13:13:20 +0100
Received: from wuerfel.localnet (HSI-KBW-149-172-15-242.hsi13.kabel-badenwuerttemberg.de [149.172.15.242])
        by mrelayeu.kundenserver.de (node=mreue004) with ESMTP (Nemesis)
        id 0Lgc09-1YKxOl1IEH-00o0B7; Wed, 19 Nov 2014 13:11:42 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Yijing Wang <wangyijing@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Liviu Dudau <liviu@dudau.co.uk>,
        Tony Luck <tony.luck@intel.com>,
        Russell King <linux@arm.linux.org.uk>,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org, sparclinux@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 5/5] PCI: Rip out pci_bus_add_devices() from pci_scan_root_bus()
Date:   Wed, 19 Nov 2014 13:11:41 +0100
Message-ID: <1645037.uypArjN50l@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1416382369-13587-6-git-send-email-wangyijing@huawei.com>
References: <1416382369-13587-1-git-send-email-wangyijing@huawei.com> <1416382369-13587-6-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:2rQ5XDWgYD2pEVfa0ndNQ1kEeKCn7CVQmYN02ioCDHK
 Gr98AoBTMGZwt7Dz5PB6RYPcTNaD/T5VWNZlkHuAq005YWO89f
 PJA7NAlls7eU4UIP3QbXlwII0MII0SGw0kKYCJ8Wx5OFeFHvia
 BFkTO69uCWnRerB4pmoFu0qSPiokkb6J3OhIpLXWnlMksKhng+
 utF3zQ6r3lTO5JbjljmMpoJ4zEecsa1IuAN8+3OQu0MgNo/yJ/
 qwT03r2Hcr8UxLoKRRAY0CeofGyLxr794yjGT9Wq0EEU/du7fy
 xuPA6Osl9/gCbJ98VvhIWv2AUNy0jc8EY3PeVkVysomKNgaDQB
 sgTZfuoqHSiAvqgpIbpo=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Wednesday 19 November 2014 15:32:49 Yijing Wang wrote:
> Just like pci_scan_bus(), we also should rip out
> pci_bus_add_devices() from pci_scan_root_bus().
> Lots platforms first call pci_scan_root_bus(), but
> after that, they call pci_bus_size_bridges() and
> pci_bus_assign_resources(). Place pci_bus_add_devices()
> in pci_scan_root_bus() hurts PCI scan logic.

I think we really need to wait for Bjorn to comment on this patch,
as I mentioned the idea behind pci_scan_root_bus() was to integrate
the scanning part, which you now undo, though I can still see this
working out in the long run.

> Should no functional change.

But you are moving the pci_bus_add_devices() later in a couple of
places. While this seems entirely reasonable, I would consider
it a functional change.

> diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
> index 076c35c..97f9730 100644
> --- a/arch/alpha/kernel/pci.c
> +++ b/arch/alpha/kernel/pci.c
> @@ -334,6 +334,8 @@ common_init_pci(void)
>  
>  		bus = pci_scan_root_bus(NULL, next_busno, alpha_mv.pci_ops,
>  					hose, &resources);
> +		if (bus)
> +			pci_bus_add_devices(bus);
>  		hose->bus = bus;
>  		hose->need_domain_info = need_domain_info;
>  		next_busno = bus->busn_res.end + 1;

How about making pci_bus_add_devices() handle a NULL argument to save
the if() here and elsewhere?
> diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
> index 1bf60b1..f083688 100644
> --- a/arch/mips/pci/pci.c
> +++ b/arch/mips/pci/pci.c
> @@ -113,6 +113,7 @@ static void pcibios_scanbus(struct pci_controller *hose)
>  		if (!pci_has_flag(PCI_PROBE_ONLY)) {
>  			pci_bus_size_bridges(bus);
>  			pci_bus_assign_resources(bus);
> +			pci_bus_add_devices(bus);
>  		}
>  	}
>  }

This one looks wrong, I think you still want to call pci_bus_add_devices()
even with PCI_PROBE_ONLY set.

> diff --git a/arch/tile/kernel/pci.c b/arch/tile/kernel/pci.c
> index 1f80a88..007466e 100644
> --- a/arch/tile/kernel/pci.c
> +++ b/arch/tile/kernel/pci.c
> @@ -308,6 +308,8 @@ int __init pcibios_init(void)
>  			pci_add_resource(&resources, &iomem_resource);
>  			bus = pci_scan_root_bus(NULL, 0, controller->ops,
>  						controller, &resources);
> +			if (bus)
> +				pci_bus_add_devices(bus);
>  			controller->root_bus = bus;
>  			controller->last_busno = bus->busn_res.end;
>  		}

Should the pci_bus_add_devices come after setting the bus numbers here?

	Arnd
