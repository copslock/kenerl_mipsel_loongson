Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Mar 2015 04:09:55 +0100 (CET)
Received: from szxga01-in.huawei.com ([119.145.14.64]:12034 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006539AbbCCDJwsWp18 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Mar 2015 04:09:52 +0100
Received: from 172.24.2.119 (EHLO szxeml427-hub.china.huawei.com) ([172.24.2.119])
        by szxrg01-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id CKF09943;
        Tue, 03 Mar 2015 11:09:29 +0800 (CST)
Received: from [127.0.0.1] (10.177.27.212) by szxeml427-hub.china.huawei.com
 (10.82.67.182) with Microsoft SMTP Server id 14.3.158.1; Tue, 3 Mar 2015
 11:09:23 +0800
Message-ID: <54F525DC.1070401@huawei.com>
Date:   Tue, 3 Mar 2015 11:09:16 +0800
From:   Yijing Wang <wangyijing@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
MIME-Version: 1.0
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     Jiang Liu <jiang.liu@linux.intel.com>, <linux-pci@vger.kernel.org>,
        Yinghai Lu <yinghai@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@arm.linux.org.uk>, <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Tony Luck <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Guan Xuetao" <gxt@mprc.pku.edu.cn>, <linux-alpha@vger.kernel.org>,
        <linux-m68k@lists.linux-m68k.org>, Liviu Dudau <liviu@dudau.co.uk>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Richard Henderson" <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "Matt Turner" <mattst88@gmail.com>,
        David Howells <dhowells@redhat.com>,
        "Michal Simek" <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        "Chris Zankel" <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, <linux-mips@linux-mips.org>,
        <linux-am33-list@redhat.com>, <linux-s390@vger.kernel.org>,
        <linux-sh@vger.kernel.org>, <sparclinux@vger.kernel.org>,
        <linux-xtensa@linux-xtensa.org>
Subject: Re: [PATCH v4 02/30] PCI: Rip out pci_bus_add_devices() from pci_scan_root_bus()
References: <1424938344-4017-1-git-send-email-wangyijing@huawei.com> <1424938344-4017-3-git-send-email-wangyijing@huawei.com> <20150303015719.GB11978@google.com>
In-Reply-To: <20150303015719.GB11978@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.27.212]
X-CFilter-Loop: Reflected
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46091
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wangyijing@huawei.com
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

On 2015/3/3 9:57, Bjorn Helgaas wrote:
> On Thu, Feb 26, 2015 at 04:11:56PM +0800, Yijing Wang wrote:
>> Just like pci_scan_bus(), we also should rip out
>> pci_bus_add_devices() from pci_scan_root_bus().
>> Lots platforms first call pci_scan_root_bus(), but
>> after that, they call pci_bus_size_bridges() and
>> pci_bus_assign_resources(). Place pci_bus_add_devices()
>> in pci_scan_root_bus() hurts PCI scan logic.
>> For arm hw_pci->scan() functions which call
>> pci_scan_root_bus(), it's no need to change anything,
>> because pci_bus_add_devices() will be called later
>> in pci_common_init_dev().
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> CC: Richard Henderson <rth@twiddle.net>
>> CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
>> CC: Matt Turner <mattst88@gmail.com>
>> CC: David Howells <dhowells@redhat.com>
>> CC: Tony Luck <tony.luck@intel.com>
>> CC: Michal Simek <monstr@monstr.eu>
>> CC: Ralf Baechle <ralf@linux-mips.org>
>> CC: Koichi Yasutake <yasutake.koichi@jp.panasonic.com>
>> CC: Sebastian Ott <sebott@linux.vnet.ibm.com>
>> CC: "David S. Miller" <davem@davemloft.net>
>> CC: Chris Metcalf <cmetcalf@ezchip.com>
>> CC: Chris Zankel <chris@zankel.net>
>> CC: Max Filippov <jcmvbkbc@gmail.com>
>> CC: Thomas Gleixner <tglx@linutronix.de>
>> CC: linux-alpha@vger.kernel.org
>> CC: linux-kernel@vger.kernel.org
>> CC: linux-mips@linux-mips.org
>> CC: linux-am33-list@redhat.com
>> CC: linux-s390@vger.kernel.org
>> CC: linux-sh@vger.kernel.org
>> CC: sparclinux@vger.kernel.org
>> CC: linux-xtensa@linux-xtensa.org
>> ---
>>  arch/alpha/kernel/pci.c          |    2 ++
>>  arch/frv/mb93090-mb00/pci-vdk.c  |    6 ++++--
>>  arch/ia64/sn/kernel/io_init.c    |    1 +
>>  arch/microblaze/pci/pci-common.c |    1 +
>>  arch/mips/pci/pci.c              |    1 +
>>  arch/mn10300/unit-asb2305/pci.c  |    5 ++++-
>>  arch/s390/pci/pci.c              |    2 +-
>>  arch/sh/drivers/pci/pci.c        |    1 +
>>  arch/sparc/kernel/leon_pci.c     |    1 +
>>  arch/tile/kernel/pci.c           |    2 ++
>>  arch/tile/kernel/pci_gx.c        |    2 ++
>>  arch/x86/pci/common.c            |    1 +
>>  arch/xtensa/kernel/pci.c         |    2 ++
>>  drivers/pci/probe.c              |    1 -
>>  14 files changed, 23 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
>> index 98a1525..518b767 100644
>> --- a/arch/alpha/kernel/pci.c
>> +++ b/arch/alpha/kernel/pci.c
>> @@ -338,6 +338,8 @@ common_init_pci(void)
>>  
>>  		bus = pci_scan_root_bus(NULL, next_busno, alpha_mv.pci_ops,
>>  					hose, &resources);
>> +		if (bus)
>> +			pci_bus_add_devices(bus);
>>  		hose->bus = bus;
>>  		hose->need_domain_info = need_domain_info;
>>  		next_busno = bus->busn_res.end + 1;
> 
> This doesn't look right.  The code above is inside a loop, and just after
> the loop we have:
> 
>     pci_assign_unassigned_resources();
>     pci_fixup_irqs(alpha_mv.pci_swizzle, alpha_mv.pci_map_irq);
> 
> I think the pci_bus_add_devices() needs to go inside another loop after
> the assign and fixup_irqs code.

What about introduce a new function to add all pci bus here like:

pci_bus_add_devices_all()
{
	struct pci_bus *root_bus;

	list_for_each_entry(root_bus, &pci_root_buses, node)
		pci_bus_add_devices(root_bus);
}

pci_assign_unassigned_resources();
pci_fixup_irqs(alpha_mv.pci_swizzle, alpha_mv.pci_map_irq);
pci_bus_add_devices_all();

> 
> You didn't fix arm, but I think it has the same problem:
> 
>     pci_common_init_dev
>       pcibios_init_hw
>         pci_scan_root_bus
>       pci_fixup_irqs
>       pci_bus_size_bridges
>       pci_bus_assign_resources

void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
{
	struct pci_sys_data *sys;
	LIST_HEAD(head);

	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
	if (hw->preinit)
		hw->preinit();
	pcibios_init_hw(parent, hw, &head);  --------> scan root bus
	if (hw->postinit)
		hw->postinit();

	pci_fixup_irqs(pcibios_swizzle, pcibios_map_irq);

	list_for_each_entry(sys, &head, node) {
		struct pci_bus *bus = sys->bus;

		if (!pci_has_flag(PCI_PROBE_ONLY)) {
			/*
			 * Size the bridge windows.
			 */
			pci_bus_size_bridges(bus);

			/*
			 * Assign resources.
			 */
			pci_bus_assign_resources(bus);
		}

		/*
		 * Tell drivers about devices found.
		 */
		pci_bus_add_devices(bus);    ------>try to attach driver
	}

pci_bus_add_devices() is already in loops, so what problem here do you mean ?

> 
>> diff --git a/arch/frv/mb93090-mb00/pci-vdk.c b/arch/frv/mb93090-mb00/pci-vdk.c
>> index b073f4d..4b63781 100644
>> --- a/arch/frv/mb93090-mb00/pci-vdk.c
>> +++ b/arch/frv/mb93090-mb00/pci-vdk.c
>> -	pci_scan_root_bus(NULL, 0, pci_root_ops, NULL, &resources);
>> +	bus = pci_scan_root_bus(NULL, 0, pci_root_ops, NULL, &resources);
>>  
>>  	pcibios_irq_init();
>>  	pcibios_fixup_irqs();
>>  	pcibios_resource_survey();
>> -
>> +	if (bus)
>> +		pci_bus_add_devices(bus);
> 
> It's one more line of code, but personally I would write:
> 
>     if (!bus)
>       return 0;
> 
>     pci_bus_add_devices(bus);
>     return 0;
> 

OK, will update it.

>>  	return 0;
>>  }
>>  
>> diff --git a/arch/ia64/sn/kernel/io_init.c b/arch/ia64/sn/kernel/io_init.c
>> index 0b5ce82..63b43a6 100644
>> --- a/arch/ia64/sn/kernel/io_init.c
>> +++ b/arch/ia64/sn/kernel/io_init.c
>> @@ -272,6 +272,7 @@ sn_pci_controller_fixup(int segment, int busnum, struct pci_bus *bus)
>>  		kfree(res);
>>  		kfree(controller);
> 
> This needs a "return;" right here.  Otherwise we'll call
> pci_bus_add_devices(NULL) below.
> 

Sorry for my mistake, will correct it.

>>  	}
>> +	pci_bus_add_devices(bus);
>>  }
>>  
>>  /*
>> diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
>> index 48528fb..d8bbad9 100644
>> --- a/arch/microblaze/pci/pci-common.c
>> +++ b/arch/microblaze/pci/pci-common.c
>> @@ -1362,6 +1362,7 @@ static void pcibios_scan_phb(struct pci_controller *hose)
>>  	hose->bus = bus;
>>  
>>  	hose->last_busno = bus->busn_res.end;
>> +	pci_bus_add_devices(bus);
>>  }
> 
> I think this is still wrong:
> 
>     pcibios_init
>       pcibios_scan_phb
>         pci_scan_root_bus
> 	pci_bus_add_devices
>       pcibios_resource_survey	<-- oops

We could also call pci_bus_add_devices_all() like above here ?

>>  
>>  static int __init pcibios_init(void)
>> diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
>> index 1bf60b1..9eb54b5 100644
>> --- a/arch/mips/pci/pci.c
>> +++ b/arch/mips/pci/pci.c
>> @@ -114,6 +114,7 @@ static void pcibios_scanbus(struct pci_controller *hose)
>>  			pci_bus_size_bridges(bus);
>>  			pci_bus_assign_resources(bus);
>>  		}
>> +		pci_bus_add_devices(bus);
>>  	}
> 
> I would add a new patch at the end of your series to cosmetically
> restructure this as:
> 
>     if (!bus)
>       return;
> 
>     next_busno = bus->busn_res.end + 1;
>     ...
>     pci_bus_add_devices(bus);
> 

That's good.

>>  }
>>  
>> diff --git a/arch/mn10300/unit-asb2305/pci.c b/arch/mn10300/unit-asb2305/pci.c
>> index 613ca1e..2a815c1 100644
>> --- a/arch/mn10300/unit-asb2305/pci.c
>> +++ b/arch/mn10300/unit-asb2305/pci.c
>> @@ -340,6 +340,7 @@ void pcibios_fixup_bus(struct pci_bus *bus)
>>   */
>>  static int __init pcibios_init(void)
>>  {
>> +	struct pci_bus *bus;
>>  	resource_size_t io_offset, mem_offset;
>>  	LIST_HEAD(resources);
>>  
>> @@ -371,11 +372,13 @@ static int __init pcibios_init(void)
>>  
>>  	pci_add_resource_offset(&resources, &pci_ioport_resource, io_offset);
>>  	pci_add_resource_offset(&resources, &pci_iomem_resource, mem_offset);
>> -	pci_scan_root_bus(NULL, 0, &pci_direct_ampci, NULL, &resources);
>> +	bus = pci_scan_root_bus(NULL, 0, &pci_direct_ampci, NULL, &resources);
>>  
>>  	pcibios_irq_init();
>>  	pcibios_fixup_irqs();
>>  	pcibios_resource_survey();
>> +	if (bus)
>> +		pci_bus_add_devices(bus);
> 
>     if (!bus)
>       return 0;
>     pci_bus_add_devices(bus);
> 

OK

>>  	return 0;
>>  }
>>  
>> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
>> index 753a567..1534e5a 100644
>> --- a/arch/s390/pci/pci.c
>> +++ b/arch/s390/pci/pci.c
>> @@ -776,7 +776,7 @@ static int zpci_scan_bus(struct zpci_dev *zdev)
>>  		zpci_cleanup_bus_resources(zdev);
>>  		return -EIO;
>>  	}
>> -
>> +	pci_bus_add_devices(zdev->bus);
>>  	zdev->bus->max_bus_speed = zdev->max_bus_speed;
> 
> We should set zdev->bus->max_bus_speed before calling
> pci_bus_add_devices().  Some drivers look at max_bus_speed.
> 

OK, will adjust the order.

>>  	return 0;
>>  }
>> diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
>> index 1bc09ee..efc1051 100644
>> --- a/arch/sh/drivers/pci/pci.c
>> +++ b/arch/sh/drivers/pci/pci.c
>> @@ -69,6 +69,7 @@ static void pcibios_scanbus(struct pci_channel *hose)
>>  
>>  		pci_bus_size_bridges(bus);
>>  		pci_bus_assign_resources(bus);
>> +		pci_bus_add_devices(bus);
>>  	} else {
>>  		pci_free_resource_list(&resources);
>>  	}
> 
> Cosmetic restructure (new patch at end of series):
> 
>     if (!bus) {
>       pci_free_resource_list(&resources);
>       return;
>     }
> 
>     next_busno = bus->busn_res.end + 1;
>     ...
>     pci_bus_add_devices(bus);

OK.

> 
>> diff --git a/arch/sparc/kernel/leon_pci.c b/arch/sparc/kernel/leon_pci.c
>> index 899b720..2971076 100644
>> --- a/arch/sparc/kernel/leon_pci.c
>> +++ b/arch/sparc/kernel/leon_pci.c
>> @@ -40,6 +40,7 @@ void leon_pci_init(struct platform_device *ofdev, struct leon_pci_info *info)
>>  
>>  		/* Assign devices with resources */
>>  		pci_assign_unassigned_resources();
>> +		pci_bus_add_devices(root_bus);
>>  	} else {
>>  		pci_free_resource_list(&resources);
>>  	}
> 
> Restructure this with the same pattern (in a new patch).
> 
>> diff --git a/arch/tile/kernel/pci.c b/arch/tile/kernel/pci.c
>> index 325df47..9475a74 100644
>> --- a/arch/tile/kernel/pci.c
>> +++ b/arch/tile/kernel/pci.c
>> @@ -339,6 +339,8 @@ int __init pcibios_init(void)
>>  			struct pci_bus *next_bus;
>>  			struct pci_dev *dev;
>>  
>> +			pci_bus_add_devices(root_bus);
>> +
>>  			list_for_each_entry(dev, &root_bus->devices, bus_list) {
>>  				/*
>>  				 * Find the PCI host controller, ie. the 1st
>> diff --git a/arch/tile/kernel/pci_gx.c b/arch/tile/kernel/pci_gx.c
>> index 2c95f37..d7a0729 100644
>> --- a/arch/tile/kernel/pci_gx.c
>> +++ b/arch/tile/kernel/pci_gx.c
>> @@ -916,6 +916,8 @@ int __init pcibios_init(void)
>>  		/* Configure the max_payload_size values for this domain. */
>>  		fixup_read_and_payload_sizes(controller);
>>  
>> +		pci_bus_add_devices(root_bus);
>> +
>>  		/* Alloc a PIO region for PCI memory access for each RC port. */
>>  		ret = gxio_trio_alloc_pio_regions(trio_context, 1, 0, 0);
>>  		if (ret < 0) {
> 
> I don't know what all the magic gxio_trio_alloc and init stuff after this
> is, but it looks to me like the pci_bus_add_devices(root_bus) should be
> done *after* all of it.

I don't know much too, but I agree it, I would poke arch tile guys.

> 
>> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
>> index 3d2612b..0cbc723 100644
>> --- a/arch/x86/pci/common.c
>> +++ b/arch/x86/pci/common.c
>> @@ -491,6 +491,7 @@ void pcibios_scan_root(int busnum)
>>  		pci_free_resource_list(&resources);
>>  		kfree(sd);
>>  	}
>> +	pci_bus_add_devices(bus);
> 
> This one is tricky.  I don't think your patch makes it any worse than it is
> today, but it doesn't fix the problem.  We need to either fix it or call it
> out in the changelog.
> 
>     pci_subsys_init		# subsys_initcall (level 4)
>       pci_legacy_init
> 	pcibios_scan_root
> 	  pci_scan_root_bus
> 	  pci_bus_add_devices
> 
>     pcibios_assign_resources	# fs_initcall (level 5)
> 

I would like to keep it here, and we know that in this routine,
it is always in system boot up context. Which do you prefer ?

>>  }
>>  
>>  void __init pcibios_set_cache_line_size(void)
>> diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
>> index 5b34033..f2ae64e 100644
>> --- a/arch/xtensa/kernel/pci.c
>> +++ b/arch/xtensa/kernel/pci.c
>> @@ -185,6 +185,8 @@ static int __init pcibios_init(void)
>>  		pci_controller_apertures(pci_ctrl, &resources);
>>  		bus = pci_scan_root_bus(NULL, pci_ctrl->first_busno,
>>  					pci_ctrl->ops, pci_ctrl, &resources);
>> +		if (bus)
>> +			pci_bus_add_devices(bus);
>>  		pci_ctrl->bus = bus;
>>  		pci_ctrl->last_busno = bus->busn_res.end;
> 
> Oops, we just dereferenced a potentially NULL pointer here (of course, this
> could happen even before your patch).
> 
> I don't understand the platform_pcibios_fixup() that follows.  I can't find
> a definition of that, but it sounds like something that maybe should happen
> before pci_bus_add_devices().

I Will move the pci_bus_add_devices() after the platform_pcibios_fixup(),
because now only driver attachment in it, I think delay it is safe.

Thanks!
Yijing.

> 
>>  		if (next_busno <= pci_ctrl->last_busno)
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 88604f2..8ef0375 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -2087,7 +2087,6 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
>>  	if (!found)
>>  		pci_bus_update_busn_res_end(b, max);
>>  
>> -	pci_bus_add_devices(b);
>>  	return b;
>>  }
>>  EXPORT_SYMBOL(pci_scan_root_bus);
>> -- 
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 


-- 
Thanks!
Yijing
